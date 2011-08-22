From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: [Git 1.7.6.557.gcee4] git stash
Date: Sun, 21 Aug 2011 23:01:24 -0700
Message-ID: <CAE1pOi1D+J5_fmsdhho1FRAipyO3Ri7GS_wy4fTNtCGbatDaDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: David Caldwell <david@porkrind.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 08:03:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvNbg-0007j4-De
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 08:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab1HVGBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 02:01:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50020 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab1HVGBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 02:01:25 -0400
Received: by ywf7 with SMTP id 7so3293567ywf.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=/jeezLZyMs2khbgMtZYktG3RJT+FNylZ4KpTl8xCa5Q=;
        b=ZXcUIEKBAGFtqiFZi4ibznzTTeRF4c7/hROk3Jx4Wx71jn38Nl48CDBnjHFLfHB4mc
         bO6NKF4nJm5GBlgYRXpRcyKeIxOFZqu7SKPZlkbo3zVY/F63p4KFJQuSFHivxSOWOmNb
         sCMORLLu7av8cn9sNEBy2mfm2gA46k+uMkeZw=
Received: by 10.236.136.167 with SMTP id w27mr11590885yhi.102.1313992884510;
 Sun, 21 Aug 2011 23:01:24 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Sun, 21 Aug 2011 23:01:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179842>

Hi David,

I noticed your very timely change to git stash in the current master
branch. I tried it but it doesn't behave as I was expecting/hoping.

hilco@centaur ~/tmp/repo repo$ git --version
git version 1.7.6.557.gcee4
hilco@centaur ~/tmp/repo repo$ git init
Initialized empty Git repository in /home/hilco/tmp/repo/.git/
hilco@centaur ~/tmp/repo repo (master #)$ cat >>.gitignore <<- EOF
>         *.ignore
>         ignore-dir/
> EOF
hilco@centaur ~/tmp/repo repo (master #%)$ mkdir src
hilco@centaur ~/tmp/repo repo (master #%)$ touch file.txt src/code.txt
hilco@centaur ~/tmp/repo repo (master #%)$ git add -A .
hilco@centaur ~/tmp/repo repo (master #)$ git commit -m '1'
[master (root-commit) 0fb4106] 1
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 file.txt
 create mode 100644 src/code.txt
hilco@centaur ~/tmp/repo repo (master)$ touch file-a.ignore src/file-b.ignore
hilco@centaur ~/tmp/repo repo (master %)$ echo "hello">src/code.txt
hilco@centaur ~/tmp/repo repo (master *%)$ mkdir ignore-dir
hilco@centaur ~/tmp/repo repo (master *%)$ touch
ignore-dir/{file.ignore,file.txt}
hilco@centaur ~/tmp/repo repo (master *%)$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   src/code.txt
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       file-a.ignore
#       ignore-dir/
#       src/file-b.ignore
no changes added to commit (use "git add" and/or "git commit -a")
hilco@centaur ~/tmp/repo repo (master *%)$ git stash --no-keep-index --all
Saved working directory and index state WIP on master: 0fb4106 1
HEAD is now at 0fb4106 1
Not removing ignore-dir/
hilco@centaur ~/tmp/repo repo (master $%)$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       ignore-dir/
nothing added to commit but untracked files present (use "git add" to track)

So it quite explicitly states "Not removing ignore-dir/". How do I
make sure it also stashes the ignore-dir directory?

Cheers,
Hilco
