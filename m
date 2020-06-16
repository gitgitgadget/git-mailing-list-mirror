Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0514AC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D8B20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpFR+Ooe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFPIqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPIqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 04:46:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B909DC05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 01:46:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o15so20576644ejm.12
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7g7ky24n/LYufuykNIgd0IXHaRy8nTd1WDPP+TW39SE=;
        b=YpFR+OoeFC1YygOux7ho5lc/3QjV3gQ5JITwlCk6Eb+3ZGnt3tfRMIoaguoApqlDr4
         A7VRiLxYk7R3PTPjC/71kwZbT896SQllv2IaZa1ZZ3HukHzwCu2I8NUaJ0+q4SYqFzdv
         1whKCzmOOcpDLV7eViQaIq5l2NSYljqdz+9/oxSPvjvka65+pIgT3XQ/q7tzTciICk92
         ievh0p1a78gV1O7fd+CuPBrSiesKCnXtJk7XmU2ePuOjjzHYInlNOmohl1wY/2HJg0px
         TFxOGYWk13DosKzQ+TKUFOzVEb9nLY7XaM2Tu4aErn0IxQjad5zBBLoCj9GfpfTiLMgu
         izGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7g7ky24n/LYufuykNIgd0IXHaRy8nTd1WDPP+TW39SE=;
        b=i3psE0enncW7MJY2lQH7wyol7mR3mLusVp2LgmeKNFrBe3jg8v8oCAQrdBCCd9EkZh
         cc/0EfnyqvI9p/uICrBaO6jQOhh1RW60dv3pcclJcZyuOaiJovrXfw/4NQKqPIGdnoyH
         dCCsWrn2cqkYfcjUihbY11Xw16XujGmfnrabzlcemYWmUsUSNRzYFAnlZ37QsghRj9gU
         U43F97R+a53FEJAAIENEoCSlK+XXJsVX9GFaqFO0pB97f4G7l8zpoqWHhBJun4GVj2Vw
         c+mej4kiL1mryDCdR93lz7jsYXyCg4FkCQqxVjWmUIduy1TOL61smkK/IHw26CURQ6lB
         HE/A==
X-Gm-Message-State: AOAM530ErVFe2MH/6lNih7WGT7iSPhEzoR/v8aETJNlNnXL+GGmBzNPN
        HuhuCI9Y/cWbwVwHf2IoOfgMmEnw
X-Google-Smtp-Source: ABdhPJxH9M+vqHnF+xiMaNmte0+hocw1ItU832AfJs1l88KS1znkgjsJFm7dMa28TBmK7SrqYE5LOA==
X-Received: by 2002:a17:906:689:: with SMTP id u9mr1697135ejb.13.1592297176950;
        Tue, 16 Jun 2020 01:46:16 -0700 (PDT)
Received: from evledraar (h65073.upc-h.chello.nl. [62.194.65.73])
        by smtp.gmail.com with ESMTPSA id f1sm9646144edn.66.2020.06.16.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:46:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the main branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.1.0
In-reply-to: <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 10:46:15 +0200
Message-ID: <877dw7csa0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 15 2020, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>

> +core.mainBranch::
> +	The name of the main (or: primary) branch in the current repository.
> +	For historical reasons, `master` is used as the fall-back for this
> +	setting.

Everywhere else in git-config(1) we just say something to the effect of
the more brief:

    The name of the main (or: primary) branch in the current repository
    (`master` by default).

I think we should do the same here for consistency & ease of reading.

As you note at the start of this series we're not changing the default
yet, so referring to the current default as historical is putting the
cart before the horse as far as producing self-contained patch serieses
goes.
