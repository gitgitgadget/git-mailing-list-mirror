From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Feb 2011, #07; Mon, 28)
Date: Sat, 05 Mar 2011 18:04:26 +0100
Message-ID: <4D726D1A.50507@drmicha.warpmail.net>
References: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 18:04:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvuuC-0008HG-O0
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 18:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab1CERE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 12:04:29 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44881 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753254Ab1CERE2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2011 12:04:28 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 51EA020A03;
	Sat,  5 Mar 2011 12:04:28 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 05 Mar 2011 12:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=DyrLRhpa5CEumPeX9ucHanaNUdc=; b=iF+oQMFJZTDbaHg8xSUjYQO/qgXh+9SF5G/Ern6q5D+6x4GUs6yDYgOa0Ng539fSx3ZEs4HFY7+G/SzgP4PEcq9uPXCGI6yfhcY9IEPwOKEROP9WZDf1BgkWhmDB1v9+MXtRerI09CNNVGm1I4ipRzniPDKogYJ9O00shYm2rSs=
X-Sasl-enc: 9YgJwKzcv4kXmXoo90F/Ay1RhR56kD7vtKchLY17LzHb 1299344668
Received: from localhost.localdomain (p54858AEC.dip0.t-ipconnect.de [84.133.138.236])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ACED8404F6E;
	Sat,  5 Mar 2011 12:04:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <7vbp1vfy5f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168503>

Junio C Hamano venit, vidit, dixit 01.03.2011 02:05:
...
> * mg/rev-list-one-side-only (2011-02-22) 6 commits
>  - t6007: test rev-list --cherry
>  - log --cherry: a synonym
>  - rev-list: --left/right-only are mutually exclusive
>  - rev-list: documentation and test for --left/right-only
>  - t6007: Make sure we test --cherry-pick
>  - revlist.c: introduce --left/right-only for unsymmetric picking
> 
> Will merge to 'next'; somebody may want to try losing many lines from
> format-patch before it hits 'master', though.  Hint, hint...

I was looking at f-p and also cherry, and getting second thoughts on
"--cherry" in the course of it. Would you hold back the top 2, please?

I'm wondering whether we should make "rev-list --cherry" more close to
"cherry" (which also takes up your suggestion to show equivalent
commits). With the top 2, "--cherry" lists the "+" commits only.

I'm thinking of something like "--cherry-mark" which is like
--cherry-pick but marks equivalent commits (with a new flag PATCHSAME)
rather than dropping them. Then,

git rev-list --cherry-pick --no-merges --left-right --right-only A...B

would be equivalent to

git cherry A B

but would make a lot of sense without --right-only, as well.

I have a monkey patch for that right now (to be polished) which uses "="
because "-" is taken for boundary commits already. (I also noticed "^"
for UNINTERESTING - when do they get shown??) I'm wondering about the
relation between --cherry-mark and --left-right though: Should the
former imply the latter, or should --cherry-mark always output '='? I
guess the latter.

If we were/are open to changing the characters which "git cherry" uses
as markers we could probably replace it by the invocation above. The
alternative (overload the meaning of '-') does not look like the best
solution.

Michael
