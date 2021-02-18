Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387DFC433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D5664E76
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhBRMZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhBRKtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 05:49:35 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE4C061788
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:48:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so3760970edd.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=F3hivKcjybe+C1076BPSPfmGS308Q2AUMlRm/VDa3v0=;
        b=IgbUUnpb/1TPfsjt+KKCClE9wTmn6+JWL8X9zY1twgFzhZIePLdKsr0yAcsC43sGv6
         ZJEkT4PYQI9zN2PloOBgTkZEnYkYmfmk2H+Z3Tt45gSKIJQTOLvokbp1zBM1Ey7D2ReF
         makBD7PWYOVkuUhkoukJElYd8fEO2FkMj9Bt1OXNc2r00fXBscTX4I4KguPLeSCIe9bS
         zhzTMeHg2KYJ89Cc7BUL1xhEJjy5SPcnqTRpjOo2uLCO5ixCWuye4i7Fs99tWyY4TvPq
         e7r7g5nUkcIFb8UX2pjB+Y8F80InRoHLe/SzPLWH3K/mwdQcUHk/zUgsLyVmHrnqmtJP
         hOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=F3hivKcjybe+C1076BPSPfmGS308Q2AUMlRm/VDa3v0=;
        b=q0alyVksKNWfmRGAx5fUhd6n+q/M4RzWMIV16FEql35xra6APYvYPLiJ+1W9I/vYDw
         6uCcfVbkv9vxG+EGlEArv4mvaA/wh9GNhwgZwpF+ptlX0mqVPrj1yj5j8GryWPILURyP
         IcNfNCy2VG7jZzyri5wVst6X8veL9PhUaPJCgJwu2RHiyVtyKwtxeupge2dFGGqHfwYW
         qaEbB7EZRbVLwEnoREZD1F2CekkCZVGhDnofEQMf1seqBf8Mk0R5ptzSNVV65LDHCgVA
         yEpOhCF0T+WK9BKQsI7Qz8vhGEpGGwHVq9pZeA/NQfFgv3U+N//mZzwxtYQjsNpFJL1Q
         q5iA==
X-Gm-Message-State: AOAM531S8kpDJEN3ktwDtSDATizSReG5Aauk8PAB7j27pYdQGkRKc9Pt
        JtZLcAy6NPEw7BVZNcRhqxc3mVNyrsbCfg==
X-Google-Smtp-Source: ABdhPJwlSjq9BfHaPquHIkP+FGG0fB9Q7ZS6Fjmo/ueSRBjf1C0yP/7wZrcHSM0b2QwPgI5AccnlwA==
X-Received: by 2002:a05:6402:26d3:: with SMTP id x19mr3581422edd.0.1613645332112;
        Thu, 18 Feb 2021 02:48:52 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id y21sm303161ejj.31.2021.02.18.02.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:48:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/3] gitmailmap.txt: fix rendering of e-mail addresses
References: <cover.1613590761.git.martin.agren@gmail.com>
 <ee0422ac399daf43a7adcc2b662b50312da04631.1613590761.git.martin.agren@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <ee0422ac399daf43a7adcc2b662b50312da04631.1613590761.git.martin.agren@gmail.com>
Date:   Thu, 18 Feb 2021 11:48:50 +0100
Message-ID: <87tuq98xd9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 17 2021, Martin =C3=85gren wrote:

> Both AsciiDoc and Asciidoctor are eager to pick up the e-mail addresses
> in this document and turn them into references at the bottom of the
> manpage / clickable links. We don't really need that for these dummy
> addresses. Spell "@" as "&#64;" to make them not do this. In the open
> block, we can instead avoid this by indenting the contents, similar to
> the earlier blocks.
>
> Fix a backtick which should have been a single quote mark. With all the
> quoting that is going on around here, this mistake trips up the parsing
> and rendering quite a bit.
>
> Before this commit, we have the same failure mode with AsciiDoc 8.6.10
> and Asciidoctor 1.5.5, and this change makes both of them happy.

THanks a lot for the fix & cleaning up my mess. This LGTM.
