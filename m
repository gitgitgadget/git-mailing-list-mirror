Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF143C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 00:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhLIAri (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:47:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60998 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLIAri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 19:47:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E03DF48AA;
        Wed,  8 Dec 2021 19:44:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RCIUxpuPVTaodnn+vE+82PCM3WoK+Pkr84mWbP
        9NfGw=; b=G7L8dhmarIzkcUKr3KrzZz0pE+X1nkPZcrSanlfhdUMPN7VK1zMauc
        15kcV49MSCSCBYcpdateCPprGCjO/2Qu0dYwiHimiW5vEM+w8Xs/axE0CPZ+OrCN
        VAQoyTzx2L/rXz71NTd0UDlj5oIJ9MNXZhe6bZsTrnHyzN7HoP360=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DB2DF48A9;
        Wed,  8 Dec 2021 19:44:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02377F48A8;
        Wed,  8 Dec 2021 19:44:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
        <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
        <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
        <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
        <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
        <211208.86ee6nmme5.gmgdl@evledraar.gmail.com>
        <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
Date:   Wed, 08 Dec 2021 16:44:01 -0800
In-Reply-To: <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 8 Dec 2021 16:14:40 -0800")
Message-ID: <xmqq5yrywqsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B1CECAC-5889-11EC-9D42-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> I'm not going to take this feedback unless there are additional votes
> from the Git community in this direction.  I make the claim that
> single-valued comma-separated config lists are easier to work with in
> the existing Git infrastructure.  We already use essentially the same
> parsing code for the core.whitespace variable and users are used to
> this syntax there. There are several other comma-separated lists in
> the config space, so this construct has precedence and will be with
> Git for some time.  Also, fsync configurations aren't composable like
> some other configurations may be. It makes sense to have a holistic
> singular fsync configuration, which is best represented by a single
> variable.

I haven't caught up with the discussion in this thread, even though
I have been meaning to think about it for some time---I just haven't
got around to it (sorry).  So I'll stop at giving a general guidance
and leave the decision if it applies to this particular discussion
to readers.

As the inventor of core.whitespace "list of values and its parser, I
am biased, but I would say that it works well for simple things that
do not need too much overriding.  The other side of the coin is that
it can become very awkward going forward if we use it to things that
have more complex needs than answering a simple question like "what
whitespace errors should be checked?".

More specifically, core.whitespace is pecuriar in a few ways.

 * It does follow the usual "the last one wins" rule, but in a
   strange way.  Notice the "unsigned rule = WS_DEFAULT_RULE"
   assignment at the beginning of ws.c::parse_whitespace_rule()?
   For each configuration "core.whitespace=<list>" we encounter,
   we start from the default, discarding everything we saw so far,
   and tweak that default value with tokens found on the list.

 * You cannot do "The system config gives one set of values, which
   you tweak with the personal config, which is further tweaked with
   the repository config" as the consequence.  This is blessing and
   is curse at the same time, as it makes inspection simpler when
   things go wrong (you only need to check whta the last one does),
   but it is harder to share the common things in more common file.

 * Its design relies on the choices being strings chosen from a
   fixed vocabulary to allow you to say "the value of the
   configuration variable is a list of tokens separated by a comma"
   and "the default has X bit set, but we disable that with -X".
   For a configuration variable whose value is an arbitrary string
   or a number, obviously that approach would not work.

If the need of the topic is simple enough that the above limitation
core.whitespace does not pose a problem going forward, it would be
fine, but we may regret the choice we make today if that is not the
case.

Thanks.
