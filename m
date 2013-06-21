From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [HELP] Corrupted repository
Date: Fri, 21 Jun 2013 16:19:20 +0530
Message-ID: <CALkWK0mQj+x3bxbxWKuwpeMj8E8bfvyK-c2bAWna6a9Xe=nBOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 12:50:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upyuv-0002FW-H1
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 12:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab3FUKuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 06:50:01 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33132 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3FUKuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 06:50:00 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so18968478iet.37
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=FAc12SFD5Cpn05OA4vsczhGQe2l86kmVc6192QCdx8M=;
        b=Vv/S44gLr0U5+RIM+tPoxPoHJCfoIwbBG2lC+80/HjxHVDOM2O+trHKvYrtt2tpIVK
         hUSVmNiy7h/Msg5DcrWV+bW+KHOLYgV7EE3mHyX1IFhiU2qHJUcqv2rG3cAxgPGwFhYY
         6Gu6Uxc7TbkMmCfhtLb/B52gvOQpGcYiQHIsrdYqWct4zHYvPUaejeLrkbPjd/RGNmDZ
         ZgM6NyYNg7wohl7AEyHY3QPtVX2365Enf9L0PfiMMs77/5FF21CVoRSCZsEBLSSrSqTV
         AHYH6gGlx5n1WHKM971L3XdQaqcA9QZlyPyIM1a//7CltQ1d8o+sdDCwcRpwlUqcGESu
         P8Qg==
X-Received: by 10.50.47.105 with SMTP id c9mr1900634ign.50.1371811800283; Fri,
 21 Jun 2013 03:50:00 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 03:49:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228592>

Hi,

Until now, my interest in corrupted repositories has been very
limited.  Just now, the power went out for a second and my UPS failed
me.  As a result, my ~/src/git is completely borked.  For your
amusement, here's a quick session showing me bumbling around:

  $ ~/src/git
  error: object file
.git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
  error: object file
.git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f is empty
  fatal: loose object 8e6a6dda24b017915449897fcc1353a9b848fd2f (stored
in .git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f) is corrupt
  artagnon|remote-cruft*+:~/src/git$ rm
.git/objects/8e/6a6dda24b017915449897fcc1353a9b848fd2f
  artagnon|remote-cruft*+:~/src/git$ git prune
  artagnon|remote-cruft*+:~/src/git$ git status
  fatal: bad object HEAD
  fatal: bad object HEAD
  artagnon|remote-cruft*+:~/src/git$ git symbolic-ref HEAD refs/heads/master
  artagnon|master*+=:~/src/git$ git status
  ## master
  MM Documentation/git-ls-remote.txt
  MM remote.c
  MM t/t5505-remote.sh
  MM t/t5510-fetch.sh
  MM t/t5515-fetch-merge-logic.sh
  MM t/t5516-fetch-push.sh
  ?? lib/
  ?? outgoing/

That status is completely bogus, by the way.

  artagnon|master*+=:~/src/git$ git reset --hard
  artagnon|master*+=:~/src/git$ git checkout remote-cruft
  fatal: reference is not a tree: remote-cruft
  artagnon|master=:~/src/git$ git reflog
  21ff915 HEAD@{10 minutes ago}: rebase -i (finish): returning to
refs/heads/remote-cruft

What happened to the rest of my reflog?!  Okay, I give up.  Let's go
back to what's present on Github.  I push often, so it's not a
problem.

  artagnon|master=:~/src/git$ git branch -D remote-cruft
  error: Couldn't look up commit object for 'refs/heads/remote-cruft'
  artagnon|master=:~/src/git$ rm .git/refs/heads/remote-cruft
  artagnon|master=:~/src/git$ git checkout -b remote-cruft
  Switched to a new branch 'remote-cruft'

Huh?  What happened to my upstream?

  artagnon|remote-cruft:~/src/git$ git branch -u ram/remote-cruft
  warning: ignoring broken ref refs/remotes/ram/remote-cruft.

Fine, let's fetch.

  artagnon|remote-cruft:~/src/git$ git fetch ram
  remote: Counting objects: 101, done.
  remote: Compressing objects: 100% (24/24), done.
  remote: Total 92 (delta 78), reused 82 (delta 68)
  error: object file
