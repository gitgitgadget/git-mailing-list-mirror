Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F7C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9240023A5B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgLRONf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgLRONf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 09:13:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9076C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:12:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 23so5708078lfg.10
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FqsVlQf8YzAcFgY0WCBJ5pssA1VZiQ2kK6MzjIWbFvc=;
        b=Nvb2clRVossKs2/Kqn+Rch1We9L+aU6//fjnaVvTHgYvt3pARPfEd1ZwaA9vyBvhwd
         UtIvMB+XMj8/YA8OPHT3Exo4iEy6LXbQOcJMeSWMLsUFVG0h6b/qHsGo/ZpMNqNJEe9h
         eP1RrMdPOmm81O2lrizRagc6CslYuimpfDX5gbCMJlNtyIMbMWgg6B3RGFgTtyiVkP4i
         acd5iuxD61HiI+FLwpzCWI8O9EZ9DGv0e+tJc9vnyu2wNoaDHUptcVJ9dFjYe4z4YaZX
         F0F46X/xnwyOJ4zCbPhanWkFWTlUee4zAFeQia71DNSDgU6trsQuBqo1JOCU7GsEXsLv
         pXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FqsVlQf8YzAcFgY0WCBJ5pssA1VZiQ2kK6MzjIWbFvc=;
        b=IoiCfDSC3DmR8VO7t2z2+9qVyZc05m/eUniYcLdUgRIfE88GAAnWCbD8SJycVFYaFJ
         SH4pR55N7CqlLKRPzLJ/wy3ia8m+iXaP6m5o9x4NiqoBxHARw2LKBk1+HXMyRXRD1RTl
         hpps7IwAGQiWUD1f8iLCo32vwtTLU8zb6SJYEQXOTJj/ZqkQVeP10qPNDuy2kfHykMhS
         SqZgJ11URHdweB4ZbwDjt9dIyNysUAwU5Of2G/+EPbT66/7NXmiDUoO3Lrj3h6Xhu8Gz
         busmcKH8BzeagzCXX/Ph/HROZbZYbnGqUlrCgJNiT+FSyt5Kp31f1YSBVZ+XRC96wf30
         37mg==
X-Gm-Message-State: AOAM530NsPof9q9q2aK9OYn4qQyO4f+9CNLJFoDHXy4LztyNBUzNOGOq
        YR6spY2I3eBvWf8nlrrgZOTmxSPMlEo=
X-Google-Smtp-Source: ABdhPJw7hhI4l772kRBuy4MLaEt/Nja4nUQfxllWPMshzFG80pyrr6eLuu6ELDJAcNWV0uw8GWJTfw==
X-Received: by 2002:a19:4c06:: with SMTP id z6mr1685707lfa.284.1608300772808;
        Fri, 18 Dec 2020 06:12:52 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c198sm935588lfg.265.2020.12.18.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:12:51 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 22/33] diff-merges: implement new values for
 --diff-merges
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-23-sorganov@gmail.com>
        <CABPp-BG1S83EUbqtqqjeLT4=Je44BpRMrf0MB+DNQK2wjRDbqQ@mail.gmail.com>
Date:   Fri, 18 Dec 2020 17:12:50 +0300
In-Reply-To: <CABPp-BG1S83EUbqtqqjeLT4=Je44BpRMrf0MB+DNQK2wjRDbqQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Dec 2020 21:39:13 -0800")
Message-ID: <871rfncie5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> We first implement new options as exact synonyms for their original
>> counterparts, to get all the infrastructure right, and keep functional
>> improvements for later commits.
>>
>> The following values are implemented:
>>
>> --diff-merges=          old equivalent
>> first|first-parent    = --first-parent (only format implications)
>> sep|separate          = -m
>> comb|combined         = -c
>> dense| dense-combined = --cc
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  diff-merges.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/diff-merges.c b/diff-merges.c
>> index 6446e2093661..cba391604ac7 100644
>> --- a/diff-merges.c
>> +++ b/diff-merges.c
>> @@ -15,6 +15,11 @@ static void set_separate(struct rev_info *revs) {
>>         revs->separate_merges = 1;
>>  }
>>
>> +static void set_first_parent(struct rev_info *revs) {
>> +       set_separate(revs);
>> +       revs->first_parent_merges = 1;
>> +}
>> +
>>  static void set_m(struct rev_info *revs) {
>>         /*
>>          * To "diff-index", "-m" means "match missing", and to the "log"
>> @@ -38,11 +43,19 @@ static void set_dense_combined(struct rev_info *revs) {
>>  }
>>
>>  static void set_diff_merges(struct rev_info *revs, const char *optarg) {
>> -       if (!strcmp(optarg, "off")) {
>> +       if (0) ;
>
> Leftover cruft from some intermediate changes or something?

No. It's just an idiom for if-switch, making all the actual cases look
the same. Without this the first one looks special when in fact it
isn't. I won't die for it though.

>
>> +       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
>>                 suppress(revs);
>> -       } else {
>> +       else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
>> +               set_first_parent(revs);
>> +       else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
>> +               set_separate(revs);
>> +       else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined"))
>> +               set_combined(revs);
>> + else if (!strcmp(optarg, "dense") || !strcmp(optarg,
>> "dense-combined"))
>> +               set_dense_combined(revs);
>> +       else
>
> Not sure I like the special-casing for "sep" and "comb".  "dense"
> seems okay since it's a real word.

That was a poor-man attempt at unique shortcuts made by hand, as well as
a reminder to consider to re-write this using generic options framework
that will do it automagically. They are just a few first letters,
nothing more. That's why I didn't even document them.

> Since you're adding short versions of m, c, and cc later in the
> series, do we need these other special-case forms?

No, I don't think we do necessarily need them, but then they do no harm
either, so I didn't remove them when I added m, c, and cc. Neither was I
sure we do need these m, c, and cc in the first place.

Thanks,
-- Sergey
