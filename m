Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A583C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6285261396
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGORHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhGORHG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:07:06 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F92BC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:04:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so6920371oti.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wg2SYhLiqfy7WVta4wBDbSepMvuwP1bSXGfeyZhf0xY=;
        b=cEuMyxMrw4NjrBhpNwQ2l5nwdbZ2AXVaRHG9wX6zKv2YcqsqoGzaQQhtAk+wnEHYgK
         nMSKZSA6B5Ly6nadEuFMFrVxKFccfQt5PnkO3/cDWaE2dFml/21Q/njqBlJPbIMu8xoA
         hLlM7rsFSb0yLjLo5sA3KNxph/9g4ifOJXFBXo4uZCGnlyrVH9fzY6xxHRq/sUmkHrJY
         qwFp6PMD0Z+eLFOS3DjMcTcyfDZ3KAM6+m0pieepF1yT+w4JwNhGaXoXJXLkkamnpNRt
         SPzq3ZznpdwIcefH5WppUA4AKna9Ho1fqyVphPNd7CE2ln5WrZ3RitU+L2DcZIKqdkny
         m9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wg2SYhLiqfy7WVta4wBDbSepMvuwP1bSXGfeyZhf0xY=;
        b=OmvPYJgTn7E5YJUfyL/+Pv2l8C89C66uie9DVBtE2Or2XyUxs+MMRIJsy2NEUnjr8C
         zEzl/9eBK1RynZHpz4ub+0UU/wYY8CGGdGMWGBzuVAbTI8h+f3j6a7rtVGqAt+l5RjKi
         XXLaOThmB8Cpn3NBX2nqJe0b35skKVgPbY64SSQnwIehBLrpP00lnX9BaV54kTrhuE4e
         0xv2pjnBF1a4b94sooGSj6pz0E6jAc1WhZP5QfvqjaXWY1X9DxZGsvSsZpC6ecLWNke4
         q02q0Fkaa6OM7zt+wcYd1/aeFLBZT1cZExRWioiZEvG7xpRjQPZ1Ec/TjV8Xhufj7Zi8
         qPjw==
X-Gm-Message-State: AOAM5314v/2XkFweEhR2zanI1LjMgWT+R3LfBbIRx67jTMhA9DjT2cns
        +uC4GV90NwZuKZUJhIc5OiQ=
X-Google-Smtp-Source: ABdhPJzddgZgc2lPuy7A/YMWpe4NTZ36l5+zFsP8IpeaQOWkImYW5bnBB7rRRCWs1BVULy5KPlsmig==
X-Received: by 2002:a9d:7985:: with SMTP id h5mr4787368otm.283.1626368652526;
        Thu, 15 Jul 2021 10:04:12 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id s5sm1200760oof.29.2021.07.15.10.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:04:11 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:04:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliamseng@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60f06a8a8e611_4b68208a9@natae.notmuch>
In-Reply-To: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
References: <pull.996.git.1626353925051.gitgitgadget@gmail.com>
Subject: RE: [PATCH] parse-options: don't complete option aliases by default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> Since 'OPT_ALIAS' was created in 5c387428f1 (parse-options: don't emit
> "ambiguous option" for aliases, 2019-04-29), 'git clone
> --git-completion-helper', which is used by the Bash completion script to
> list options accepted by clone (via '__gitcomp_builtin'), lists both
> '--recurse-submodules' and its alias '--recursive', which was not the
> case before since '--recursive' had the PARSE_OPT_HIDDEN flag set, and
> options with this flag are skipped by 'parse-options.c::show_gitcomp',
> which implements 'git <cmd> --git-completion-helper'.
> 
> At the point where 'show_gitcomp' is called in 'parse_options_step',
> 'preprocess_options' was already called in 'parse_options', so any
> aliases are now copies of the original options with a modified help text
> indicating they are aliases.
> 
> Helpfully, since 64cc539fd2 (parse-options: don't leak alias help
> messages, 2021-03-21) these copies have the PARSE_OPT_FROM_ALIAS flag
> set, so check that flag early in 'show_gitcomp' and do not print them,

Makes sense but I don't think what the patch is doing should be buried
here. I think a separate paragraph explaining what you are trying to do
will be better.

> unless the user explicitely requested that *all* completion be shown (by
> setting 'GIT_COMPLETION_SHOW_ALL'). After all, if we want to encourage
> the use of '--recurse-submodules' over '--recursive', we'd better just
> suggest the former.
> 
> The only other options alias is 'log' and friends' '--mailmap', which is
> an alias for '--use-mailmap', but the Bash completion helpers for these
> commands do not use '__gitcomp_builtin', and thus are unnaffected by
> this change.
> 
> Test the new behaviour in t9902-completion.sh. As a side effect, this
> also tests the correct behaviour of GIT_COMPLETION_SHOW_ALL, which was
> not tested before. Note that since '__gitcomp_builtin' caches the
> options it shows, we need to re-source the completion script to clear
> that cache for the second test.

I agree this is better, and the patch itself looks obviously correct.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
