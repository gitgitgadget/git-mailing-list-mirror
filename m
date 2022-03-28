Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B943BC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 06:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiC1GGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiC1GGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 02:06:13 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0531E0E9
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 23:04:31 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4KRhwp3DGFz5tlJ;
        Mon, 28 Mar 2022 08:04:26 +0200 (CEST)
Message-ID: <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
Date:   Mon, 28 Mar 2022 08:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
 <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
 <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
 <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
 <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.03.22 um 13:15 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Sun, Mar 27 2022, Johannes Sixt wrote:
> 
>> Am 26.03.22 um 18:14 schrieb Ævar Arnfjörð Bjarmason:
>>> Partially revert d323c6b6410 (i18n: git-sh-setup.sh: mark strings for
>>> translation, 2016-06-17).
>>>
>>> These strings are no longer used in-tree, and we shouldn't be wasting
>>> translator time on them for the benefit of a hypothetical out-of-tree
>>> user of git-sh-setup.sh.
>>
>> There is public documentation for these functions. Hence, you must
>> assume that they are used in scripts outside of Git. Castrating their
>> functionality like this patch does is unacceptable.
> 
> For require_clean_work_tree() the public documentation for this function
> states that it will emit a specific error message in English, and you're
> expected to Lego-interpolate a string that we'll concatenate with it:
> 
> 	[...]It emits an error message of the form `Cannot
>         <action>: <reason>. <hint>`, and dies.  Example:
> 	+
> 	----------------
> 	require_clean_work_tree rebase "Please commit or stash them."
> 
> So I think that marking it for translation like this as d323c6b6410 was
> always broken in that it broke that documented promise.

I can buy this argument. But then this must be a separate commit with
this justification.

> But that's just an argument for keeping the require_clean_work_tree()
> part of this patch, not require_work_tree_exists().
> 
> For that one and others in git-sh-setup we've never said that we'd
> provide these translated (and to the extent we've implied anything about
> the rest, have strongly implied the opposite with
> require_clean_work_tree()'s docs).
> 
> Nothing will break for out-of-tree users as a result of this
> change. When we added these functions and their documentation their
> output wouldn't be translated, then sometimes it was, now it's not
> again.

This does not sound convincing at all, but rather like "I want the code
to be so, and here is some handwaving to justify it". What is wrong with
the status quo?

> We need also need to be mindful of translator time, it's a *lot* of
> strings to go through, and e.g. I've commented in the past on patches
> that marked stuff in t/helper/ for translation.

Translator's time is your concern? No translator sifts through 5000
strings on every release. There are tools that show only new strings to
translate. A text is translated once and then it lies under the radar
until someone changes it. Don't tell me that is time-consuming. On the
other hand, there is a lot of *reviewer* time that you are spending with
changes like this. *That* should be your concern.

-- Hannes
