Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E778CC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbiFIScC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFIScB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 14:32:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC42BC14
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 11:31:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s12so41948506ejx.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HdgYh7H6djiSkWdskIqW1HYZC75prn7mcolys9sjAas=;
        b=d+zU60w0gN85I1vhWOd+yPsNiB96tcUicmJtU3Ms9smN/4DLNQJdXGVi1f2RiisIPM
         zrrrFoedS9s5fTJRKJmdaZn4Dsq7SNY+bm4UQD9+gdtTHq8Uo2G8+WHFQX8hS/xGZppp
         buAiFmNDL88fHmmBo8nHS3dO04CER7vyXS/VzIO+qQssRadE+ZIprbPN8avKuOqI7qwb
         +K5cALVmUL8kWr3o0YVZ6bFmaIzyC9LROmKUSn2LmAyfOjRDiRXVuolfYubRhutDK+Wp
         7QO4qmobLtMui8eDTfOzwIp81Mr4lsdalRqf4KIc9veJZELM8PoUwtLtxSjrJYfLC8CE
         zHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HdgYh7H6djiSkWdskIqW1HYZC75prn7mcolys9sjAas=;
        b=xTyzAq+o1WP6X1pbjmX0tJW21A0xeiCVEEYr0RzqiR8Ac1J8kf2XwuYw3jiZD4jKO+
         BNup2M0NyiV55LQ4zt/5C85qn9FJ78u9z0mlFvBF5Ri20B9GGS5irrv3V+d6eyZ0Fzzq
         Iui3y0viAtO6DREw0c02CXzbDeTIas00nmsNjUGiUa8n8GSd6nbC5Bf9l3d3oEhGp7Wp
         A0bG8bjHiU6Vryb+tWgNs7GesSBQ95TJJ5j7zzHu5NkCCdTkDBru87x3OdNBRAF1Z3sw
         vHG/QHYsm/hUfI/fR6ZWpFRnL2FQrTC77vI/YgJEFje0SZWKaTpMoTCnUAKcfqfUnYbv
         6MYQ==
X-Gm-Message-State: AOAM530QQZxvQ7lKIDo4168jKCaUXxLWmGssMc8ENe1pMKg8IospXiXM
        2/K/pMNQ3xSOi1Rper6Vtu0=
X-Google-Smtp-Source: ABdhPJwnWkY7w/0Nt7EAPXzJ2qxyTNpKJpDTjp+2hR/go29ibieorFkh1qRJT00RPJ5bM7qRwIH/gA==
X-Received: by 2002:a17:907:7fa9:b0:711:d214:36cd with SMTP id qk41-20020a1709077fa900b00711d21436cdmr18620268ejc.600.1654799517413;
        Thu, 09 Jun 2022 11:31:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x11-20020a056402414b00b0043158c608e4sm8051877eda.27.2022.06.09.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:31:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzMwm-0032R6-Bq;
        Thu, 09 Jun 2022 20:31:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Date:   Thu, 09 Jun 2022 20:27:47 +0200
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqtu8x1fd4.fsf@gitster.g>
 <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
 <xmqq5ylarhsg.fsf@gitster.g>
 <3d67b69b-fac8-3171-92dc-303ea672efbf@github.com>
 <xmqqk09plnze.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqk09plnze.fsf@gitster.g>
Message-ID: <220609.86v8t9sn6r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 09 2022, Junio C Hamano wrote:

> Derrick Stolee <derrickstolee@github.com> writes:
> [...]
>> I hope I am going in the right direction here, but I likely
>> misunderstood some of your proposed alternatives.
>
> I wasn't seriously "proposing" an alternative.  It was just that it
> looked wasteful to go to a separate format (i.e. bundle) when packfiles
> should suffice, as you would be adding extra information that is not
> in bundles via the table-of-contents anyway, and what is given by a
> bundle that is missing in a packfile is only the refs information,
> which should be trivial to add to the table-of-contents.

One thing that got pointed out to me by someone interested in this
feature is that they'd be interested in serving up historical git
repositories with a repo.bundle file.

We're much better off with a format that includes refs for those use
cases, even though no version of the patches that have been kicked
around support this particular use-case yet (but it would be relatively
easy as a follow-up).

I also daresay that bundles will tend to integrate better into existing
infrastructure, since if you're doing incremental backups with them it's
a natural extension to throw those same incremental updates at a CDN and
serve them up with bundle-uri.

I also think we can come up with much better tooling for collections of
bundles than random packfiles, since they declare what "tip" they want,
and we're able to add arbitrary key-values to the header format in the
future (and Stolee already added one such key-value).
