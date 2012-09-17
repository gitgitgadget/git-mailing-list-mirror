From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 22:53:18 +0530
Message-ID: <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:24:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDf38-000485-0y
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2IQRXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:23:46 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39932 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab2IQRXk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 13:23:40 -0400
Received: by qcro28 with SMTP id o28so4668849qcr.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IvOPkoJ8QwW/FJy9xUGotSmNIy+3FlnMPyU+HyE1FPs=;
        b=Y6MasuEN31QHfo03GdMJyhsfJLtgoLgvGCBiv3tSCcYxCAT4uaNd1OHrIsQx6i33tU
         9zDx/bS8SCAB46EnE8Dsy1LO9ZAvmCMiioqeZpEGHagqJgcMxNqj2OGm9zMxVHMlw8UZ
         l49FUH7vmSXj/SS1IjLr+7pvQfBSqfyaY8zZgjE6Wqh2u6GxDS7ZyEVF9rQF9P3NGwHp
         NDjzVwoekJ6Zze9eFVxKzJIQChZ+6E1VIBIRoZtYcfId+UP5SJp8Lqd1R5VVpEPOQZGi
         WgOwhiYjRxQhh68JlZ50IhDK/q4XrSX0lM1roNgvqQBe/K0kyZV1PB7PeLsZkc/MVfC8
         sdUA==
Received: by 10.224.222.143 with SMTP id ig15mr29022289qab.25.1347902619263;
 Mon, 17 Sep 2012 10:23:39 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 10:23:18 -0700 (PDT)
In-Reply-To: <20120917172022.GA1179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205718>

Hi Peff,

Jeff King wrote:
> No, that should work (and it does work here). I assume you can pass
> t0000 without --valgrind?

Yes.  Here's the output from running it with --valgrind.  I'm digging
deeper to see what went wrong.

make_valgrind_symlink:6: permission denied:
/home/artagnon/src/git/t/../git-instaweb
./test-lib.sh:487: no matches found:
/home/artagnon/svn/prefix/svn-trunk/bin:/home/artagnon/bin:/home/artagnon/bin/depot_tools:/home/artagnon/.ruby/bin:/home/artagnon/.python/bin:/home/artagnon/.cabal/bin:/home/artagnon/svn/prefix/svn-trunk/bin:/home/artagnon/bin:/home/artagnon/bin/depot_tools:/home/artagnon/.ruby/bin:/home/artagnon/.python/bin:/home/artagnon/.cabal/bin:/home/artagnon/bin:/usr/local/bin:/usr/bin:/bin:/usr/games:/home/artagnon/.ec2/bin:/home/artagnon/.ec2/bin/git-*
Initialized empty Git repository in /home/artagnon/src/git/t/trash
directory.test-lib/.git/
expecting success:
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty

ok 1 - .git/objects should be empty after git init in an empty repo

expecting success:
        find .git/objects -type d -print >full-of-directories &&
        test_line_count = 3 full-of-directories

ok 2 - .git/objects should have 3 subdirectories

expecting success:
        :

ok 3 - success is reported like this

checking known breakage:
        false

not ok 4 - pretend we have a known breakage # TODO known breakage

expecting success:
        mkdir passing-todo &&
        (cd passing-todo &&
        cat >passing-todo.sh <<-EOF &&
        #!/bin/sh

        test_description='A passing TODO test

        This is run in a sub test-lib so that we do not get incorrect
        passing metrics
        '

        # Point to the t/test-lib.sh, which isn't in ../ as usual
        TEST_DIRECTORY="/home/artagnon/src/git/t"
        . "$TEST_DIRECTORY"/test-lib.sh

        test_expect_failure 'pretend we have fixed a known breakage' '
                :
        '

        test_done
        EOF
        chmod +x passing-todo.sh &&
        ./passing-todo.sh >out 2>err &&
        ! test -s err &&
        sed -e 's/^> //' >expect <<-\EOF &&
        > ok 1 - pretend we have fixed a known breakage # TODO known breakage
        > # fixed 1 known breakage(s)
        > # passed all 1 test(s)
        > 1..1
        EOF
        test_cmp expect out)

test_cmp:1: command not found: diff -u
not ok - 5 pretend we have fixed a known breakage (run in sub test-lib)
#
#               mkdir passing-todo &&
#               (cd passing-todo &&
#               cat >passing-todo.sh <<-EOF &&
#               #!/bin/sh
#
#               test_description='A passing TODO test
#
#               This is run in a sub test-lib so that we do not get incorrect
#               passing metrics
#               '
#
#               # Point to the t/test-lib.sh, which isn't in ../ as usual
#               TEST_DIRECTORY="/home/artagnon/src/git/t"
#               . "$TEST_DIRECTORY"/test-lib.sh
#
#               test_expect_failure 'pretend we have fixed a known breakage' '
#                       :
#               '
#
#               test_done
#               EOF
#               chmod +x passing-todo.sh &&
#               ./passing-todo.sh >out 2>err &&
#               ! test -s err &&
#               sed -e 's/^> //' >expect <<-\EOF &&
#               > ok 1 - pretend we have fixed a known breakage # TODO
known breakage
#               > # fixed 1 known breakage(s)
#               > # passed all 1 test(s)
#               > 1..1
#               EOF
#               test_cmp expect out)
#

expecting success:
        test_have_prereq HAVEIT &&
        haveit=yes

ok 6 - test runs if prerequisite is satisfied

skipping test: unmet prerequisite causes test to be skipped
        donthaveit=no

ok 7 # skip unmet prerequisite causes test to be skipped (missing DONTHAVEIT)

skipping test: test runs if prerequisites are satisfied
        test_have_prereq HAVEIT &&
        test_have_prereq HAVETHIS &&
        haveit=yes

ok 8 # skip test runs if prerequisites are satisfied (missing HAVETHIS,HAVEIT)

skipping test: unmet prerequisites causes test to be skipped
        donthaveit=no

ok 9 # skip unmet prerequisites causes test to be skipped (missing
HAVEIT,DONTHAVEIT)

skipping test: unmet prerequisites causes test to be skipped
        donthaveiteither=no

ok 10 # skip unmet prerequisites causes test to be skipped (missing
DONTHAVEIT,HAVEIT)

bug in test framework: multiple prerequisite tags do not work reliably
FATAL: Unexpected exit with code 1

> It seems very odd that valgrind would have an impact here, since those
> tests are not even running git.

Yeah, I know!

Ram
