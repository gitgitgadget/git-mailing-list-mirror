Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7241EC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbiEZS41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348727AbiEZS4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:56:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7031A994FE
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:56:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ck4so4613490ejb.8
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PoOvQRPl1g+6wY4egd3uRzRLE2m2m8Ce1BAOTJGpKig=;
        b=Ad8CAGCJucM0mv4HAQtTB2hu68r+Xlj5xELbR8YkDdvcnIRVwlUKl46G53bQ92Vpnr
         1qPsUeZG4igeRTlqvgFh8GVNfnnAfZJiDmT8KSMb6sCAj7hwvVjYa65Qn5GwFVrxgjA0
         fJYi5P680sZlSSxj5fjgaHt0Qxakd72FGtTCWGaV86gtmM1sGddIHZjqKZ/N+a9x8+OB
         Rj3RA3MhoY2qlA7BoSoEBZG/EWXmgDoNtq9acplkMgJsetL2yHIb+R65Wuh9TeC1QYzp
         m5N54GJxGFDeCE8/XO6n8C+SheCs7a3KYoZzz4mBrlLSCZAGPYQ22dpK68xlSXrO2B/X
         zVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PoOvQRPl1g+6wY4egd3uRzRLE2m2m8Ce1BAOTJGpKig=;
        b=exfhI8ccswgLl413gFnp/a1tj4fJlF8+MiXniTp9MNVrtDZ55d9icXXxJGgdVkkKmh
         ggw5vGbiWsmbdQJnv5CqCcthWCo+6qm651Criqmh5jwRcCaf3vwybWfsWh0h5kO0508F
         2GgQZKsAPEkSCirAsteZE3Zj5lwSbxCc4gscDRhFQou1jyTylSFCC5G5u4tzJswfemwQ
         VrIUVtNanJTwQCRkfdN6fJmYGgqzuB/OKUd2qRvI1fwKy9Em8y6+3jL4dhgtssUIx7Hi
         KC7DnEifE4jn+rieyDXKB6EaBCLw7B5/SZKENyhNlf0Swgnwczy9AcwO8E7CKVrcvUhW
         7Fsg==
X-Gm-Message-State: AOAM530auLsTE+scX3uDaa5MHLsjXPMcHInWHl8uuU4dTzaZss0Nzyk8
        iS5Lsj5MLkFZFUiek4ASZ0cKc8kNFhs6IA==
X-Google-Smtp-Source: ABdhPJzSFruCNdY8qFheqn57hG83SjpuywHtHeX6MDknlDOpfCLp4QAdYdEVXSTeprHoXQicBqxIYQ==
X-Received: by 2002:a17:907:3f1c:b0:6ff:2bc2:6ac2 with SMTP id hq28-20020a1709073f1c00b006ff2bc26ac2mr2733162ejc.696.1653591373963;
        Thu, 26 May 2022 11:56:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906774300b006f3ef214db7sm759360ejn.29.2022.05.26.11.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:56:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIeb-000FuV-1w;
        Thu, 26 May 2022 20:56:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: js/bisect-in-c (was: What's cooking in git.git (May 2022, #07; Wed,
 25))
Date:   Thu, 26 May 2022 20:54:36 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqzgj41ya2.fsf@gitster.g>
Message-ID: <220526.86r14g3yya.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> * js/bisect-in-c (2022-05-21) 15 commits
>  - bisect: no longer try to clean up left-over `.git/head-name` files
>  - bisect: remove Cogito-related code
>  - Turn `git bisect` into a full built-in
>  - bisect: teach the `bisect--helper` command to show the correct usage strings
>  - bisect: move even the command-line parsing to `bisect--helper`
>  - bisect--helper: return only correct exit codes in `cmd_*()`
>  - bisect--helper: move the `BISECT_STATE` case to the end
>  - bisect--helper: make `--bisect-state` optional
>  - bisect--helper: align the sub-command order with git-bisect.sh
>  - bisect--helper: using `--bisect-state` without an argument is a bug
>  - bisect--helper: really retire `--bisect-autostart`
>  - bisect--helper: really retire --bisect-next-check
>  - bisect--helper: retire the --no-log option
>  - bisect: avoid double-quoting when printing the failed command
>  - bisect run: fix the error message
>
>  Final bits of "git bisect.sh" have been rewritten in C.
>
>  Will merge to 'next'?
>  source: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>

This topic has outstanding regressions in CLI parsing. I.e. we'll now
offer to start bisection where we previously errored out on invalid
command usage. See my replies in that thread.
