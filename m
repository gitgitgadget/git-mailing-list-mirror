From: Andriy Gapon <avg@FreeBSD.org>
Subject: Re: Bug in git rebase --continue in v1.8.4
Date: Wed, 04 Sep 2013 11:53:12 +0300
Message-ID: <5226F4F8.7090304@FreeBSD.org>
References: <5221E661.1070200@gmx.de> <5226E8FC.8070208@FreeBSD.org> <vpqsixl9ezo.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH8qx-00036y-LX
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934512Ab3IDIyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:54:14 -0400
Received: from citadel.icyb.net.ua ([212.40.38.140]:4118 "EHLO
	citadel.icyb.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934416Ab3IDIyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:54:12 -0400
Received: from porto.starpoint.kiev.ua (porto-e.starpoint.kiev.ua [212.40.38.100])
	by citadel.icyb.net.ua (8.8.8p3/ICyb-2.3exp) with ESMTP id LAA23227;
	Wed, 04 Sep 2013 11:54:09 +0300 (EEST)
	(envelope-from avg@FreeBSD.org)
Received: from localhost ([127.0.0.1])
	by porto.starpoint.kiev.ua with esmtp (Exim 4.34 (FreeBSD))
	id 1VH8qn-0006QG-1H; Wed, 04 Sep 2013 11:54:09 +0300
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:17.0) Gecko/20130810 Thunderbird/17.0.8
In-Reply-To: <vpqsixl9ezo.fsf@anie.imag.fr>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233824>

on 04/09/2013 11:18 Matthieu Moy said the following:
> [ Cc-ing Ram, as he is the author of the possibly guilty commit. ]
> 
> Andriy Gapon <avg@FreeBSD.org> writes:
>> Judging by the lack of followups, could this be a FreeBSD-specific problem?
> 
> I can't reproduce here (Debian GNU/Linux). Do the testsuite pass for
> you?
> 
> If not, can you write a failing test? A minimalist script outside the
> testsuite may help too if you're not familiar with Git's testsuite.

Thank you for the suggestion.
I've just tried it and it failed here:

*** t3403-rebase-skip.sh ***
ok 1 - setup
ok 2 - rebase with git am -3 (default)
ok 3 - rebase --skip can not be used with other options
not ok 4 - rebase --skip with am -3
#
#               git rebase --skip
#
not ok 5 - rebase moves back to skip-reference
#
#               test refs/heads/skip-reference = $(git symbolic-ref HEAD) &&
#               git branch post-rebase &&
#               git reset --hard pre-rebase &&
#               test_must_fail git rebase master &&
#               echo "hello" > hello &&
#               git add hello &&
#               git rebase --continue &&
#               test refs/heads/skip-reference = $(git symbolic-ref HEAD) &&
#               git reset --hard post-rebase
#
ok 6 - checkout skip-merge
ok 7 - rebase with --merge
not ok 8 - rebase --skip with --merge
#
#               git rebase --skip
#
ok 9 - merge and reference trees equal
not ok 10 - moved back to branch correctly
#
#               test refs/heads/skip-merge = $(git symbolic-ref HEAD)
#
# failed 4 among 10 test(s)


Christoph has also suggested a small test script in his original email that
started this thread:
http://thread.gmane.org/gmane.comp.version-control.git/233516

-- 
Andriy Gapon
