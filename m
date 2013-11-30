From: Aaron Brooks <aaron@brooks1.net>
Subject: git stash doesn't honor --work-tree or GIT_WORK_TREE
Date: Sat, 30 Nov 2013 14:04:03 -0500
Message-ID: <CABL6xpD9jvJWjUj0n+mgC419fGzA2N-b_yJho9zharCD6YTSiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 30 20:04:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmpqA-0001Es-LC
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 20:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab3K3TE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 14:04:26 -0500
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:53108 "EHLO
	homiemail-a23.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750766Ab3K3TE0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Nov 2013 14:04:26 -0500
X-Greylist: delayed 11036 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Nov 2013 14:04:26 EST
Received: from homiemail-a23.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a23.g.dreamhost.com (Postfix) with ESMTP id F0EBB4B0063
	for <git@vger.kernel.org>; Sat, 30 Nov 2013 11:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=brooks1.net; h=
	mime-version:from:date:message-id:subject:to:content-type; s=
	brooks1.net; bh=cE+fiJ6F5dZfGY+T+jdoYP+iw6g=; b=XriQZxYxdArwzEJV
	JD+qDmPZtDGtcTF5dM85ahbrPEOXovhQ5CrSVzseUiSYoNun2q7MvlK3eF6MYuhe
	owVZvxiVXNrGTqic7UwB3Y53m6FPsCHhmINy9a/mtXZW9MLq10P2LhJaPK44eQcB
	v4w8jMeMalcXXNiLQnCavkYCH0Y=
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com [209.85.217.174])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: aaron@brooks1.net)
	by homiemail-a23.g.dreamhost.com (Postfix) with ESMTPSA id 9430F4B0062
	for <git@vger.kernel.org>; Sat, 30 Nov 2013 11:04:25 -0800 (PST)
Received: by mail-lb0-f174.google.com with SMTP id c11so7727042lbj.33
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 11:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=TyN0qtNeVZx7ZBf5XfHX/sR9lcPKSZb3bX0DNJxBzJ0=;
        b=EW5UvFZmqYbKk/f6jqhrpARqPXcAHPj1Rijn/Q7H8/yGSAXzI9HZjocLRpKl7NqzDJ
         K6UyG8bCVh2pCTRPk7AZWVfjU1EUXngqdkimNYqe5vhovIM9KwfX8hVImLLSa1fVzehH
         hH8h+5pimGbOwB5sE/yy3zyso6HUQO1KRIeQk9JgtqcvLy5CPpr89YwhI+nx04kSHT3D
         asoLAHqG5/zlRZf1gymXO3gHe7SdwoH94dEM6V3ABaIO/QEa2aMjAI+K6sm34rJs+VG8
         6cckdyI0KeKZvfvFIR9GuDpp7Atp0vMQN4n1N48nwE4k5kNziJUA9Cxg06tPGjy4flKp
         dMWg==
X-Received: by 10.112.53.97 with SMTP id a1mr342509lbp.38.1385838263700; Sat,
 30 Nov 2013 11:04:23 -0800 (PST)
Received: by 10.114.78.165 with HTTP; Sat, 30 Nov 2013 11:04:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238568>

Unlike other commands, git stash doesn't work outside of the worktree,
even when --work-tree is specified:

abrooks@host:~/tmp$ mkdir test-repo
abrooks@host:~/tmp$ cd !$
cd test-repo
abrooks@host:~/tmp/test-repo$ git init
Initialized empty Git repository in /home/abrooks/tmp/test-repo/.git/
abrooks@host:~/tmp/test-repo$ echo "foo" > foo.txt
abrooks@host:~/tmp/test-repo$ git add foo.txt
abrooks@host:~/tmp/test-repo$ git commit -m "adding foo"
[master (root-commit) 9d0705e] adding foo
 1 file changed, 1 insertion(+)
 create mode 100644 foo.txt
abrooks@host:~/tmp/test-repo$ echo "bar" >> foo.txt
abrooks@host:~/tmp/test-repo$ cd ..
abrooks@host:~/tmp$ git --git-dir=./test-repo/.git --work-tree=./test-repo stash
fatal: /usr/lib/git-core/git-stash cannot be used without a working tree.
abrooks@host:~/tmp$ cd test-repo/
abrooks@host:~/tmp/test-repo$ git stash
Saved working directory and index state WIP on master: 9d0705e adding foo
HEAD is now at 9d0705e adding foo
abrooks@host:~/tmp/test-repo$ cd ../
abrooks@host:~/tmp$ git --git-dir=./test-repo/.git
--work-tree=./test-repo stash list
fatal: /usr/lib/git-core/git-stash cannot be used without a working tree.

The same also does not work when setting GIT_DIR and GIT_WORK_TREE.

As a user, this seems wrong.

It looks like the "require_work_tree" function should check the
environment variables in addition to the status of the PWD (via
git-rev-parse).

Having looked through several of the other git-*.sh scripts, I think
other shell based git commands will have similar problems.

Thanks,

Aaron
