Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5827FC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiFJCLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiFJCLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:11:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF4355008
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:11:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z7so33401476edm.13
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DThuOlBGOJUY+Swq3f5fQDUhp33UUmLlSPlIAjE6I7c=;
        b=lDw3yUKMkYVGexmvRTuMAK2A5yIYfUYMqRTC3uCfjorH7OMs33ybf7fuW39fBwzcih
         tj4K8F6rcoDba3BFdGEROv8DTJyddloKBPnvmuqRB4/xlRstwVllFcwQnIS2bs5343NH
         KDkho/gzAsXddrJAH6wbekXFH8SG9jyoQaOK9VniqO/Z9FrKs5KSUqTYJfwMChnZ7mN5
         XKT+6Qq6rSFQx3axwxIh9ZWRGpdHmyUE/rGYqVjPp22L6qwldYB1Emxn3BAPeS8l5Juw
         pzp7JI89oG+GfC3mGBEhwab0zIr4RCRbPvjO2Cgw7RWVFVwbbpoE8m0qRhEqNFbDuUHl
         sSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DThuOlBGOJUY+Swq3f5fQDUhp33UUmLlSPlIAjE6I7c=;
        b=Ro9GXHUvt1A8PJmP+M8e5F73AL1kPwDAWRb2fZNARaV3g2h70B0qChxCIMqX6pyMu3
         t53UDXEqQr1YAGP7fNppKAONH4RLhaC7ub6aIyKm0IHNivARi9o+1psb3cCLDkfMbrfo
         /G2T0cXmFGN/jOKqssLfsvuNwSiNjvq65T0g0wKAUa4c6/K04EQZKipTXqCI5saR4Psj
         nmSLXLbKAmT7M85+INzc0KfcUyMBeBtl0KhsJo7o4jUzbew+E5fiWekVPtZ5iTC3iveD
         LqExDToXCHIuF4i/JWXgBuWiyiI2HBecAHD7yC/b7tsqpCXK6lEEDrQTqLf5bCkz1R7j
         NDKQ==
X-Gm-Message-State: AOAM53120aCx3JEB+WJSMbeLasHESqbwG4DXOZf0PIDVGHQTrVYVFjqg
        RI5NWDPAOUz08mEze1REbCGHttdPE2/gLw==
X-Google-Smtp-Source: ABdhPJxm5eG8KQReRr98WQagNh8V8dE90GG0/L3rVIgyDfCQ7JK1RAXrSgI/P3Yvi1/jshSgK+sVHQ==
X-Received: by 2002:a05:6402:1f0f:b0:42d:d4a5:a38c with SMTP id b15-20020a0564021f0f00b0042dd4a5a38cmr47382054edb.140.1654827077619;
        Thu, 09 Jun 2022 19:11:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id pk16-20020a170906d7b000b006fee526ed72sm11208254ejb.217.2022.06.09.19.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:11:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzU7I-00380Q-Gs;
        Fri, 10 Jun 2022 04:11:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6+ 4/7] scalar: implement `scalar diagnose`
Date:   Fri, 10 Jun 2022 04:08:34 +0200
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
 <20220528231118.3504387-5-gitster@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220528231118.3504387-5-gitster@pobox.com>
Message-ID: <220610.86ilp9s1x7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 28 2022, Junio C Hamano wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> The `diagnose` command is the culmination of this hard-won knowledge: it
> gathers the installed hooks, the config, a couple statistics describing
> the data shape, among other pieces of information, and then wraps
> everything up in a tidy, neat `.zip` archive.
> [...]
> +	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
> +	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
> +	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
> +	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
> +	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
> +		goto diagnose_cleanup;

Noticed on top of some local changes I have to not add a .git/hooks (the
--no-template topic), but this fails to diagnose any repo that doesn't
have these paths, which are optional, either because a user could have manually removed them, or used --template=.

although I don't think there's a way to create that sort of repo with
the scalar tooling, it doesn't seem to forward that option, but I didn't
look deeply.

So, no big deal, but it would be nice to have that fixed. Is there a
reason for why this mere addition of various stuff for diagnosis goes
straight to an opendir() and error on failure, as opposed to doing an
lstat() etc. first?
