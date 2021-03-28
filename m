Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B054EC433E1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB156199F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhC1CBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:01:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59712 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhC1CBq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:01:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46DBEB841A;
        Sat, 27 Mar 2021 22:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2xuHtJXMfr4cmSXpiXzUZwAHwZg=; b=JheTKb
        He3xKY+dzRldwHKxo9kR5CuERO+mt3gt6SlrwJ+Ns485aaZl/WnWNRBD3N1A1b6Q
        vnkHFX8HQSaU+xPLUAZCgcDVdXVVVzf7t55p3CTlcRCml8i9elag7V0y/7Hi0/Ag
        CN9lcHSAZwLbTJrUsyH5iz0x1nqWzJduOJviI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JcEATRD+PR+vnPO8g/U9e40AO/VFr52N
        wjUBP8oweq5YYGwRch6R2aGhxkqcK4Q/6IxrjAP4w6KRJxXyW54YG33Vv7Wn+Aqf
        BiQsZE0lkdAk2QxgjUVNsrb4AH2ey+MZVwkzOce0E8uMXNRC2GlsD8AV4gdqxpV8
        /8nsKeolfWs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DB84B8419;
        Sat, 27 Mar 2021 22:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5A2CB8418;
        Sat, 27 Mar 2021 22:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] merge-ort: record the reason that we want a rename
 for a directory
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
        <05850cb49823ea9c6d6c7cfd3b4adbbc1c47abc6.1615674128.git.gitgitgadget@gmail.com>
        <baca2700-0959-c4ca-6ba9-ceb5188f96f4@gmail.com>
        <CABPp-BHLL_u_E-Ss=AYWUZM+_9hbC6D6WzRjxEUwmexTEgQ2zw@mail.gmail.com>
Date:   Sat, 27 Mar 2021 19:01:45 -0700
In-Reply-To: <CABPp-BHLL_u_E-Ss=AYWUZM+_9hbC6D6WzRjxEUwmexTEgQ2zw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 15 Mar 2021 08:27:48 -0700")
Message-ID: <xmqq4kgwox2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C914D86-8F69-11EB-AF49-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Mar 15, 2021 at 7:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/13/2021 5:22 PM, Elijah Newren via GitGitGadget wrote:
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > When one side of history renames a directory, and the other side of
>> > history added files to the old directory, directory rename detection is
>> > used to warn about the location of the added files so the user can
>> > move them to the old directory or keep them with the new one.
>> >
>> > This sets up three different types of directories:
>> >   * directories that had new files added to them
>> >   * directories underneath a directory that had new files added to them
>> >   * directories where no new files were added to it or any leading path
>> >
>> > Save this information in dirs_removed; the next several commits will
>> > make use of this information.
>> ...
>> > +/* dir_rename_relevance: the reason we want rename information for a dir */
>> > +enum dir_rename_relevance {
>> > +     NOT_RELEVANT = 0,
>> > +     RELEVANT_FOR_ANCESTOR = 1,
>> > +     RELEVANT_FOR_SELF = 2
>> > +};
>>
>> Is this potentially a flag list? It's hard to tell because we don't
>> have another item (3 or 4?).
>>
>> >               unsigned sides = (0x07 - dirmask)/2;
>> > +             unsigned relevance = (renames->dir_rename_mask == 0x07) ?
>> > +                                     RELEVANT_FOR_ANCESTOR : NOT_RELEVANT;
>> > +             /*
>> > +              * Record relevance of this directory.  However, note that
>> > +              * when collect_merge_info_callback() recurses into this
>> > +              * directory and calls collect_rename_info() on paths
>> > +              * within that directory, if we find a path that was added
>> > +              * to this directory on the other side of history, we will
>> > +              * upgrade this value to RELEVANT_FOR_SELF; see below.
>> > +              */
>>
>> This comment seems to imply that RELEVANT_FOR_SELF is "more important"
>> than RELEVANT_FOR_ANCESTOR, so the value will just be changed (not a
>> flag).
>
> Yes.
>
>> > +     /*
>> > +      * Here's the block that potentially upgrades to RELEVANT_FOR_SELF.
>> > +      * When we run across a file added to a directory.  In such a case,
>> > +      * find the directory of the file and upgrade its relevance.
>> > +      */
>> > +     if (renames->dir_rename_mask == 0x07 &&
>> > +         (filemask == 2 || filemask == 4)) {
>> > +             /*
>> > +              * Need directory rename for parent directory on other side
>> > +              * of history from added file.  Thus
>> > +              *    side = (~filemask & 0x06) >> 1
>> > +              * or
>> > +              *    side = 3 - (filemask/2).
>> > +              */
>> > +             unsigned side = 3 - (filemask >> 1);
>> > +             strintmap_set(&renames->dirs_removed[side], dirname,
>> > +                           RELEVANT_FOR_SELF);
>>
>> Yes, using "RELEVANT_FOR_SELF" here, not "relevance | RELEVANT_FOR_SELF".
>> OK. This should make the later consumers simpler.
>
> Yep, indeed.  Would it make it clearer earlier if I were to stop
> assigning the explicit values in the enum?  Would adding a comment
> when I introduce the enum be easier?  Or was it just "thinking out
> loud"?

You are not asking me, but if you were, I'd say not using enum for
bitmask would be a good discipline to follow, and an enum like this
one that is used only for uniqueness of the values would benefit from
not having explicit value assignments.
