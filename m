Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B5C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 13:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C727207DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 13:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Ojrg8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHBM7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgHBM7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 08:59:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEBEC06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 05:59:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so14551165lfg.6
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=skZcdwMENJq8W6TdZb5Pp1LBhMXOe1OPpNZebJZPzzw=;
        b=R0Ojrg8Wz0Bi11CvEmVM2c6Vy7ejRIGSmDhWA9kGV3GoilywXZpNcgOGc6aq69M4eT
         SRioVhBNyv3j/wxUrb+Wmo3T65pYZ7KSg2WAl+xgDaRvaeo0mZV5sjHKOoSqHWO4jPvZ
         /upKEnmh/FHze9GsJadUCvkE89DgAtEyMyrLW+tUCRu2G5g2BRAQdXCVs6ZmGxBwB9A2
         GADGF/FpCnccAvJtWsS0cj+RjhFRfCZ44EyqvIcZrlyKNMzO/KaRliLR9aHhGUEjJ8XT
         LCmghEOMNg0OgmMgRKbxUVWYM77ArQcVbLlm7nytE+3Nwu04maFJ23uK112f6geYCGaQ
         7+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=skZcdwMENJq8W6TdZb5Pp1LBhMXOe1OPpNZebJZPzzw=;
        b=hoFfaPSZ2YzQnurHV7c9eEVtZUYbextvPh2rgCd0LI44TjgR3Cqr6KXRKhY2qTnhKv
         Vub2MUB5l+9Wz3GiietAYdGdO8DWPvBm87VcaMap2psRdt38XRMASqSAd2kVpUpqP99K
         8kcZ5aAHl/7ciAqN5OPxoYVRs96F26GMmmW8NqeHiL9+Snnq4e7qrQ+moLzu2zmvlzp9
         cGeXNwNsNm+HePe5CE4CXqXjnSPe6p58cSgeo8To6FdSEcSoLxz0wVl4ynn4wEXwuji6
         +dLH9Lgm0F1ZBAoOOJezgT0X4gf/58Ax1JaPKEm8mQMAGho93bopiSE1Qsxac0ogAUv4
         4RyA==
X-Gm-Message-State: AOAM532gDjWHT4AWP+IbyM65zQvne+kQw50VDJdzh7OpP7lA7jg0Af5a
        26MFN6S5FG94qdb5WHpLi2E=
X-Google-Smtp-Source: ABdhPJzHXFgBgZbSC96LOmG0tEwIUEP5FUTvVZ+C4wIuwYdgbZRcVsjej5H5kRrth9g0TunGwpCYWw==
X-Received: by 2002:ac2:51ac:: with SMTP id f12mr6083898lfk.6.1596373187783;
        Sun, 02 Aug 2020 05:59:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i26sm2957103ljj.102.2020.08.02.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 05:59:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
Date:   Sun, 02 Aug 2020 15:59:46 +0300
In-Reply-To: <20200731230858.GA1461090@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 31 Jul 2020 19:08:58 -0400")
Message-ID: <87mu3drynx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 30, 2020 at 12:41:39AM +0300, Sergey Organov wrote:
>
>> > Here's a re-roll taking into account the discussion so far:
>> >
>> >   - the escape hatch option name is flipped to "--no-diff-merges" (with
>> >     "--diff-merges" matching "-m")
>> 
>> Rather than being just a synonym for -m, is there a chance for
>> "--diff-merges" implementation to be turned to output diff to the first
>> parent only, no matter if --first-parent is active or not?
>>
>> Alternatively, may it have a parameter such as "-m parent-number" of
>> "git cherry-pick" being set to "1" by default?
>
> Yes, I agree that would be a useful feature, but I don't think it needs
> to be part of this series. It could be implemented as --diff-merges=1 to
> show only the one against the first parent, or as its own option. But we
> can add that on top.
>
>> This -m output of diffs to all the parents is in fact primary source of
>> confusion for me, even over all these mind-blowing inter-dependencies
>> between --first-parent, --cc, -c, -m, -p and what not. Who ever needs
>> these (potentially huge) diffs against other parents, anyway?
>
> I've used "-m" second-parent diffs occasionally for hunting down
> mismerges, etc, but I agree that most of the time you just want to see
> the diff against the first parent.
>
>> Introduction of this new option is a great opportunity for improvement
>> that would be a pity to miss.
>
> Adding an optional value to the flag is something we can do later. We
> would miss the opportunity for "--diff-merges" to default to
> "--diff-merges=1", but I'm not sure I'd want to do that anyway. Having
> it be consistent with "-m" seems less confusing to me, and it is already
> too late to change that.
>
> If we want an option that defaults to "1", we can give it a new name.
> The only thing that is lost now is that --diff-merges would already be
> taken. :) But I think I'd probably call such an option "--diff-parents"
> or something like that anyway.

Yeah, I see your point, thanks for considering!

What I in fact have in mind is something like:

  --diff-merges[=<parent-number>|c|cc|all]

to have a single point of definition of the needed format of merges
representation.

Then comes the question of the default. "all" is what'd make it behave
as "-m" behaves now. If it's too late for --diff-merges to have
different default, could the default possibly be a configuration
option rather than yet another command-line option?

-- Sergey
