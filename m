From: =?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
Subject: Linked workdirs break typo-correction.
Date: Thu, 25 Jun 2015 16:15:23 +0200
Message-ID: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
Reply-To: bjornar@snoksrud.no
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 16:15:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z87wE-0001m7-Nm
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 16:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbbFYOP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2015 10:15:26 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36234 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbbFYOPY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 10:15:24 -0400
Received: by ykdr198 with SMTP id r198so41125329ykd.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=WhVFAknyNO54jlcBHoMPIHDdZdmR/XPXr7Z1okyPm14=;
        b=K1g00L1jesfLdSF8Gzs9j+Wjl7bS91tERs6FHlv8zfpoI/zkzi7/ZkZbLN3iz8ZQHW
         sebB1eKcqvLErDfZJVSg+7Gz+BShPJq+a5wT624ZsXgUCfd5Y63WJPsy/jVgyaqcv8GL
         CPDLko+xjXOOpO4aoY2+5J7Suxu8yvA5E5/mUBE2120oNzxVTup4AiMjWV0KpRzNUhpG
         0X+MNZLbfE+vvuvaeqsdDBZbqUa+cw76ReNPV2o8wHTMz3DSRLJU3gT0OtCMrDLt21kI
         zioseG+ke2BnnALxQeqlQq1ZtNsFlfFlHPrMT1j3/H6Fxj7Bvyb9oZ5Rvd98D2a3fEO9
         l2Zg==
X-Received: by 10.13.244.195 with SMTP id d186mr48558399ywf.73.1435241723823;
 Thu, 25 Jun 2015 07:15:23 -0700 (PDT)
Received: by 10.129.71.3 with HTTP; Thu, 25 Jun 2015 07:15:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272677>

This is a weird one..

When standing in a folder inside a linked working copy, the
typo-correction breaks all commands.

Repro:
~/git $ git --version
git version 2.4.4.600.g6397abd
~/git $ git init bar
Initialized empty Git repository in ~/git/bar/.git/
~/git $ cd bar
~/git/bar (master #) $ git commit -m init --allow-empty
[master (root-commit) 554ea84] init
~/git/bar (master) $ mkdir folder
~/git/bar (master) $ touch folder/file
~/git/bar (master) $ git add folder
~/git/bar (master +) $ git commit -m folder
[master 8c00ba8] folder
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 folder/file
~/git/bar (master) $ cd folder/
~/git/bar/folder (master) $ git shw
WARNING: You called a Git command named 'shw', which does not exist.
Continuing under the assumption that you meant 'show'
in 0.1 seconds automatically...
commit 8c00ba8d30cff0e0d1b9cf110a65ea8f33edf8b2
Author: Bj=C3=B8rnar Snoksrud <bsnoksru@cisco.com>
Date:   Thu Jun 25 16:08:01 2015 +0200

    folder

diff --git a/folder/file b/folder/file
new file mode 100644
index 0000000..e69de29
bsnoksru@calculon ~/git/bar/folder (master) $ git branch foo
bsnoksru@calculon ~/git/bar/folder (master) $ git checkout foo --to
~/git/foo
Enter /home/bsnoksru/git/foo (identifier foo)
Switched to branch 'foo'
bsnoksru@calculon ~/git/bar/folder (master) $ cd ../../foo/folder/
~/git/foo/folder (foo) $ git shw
WARNING: You called a Git command named 'shw', which does not exist.
Continuing under the assumption that you meant 'show'
in 0.1 seconds automatically...
fatal: internal error: work tree has already been set
Current worktree: ~/git/foo
New worktree: ~/git/foo/folder
~/git/foo/folder (foo) $ git brnch baz
WARNING: You called a Git command named 'brnch', which does not exist.
Continuing under the assumption that you meant 'branch'
in 0.1 seconds automatically...
fatal: internal error: work tree has already been set
Current worktree: /home/bsnoksru/git/foo
New worktree: /home/bsnoksru/git/foo/folder


--=20
bjornar@snoksrud.no
