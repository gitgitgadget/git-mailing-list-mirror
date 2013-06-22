From: Eric Lindsey <elindsey@ucsd.edu>
Subject: git subtree pull incorrectly reports merge conflict
Date: Sat, 22 Jun 2013 16:59:59 -0700
Message-ID: <CANFFsAZ-Q--3Kx_rYgkALd=nvo6r24sNpNQeHQdALYHhDwBxPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 23 02:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqXsT-0002zR-0r
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 02:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab3FWAJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 20:09:38 -0400
Received: from iport-c2-out.ucsd.edu ([132.239.0.174]:58386 "EHLO
	iport-c2-out.ucsd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab3FWAJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 20:09:37 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jun 2013 20:09:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucsd.edu; i=elindsey@ucsd.edu; q=dns/txt;
  s=041709-iport; t=1371946177; x=1403482177;
  h=mime-version:date:message-id:subject:from:to;
  bh=W+m0T5pMIymaPd7MNDdYVytBqZa7Ov5spxIwmaG2hNA=;
  b=h7w2LNkna1KmPapK1R3A4+D0zAie6NIhcDUQGqJ3GOI6KTit6Fer7KZy
   zCLWklThAh6Lp2iXDjQv59XwYUZhPFflUeY4tCRrqYf5KnSWXR+uVt16r
   phYks8BmTzPKO6EtOOBFroAHu+NCLfmg+zpO98ei0gqi5o8m9C8JXCNwK
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvMFAGI5xlGE7/kU/2dsb2JhbABbgwkBea1FAYpwh3UIFnSDSV0SAQUBFogtnCiCfpRWiAePbINNA4khjiKGDolRFimBJoMw
X-IronPort-AV: E=Sophos;i="4.87,920,1363158000"; 
   d="scan'208";a="1010038225"
X-Spam-Status: No
X-Spam-Level: 
Received: from smtp-tpcs.ucsd.edu ([132.239.249.20])
  by iport-c2-out.ucsd.edu with ESMTP; 22 Jun 2013 17:00:00 -0700
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com [74.125.82.178])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by smtp-tpcs.ucsd.edu (Postfix) with ESMTPSA id 789F77FF16
	for <git@vger.kernel.org>; Sat, 22 Jun 2013 17:00:00 -0700 (PDT)
Received: by mail-we0-f178.google.com with SMTP id u53so7421465wes.9
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 16:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=W+m0T5pMIymaPd7MNDdYVytBqZa7Ov5spxIwmaG2hNA=;
        b=jTExF1dLzksa0DmuOdzR/lfHvb5l3HNQCAjVgee+rGA9wWQFeOg4Askknbffe1xf1e
         GMY5QHRmIssoEuSbqUgHgbJnG60bGSjP3Da0oObiUdY778/DkZxFvEBYNfzGZRY/irR8
         kJ2w7vgDJQH2RegmhB529XqjH+fFRHtxxgAkMXmEfdxqFahumsuuwuHOR7hFTRI86KPV
         fhLSh6I1uM/NLaxrQVJjDadXkYFFDMZSdhcASypwiCYkCigUqMKPz1iCL0lNAhLUlZLd
         wE1Wk65aN8OXBe6BUE2vKGUfBPzprvmos4YFMX20jVKykYRT14AvHarnmhp+2clcc0/4
         5E1A==
X-Received: by 10.180.11.146 with SMTP id q18mr2471771wib.50.1371945599104;
 Sat, 22 Jun 2013 16:59:59 -0700 (PDT)
Received: by 10.180.183.230 with HTTP; Sat, 22 Jun 2013 16:59:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228719>

I'm having trouble pulling changes from a repo that was imported as a
subtree with 'git subtree add'. The issue occurs when I have
previously used 'git subtree push' from within the project directory,
then pushed changes to the remote repo again from somewhere else (from
another project also using it as a subtree, or directly with 'git
push' -- doesn't matter). When I go back to the initial project, 'git
subtree pull' has a merge conflict, and fails to merge the new
changes. The reported conflict is half-empty, so I can't see why there
is any conflict at all.

I've found an odd workaround, where calling "subtree pull" immediately
after the "subtree push" from the project directory seems to keep
things in sync and prevent the later conflict (see the script below).
I'm stumped as to why running a pull should find any changes right
after a push, but this is what happens. So it seems like a bug, unless
I'm missing a critical step somewhere -- I'm fairly new to git still.

I've pasted a script below that reproduces the problem in a simple
case, for my version of git (1.8.3.1, installed via homebrew on OS X
10.8.4).

Thanks,
Eric


#start from scratch
rm -rf foo bar foo.git

# create remote repo. for foo (bare)
mkdir foo.git
cd foo.git
git init --bare
cd ..

#create library foo and push to remote repo
mkdir foo
cd foo
echo "this is a test file" > test.foo
git init
git add .
git commit -m "initial commit to foo"
git remote add origin ../foo.git
git push origin master
cd ..

#create a project that uses foo as subtree
mkdir bar
cd bar
git init
echo "test" > test.bar
git add .
git commit -m "initial commit to bar"
git subtree add --prefix=foo ../foo.git master
echo "modify foo from bar" >> foo/test.foo
git add foo/test.foo
git commit -m "update foo from bar"
git subtree push --prefix=foo ../foo.git master
### if I uncomment the next line, final 'subtree pull' doesn't fail... why?
#git subtree pull --prefix=foo ../foo.git master -m "pull right after push"
cd ..

#now update foo from elsewhere
cd foo
git pull origin master
echo "modify foo from foo" >> test.foo
git add test.foo
git commit -m "update foo again"
git push origin master
cd ..

# try to pull update from project bar
cd bar
git subtree pull --prefix=foo ../foo.git master -m "pull foo"

#above command fails to merge, and the reported conflict is half-empty.
#resulting contents of bar/foo/test.foo are:

#this is a test file
#modify foo from bar
#<<<<<<< HEAD
#=======
#modify foo from foo
#>>>>>>> f0a24eeb1614228a1368ae23112ff4923dcf557e
