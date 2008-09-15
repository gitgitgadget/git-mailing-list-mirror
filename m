From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Diff-tree does not work for initial commit
Date: Mon, 15 Sep 2008 13:01:25 -0700
Message-ID: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfKHK-0005p4-LA
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 22:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbYIOUB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 16:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYIOUB1
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 16:01:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:7504 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbYIOUB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 16:01:26 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1469780waf.23
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=+WREW+PhG/FBvA0rm07XQNpIAWEiTDgc8tIjcUUxFDY=;
        b=n3fiRtNol/y0sAvD1muo8if+2wVa5O8rh/ecVnksEFrsooM1X/HD7JNs3sKLzCdIei
         3ufPQY9yG2sEARrAhn4RHV+hQE1DqAL4rqyLN/dJQuoJ1zErkrGqmbbY/SiuPINH0Cr5
         s0D4yt31ZcHYhrHyFVrXTHSLbA/myIyI8sETw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ss68EU9GXkgG3+84zdBbXs9WTj+ytgcTvmOFYYgnZ6wpPiGjT8/jlKvHg8rUsNXWtF
         xFpV+dIoM9cUXJGSZJvjo00GymZfYZWT60LzPja99IzfM/BHaphnoY6gSlt0rzGLHayp
         WIiUrI6Fd4dQbmh1H3M28zQJAqI6LFSzkiVvA=
Received: by 10.114.180.1 with SMTP id c1mr30104waf.85.1221508885431;
        Mon, 15 Sep 2008 13:01:25 -0700 (PDT)
Received: by 10.115.78.6 with HTTP; Mon, 15 Sep 2008 13:01:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95935>

Hi, It looks like I found a bug in git.

The problem: In my script I need to know what files were modified by
given commit. I use diff-tree for it. Although it works for most
cases, for initial commit it does not. Here is a sequence of actions.

anatol:~ $ mkdir mkdir initialcommitissue
anatol:~ $ cd initialcommitissue/
anatol:initialcommitissue $ git init
Initialized empty Git repository in /home/anatol/initialcommitissue/.git/
anatol:initialcommitissue $ echo "First commit" > 1.txt
anatol:initialcommitissue $ git add 1.txt
anatol:initialcommitissue $ git commit -m "First commit"
Created initial commit 31ccc6a: First commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 1.txt
anatol:initialcommitissue $ git diff-tree HEAD     <<<<< PROBLEM IS HERE
anatol:initialcommitissue $ echo "Second commit" > 2.txt
anatol:initialcommitissue $ git add 2.txt
anatol:initialcommitissue $ git commit -m "Second commit"
Created commit 51e8bcb: Second commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 2.txt
anatol:initialcommitissue $ git diff-tree HEAD
51e8bcbb739fc8329fc092db7a84b02bbc64feb2
:000000 100644 0000000000000000000000000000000000000000
c133ee6afb86d836ae607cc12e7b7b42242aa5fa A	2.txt


so git diff-tree HEAD works fine but git diff-tree HEAD~1 does not. I
guess in sake of consistency it should show all changed files in
initial commit.

-- 
anatol
