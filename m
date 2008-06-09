From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add testcase for merging in a CRLF repo, showing that
 conflict file is in LF only
Date: Mon, 09 Jun 2008 17:05:58 +0200
Message-ID: <484D46D6.9040900@viscovery.net>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org> <484D3225.3020900@viscovery.net> <484D424C.3010002@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 17:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5iy5-0004s4-JT
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 17:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbYFIPGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 11:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756633AbYFIPGD
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 11:06:03 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:60057 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbYFIPGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 11:06:01 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K5iwX-0001JQ-Eh; Mon, 09 Jun 2008 17:05:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3C6226C4; Mon,  9 Jun 2008 17:05:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <484D424C.3010002@trolltech.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84389>

Marius Storm-Olsen schrieb:
> Johannes Sixt said the following on 09.06.2008 15:37:
>> Marius Storm-Olsen schrieb:
>>> An LF only conflict file results in the resolved file being in LF,
>>> the commit is in LF and a warning saying that LF will be replaced
>>> by CRLF, and the working dir ends up with a mix of CRLF and LF files.
>>
>> After reading these 3 lines I've no idea what you are talking about. Can
>> you translate this to English, please? ;-)
> 
> Certainly :-)
> It means that if you work on a repo with core.autocrlf == true, you'd
> expect every text file to have CRLF EOLs. However, if you by some
> operation, get a conflict, then the conflicted file has LF EOLs.
> Now, of course you'd go about resolving the files conflict, and then
> 'git add <file>'. When you do that, you'll get the warning saying that
> LF will be replaced by CRLF. Then you commit. The end result is that you
> have a workingdir with a mix of LF and CRLF files, which after some more
> operations may trigger a "whole file changed" diff, due to the
> workingdir file now having LF EOLs.

Aha! Care to write it this way in the commit message in the next round? ;)

>>>  Sorry, no patch to actually *fix* the problem.
>>
>> Then you should use test_expect_failure instead of test_expect_success.
>> And maybe also mention it in the commit message.
> 
> Well, the test case is written in a way that it *should* pass (iow, it
> _expects_ a success), but it currently doesn't. So, the goal is that
> someone, who is more intimate with the code, can just run the testcase
> until it passes (fixing in between each run, of course ;-)

test_expect_failure has changed its meaning. It's now used to say precisly
what you describe here.

It means: "We should expect this command sequence to complete
successfully, but we know that there is a bug in a git command, and hence
we must expect failure until it is fixed."

Such a test is marked as "still broken", and the test run is not
interrupted. If the bug is fixed, the test is marked as "FIXED" until the
'test_expect_failure' is turned into 'test_expect_success'.

>>> +test_expect_success 'Check that conflict file is CRLF' '
>>> +    git reset --hard a &&
>>> +    ! git merge side &&
>>
>>     test_must_fail git merge side &&
> 
> Ah, I checked a few other testcases, where I saw the ! construct. I
> don't mind changing it, if it's important. Does it add 'feature' to the
> testcase by using test_must_fail, instead of '!' ?

'! git cmd' says that any unusual exit is ok, even a segfault and
incorrect usage. 'test_must_fail git cmd' says that only deliberate error
exits are ok.

-- Hannes
