Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C8520189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbcFVQiI (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:38:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38548 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750970AbcFVQiH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:38:07 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D4C1F209EB
	for <git@vger.kernel.org>; Wed, 22 Jun 2016 12:38:05 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 22 Jun 2016 12:38:05 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=IzD67dMIvDUUWI9
	icLDGWgM8UoY=; b=XTNoEiI0FLGrGUHzU0mr/L8A1ZIlO2xZxHYMao8OhtrQcFk
	NVrZ0bEX1s27jd7o3Dzzw1G9vCl4qXAhoW9mB4VqEt7c+Zfbx+m8A+2ppkmOYHUw
	8WSF7UnP5Kr9k/g+UacRuu9xwn+xyVeLb0+gGF9w6u3eBoLZbLxhtdM3qRkg=
X-Sasl-enc: MhSzWVFLysy0TjOnxt0BctqKwxNct6Uvbf2VFPWpVwH4 1466613485
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id 546DCCCDBB
	for <git@vger.kernel.org>; Wed, 22 Jun 2016 12:38:05 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id 9E4383047D3
	for <git@vger.kernel.org>; Wed, 22 Jun 2016 16:38:03 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id 5EC46C01DC; Wed, 22 Jun 2016 09:38:04 -0700 (PDT)
From:	Nikolaus Rath <Nikolaus@rath.org>
To:	git@vger.kernel.org
Subject: Re: How to find commits unique to a branch
References: <878txz8ubq.fsf@thinkpad.rath.org>
	<xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
	<87lh1z78fr.fsf@thinkpad.rath.org> <87oa6ubeq4.fsf@thinkpad.rath.org>
	<xmqq7fdiqtqv.fsf@gitster.mtv.corp.google.com>
Mail-Copies-To:	never
Mail-Followup-To: git@vger.kernel.org
Date:	Wed, 22 Jun 2016 09:38:04 -0700
In-Reply-To: <xmqq7fdiqtqv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jun 2016 11:31:04 -0700")
Message-ID: <87mvmdgowj.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Jun 21 2016, Junio C Hamano <gitster@pobox.com> wrote:
> Nikolaus Rath <Nikolaus@rath.org> writes:
>
>> On Jun 20 2016, Nikolaus Rath <Nikolaus@rath.org> wrote:
>>> On Jun 20 2016, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Nikolaus Rath <Nikolaus@rath.org> writes:
>>>>
>>>>> What's the best way to find all commits in a branch A that have not been
>>>>> cherry-picked from (or to) another branch B?
>>>>>
>>>>> I think I could format-patch all commits in every branch into separate
>>>>> files, hash the Author and Date of each files, and then compare the two
>>>>> lists. But I'm hoping there's a way to instead have git do the
>>>>> heavy-lifting?
>>>>
>>>> "git cherry" perhaps?
>>>
>>> That seems to work only the "wrong way around". I have a tag
>>> fuse_3_0_start, which is the common ancestor to "master" and
>>> "fuse_2_9_bugfix". I'd like to find all the commits from fuse_3_0_start
>>> to master that have not been cherry-picked into fuse_2_9_bugfix.
>
> Hmm, so the topology roughly would look like:
>
>             A'--B'--D' 2fix
>            /
>           o---A---B---C---D---E---F master
> 	3start
>
> And you want to find commits in 3start..master that do not have
> equivalent in 3start..2fix
>
> "git cherry --help" starts like this:
>
>     NAME
>            git-cherry - Find commits yet to be applied to upstream
>
>     SYNOPSIS
>            git cherry [-v] [<upstream> [<head> [<limit>]]]
>
>     DESCRIPTION
>            Determine whether there are commits in <head>..<upstream>
>            that are equivalent to those in the range <limit>..<head>.
>
> Applying that to our picture, we want to find commits yet to be
> applied to 2fix, and do so by comparing the commits between
> 3start..master and 3start..2fix.
>
> I find that the first sentence of the description is fuzzy
> ("Determine whether" would imply that you would get "Yes/No" but
> what we want is "here are the commits that do not have counterpart
> in 2fix"), but we already know <upstream> corresponds to 2fix
> (i.e. we are finding ones yet to be applied to there, which can be
> inferred from the NAME line), so <head> must be 'master' That means
> that <limit> corresponds to 3start, and we will be comparing commits
> in two ranges:
>
>     master..2fix (i e. <head>..<upstream>, which is the same thing as 3start..2fix)
>     3start..master (i.e. <limit>..<head>)
>
> So perhaps "git cherry -v 2fix master 3start"?

This works, thanks! I don't quite understand why though. I started by
saying that I want to know which commits in master are have been cherry
picked after 3start was branched to 2fix, so <limit>..<head> must be
3start..2fix, which only leaves "master" as <upstream>.  What's wrong
with that thought?


Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             »Time flies like an arrow, fruit flies like a Banana.«
