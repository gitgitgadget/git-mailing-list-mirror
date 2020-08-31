Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49FC433E7
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4149206E3
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 12:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryb9pL4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgHaMpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaMpi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 08:45:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD36C061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 05:45:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so6888990ejb.4
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C9e/3K2OzpaZZY8xFn36NNpCT+TfloVuc6O9LthfVZM=;
        b=Ryb9pL4Ph0l5Fa7sc7dFms8D/merfdSbW+1f+WhJ/yWfr9F4u2v3uez+Y/HCzqN12K
         WmQc71bjOmnR98pT6WyEt0JxLYkH8352ogKEfypTolQIseG1zz4Ghq5cypp66JlEbLBx
         /ziQ9l8/+tXIu/tvUdigO84tTdMlL0cKxOaOJAAUjy/cI5bUZSzrnrjWsBw+J5FX3vgw
         JaeVmiDDi8mTQTsQ6nXDmKohc/BypJ8ruaW+s2H/yhFTm1Cm45iN399ZeHuRf4vfYInR
         RvYC13qE9bdV9ERLbV9mbh63yrHpwYKFvoRuTIzzxD6gHI8YOOOCBcFWW1IVPJGcf0B0
         uZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=C9e/3K2OzpaZZY8xFn36NNpCT+TfloVuc6O9LthfVZM=;
        b=hXmjTwEWAghgi8wBUVjkxsmv02WPjZuQQ04LuIevM+frDxWxpnlsTLWiF5pHCyV9tR
         Ou92ZDyDdhUsFROYnUrCFnxUOAnIuLi0b6FBXUEixC4O9tWtuouROvfcFP/uKhLbYYnO
         O0FxEQqM1GHKuaSjJTmcMpCC4IJ8aZYKLQJrbG5nug1iGxK/9vDoW+o4k/dusOqp9x3R
         GnUzHhxN6lsnN8v/9CS02yruDcm8rnCU6531DOfSS4Gm/yY0JKZZvsSqh56srkeVAbi7
         9Bf2PPeJ6dScVNQCUOkwsFnG5PjecWRQUNNvSMLJYY/1V3OQ3ebuG9+LpM9+dziIQRtv
         NMbw==
X-Gm-Message-State: AOAM5309WKWvxdW05MLrf+z9XP1KgPG8v8GhaCg3hHIZU67dfLfJZcVf
        V90IT7MKExln3wjRAoj18NpmM0stDjs=
X-Google-Smtp-Source: ABdhPJwlTFBfR6mpjKawsSLzDMiWsLLmSvwc3Zm7KYiKRVWVDrpyON+8rtTr+mfFYT+la8ZAJ3HaBA==
X-Received: by 2002:a2e:b81a:: with SMTP id u26mr636856ljo.241.1598877935269;
        Mon, 31 Aug 2020 05:45:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b1sm1552575ljp.78.2020.08.31.05.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:45:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] revision: add separate field for "-m" of "diff-index
 -m"
References: <20200829194634.23306-1-sorganov@gmail.com>
        <20200829201140.23425-1-sorganov@gmail.com>
        <xmqqo8mrh12b.fsf@gitster.c.googlers.com>
Date:   Mon, 31 Aug 2020 15:45:33 +0300
In-Reply-To: <xmqqo8mrh12b.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 30 Aug 2020 21:49:32 -0700")
Message-ID: <87a6ybugpe.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Historically, in "diff-index -m", "-m" does not mean "do not ignore
>> merges", but
>> "match missing". Despite this, diff-index abuses 'ignore_merges'
>> field being set
>> by "-m", that in turn causes more troubles.
>
> "causes more troubles"?  When there is no trouble, and no "more"
> trouble, concretely mentioned, it is a quite weak justfiication.

Well, existed comment says "Backward compatibility wart" that sounds
like a trouble to me already. No?

Then, since "--[no-]diff-merges" is introduced, we have:

$ git diff-index HEAD
:100644 000000 4aec621a6d1a9a5892f0b4b6feb2ed329fd04bf2 0000000000000000000000000000000000000000 D	main/main.cc
$ git diff-index -m HEAD
$ git diff-index -m --no-diff-merges HEAD
:100644 000000 4aec621a6d1a9a5892f0b4b6feb2ed329fd04bf2 0000000000000000000000000000000000000000 D	main/main.cc

that sounds like yet another trouble. That's why I used "more trouble" in my
commit message.

If you say "compatibility wart" is not a trouble by itself, -- I'm fine
with it, -- then "more" in my commit message is misplaced indeed.

>
> There is no reason to say "historically" here, as it has been like
> so from beginning of the time, it still is so and it is relied
> upon.  "diff-{files,index,tree}" are about comparing two things, and
> not about history (where a "merge" might influence "now we are
> showing this commit.  which parent do we compare it with?"), so
> giving short-and-sweet "-m" its own meaning that is sensible within
> the context of "diff" was and is perfectly sensible thing to do.

Well, if "historically" makes you feel uncomfortable, -- I'm willing to
get rid of it.

>
> What is worth fixing is not "-m" in diff-index means "match missing"
> while "-m" in log wants to mean "show merges".  It is that, even both
> commands use the same option parsing machinery, and the use of these
> two options are mutually exclusive so there is no risk of confusion,
> the flag internally used to record the presense of the "em" option is
> not named neutrally (e.g. "revs->seen_em_option").
>
> 	The "log" family of commands and "diff" family of commands
> 	share the same command line parsiong machinery.  For the
> 	former, "-m" means "show merges" while for the latter it
> 	means "match missing".  Tnis is not a problem at the UI
> 	level, as "show/not show merges" is meaningless in the
> 	context of "diff", and similarly "match/not match missing"
> 	is meaningless in the context of "log".
>
> 	But there are two problems with this arrangement.
>
> 	1. the field the presense of the option on the command line
> 	   is recorded in has to be given a name.  It is currently
> 	   called "ignore_merges", which gives an incorrect
> 	   impression that using it for "diff" family is somehow a
> 	   mistake, and renaming it to "match_missing" would not be
> 	   a solution, as it will give an incorrect impression that
> 	   "log" family is abusing it.  However, naming the field to
> 	   something neutral, e.g. "em_option", would make the code
> 	   harder to understand.
>
> 	2. because it uses the same command line parser, giving a
>     	   default for "diff -m" in a way that is different from the
>     	   default for "log -m" is quite cumbersome if they use the
>     	   same field to record it.
>
> 	Introduce a separate "match_missing" field, and flip it and
> 	"ignore_merges" when we see the "-m" option on the command
> 	line.  That way, even when ignore_merges's default is
> 	affected by end-user configuration, the default for
> 	"match_missing" would not be affected.
>
> I think the above would be in line with what you wanted to say but
> didn't, and I think it supports the split fairly well.
>
> I have a very strong objection against changing the built-in default
> of "log -m", but I do agree that this split of the single field into
> two is a fairly good idea.  So I do not want to be in the position
> that must reject this change because "log -m" and "diff-index -m"
> will never be on by default.  Basing the justification of this
> change on end-user configurability would be a good way to sidestep
> the issue, and avoids taking this change hostage to the discussion
> on what should be the built-in default for "log/diff-index -m".

This change has nothing to do with defaults. It rather about correct and
clear code.

I'll re-roll with better commit message.

Thanks,
-- Sergey
