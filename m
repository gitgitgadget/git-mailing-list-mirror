Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5057C2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD9D23A9F
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgLROCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgLROCj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 09:02:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB48C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:01:58 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l11so5754948lfg.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bTVcQrVTGBsLaJQdFiTFPoWg1P2R4M122Io5Q/IaBEg=;
        b=j9vDsGp6iQ5TBBD+Sn7sax3G9fTTsCMjP9pveCfK8ySLaASWqNyDlL7WQFnLKKecEA
         w007wC07CQ/ZzzIM+sWLrQ2Xgw2JVcxfKvkTK3os8ROsFrE8ix51Fskx1BTjztJJB5Hf
         hkLdQZ2VceCuwtG/b5tQuQm4QcX0zcJ0bWLey+zVMEJmPaR2vv/QjJRvt95D4SMu7lUb
         u0Tc1kZCTMArjtJp5plL7ERLFcUzijf+QR7SkWmt5MZCDomZjDifpoqzWrJqRILlw+FG
         KVgNoPth1cJeOvk6F0vRg0+Tmk8yiWyGSlM0p7qyN+Rrt3KBPhlskEtiaQ8+nOnQzqxo
         iy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bTVcQrVTGBsLaJQdFiTFPoWg1P2R4M122Io5Q/IaBEg=;
        b=IMgYTeJZIW4I70dFHsbHcX1bKODCGN8LUDl9brjDZUbz8nfueX6qp/VnCHSRCaYvQV
         85OzbRlphVl60W3rMKx7N1ivJNchGHXx5Xl/0QsQqbh68hS3S22BvdLnsSqtQRQyCbYi
         8kb5nKL+RfrUG9uDrQuXwROEH4d6k1WuUb6KPohXhxYnf9C/CZXFkzi+n5jo0P0JeWrO
         1NBf9r6WYs5mfxc4Wjs/JNLWr45I6yD1eg5dmEemU+SUCdTR+cRUK9ikEK92BLx81j+y
         qxrWA9wo6LmzwSEx0dpDnw7kg7sJL8AD6ARXgeSSb6orTYEPxYjf2OCis1PABB140dwT
         nhFw==
X-Gm-Message-State: AOAM532JuG++UnohVyYDB6oqbYqn4va1X7oZM6D3u/T34D7ot63eeD8L
        2gruRoDCSMkr2F8eo3gagzxbEH2BwFc=
X-Google-Smtp-Source: ABdhPJz6MrjeiD00QwwlU9eQLwMxWOcnotEaUEaUL/ZsP2mMxFmdUk9rqEdP7R5KL4JbcpyqhpyqAg==
X-Received: by 2002:a2e:2c15:: with SMTP id s21mr1853022ljs.39.1608300116722;
        Fri, 18 Dec 2020 06:01:56 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 20sm934905lfd.237.2020.12.18.06.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:01:55 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 24/33] diff-merges: handle imply -p on -c/--cc logic
 for log.c
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-25-sorganov@gmail.com>
        <CABPp-BHh4VSTQ=VOzik5H34OcJaQ63wSgPgrZqJ5-_XvBSow+g@mail.gmail.com>
Date:   Fri, 18 Dec 2020 17:01:54 +0300
In-Reply-To: <CABPp-BHh4VSTQ=VOzik5H34OcJaQ63wSgPgrZqJ5-_XvBSow+g@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Dec 2020 22:00:54 -0800")
Message-ID: <875z4zciwd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Move logic that handles implying -p on -c/--cc from
>> log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
>> belongs.
>
> A very minor point, but I'd probably drop the "where it belongs";
> while I think the new place makes sense for it, it reads to me like
> you're either relying on a consensus to move it or implying there was
> a mistake to not put it here previously, neither of which makes sense.

Well, it was meant to be an excuse for not moving it there earlier in
the patch series indeed. I just overlooked this piece of code that
logically belongs to the diff-merges module. I think you need to
consider the state of the sources right before this patch to see the
point of phrasing it like this.

That said, I'm fine removing this either.

> Much more importantly, this patch doesn't do what you said in
> discussions on the previous round.  It'd be helpful if the commit
> message called out that you are just moving the logic for now and that
> a subsequent patch will tweak the logic to only trigger this for
> -c/--cc and not for --diff-merges=.* flags.

I believe this patch is useful by itself, even without any future
improvements (that we actually discussed), if any, so I don't see the
point in describing what this patch doesn't do.

OTOH, the commit message seems to be clear enough to expect this patch
to be pure refactoring, without any functional changes, no?

Thanks,
-- Sergey

>
>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  builtin/log.c | 4 ----
>>  diff-merges.c | 7 ++++++-
>>  2 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 63875c3aeec9..c3caf0955b2b 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -723,10 +723,6 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
>>             rev->prune_data.nr == 1)
>>                 rev->diffopt.flags.follow_renames = 1;
>>
>> -       /* Turn --cc/-c into -p --cc/-c when -p was not given */
>> -       if (!rev->diffopt.output_format && rev->combine_merges)
>> -               rev->diffopt.output_format = DIFF_FORMAT_PATCH;
>> -
>>         if (rev->first_parent_only)
>>                 diff_merges_default_to_first_parent(rev);
>>  }
>> diff --git a/diff-merges.c b/diff-merges.c
>> index 0165fa22fcd1..2ac25488d53e 100644
>> --- a/diff-merges.c
>> +++ b/diff-merges.c
>> @@ -127,6 +127,11 @@ void diff_merges_setup_revs(struct rev_info *revs)
>>                 revs->first_parent_merges = 0;
>>         if (revs->combined_all_paths && !revs->combine_merges)
>>                 die("--combined-all-paths makes no sense without -c or --cc");
>> -       if (revs->combine_merges)
>> +       if (revs->combine_merges) {
>>                 revs->diff = 1;
>> +               /* Turn --cc/-c into -p --cc/-c when -p was not given */
>> +               if (!revs->diffopt.output_format)
>> +                       revs->diffopt.output_format = DIFF_FORMAT_PATCH;
>> +       }
>> +
>>  }
>> --
>> 2.25.1
>>

