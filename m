From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] git-rebase.sh: Fix --merge --abort failures
 when path contains whitespace
Date: Fri, 11 Apr 2008 15:37:22 -0700
Message-ID: <7vfxtsow65.fsf@gitster.siamese.dyndns.org>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <7vr6dexids.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Sat Apr 12 00:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkRt0-0005na-2M
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 00:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbYDKWhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 18:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbYDKWhh
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 18:37:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554AbYDKWhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 18:37:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A81B1FDE;
	Fri, 11 Apr 2008 18:37:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 402831FDB; Fri, 11 Apr 2008 18:37:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79305>

Junio C Hamano <gitster@pobox.com> writes:

> I am very inclined to replace t3407 with the following.
>
> diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
> index 37944c3..cadfb23 100755
> --- a/t/t3407-rebase-abort.sh
> +++ b/t/t3407-rebase-abort.sh
> @@ -4,7 +4,13 @@ test_description='git rebase --abort tests'
>  
>  . ./test-lib.sh
>  
> +### Test that we handle strange characters properly
> +work_dir="$(pwd)/test \" ' \$ \\ dir"
> +

Eh, I am sorry, but a slight change of plans.  We would probably want to
exclude backslash from the above, so that we do not get inconsistent test
between DOSsy systems and others.

I think your "trash directory" is a reasonable way to test a very common
issue.  SP is not all that unusual character to use in a pathname,
especially created from within a GUI-ish environment.  So probably we
can do something similar here, like:

	work_dir="$(pwd)/test dir"
