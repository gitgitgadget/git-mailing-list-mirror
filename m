From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: make test
Date: Mon, 15 Oct 2012 13:00:14 +0200
Message-ID: <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:00:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNiPk-0003Z9-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab2JOLAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:00:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:65071 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab2JOLAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:00:41 -0400
Received: from DualCore (dsdf-4d0a1987.pool.mediaWays.net [77.10.25.135])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MeMIx-1SzjL73QP1-00Pj8Z; Mon, 15 Oct 2012 13:00:40 +0200
In-Reply-To: <507BEB12.9040101@viscovery.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIVSFpveJljjAzS/2bNxxeCRCIxGwHjqAgSlxvZFNA=
Content-Language: de
X-Provags-ID: V02:K0:lByaXU15XzZ32tE8TyW8RVchccpZYEloccIvy+YnsuA
 0XkKbTIU+rXwIMBUqotMmI1VhEE0CZ/j/Tkj7bB2vmdDjWefFI
 jAmYGeKiy+2TgU7yj8qfi+XepPQkZO+dlxbnYemsFRl5Kpq1ap
 w/uVmXzn0TelU6IZNscJPtTJp9QmvyaqfmsBLShwfMTxG/ea6A
 M4kBu8ocx5AbhUDK5uzmSJYiBHiNpE4S2+XnvUnS8tUdRMr0mt
 TzwhkD7/E+zibE8m8wZeeC7L44YtRvYTQpnLVYKF5DiPtrt7Kb
 dM9gC1zkbrDPlfJeqU5lM5xcamG85sOZY2Z2lV+C/yW7eY0yKv
 mNJ4BlCeY5s9LtEDjbDWsYCI1HRFXxPnOfIkqKYN50yy7HKJcK
 eDL+nn9yYyOqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207734>

> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Sent: Monday, October 15, 2012 12:53 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: make test
> 
> Am 10/15/2012 12:36, schrieb Joachim Schmitz:
> > not ok 4 - pretend we have a known breakage # TODO known breakage
> >
> >    This is expected, right?
> 
> Right.
> 
> >    the next is not though? Why might it be failing, where to check?
> >
> > not ok - 12 tests clean up even on failures
> > #
> > #               mkdir failing-cleanup &&
> > #...
> > #               test_cmp expect out
> > #               )
> > #
> 
> First thing:
> 
>   ./t0000-basic.sh -v -i

OK, I should have mentioned that I did look with -v :
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
#               test_expect_success 'failure to clean up causes the test to fail' '
#                       test_when_finished "(exit 2)"
#               '
#               test_done
#
#               EOF
#
#               chmod +x failing-cleanup.sh &&
#               test_must_fail ./failing-cleanup.sh >out 2>err &&
#               ! test -s err &&
#               ! test -f "trash directory.failing-cleanup/clean-after-failure" &&
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

> and if that does not give sufficient clues,
> 
>   $SHELL_PATH -x ./t0000-basic.sh -v -i

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
#               test_expect_success 'failure to clean up causes the test to fail' '
#                       test_when_finished "(exit 2)"
#               '
#               test_done
#
#               EOF
#
#               chmod +x failing-cleanup.sh &&
#               test_must_fail ./failing-cleanup.sh >out 2>err &&
#               ! test -s err &&
#               ! test -f "trash directory.failing-cleanup/clean-after-failure" &&
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
+ die

Looks identical, except for the "die" at the end. And still leaves me without a clue...

> (Beware, though: in some cases, the latter gives additional failures, in
> particular, when the stderr of a command is checked for with test_cmp
> instead of grep because the 'actual' results contain the shell command
> logs, which are not in the 'expected' results.)
> 
> -- Hannes,

Bye, Jojo
