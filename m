From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] git-rebase--interactive: auto amend only edited commit
Date: Tue, 09 Sep 2008 08:42:57 +0200
Message-ID: <48C61AF1.1060703@viscovery.net>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com> <1220906569-26878-2-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 08:44:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcwxW-0003L2-HJ
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 08:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbYIIGnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 02:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYIIGnG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 02:43:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33007 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbYIIGnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 02:43:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KcwwD-0005EN-Qd; Tue, 09 Sep 2008 08:42:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 91AAE69F; Tue,  9 Sep 2008 08:42:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1220906569-26878-2-git-send-email-dpotapov@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95340>

Dmitry Potapov schrieb:
> Another problem is that after being stopped at "edit", the user adds new
> commits. In this case, automatic amend behavior of git rebase triggered
> by some stage changes causes that not only that the log message of the
> last commit is lost but that it will contain also wrong Author and Date
> information.
> 
> Therefore, this patch restrict automatic amend only to the situation
> where HEAD is the commit at which git rebase stop by "edit" command.
...
> @@ -430,6 +430,8 @@ do
>  			if test -f "$DOTEST"/amend
>  			then
>  				amend=$(git rev-parse --verify HEAD)
> +				test "$amend" = $(cat "$DOTEST"/amend) ||
> +				die "You have uncommitted changes"

Doesn't this terse message carry a bit of a "WTF?" factor? In other
situations rebase --continue goes into git-commit just fine, but it does
not under these special conditions. How about this:

"Will not auto-commit uncommitted changes after you have already committed
something. Please run 'git commit --amend' yourself."

>  				git reset --soft HEAD^ ||
>  				die "Cannot rewind the HEAD"
>  			fi

-- Hannes
