Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89872C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC30246E0
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYJ5rMKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgKSMeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 07:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbgKSMd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 07:33:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EAFC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 04:33:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j205so7966453lfj.6
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 04:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EbMSMT/haVM2PrKuJmItpc+FaSqD9FNdEdI/CBi3adA=;
        b=eYJ5rMKaBcKXucAAB1xsvQeFOR6HEmjOqHjlyeI+5uZp0sZf0PUkXeYdx2pWRccUGD
         3TjjMJFY8ULHKCJQ8OYILWKkCfUr54WOA19pxoaTwGq0A8tCEX/i/FXIjRRgjMqQOSXb
         CSu+ztPQEZL//1s9z8ALwzE5HlRaeuNbt65a6V8a2jlsq2SPBK8wmbAl2FH+qiY1AKkZ
         E77pA6Xo8/mjE5+Bu8FwLxTXMtYx/sVna1QwmUKWk09ByIzSEK/4N6Jf72AvaMzI9upj
         fOpHz3K+sAgrqOJ0EtCZ2Sm3pjN7v6hp8ZEcx0A1f9Izm1UFG6K6VFfQOMGLMkpXlN5u
         d3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=EbMSMT/haVM2PrKuJmItpc+FaSqD9FNdEdI/CBi3adA=;
        b=AJbwCefpPH6SZHL2eJDcPeb4vqPBiu7stmTqdn5QIWv4EZ3QsePbHAVggKXspDBRl4
         EUZxALJJLqv91UhuukrSNSHxu7+xE2Qe8QritXu+yp3/3Mz2pjt7nxP8OuPsym+/wOyo
         tuRKVV6/TNFcklbNbsoQ9vvPHhiVEtbxruSi7v1zR2vQ8Fts7ndvyCvaXsxcx61Ii+kY
         wcsNa2ENM5kODyhsffL5NRQvkmq+9qUdb+tz/B9JdWv7n+y/G1j8oyQ5zHSuft4zUXZF
         qb81R06J7Mer2KXCsikRMi2V40F4a2AXI7VWGVS1hyYZptg3fU8Tqdd3Swbxx/lGJckd
         JizQ==
X-Gm-Message-State: AOAM531CPvbJRtrUxjD3GJsi6j12SG7D0uH6BSoJ1K9BRGdANAFif5cF
        mLWRIi5+QE4GvmOGpoBRfm8=
X-Google-Smtp-Source: ABdhPJzNr5oXOdenxIu/s1Y2LjthhRqTahg3gbNTQz6lMgpjNQ6yEkI6qxOQNSLgCCpG0NavfIBnwQ==
X-Received: by 2002:a19:c55:: with SMTP id 82mr5326435lfm.84.1605789237912;
        Thu, 19 Nov 2020 04:33:57 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 22sm3693608ljw.40.2020.11.19.04.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 04:33:57 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
        <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
        <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
        <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email>
        <871rgpr497.fsf@osv.gnss.ru>
        <fe8962ee-0e0b-19bb-4b89-4603cdabee74@iee.email>
Date:   Thu, 19 Nov 2020 15:33:56 +0300
In-Reply-To: <fe8962ee-0e0b-19bb-4b89-4603cdabee74@iee.email> (Philip Oakley's
        message of "Thu, 19 Nov 2020 11:50:23 +0000")
Message-ID: <873615plu3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 19/11/2020 11:10, Sergey Organov wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> On 19/11/2020 01:51, Junio C Hamano wrote:
>>>> Philip Oakley <philipoakley@iee.email> writes:
>>>>
>>>>> An alternative in the other direction is to go with the 'not currently
>>>>> on any branch' (detached at nowhere) but then require users to
>>>>> deliberately create their first branch with their chosen name. This
>>>>> moves the 'backward incompatibility' to a different place, which may be
>>>>> easier to manage.
>>>> As has already been mentioned by Peff, I do not think that is a
>>>> workable alternative, especially given that people are generally
>>>> afraid of and easily get confused by being on a detached HEAD.
>>> Yes, our use of the technical phrase 'detached HEAD' is confusing,
>>> compared with the more pleasant 'not on any branch', or 'not at a branch
>>> tip'. Such is the curse of knowledge.
>> To me "not on a branch [tip]" is also confusing, as in fact you are, as
>> is easily seen after you perform a few commits, and now HEAD points
>> directly to the tip of the branch (that has no other references).
>>
>> I wonder why Git didn't rather adopt "unnamed branch" or "nameless
>> branch" to describe this mode of operation?
> Given the ephemeral nature of branches they sound like good
> suggestion.

Sure, so to me they sound even more natural in Git context than in any
other VCS I'm aware of.

>
> However I suspect "history" to be the "why" of the current 'detached
> head' usage.
> Maybe it's a side reference to Nearly Headless Nick or other discussions
> of the time (aka lost in history)?

I do have a few commits at which HEAD has been detached, not once at
some. Bloody they are.

-- Sergey