.git/objects/08/2b069c11e8d4f372b963b038cbf5b71a676ef6 is empty
  fatal: loose object 082b069c11e8d4f372b963b038cbf5b71a676ef6 (stored
in .git/objects/08/2b069c11e8d4f372b963b038cbf5b71a676ef6) is corrupt
  fatal: unpack-objects failed

Fine, let's run an fsck and get rid of all the corrupted objects.

  $ git fsck
  error: object file
.git/objects/08/2b069c11e8d4f372b963b038cbf5b71a676ef6 is empty
  error: object file
.git/objects/08/2b069c11e8d4f372b963b038cbf5b71a676ef6 is empty
  fatal: loose object 082b069c11e8d4f372b963b038cbf5b71a676ef6 (stored
in .git/objects/08/2b069c11e8d4f372b963b038cbf5b71a676ef6) is corrupt
  artagnon|remote-cruft:~/src/git$ rm
.git/objects/08/2b069c11e8d4f372b963b038cbf5b71a676ef6
  artagnon|remote-cruft:~/src/git$ git repack
  artagnon|remote-cruft:~/src/git$ git fetch ram
  remote: Counting objects: 101, done.
  remote: Compressing objects: 100% (24/24), done.
  remote: Total 92 (delta 78), reused 82 (delta 68)
  Unpacking objects: 100% (92/92), done.
  error: object file
.git/objects/64/fa33d706658278b871a6e2ca66694efcadacca is empty
  fatal: loose object 64fa33d706658278b871a6e2ca66694efcadacca (stored
in .git/objects/64/fa33d706658278b871a6e2ca66694efcadacca) is corrupt
  error: github.com:artagnon/git did not send all necessary objects

Fine, my packfiles are corrupt.  Let's unpack-objects by hand.

  artagnon|remote-cruft:~/src/git$ mv .git/objects/pack .git/objects/pack.old
  artagnon|remote-cruft+:~/src/git$ for i in
.git/objects/pack.old/*.pack; do git unpack-objects -r <$i; done
  artagnon|remote-cruft:~/src/git$ git fetch ram
  remote: Counting objects: 101, done.
  remote: Compressing objects: 100% (24/24), done.
  remote: Total 92 (delta 78), reused 82 (delta 68)
  Unpacking objects: 100% (92/92), done.
  error: object file
.git/objects/64/fa33d706658278b871a6e2ca66694efcadacca is empty
  fatal: loose object 64fa33d706658278b871a6e2ca66694efcadacca (stored
in .git/objects/64/fa33d706658278b871a6e2ca66694efcadacca) is corrupt
  error: github.com:artagnon/git did not send all necessary objects

  Auto packing the repository for optimum performance. You may also
  run "git gc" manually. See "git help gc" for more information.
  error: bad ref for refs/remotes/ram/remote-cruft
  error: bad ref for refs/remotes/ram/remote-cruft
  Counting objects: 161917, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (159963/159963), done.
  Writing objects: 100% (161917/161917), done.
  Total 161917 (delta 117725), reused 0 (delta 0)
  Removing duplicate objects: 100% (256/256), done.
  error: bad ref for refs/remotes/ram/remote-cruft
  Checking connectivity: 161917, done.
  warning: There are too many unreachable loose objects; run 'git
prune' to remove them.

I'm assuming it just went back and fetched everything the second time.
 Why didn't it do that in the first place?

  artagnon|remote-cruft:~/src/git$ git log ram/remote-cruft
  warning: ignoring broken ref refs/remotes/ram/remote-cruft.

Now what?  Why didn't the fetch update this ref?

  artagnon|remote-cruft:~/src/git$ rm .git/refs/remotes/ram/remote-cruft
  artagnon|remote-cruft:~/src/git$ git fetach ram
  remote: Counting objects: 101, done.
  remote: Compressing objects: 100% (24/24), done.
  remote: Total 92 (delta 78), reused 82 (delta 68)
  Unpacking objects: 100% (92/92), done.
  From github.com:artagnon/git
   * [new branch]      remote-cruft -> ram/remote-cruft
   * [new branch]      upstream-fix -> ram/upstream-fix

Yes!  Everything finally works.

Was I being stupid, or is fixing corrupted repositories really this
non-trivial?  Comments appreciated.

Thanks.
