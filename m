From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: master: t5800-remote-helpers.sh hangs on test "pulling from remote
 remote"
Date: Sat, 14 Apr 2012 11:01:12 +0200
Message-ID: <4F893CD8.5020700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 11:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIyrE-00086B-4Q
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 11:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab2DNJBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 05:01:19 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37109 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2DNJBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 05:01:17 -0400
Received: by wgbdr13 with SMTP id dr13so3710116wgb.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=6UNQKwR/n+C5hEybNqf74qMmSTtjzYQo7Eo9PFJNXBo=;
        b=SswkI7Q3TuwWplO/VbbTkbB0VlIRyN995ekPqhPGaGRKJ3tRjgoEiB8OL88q9utBIZ
         n+LNG6tWYP7aG/Gqxknhh3ZvHc5BFR9OFyf62PZdBEav8SGybKZFDZPcBeOrJs+3lsvS
         TskHvq3pXSmKqnuBL5om1qh1+uexKbARhzUoHdLTS+p3so8UI6UmljNl58F8kqvHkQHt
         pnUNR9gOnEdAIM7lbAfKcL5TG9LHpJG5ylKiH+1ybh0ToXBw2SIQ9q5Mcv0lvZi500/f
         zyI7UU2IaLc/8v9ZFZkNz7QK7RVPQzxAufCmpdbxR4P99TiRwp193BGlGFnLJAreSqPw
         3qDw==
Received: by 10.180.97.4 with SMTP id dw4mr2838839wib.18.1334394076446;
        Sat, 14 Apr 2012 02:01:16 -0700 (PDT)
Received: from [82.60.36.120] (host120-36-dynamic.60-82-r.retail.telecomitalia.it. [82.60.36.120])
        by mx.google.com with ESMTPS id ff2sm4883145wib.9.2012.04.14.02.01.14
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 02:01:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195482>

The test 't5800-remote-helpers.sh' hangs on my Linux desktop (where I have
installed a custom simple-minded firewall based on iptables).  This does
not happen on remote systems I use for testing, so I guess the problem
lies with my machine.  Still, having the test to hang is unnecessarily
harsh and user-unfriendly IMHO, and it would be better to detect the
situation and SKIP or FAIL the affected test cases instead.

For reference, here is the output of the test 't5800-remote-helpers.sh' run
with the '-v' option:

-*-*-

Initialized empty Git repository in /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/.git/
expecting success:
        git init --bare server/.git &&
        git clone server public &&
        (cd public &&
         echo content >file &&
         git add file &&
         git commit -m one &&
         git push origin master)

Initialized empty Git repository in /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server/.git/
Cloning into 'public'...
warning: You appear to have cloned an empty repository.
done.
[master (root-commit) 9a7aa46] one
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file
Counting objects: 3, done.
Unpacking objects: 100% (3/3), done.
Writing objects: 100% (3/3), 219 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
 * [new branch]      master -> master
ok 1 - setup repository

expecting success:
        git clone "testgit::${PWD}/server" localclone &&
        test_cmp public/file localclone/file

Cloning into 'localclone'...
ok 2 - cloning from local repo

expecting success:
        git clone "testgit::file://${PWD}/server" clone &&
        test_cmp public/file clone/file

Cloning into 'clone'...
ok 3 - cloning from remote repo

expecting success:
        (cd public &&
         echo content >>file &&
         git commit -a -m two &&
         git push)

[master 0eb255a] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
Counting objects: 5, done.
Unpacking objects: 100% (3/3), done.
Writing objects: 100% (3/3), 252 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To /devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
   9a7aa46..0eb255a  master -> master
ok 4 - create new commit on remote

expecting success:
        (cd localclone && git pull) &&
        test_cmp public/file localclone/file

>From testgit::/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
   9a7aa46..0eb255a  master     -> origin/master
Updating 9a7aa46..0eb255a
Fast-forward
 file |    1 +
 1 file changed, 1 insertion(+)
ok 5 - pulling from local repo

expecting success:
        (cd clone && git pull) &&
        test_cmp public/file clone/file

>From testgit::file:///devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server
   9a7aa46..0eb255a  master     -> origin/master
Updating 9a7aa46..0eb255a
Fast-forward
 file |    1 +
 1 file changed, 1 insertion(+)
ok 6 - pulling from remote remote

expecting success:
        (cd localclone &&
        echo content >>file &&
        git commit -a -m three &&
        git push) &&
        compare_refs localclone HEAD server HEAD

[master 30d4cae] three
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)

-*-*-

At this point, the test hangs, and I have to manually kill it with a SIGINT,
the result being:

-*-*-

Traceback (most recent call last):
  File "/devel/stefano/src/git/git-remote-testgit", line 265, in <module>
    sys.exit(main(sys.argv))
  File "/devel/stefano/src/git/git-remote-testgit", line 262, in main
    more = read_one_line(repo)
  File "/devel/stefano/src/git/git-remote-testgit", line 227, in read_one_line
    func(repo, cmdline)
  File "/devel/stefano/src/git/git-remote-testgit", line 175, in do_export
    changed = repo.importer.do_import(repo.gitdir)
  File "/home/stefano/src/git/t/../git_remote_helpers/build/lib/git_remote_helpers/git/importer.py", line 54, in do_import
    check_call(args)
  File "/home/stefano/src/git/t/../git_remote_helpers/build/lib/git_remote_helpers/util.py", line 169, in check_call
    retcode = call(*popenargs, **kwargs)
  File "/home/stefano/src/git/t/../git_remote_helpers/build/lib/git_remote_helpers/util.py", line 155, in call
    return subprocess.Popen(*popenargs, **kwargs).wait()
  File "/usr/lib/python2.7/subprocess.py", line 1291, in wait
    pid, sts = _eintr_retry_call(os.waitpid, self.pid, 0)
  File "/usr/lib/python2.7/subprocess.py", line 478, in _eintr_retry_call
    return func(*args)
KeyboardInterrupt
FATAL: Unexpected exit with code 0

-*-*-

If I run ps(1) in another terminal before interrupting the hung test, the
following command sticks out as a possible culprit:

git-fast-import --quiet --export-marks=/devel/stefano/src/git/t/trash \
directory.t5800-remote-helpers/localclone/.git/info/fast-import/\
c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks \
--import-marks=/devel/stefano/src/git/t/'trash directory.t5800-remote-helpers'/\
localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/\
git.marks

-*-*-

Other possibly relevant information:

  $ hg --version | head -1
  Mercurial Distributed SCM (version 1.8.3) $ python --version

  $ python --version
  Python 2.7.2+

  $ /bin/sh --version | head -1
  GNU bash, version 4.1.5(1)-release (i486-pc-linux-gnu)

  $ git describe
  v1.7.10-167-gf245c01
