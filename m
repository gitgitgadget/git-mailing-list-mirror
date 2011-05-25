From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Wed, 25 May 2011 09:38:43 +0200
Message-ID: <4DDCB203.3020802@drmicha.warpmail.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com> <4DDA618E.4030604@drmicha.warpmail.net> <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com> <20110523181147.GA26035@sigill.intra.peff.net> <20110523201529.GA6281@sigill.intra.peff.net> <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com> <20110523234131.GB10488@sigill.intra.peff.net> <7v39k4aeos.fsf@alter.siamese.dyndns.org> <4DDB5C0F.1080102@drmicha.warpmail.net> <20110524191337.GB584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 09:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP8gA-0006pM-B6
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 09:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676Ab1EYHir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 03:38:47 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54473 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754666Ab1EYHir (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 03:38:47 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EB2A420194;
	Wed, 25 May 2011 03:38:45 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 25 May 2011 03:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Gs7bPXXAxdIPa3KZP+zFt1kK0t0=; b=l2uPZSE2hYqCvs0Aev/DZj9OeLoSsgu8jp/Kx7OolvX+g9ucTFhgFli6X4ocEfvDhERj4HV0c6J1+p223fj+AGGdrAXmqfftjvcqipr4K5xqFyhgiWaqRecLk6lfSaeaQ40s4jOQxmwVxs6nitqQPCUeaZgsMbPTKCIIohWjD0k=
X-Sasl-enc: 9aDBLd0cTvzzRUGZKJSqBiJ04SFkWT7drD3qk71ozYc2 1306309125
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 28B80408FBA;
	Wed, 25 May 2011 03:38:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110524191337.GB584@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174374>

Jeff King venit, vidit, dixit 24.05.2011 21:13:
> On Tue, May 24, 2011 at 09:19:43AM +0200, Michael J Gruber wrote:
> 
>>> It is conceivable that we _could_ newly define a "combined external diff
>>> driver" that would take 3 or more files, and compute and show the combined
>>> result by itself, but that will certainly not go through the codepath you
>>> touched with the textconv patch. Calling out to such a new type of
>>> external diff driver would have to happen at the level where we have 1+N
>>> blob object names for a N-parent commit, namely, at the beginning of
>>> show_patch_diff(), bypassing the entire contents of that function and
>>> instead letting the new n-way external diff driver do everything.
>>>
>>> I however highly doubt that such an interface would make sense. For
>>> example, what would be the desirable format to compare three versions of
>>> "What's cooking" postings, and how would the updated compare-cooking.perl
>>> script would look like?
>>
>> Yeah, currently --cc with external makes no sense, but there are several
>> external tools which could present a 3-way diff in a useful way (or even
>> n-way with n>3), e.g. vimdiff, kdiff3, meld.
> 
> I agree with Junio that we would need a new config option and external
> interface for "n-way combined diff". However, isn't what things like
> vimdiff and meld do the reverse of our combined diff? That is, don't
> they assume the 3 trees are: ours, theirs, and ancestor (i.e., merge
> base)? Whereas in a combined diff, it is actually: merge parent 1
> (ours), merge parent 2 (theirs), and merge _result_.
> 
> Also, do those tools generally handle n-way comparisons as opposed to
> 3-way?

"Those" tools do "that" which I mean :)

It depends on the tool, of course. vimdiff does not have any assumptions
that I know of, it marks those hunks which are not common to all
buffers, and marks them differently depending on what subset of buffers
shares them. That aspect is the same for kdiff3 and meld (n<=3 for meld)
in diff mode.

There are more differences in merge mode:

In vimdiff, you can "put" a hunk (i.e. apply the change) to another
buffer (or "obtain" one), i.e. you can easily move hunks between the
buffers (to do a merge). In kdiff3's auto merge mode there is the
assumption you mention (because it actively does some merging).

So, in vimdiff, you could in principle change and write any buffer but
our tools don't support it so far because it is not needed for a merge
which has one "target" only. In the ui of my dreams, I would have 3
buffers HEAD INDEX WORKTREE (H I W) and moving hunks between them would
do all of add -p, reset -p and checkout -p (the HEAD buf would be
read-only).

With "differently abled" tools it could still be useful to have, say a
tool invoked for the merge HEAD+WORKTREE -> INDEX (with the current
state of the INDEX as the automatic resolution to start off from) so
that you can do add+reset -p with your mergetool, and maybe similarly
for HEAD+INDEX -> WORKTREE. I.e. addtool and checkouttool in addition to
the difftool and mergetool which we have. Just not for the current
release cycle any more.

Michael
