From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] code cleanup in sha1_file.c: xmalloc -> xcalloc
Date: Tue, 10 Feb 2009 08:43:46 -0800
Message-ID: <7v3aemnsxp.fsf@gitster.siamese.dyndns.org>
References: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guanqun Lu <guanqun.lu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvjf-0006YI-01
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbZBJQnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbZBJQnw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:43:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbZBJQnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:43:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9729C9820A;
	Tue, 10 Feb 2009 11:43:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7CDFE98203; Tue,
 10 Feb 2009 11:43:48 -0500 (EST)
In-Reply-To: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
 (Guanqun Lu's message of "Wed, 11 Feb 2009 14:43:31 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF4412DC-F791-11DD-B055-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109270>

Guanqun Lu <guanqun.lu@gmail.com> writes:

> 'xmalloc' followed immediately by 'memset' is replaced
> with 'xcalloc', and a simple grep in this project seems
> to show that it's the only place.

But isn't this memset() done only for the initial part of the allocated
area, not the whole thing?  You are not cleaning up but changing what it
does, if I am reading this code correctly.

> Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
> ---
>  sha1_file.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 8868b80..93e5fc0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -858,8 +858,7 @@ unsigned char* use_pack(struct packed_git *p,
>  
>  static struct packed_git *alloc_packed_git(int extra)
>  {
> -	struct packed_git *p = xmalloc(sizeof(*p) + extra);
> -	memset(p, 0, sizeof(*p));
> +	struct packed_git *p = xcalloc(1, sizeof(*p) + extra);
>  	p->pack_fd = -1;
>  	return p;
>  }
> -- 
> 1.6.1.2.392.gb04d1
