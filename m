From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: make test
Date: Mon, 15 Oct 2012 12:36:00 +0200
Message-ID: <k5gov5$fe1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 12:36:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNi2T-00045R-Ii
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 12:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab2JOKgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 06:36:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:45320 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab2JOKgi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 06:36:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TNi2L-0003uB-6o
	for git@vger.kernel.org; Mon, 15 Oct 2012 12:36:41 +0200
Received: from dsdf-4d0a1987.pool.mediaways.net ([77.10.25.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 12:36:41 +0200
Received: from jojo by dsdf-4d0a1987.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 12:36:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a1987.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207730>

Hi folks

I'm trying to understand why certain tests in 'make test' fail. Here's the 
first one

$ ../git --version
git version 1.8.0.rc2.5.g6b89306
$ GIT_TEST_CMP_USE_COPIED_CONTEXT=true ./t0000-basic.sh # our diff doesn't 
understand -u
ok 1 - .git/objects should be empty after git init in an empty repo
...
ok 3 - success is reported like this
not ok 4 - pretend we have a known breakage # TODO known breakage

    This is expected, right?

ok 5 - pretend we have fixed a known breakage (run in sub test-lib)
...
ok 11 - tests clean up after themselves

    the next is not though? Why might it be failing, where to check?

not ok - 12 tests clean up even on failures
#
#               mkdir failing-cleanup &&
#               (
#               cd failing-cleanup &&
#
#               cat >failing-cleanup.sh <<-EOF &&
#               #!/bin/sh
#
#               test_description='Failing tests with cleanup commands'
#
#               # Point to the t/test-lib.sh, which isn't in ../ as usual
#               TEST_DIRECTORY="/home/jojo/git/git/t"
#               . "$TEST_DIRECTORY"/test-lib.sh
#
#               test_expect_success 'tests clean up even after a failure' '
#                       touch clean-after-failure &&
#                       test_when_finished rm clean-after-failure &&
#                       (exit 1)
#               '
#               test_expect_success 'failure to clean up causes the test to 
fail' '
#                       test_when_finished "(exit 2)"
#               '
#               test_done
#
#               EOF
#
#               chmod +x failing-cleanup.sh &&
#               test_must_fail ./failing-cleanup.sh >out 2>err &&
#               ! test -s err &&
#               ! test -f "trash 
directory.failing-cleanup/clean-after-failure" &&
#               sed -e 's/Z$//' -e 's/^> //' >expect <<-\EOF &&
#               > not ok - 1 tests clean up even after a failure
#               > #     Z
#               > #     touch clean-after-failure &&
#               > #     test_when_finished rm clean-after-failure &&
#               > #     (exit 1)
#               > #     Z
#               > not ok - 2 failure to clean up causes the test to fail
#               > #     Z
#               > #     test_when_finished "(exit 2)"
#               > #     Z
#               > # failed 2 among 2 test(s)
#               > 1..2
#               EOF
#               test_cmp expect out
#               )
#
ok 13 - git update-index without --add should fail adding
...
ok 47 - very long name in the index handled sanely
# still have 1 known breakage(s)
# failed 1 among remaining 46 test(s)
1..47

Bye, Jojo 
