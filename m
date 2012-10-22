From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: make test
Date: Mon, 22 Oct 2012 16:19:39 +0200
Message-ID: <001a01cdb060$45fbc7d0$d1f35770$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:19:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQIrH-0001fl-3V
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 16:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab2JVOTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 10:19:47 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:58582 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab2JVOTr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 10:19:47 -0400
Received: from DualCore (dsdf-4d0a104c.pool.mediaWays.net [77.10.16.76])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MhrpH-1TmURW2Cbz-00Mtye; Mon, 22 Oct 2012 16:19:45 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2wYEU4cO48uZeUQ0O37WWWQ271mA==
Content-language: de
X-Provags-ID: V02:K0:SlP9CBQLAlWgp62tFUxqpLvYzXmCN44X3SgocagISLq
 jbRvMCpFSx1LSjyR88dfct6Fh6+0XXGlfdFBLbxpqi2brMNfbs
 YFF+W3kuwEp8SPit2VZlqZjRCOM7H9fk0UXfRVWxijCVyZRo6L
 vuLKHXZoOfgB/+oxQykdrNGIOeRRK7hvJSlSdMYsvFNWKHiecq
 cPL0jX0OvBdqFJ3A4fNdy/R5PRhawA8woYN0iRgza8oUvOWcAG
 xufw9nZCY0Y+DltFcu0pldvlzLN+hXu+zGblpmBSEmw6/Vf4Ar
 oK1LXLVcTSt0lsNPzf2fW6Zh7TEp1uTs6QDbeoqswA5n8l/wbx
 2JQ0SZkrzDGSyOlMtZES+Tv1hStNGCvrgipRGNCViIRlgp0CS+
 Moul+XTwCmDKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208188>

"Joachim Schmitz" <jojo@schmitz-digital.de> schrieb im Newsbeitrag news:<k5gov5$fe1$1@ger.gmane.org>...
> Hi folks
> 
> I'm trying to understand why certain tests in 'make test' fail. Here's the 
> first one
> 
> $ ../git --version
> git version 1.8.0.rc2.5.g6b89306
> $ GIT_TEST_CMP_USE_COPIED_CONTEXT=true ./t0000-basic.sh # our diff doesn't 
> understand -u
> ok 1 - .git/objects should be empty after git init in an empty repo
> ...
> ok 3 - success is reported like this
> not ok 4 - pretend we have a known breakage # TODO known breakage
> 
>     This is expected, right?
> 
> ok 5 - pretend we have fixed a known breakage (run in sub test-lib)
> ...
> ok 11 - tests clean up after themselves
> 
>     the next is not though? Why might it be failing, where to check?
> 
> not ok - 12 tests clean up even on failures
> #
> #               mkdir failing-cleanup &&
> #               (
> #               cd failing-cleanup &&
> #
> #               cat >failing-cleanup.sh <<-EOF &&
> #               #!/bin/sh
> #
> #               test_description='Failing tests with cleanup commands'
> #
> #               # Point to the t/test-lib.sh, which isn't in ../ as usual
> #               TEST_DIRECTORY="/home/jojo/git/git/t"
> #               . "$TEST_DIRECTORY"/test-lib.sh
> #
> #               test_expect_success 'tests clean up even after a failure' '
> #                       touch clean-after-failure &&
> #                       test_when_finished rm clean-after-failure &&
> #                       (exit 1)
> #               '
> #               test_expect_success 'failure to clean up causes the test to 
> fail' '
> #                       test_when_finished "(exit 2)"
> #               '
> #               test_done
> #
> #               EOF
> #
> #               chmod +x failing-cleanup.sh &&
> #               test_must_fail ./failing-cleanup.sh >out 2>err &&
> #               ! test -s err &&
> #               ! test -f "trash 
> directory.failing-cleanup/clean-after-failure" &&
> #               sed -e 's/Z$//' -e 's/^> //' >expect <<-\EOF &&
> #               > not ok - 1 tests clean up even after a failure
> #               > #     Z
> #               > #     touch clean-after-failure &&
> #               > #     test_when_finished rm clean-after-failure &&
> #               > #     (exit 1)
> #               > #     Z
> #               > not ok - 2 failure to clean up causes the test to fail
> #               > #     Z
> #               > #     test_when_finished "(exit 2)"
> #               > #     Z
> #               > # failed 2 among 2 test(s)
> #               > 1..2
> #               EOF
> #               test_cmp expect out
> #               )
> #
> ok 13 - git update-index without --add should fail adding
> ...
> ok 47 - very long name in the index handled sanely
> # still have 1 known breakage(s)
> # failed 1 among remaining 46 test(s)
> 1..47

As mentioned elsethread this works if using bash rather than the system's sh (which is a ksh)

But there are several other failures. After some investigations and experiments I found the following tests to fail with the system
provided grep (for which I had to set GIT_TEST_CMP_USE_COPIED_CONTEXT), but succeed with GNU grep:
t3308 #14, #15, #17and #19
t3310 #10, #12, #14 and #18
t4047 #38 and #39
t4050 #2 and #3
t4116 #3, #4 and #5
t5509 #2
t7401 #18

The following fail with the system provided tar, but succeed with GNU tar:
t0024 #2
t4116 #4,
t5000 #14, #16, #20, #24, #26 and #51
t5001 #2, #6, #10 and #15

The following tests fail with the system provided sh (which is a ksh really), but succeed with bash:
t0000 #12
t0001 #20
t1450 #17 and #18
(t0204 #3 and #8 succeed in sh but fail in bash. They succeed in bash too when /usr/local/bin is in PATH first though, which would
sort the diff and tar problem too, need to investigate why)
t3006 #2 and #3

t3403 #4, #5, #8 and #9
t3404 #2 - #13, #14 - #18, #20 - #41, #44, #46 - #70
t3409 #2 - #5
t3410 #2 and #3
t3411 #2 and #3
t3412 #8, #10 - #12, #15, #17, #23, #25, -26, #28, #29, #31
t3413 #3, #5 - #10, #14, #15
and many more...

The following needs bash and /usr/local/bin first in PATH ("PATH=/usr/local/bin:$PATH make test")
t0204 #3 and #8 (or just sh, see above)
t3032 #11
t3900 #24, #25
t4201 #8
t5000 #14
t5150 #6

I though "SANE_TOOL_PATH=/usr/local/bin" plus "SHELL_PATH=/usr/local/bin/bash" would to fix the all but it does not and instead
brings up some other failures too:
t5521 #2 and #5
t5526 #2, #5, #8, #10, #12, #13, #16 - #19, #21 - #25
t5702 #3
t5800 #2, #3, #5 - #14
t9001 #66

With additionally having "PATH=/usr/local/bin:$PATH" all but one work, so there must be something wrong with SANE_TOOL_PATH?.
The single failure remaining is
t0301 #12 "helper (cache --timeout=1) times out"
I don't understand this at all, neither the -v options nor running it with bash -x helps me in understanding what the issue is.

Bye, Jojo
