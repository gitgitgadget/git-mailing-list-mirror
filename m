Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE2B1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 08:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbcFUI3s (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 04:29:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38565 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752102AbcFUI3m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 04:29:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 556382026B;
	Tue, 21 Jun 2016 04:28:55 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 21 Jun 2016 04:28:55 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=doPwcDQebeydb+oKfOiB4xQO8gQ=; b=YrwV9K
	5V0WAzX7+aZUNbwGkeWXuDBVcrTaqEP9euv2rwoG48f54IzgYSiwkEU2THPuBoqZ
	KRqZ/XG+ssKV0IWN8Fg1CXTK0gjj2X5i5zLomT1GDMqxP3yr5jFXWMw3TllNXOCT
	SFwrqnYMlUuKKAVrF6qQoLV0TrHDzjXmELkGA=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=doPwcDQebeydb+o
	KfOiB4xQO8gQ=; b=kvd3XOvUmU/4CyA9L8e38SzNYGUPZXl5wZ0muYt45PDk5X9
	+khw+GdLZFCSABisco3clDeW7JEpbAIPjNaVcdjEM7Wq8sltK6jdvjafytoug0k/
	0NLs1wRVzSXxip/5BLYh2RndiYj05Y41yGMaJoaOnVwpGIdr1w4d27KDD76Y=
X-Sasl-enc: BPICK8BvpVsdhStZe36eJXQoLpBGWdjG1jN9qFUsY4hN 1466497734
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4EC8BF29EE;
	Tue, 21 Jun 2016 04:28:54 -0400 (EDT)
Subject: Re: How to find commits unique to a branch
To:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nikolaus Rath <Nikolaus@rath.org>
References: <878txz8ubq.fsf@thinkpad.rath.org>
 <xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
 <87lh1z78fr.fsf@thinkpad.rath.org>
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <8a97003e-fa74-2d9b-f2a8-946614be649c@drmicha.warpmail.net>
Date:	Tue, 21 Jun 2016 10:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <87lh1z78fr.fsf@thinkpad.rath.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nikolaus Rath venit, vidit, dixit 21.06.2016 01:21:
> On Jun 20 2016, Junio C Hamano <gitster@pobox.com> wrote:
>> Nikolaus Rath <Nikolaus@rath.org> writes:
>>
>>> What's the best way to find all commits in a branch A that have not been
>>> cherry-picked from (or to) another branch B?
>>>
>>> I think I could format-patch all commits in every branch into separate
>>> files, hash the Author and Date of each files, and then compare the two
>>> lists. But I'm hoping there's a way to instead have git do the
>>> heavy-lifting?
>>
>> "git cherry" perhaps?
> 
> That seems to work only the "wrong way around". I have a tag
> fuse_3_0_start, which is the common ancestor to "master" and
> "fuse_2_9_bugfix". I'd like to find all the commits from fuse_3_0_start
> to master that have not been cherry-picked into fuse_2_9_bugfix.
> 
> However:
> 
> * "git cherry fuse_3_0_start master release2.9" tells me nothing has
>   been cherry-picked at all (only lines with +)
> 
> * "git cherry fuse_3_0_start release2.9 master" also tells me nothing
>   has been cherry picked, but somehow shows a smaller total number of
>   commits.
> 
> * "git cherry master release2.9 fuse_3_0_start" gives me the commits
>   from fuse_2_9_bugfix that have not been cherry-picked into master
>   (which seems to be in contradiction to the two earlier commands).
> 
> 
> Am I missing something obvious?

There is always

git log --left-right --cherry-mark A...B

to give you a good overview of the situation.

"--cherry-pick" instead of "--cherry-mark" will leave out the
"="-commits (equivalent ones), and the description of "git log --cherry"
in the log man page gives you a good idea of how you can combine
"--cherry-pick" with "--left-only" etc. to give you exactly what you want.

For script-usage, you can finally replace "git log" by "git rev-list"
with the same rev selecting options.

Michael

