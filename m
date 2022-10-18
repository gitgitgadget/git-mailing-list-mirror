Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE126C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 13:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiJRNyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJRNyY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 09:54:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28602D03BD
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:54:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g27so20528846edf.11
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNVZRDic4FZnRpvl02QGkyECz/oV5ZNabFwg7W02GxU=;
        b=RMU/pmwGGFPgdnzEjocDX4OrQuibkJ4blCfhhI05PgpxH4uNBmpsqFNp3KLEpVxERf
         lGB8OEqFGU2uJ1YjHJY2xoTEHU76Ka3Lvoy0x6xxZrXwF7tm5vqKc5zNo9XCp9H9ZUuf
         dHkx3OrSOSsfBXeLNyeEmVWVQX35BT8qH6+rJ2KQFV9/gBsSpfz5uUKX7YYhlvAKXWKD
         G7tkM7sdwjOioeVmZ48JR4oTH8qZP4LZM3kj1FwLUwUbx4yBlInZ5u0Dko7h8LJqtqAQ
         I8EXJMOhAVov6tndXMw0zZF/xanxQGG75WgbfCr52wt2QC8n4k+Yyoz/oRz/j48DHcnl
         AuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNVZRDic4FZnRpvl02QGkyECz/oV5ZNabFwg7W02GxU=;
        b=TiRO4KSOub9ECvDz7tcmTfIFfwXbCuMskacJxBsjhN7tjoWLgCMQLZS5/zZrON0LH0
         DMxBTsAxks2ATN3yZFOGn+EnM3lJUfWZvX1ruvWIRywMxAYP1+a0Puhr2/1W53tev3UN
         jLQxdwLfoesdD9T1Z9fohJsoSL8na1LHuZ8N4pNNl6o4vjaW9IMQ20sb15imXBVXnl1E
         sMPxXENtX557WB9P/Nw8BY88iEiDRv/+OM/4LmobKQW1DmZzNLOLOMFHRTgZU5MWfU94
         kzo8mF9QWY+Rho6NM29D3y3SFBCRevxlNB923ZDKMtFHOrC2V6H5GZtDgkG1S2cWKfxJ
         bd7Q==
X-Gm-Message-State: ACrzQf3Kph0rLecmVY/+RiV823uf6r4rv6fJVyEwb19H0TffB9hZp5LJ
        K3TlSCEXYaw3QB0QwBEd/PEJEd4EyxAiWg==
X-Google-Smtp-Source: AMsMyM71ZUiGk8NtzBIxT2JE/Fond28WKF9Vx+AvSfLyKs1PNhGSgzeV6cq8Z0jwm8rXz2g5CwQ/mw==
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id j26-20020aa7de9a000000b0044d819144c5mr2686480edv.232.1666101251164;
        Tue, 18 Oct 2022 06:54:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h9-20020a05640250c900b004591e6f7f47sm9155894edb.42.2022.10.18.06.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:54:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okn2n-005mYQ-1s;
        Tue, 18 Oct 2022 15:54:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/5] add -p: avoid ambiguous signed/unsigned comparison
Date:   Tue, 18 Oct 2022 15:53:45 +0200
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
 <41a8021a4bd09e1470d04ec11d392777d4f5824f.1666090745.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <41a8021a4bd09e1470d04ec11d392777d4f5824f.1666090745.git.gitgitgadget@gmail.com>
Message-ID: <221018.86wn8xgrum.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the interactive `add` operation, users can choose to jump to specific
> hunks, and Git will present the hunk list in that case. To avoid showing
> too many lines at once, only a maximum of 21 hunks are shown, skipping
> the "mode change" pseudo hunk.
>
> The comparison performed to skip the "mode change" pseudo hunk (if any)
> compares a signed integer `i` to the unsigned value `mode_change` (which
> can be 0 or 1 because it is a 1-bit type).
>
> According to section 6.3.1.8 of the C99 standard (see e.g.
> https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf), what should
> happen is an automatic conversion of the "lesser" type to the "greater"
> type, but since the types differ in signedness, it is ill-defined what
> is the correct "usual arithmetic conversion".
>
> Which means that Visual C's behavior can (and does) differ from GCC's:
> When compiling Git using the latter, `add -p`'s `goto` command shows no
> hunks by default because it casts a negative start offset to a pretty
> large unsigned value, breaking the "goto hunk" test case in
> `t3701-add-interactive.sh`.
>
> Let's avoid that by converting the unsigned bit explicitly to a signed
> integer.
>
> Note: This is a long-standing bug in the Visual C build of Git, but it
> has never been caught because t3701 is skipped when `NO_PERL` is set,
> which is the case in the `vs-test` jobs of Git's CI runs.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-patch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..3524555e2b0 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1547,7 +1547,7 @@ soft_increment:
>  			strbuf_remove(&s->answer, 0, 1);
>  			strbuf_trim(&s->answer);
>  			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
> -			if (i < file_diff->mode_change)
> +			if (i < (int)file_diff->mode_change)
>  				i = file_diff->mode_change;
>  			while (s->answer.len == 0) {
>  				i = display_hunks(s, file_diff, i);

Junio pointed out in the last round that this really could use a
separate submission, and I tend to agree. It's really nothing to do with
cmake...
