From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cat-file --batch: flush stdout also when objects are
 missing
Date: Tue, 03 Jun 2008 12:40:34 -0700
Message-ID: <7vve0q1f4d.fsf@gitster.siamese.dyndns.org>
References: <1212518057-9137-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 21:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cO3-0000My-5z
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 21:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYFCTkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 15:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYFCTkq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 15:40:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbYFCTkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 15:40:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCA5F4739;
	Tue,  3 Jun 2008 15:40:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3EA1F4738; Tue,  3 Jun 2008 15:40:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F3EA5288-31A4-11DD-9E58-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83693>

Lea Wiemann <lewiemann@gmail.com> writes:

> cat-file --batch/--batch-check only flushes stdout when the object
> exists, but not when it doesn't ("<object> missing").  This makes
> bidirectional pipes hang.
>
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
>  builtin-cat-file.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> index 200345e..f8b3160 100644
> --- a/builtin-cat-file.c
> +++ b/builtin-cat-file.c
> @@ -159,6 +159,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
>  
>  	if (get_sha1(obj_name, sha1)) {
>  		printf("%s missing\n", obj_name);
> +		fflush(stdout);
>  		return 0;
>  	}
>  
> -- 
> 1.5.6.rc0.92.g27fd.dirty

Ah, good catch.

Thanks.
