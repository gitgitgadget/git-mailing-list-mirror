From: Dmitry Pavlenko <dmit10@mail.ru>
Subject: git diff-index and both deleted conflict
Date: Fri, 11 Mar 2011 19:47:55 +0300
Message-ID: <201103111947.55412.dmit10@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 18:14:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py5ui-0003Ce-Bx
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 18:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab1CKROD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 12:14:03 -0500
Received: from fallback1.mail.ru ([94.100.176.18]:36745 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1CKROB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 12:14:01 -0500
X-Greylist: delayed 1554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2011 12:14:00 EST
Received: from smtp6.mail.ru (smtp6.mail.ru [94.100.176.48])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id 5301D2CDCE5B
	for <git@vger.kernel.org>; Fri, 11 Mar 2011 19:53:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:To:From; bh=+fGDxsiNB7bfIwQRgBMUxXQYCampu/Y6uFqZ8toQiS0=;
	b=nOQa0FtvC1C+MEkY7RXDJVq+AORl+JF9jMMq+ibP0ojidkSZ0iBEkE7ntWdzJ/Yu09Dlebt4JHuz2qY4HMAQe0g1SPl6G8TuDK7eBh2n2JeY5G52cnsl1lcFI1zO/sC4;
Received: from [78.37.150.154] (port=4245 helo=dmit10.localnet)
	by smtp6.mail.ru with asmtp 
	id 1Py5VT-0006L6-00
	for git@vger.kernel.org; Fri, 11 Mar 2011 19:48:03 +0300
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168916>

Hello all,

Could you advise me the fastest way to check in my script 
that there's "no local changes in the repository (in the working tree and 
index)" so that I could perform "git rebase" there?

git svn dcommit" should check for the same because it performs rebase.
"git svn dcommit" calls "git diff-index HEAD".

According to the documentation "git diff-index HEAD" performs the check I need. 
But I've discovered that in the case of "both deleted" conflict "git diff-index 
HEAD" outputs nothing but rebase still doesn't want to run. 

So, at least either "git diff-index HEAD" or its documentation and "git-svn" 
should be fixed, I think.

And I'm still asking for the fastest method that could predict that working 
tree and index are clean, no conflict, and I can run "git rebase".


A simple script to generate "both deleted":

#!/bin/sh

git init
touch foo
git add foo
git commit -m 'initial commit'
git checkout -b tmp
git mv foo X
git commit -m 'rename to X'
git checkout -
git mv foo Y
git commit -m 'rename to Y'
git merge tmp
git add Y
git rm X
