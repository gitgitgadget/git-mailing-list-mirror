Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C69C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiGUTGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUTGE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:06:04 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC0B2CC88
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:06:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z22so3332199edd.6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=tYuzyvxgBnLvQaiLSlTw2jPciNCOsd0YIIVk/pKmwRo=;
        b=eQkyiSUhcshY/fucfDM7uDA2GuoAaMgZZpEobWgBPQvaDmtW8MrcfiQNP7rWwMpPlQ
         I6dCofh/hR11HDXsQlX1a45GuO0XcSVlbys8MJxRMrF1AyrLEudL/hhLyem3FZ9l8bAA
         WmX3Y90Zm+DuDeLH7lpm0obLACvVoPnbtwko6QSKt4PAMfo1z5HIlJvuKrfjHKNT6xiL
         e5vE6Ox5Bdt1Psc8YVB5+GgS2TmWyLcd3nkC9w/QMfNfcFaHHEWY4ONDsrzWHAem3QEj
         09krAxivyY8krWZtRmwJ9sRpSE3GGieirdFcK3rmDrZzSTIEmDCa5mEL7DEOJG8VszXm
         fReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=tYuzyvxgBnLvQaiLSlTw2jPciNCOsd0YIIVk/pKmwRo=;
        b=OjT4IsiWeotNr6wgXItufeB7m1QP7xGsCUxKgonJXRiOC9vpC+dkoxD9gFgcdYDjHI
         3DtyONBtCk5zB4dCSzo4PUh9ZuZWaO5nrJBs5NoU26lo3c7pn1xpndYlIgJQKfaMY+Vy
         SIgNVMrwyanwrw53xjY1Zp0LBIPBQ0hu9Y3CZ0+zproUqgbLV47WUkLxzIQwzDzCp+ZK
         Tz2zWtOnHLH/THF2eSbLAYyK30XScsqM4U77QL25QlPHF0UKGb3rh+CaHfLZJqE7R8Io
         mU5AlSBu3lvJ7DamS1holJIM/JPl4Rl//UHLEWeaWZ2geo444PoZsbAzFsTUD4C9psom
         3m0A==
X-Gm-Message-State: AJIora8m4QFuSB/3OrWXoCVe2x5OyMfj6T8Ctf/BlKJXadN88J6Eez/c
        hk2Q/mdqwBLDTYtRDMdwWZKZoer+HW7/ww==
X-Google-Smtp-Source: AGRyM1t2DbXfKMJWER29JOMSCoar29jrANc7oKlqwzWAbExKUUuL69sw7efrmefZkEuW6wt2stz96A==
X-Received: by 2002:a05:6402:1e94:b0:43a:9e92:bf2 with SMTP id f20-20020a0564021e9400b0043a9e920bf2mr58684786edf.248.1658430361088;
        Thu, 21 Jul 2022 12:06:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f6-20020a05640214c600b0043a6df72c11sm1415570edx.63.2022.07.21.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:05:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEbUk-004mpA-J0;
        Thu, 21 Jul 2022 21:05:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: re-mentioning --preserve-merges in the docs (was: [PATCH v3 05/11]
 rebase: drop support for `--preserve-merges`)
Date:   Thu, 21 Jul 2022 21:02:14 +0200
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
 <2d7a4a2c564aaafbf8da97cf017766163c77b70b.1631048713.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2d7a4a2c564aaafbf8da97cf017766163c77b70b.1631048713.git.gitgitgadget@gmail.com>
Message-ID: <220721.86wnc6s2uh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> --p::
> ---preserve-merges::
> -	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
> -	instead of flattening the history by replaying commits a merge commit
> -	introduces. Merge conflict resolutions or manual amendments to merge
> -	commits are not preserved.

[In reply to an old commit]

I opened "man git-rebase" today due to an on-list discussion and went
through pretty much:

 1. /preserve-merges # fails
 2. skimming the SYNOPSIS, forgetting what the new thing is called
 3. Paging down, eventually findinging & remembering the new thing is
    "--rebase-merges".

I wonder if there's objections to reinstating this in the docs
somewhere, just as something like:

	--preserve-merges:
		An old "rebase" backend which is no longer supported,
		and which was removed from git in version v2.35.0.

We don't do that with all flags that we've dropped, but perhaps this one
was well known enough to not leave readers hanging...


