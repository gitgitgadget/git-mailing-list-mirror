Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B20C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B33C206C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GcMtDdpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLUXtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:49:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51562 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUXtP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 18:49:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B8993945B;
        Sat, 21 Dec 2019 18:49:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bkFSTqFrF3vMtX98rfz5nJc8LZQ=; b=GcMtDd
        pT1ZlptTab+IBPDx0RnLiflX11nXvlIpB6DmrMuo/AYz5HIjXmjSNZJzrgy/bWUr
        21EWCj3TVJnBbeJryTLVG8XO5srKgqHCBN9uCHWhRk8W8necDZ6/yCZTkZF6N3Zc
        6DxVideHo24jHqetwKzLzqwhe5mrdr0oXKn4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qNBdA7Mzy07bUL9iP/wtZS5g2PLy2XAN
        ZcnzprYBcwJzvUDRUJtqGxZD7Ac2Ofhqm+QUbMz1TvyAngmvXcTHAsgIssdwD05q
        dtm1bJ9G/2Cme4ucQW2dv+V8EqtdrxDaZsgoWT4ayfnn14YZYojfraMKS2QKqC0k
        cW0qJt3R+0I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 123FB39459;
        Sat, 21 Dec 2019 18:49:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4370939451;
        Sat, 21 Dec 2019 18:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>
Subject: Re: [PATCH 01/15] rebase: extend the options for handling of empty commits
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <13e2056e780b00baf86d4020c0974b6b05ce115b.1576861788.git.gitgitgadget@gmail.com>
        <xmqqimma8z3t.fsf@gitster-ct.c.googlers.com>
        <CABPp-BF5MaO60GAXbqYPfEePKyn_K-B_hQXNvTN_L4S6iA_93w@mail.gmail.com>
Date:   Sat, 21 Dec 2019 15:49:11 -0800
In-Reply-To: <CABPp-BF5MaO60GAXbqYPfEePKyn_K-B_hQXNvTN_L4S6iA_93w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Dec 2019 16:32:39 -0800")
Message-ID: <xmqqimm96xzc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D16029A-244C-11EA-B378-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > +static long parse_empty_value(const char *value)
>> > +{
>> > +     if (!value)
>> > +             return EMPTY_UNSPECIFIED;
>> > +     else if (!strcasecmp(value, "drop"))
>> > +             return EMPTY_DROP;
>> > +     else if (!strcasecmp(value, "keep"))
>> > +             return EMPTY_KEEP;
>> > +     else if (!strcasecmp(value, "ask"))
>> > +             return EMPTY_ASK;
>>
>> Not an error but just silently ignored?
>
> Oops, I'll switch it to an error.

Not necessarily (see "Ahh, OK" below).

>> > +     return EMPTY_UNSPECIFIED;
>> > +}
>> > +
>>
>> > +static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
>> > +{
>> > +     struct rebase_options *options = opt->value;
>> > +     long value = parse_empty_value(arg);
>>
>> Ahh, OK.
>>
>> Wouldn't it be better to make the variable and the parsing helper
>> function of type "enum empty_type", not "long", just like the field
>> in the rebase_options struct?
>
> Indeed, I'll fix this up.

Thanks. I was wondering if there is something subtle I didn't see
going on around here.
