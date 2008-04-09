From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/8] git-rebase.sh: Fix --merge --abort failures when
 path contains whitespace
Date: Wed, 09 Apr 2008 16:51:20 +0200
Message-ID: <47FCD7E8.40004@viscovery.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <47FC6863.8070704@viscovery.net> <20080409143702.GD24402@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:52:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjbeo-0005Xc-OH
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbYDIOv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYDIOv1
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:51:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11197 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYDIOv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:51:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jjbdw-0002OA-FI; Wed, 09 Apr 2008 16:51:22 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 37483546; Wed,  9 Apr 2008 16:51:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080409143702.GD24402@shion.is.fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79112>

Bryan Donlan schrieb:
> On Wed, Apr 09, 2008 at 08:55:31AM +0200, Johannes Sixt wrote:
>> Bryan Donlan schrieb:
>>> +### Test that we handle strange characters properly
>>> +work_dir="$(pwd)/test \" ' \$ \\ dir"
>> In effect, you modify only this test to stress-test strange characters,
>> but other tests in the test suite still run in a "sane" environment. IOW,
>> I don't think you should go to this extreme for this one test only. The
>> better approach would be to rename 'trash' in test-lib.sh to this strange
>> name so that all tests suffer from a challenging environment.
> 
> I can do that, but it'd have to come as the last patch in the patchset,
> or it would obviously cause test failures. My goal here was to ensure
> that the bug I fixed in the patch would be tested in an isolated manner.

I for my taste could live without a test because the fix is so obvious.
Given that you have to prepend 'cd "$work_dir"' to *all* the tests, this
really just highlights that for the purpose of this test the name 'trash'
of the regular test directory is just too simple ;)

Of course, it's Junio's draw, and he likes to have tests for fixes that
are submitted.

> If you like I can add a change to the trash directory to the next rev of
> the patchset.

Yes, why not?

>>> -		git reset --hard pre-rebase
>>> -		test_must_fail git rebase'"$type"' master &&
>>> -		test -d '$dotest' &&
>>> +		git reset --hard pre-rebase &&
>>> +		test_must_fail git rebase$type master &&
>>> +		test -d \"\$dotest\" &&
>> I could imagine that the missing && after the git reset is deliberate. Mike?
> 
> I assumed that if git reset failed here we'd probably want to know :)

On second sight, this indeed looks just like an omission and your change
is good.

-- Hannes
