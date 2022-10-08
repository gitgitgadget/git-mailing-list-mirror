Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B024C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 03:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJHDql (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 23:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHDqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 23:46:39 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082161F2C0
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 20:46:39 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id g13so3432812ile.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 20:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7k3nRQHSKiZh73SwrZVpMOb335seMGXtTql7FapGrZs=;
        b=2yXFrgm1N4crZaWEOwvIa++qYW8/Giz35gvSeOj4+CVgFMHyqy60OwcKBb22LvynLP
         t7BvOSGsPJ5ADb69Ho/1YfbAy363GBwB+8gfyoSr0PDZqx1h7nHU6BZdIGTmQVWhmFXy
         SjkN6y6SHYs8Kby9RcFDEdMsPtVfRIyLmrpxL5E+Zh341ysQ1AbCuIJWvW8kuFckQJZ9
         OQZF6vjDKjn2pk/b0soJI1CH7HwdV99hH8oIj6fLnZnUyGrZy5VpGlWNEnRmdlQxi/lk
         uzMqh5JaoVgIz9FyWFjjAa3oDfR9OwDq8b6K1Q/81auy/3OP+GploO8b62GScdciqe4a
         cOgg==
X-Gm-Message-State: ACrzQf0WBrNV+8FXqqAt9ezIYMT9Ru8q8cdAjh4GUMqBjAqgbFCw1jyw
        tpw/ZdtF8u6rSasL+2u6ZPG7SkKgB8VUHa1WNn8=
X-Google-Smtp-Source: AMsMyM5rbDSn5WVOygiUY+BtOfRnvOU0rshLOg0KTPmTtuLRrSKHzPUPnwqA99HRLePFSFiDFx6Mls5jvbr4EKO4vGM=
X-Received: by 2002:a05:6e02:12c1:b0:2f1:870a:ad64 with SMTP id
 i1-20020a056e0212c100b002f1870aad64mr4103916ilm.147.1665200798218; Fri, 07
 Oct 2022 20:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
 <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com> <xmqqpmf3frr5.fsf@gitster.g>
 <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de> <58d3ef47-2196-4f59-692a-fc86dfbc1252@jeffhostetler.com>
 <xmqqtu4fco9d.fsf@gitster.g>
In-Reply-To: <xmqqtu4fco9d.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Oct 2022 23:46:27 -0400
Message-ID: <CAPig+cS=k80JdCBAHbSqcOUBc=iGDetoT3u84oRj2CKpFs7CGg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> I do agree that one is dense, but aims for the same thing, and a bit
> more.  It might be easier to read if written in longhand, but ...
>
> ifeq ($(uname_s),Darwin)
> ifeq ($(filter clang12,$(COMPILER_FEATURES)),)
> DEVELOPER_CFLAGS += -Wno-missing-braces
> endif
> else
> ifeq ($(filter clang9,$(COMPILER_FEATURES)),)
> DEVELOPER_CFLAGS += -Wno-missing-braces
> endif
> endif
>
> ... we'd need to repeat ourselves, so...

The repetition is a very minor downside. The big benefit of this
version is that it's easy to understand at-a-glance, unlike the
"dense" version with its high cognitive load.
