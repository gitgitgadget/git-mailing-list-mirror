From: =?UTF-8?Q?Stefan_Fr=c3=bchwirth?= <stefan.fruehwirth@uni-graz.at>
Subject: Re: [PATCH] merge_blobs: use strbuf instead of manually-sized
 mmfile_t
Date: Tue, 16 Feb 2016 13:14:09 +0100
Message-ID: <56C31291.1010308@uni-graz.at>
References: <56C2459B.5060805@uni-graz.at>
 <20160216011258.GA11961@sigill.intra.peff.net>
 <20160216050915.GA5765@flurp.local>
 <20160216055043.GB28237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 13:14:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVeWM-0000I1-KA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbcBPMOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:14:20 -0500
Received: from EX07HTCA01.UNI-GRAZ.AT ([143.50.13.79]:41899 "EHLO
	ex07htca01.uni-graz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbcBPMOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 07:14:12 -0500
Received: from EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) by
 ex07htca01.pers.ad.uni-graz.at (2002:8f32:d4f::8f32:d4f) with Microsoft SMTP
 Server (TLS) id 8.3.406.0; Tue, 16 Feb 2016 13:14:09 +0100
Received: from [143.50.233.116] (143.50.233.116) by
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Tue, 16 Feb 2016 13:14:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160216055043.GB28237@sigill.intra.peff.net>
X-ClientProxiedBy: EX13MS04.pers.ad.uni-graz.at (2002:8f32:dc2::8f32:dc2) To
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286340>

Thank you for working on this! Let me just address two things from an 
outsider's perspective:

On 2016-02-16 at 06:50, Jeff King wrote:
> Yeah, maybe. There were two reasons I avoided adding a test.
>
> One, I secretly hoped that by dragging my feet we could get consensus on
> just ripping out merge-tree entirely. ;)

Since I cannot comment on the code quality or maturity of merge-tree, 
but would appreciate if this tool worked as expected, let me quote 
Chris' comment[1] on why he uses merge-tree instead of just "git merge", 
hoping that it has an impact upon your decision whether to keep the code 
or "ripping it out":

"One might ask, why not use the porcelain 'git merge' command? One
reason is, in the context of the two phase commit protocol, we'd rather
do pretty much everything we possibly can in the voting stage, leaving
ourselves with nothing to do in the finish phase except updating the
head to the commit we just created, and possibly updating the working
directory--operations that are guaranteed to work. Since 'git merge'
will update the head, we'd prefer to do it during the final phase of the
commit, but we can't guarantee it will work. There is not a convenient
way to do a merge dry run during the voting phase. Although I can
conceive of ways to do the merge during the voting phase and roll back
to the previous head if we need to, that feels a little riskier. Doing
the merge ourselves, here, also frees us from having to work with a
working directory, required by the porcelain 'git merge' command. This
means we can use bare repositories and/or have transactions that use
a head other than the repositories 'current' head."

> Two, I'm not sure what the test output _should_ be. I think this case is
> buggy. So we can check that we don't corrupt the heap, which is nice,

What do you mean exactly by "this case is buggy"? Doesn't make sense to me.

Stefan

[1] https://github.com/Pylons/acidfs/blob/master/acidfs/__init__.py
