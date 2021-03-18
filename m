Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB187C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7241E64EED
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhCRWnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 18:43:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61457 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhCRWnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 18:43:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 725F210F78F;
        Thu, 18 Mar 2021 18:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4nPjAkNvkfekF/YlqK1TvZVeNE8=; b=awAy77
        R+fhVjb3rbIWo2fz3lGn3NElFet2qiNKxnisPRjN1foKzwDvF5Mzi351JmQkMEz6
        wVSZEE4jozgbDzUaDWtvd+HJxA1KSgCtvoIEMlj+4V7/ZvrE5rOufwGo4dLsGgDB
        3ajpIzR7uH2oxXj3LfvRE9UVybiv+V4SfYw4A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iw+0nwM/4WwHg33Uc35fcm7cOXq/P4E7
        7M/ZmUtNWIgiXCDt+LTBfYWnE6VNRvbJNnpQ7G2Zis4DWxznipDS5h8q/DaKhe9M
        rnFp2fkdznFe7WD4lBxeEgN3x8ionIGDBkbJBppYUCEjcE5VSqzqlpXBWIt4Jt6G
        kiym8Tt/RwA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B25610F78D;
        Thu, 18 Mar 2021 18:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2F6310F78C;
        Thu, 18 Mar 2021 18:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2021, #05; Wed, 17)
References: <xmqqblbhtoa6.fsf@gitster.g>
        <CABPp-BGkvUK3Xs6ZsWwv_C_tdJN-84ebBcxZCAoRu+sX7aWQ8g@mail.gmail.com>
Date:   Thu, 18 Mar 2021 15:43:14 -0700
In-Reply-To: <CABPp-BGkvUK3Xs6ZsWwv_C_tdJN-84ebBcxZCAoRu+sX7aWQ8g@mail.gmail.com>
        (Elijah Newren's message of "Wed, 17 Mar 2021 16:13:27 -0700")
Message-ID: <xmqqeegcqe0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53EDD2F4-883B-11EB-9FFB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Will do; I'll also point out a few topics that have been reviewed but
> haven't been picked up yet.
>
>> * en/ort-perf-batch-9 (2021-03-10) 8 commits
>>  - diffcore-rename: avoid doing basename comparisons for irrelevant sources
>>  - merge-ort: skip rename detection entirely if possible
>>  - merge-ort: use relevant_sources to filter possible rename sources
>>  - merge-ort: precompute whether directory rename detection is needed
>>  - merge-ort: introduce wrappers for alternate tree traversal
>>  - merge-ort: add data structures for an alternate tree traversal
>>  - merge-ort: precompute subset of sources for which we need rename detection
>>  - diffcore-rename: enable filtering possible rename sources
>>  (this branch uses en/ort-perf-batch-8.)
>>
>>  More ort.
>
> Can I suggest an alternate title?  "merge-ort optimization of skipping
> irrelevant renames" or anything that gets the idea of "skipping
> irrelevant renames" in there.

Thanks.

>> * en/ort-perf-batch-8 (2021-02-26) 10 commits
>>   (merged to 'next' on 2021-03-07 at f03b2c1acd)
>>  + diffcore-rename: compute dir_rename_guess from dir_rename_counts
>>  + diffcore-rename: limit dir_rename_counts computation to relevant dirs
>>  + diffcore-rename: compute dir_rename_counts in stages
>>  + diffcore-rename: extend cleanup_dir_rename_info()
>>  + diffcore-rename: move dir_rename_counts into dir_rename_info struct
>>  + diffcore-rename: add function for clearing dir_rename_count
>>  + Move computation of dir_rename_count from merge-ort to diffcore-rename
>>  + diffcore-rename: add a mapping of destination names to their indices
>>  + diffcore-rename: provide basic implementation of idx_possible_rename()
>>  + diffcore-rename: use directory rename guided basename comparisons
>>  (this branch is used by en/ort-perf-batch-9.)
>>
>>  Rename detection rework continues.
>>
>>  Will cook in 'next'.
>
> I think it's ready to merge to master.

When a "will merge to 'next'" topic is merged to 'next', its label
is mechanically rewritten to "will merge to 'master'" outside the
pre-release freeze, and to "will cook in 'next'" while pre-release
freeze.  So for the topics labelled with "Will cook in 'next'", by
default they should turn into "Will merge to 'master'".

That was why I was specifically asking for topics to be KICKED OUT
of 'next', to give them a fresh start without having to do "oops,
this was a mistake, let's patch it up".

> Here are some reviewed topics that haven't been cooking yet, that I
> personally think are worth picking up (at least for seen and probably
> for next rather soonish):

Thanks for a useful list of topics.  At this point, topics that are
not picked up are not because they are not ready/worth, but because
there are too many of them sent during the pre-release freeze.

> * My ort-perf-batch-10 ("skip even more irrelevant renames") series:
> https://lore.kernel.org/git/8422759a-a4a3-4dc6-4ae7-4a61896b9946@gmail.com/;
> (the review comment there is addressed by the next patch series in
> this list)

There are 8, 9 and now this 10 in flight, which is two topics too
many to have in flight at the same time X-<.  Luckily -8 seems to be
good for 'master', so there is no risk of having to rewind it
anymore, which makes the burden of having to carry multiple dependent
topics at the same time.
