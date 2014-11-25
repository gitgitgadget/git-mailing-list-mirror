From: debugging data <debugging.data@gmail.com>
Subject: push rejected (non-fast-forward)
Date: Tue, 25 Nov 2014 12:45:45 -0500
Message-ID: <C2E11014-CFE8-490E-A21A-DB42CC8E4175@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 18:43:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtK9Q-0003ir-PF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 18:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbaKYRnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 12:43:40 -0500
Received: from mail-yh0-f67.google.com ([209.85.213.67]:51110 "EHLO
	mail-yh0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaKYRnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 12:43:40 -0500
Received: by mail-yh0-f67.google.com with SMTP id a41so107199yho.10
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=KvAkSgi3A3Hy9BrqnciRl44VGGV9RxkUS67os9Mppp8=;
        b=Kbqk73sJguQ3jgyHmphpXyP82f53iA7uC2ETCuu/30rvtTwlG2CiF05TbpRJiCu++p
         3GAQJUXqoK96GTpOFd8O7fyaaA3KW+AaCNdFQcqpZMy8QV+sKHdNjA+4JjWhz3NgyeL8
         W3kx6ZcKjgS0/0q1k0nQquew7jN365I04nSzbkfjVz/7VAgzTl3aDk/9DMSZqENFxgLK
         gSQwilFR2ni5t9Mdp0Cb1CFm+tCCaY3TaD4X6nRc8HQq3V/Y5v8vEWjDtG7b4UuFeNNe
         y1j9mij6M9mk7+y1PpyzSQCJUcUrRGgOs0NzOvKfBAm06ZZfdbe7IF4iKDMUrpcZ+OC2
         TtMg==
X-Received: by 10.170.72.7 with SMTP id o7mr28150686yko.73.1416937419355;
        Tue, 25 Nov 2014 09:43:39 -0800 (PST)
Received: from [10.0.0.15] (c-69-136-29-70.hsd1.fl.comcast.net. [69.136.29.70])
        by mx.google.com with ESMTPSA id e35sm945886yhq.45.2014.11.25.09.43.38
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 09:43:39 -0800 (PST)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260227>

Changes to a remote branch causes a user not to be able to push their
changes because their tip is behind its remote counterpart.


Here are the git repos:

github.com/user-one/project
github.com/user-two/project

Here's what happened:

1. user-one creates a project and adds file-one.txt to the repo with
contents "file one"

2. user-one commits and pushes to master

3. user-one creates directory "foo/" with a file named "foo.txt". "foo.txt"
contains text "foo"

4. user-one commits and pushes to master

5. user-two forks github.com/user-one/project

6. user-two creates new branch called "so-much-foo" and changes the text of
foo/foo.txt to "so much foo"

7. user-two commit, pushes, to origin/master, and creates a pull request

8. user-one creates "file-two.txt" with contents "file two", commits, and
pushes to master

9. user-two changes the contents of "foo/foo.txt" from "so much foo" to
"foo\nfoo", then commits the file

10. user-two types this command: `git remote add user-one git@github.com:
user-one/project.git`

11. user-two types another command: git pull --rebase user-one master

12. user-two attempts to push changes to the branch so-much-foo but is
denied as seen here:

$ git push origin so-much-foo
To git@github.com:user-two/project.git
 ! [rejected]        so-much-foo -> so-much-foo (non-fast-forward)
error: failed to push some refs to 'git@github.com:user-two/project.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.


It doesn't look like the tip is behind though:


/project$ git log
commit dd240b6ba15d27d074726e9b1b0e665e3507a2fd
Author: User Two <debugging.data+user2@gmail.com>
Date:   Mon Nov 24 22:55:45 2014 +0000

    foo/foo.txt from "so much foo" to "foo\nfoo"

commit 5cd55b8775750c2631b3c1f249f541402cc38c27
Author: User Two <debugging.data+user2@gmail.com>
Date:   Mon Nov 24 22:51:12 2014 +0000

    changed foo/foo.txt contents to "so much foo"

commit 75fca5dfa5157a18b55bb89fba70aee8680cfbf2
Author: User One <debugging.data+user1@gmail.com>
Date:   Mon Nov 24 22:52:42 2014 +0000

    file-two.txt with contents "file two"

commit faf9ccfbde95158b2b4a3e291a1e32789381a37e
Author: User One <debugging.data+user1@gmail.com>
Date:   Mon Nov 24 22:46:28 2014 +0000

    foo/ and foo/foo.txt with contents "foo"

commit 17471484163127daaf5233eccf5fac89e9d7a53e
Author: User One <debugging.data+user1@gmail.com>
Date:   Mon Nov 24 22:43:08 2014 +0000

    file-one.txt with contents "file one"


I have struggled with this today, and I'm not sure what to do, so I've
resorted to asking for help here. I guess someone here has dealt with this
at least once.

Are there tools that would help make this process easier?
