Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA71EC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 10:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiITKOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiITKNq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 06:13:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A3719B0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 03:13:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q21so3056713edc.9
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=ayvxe2EAB4cUmGWla4/oJywXaI0yoIq8zFejuAo7UNE=;
        b=W9H0XjeVP6B2bVP14NGY+3T5ZtGUv+r9km4R4Z13U/q3wbTD0Duu8+c0882Lehx4sy
         u9sy3HPXqovdUfwlSt8D8FSoUVs8geVcJSPDHR2EzEKDk6ISVUM52fWUOwU08NEd9GW1
         1tgHvFTBrQFohUiwn8UL3Pzroqd5dK4f1pY67M8EcSOl/JrMSDHhB+6sGg1L+NxObbK/
         Dc0TSd+qyB9ea0VpyUH9WxalSs54vQK8RGXWIFTocM4CowBPZo+yNiUknlyO9iaJmVWx
         Dx/761qVO8g8d9H8Jb1y0Eh36/97lpUOfw0kfo9JGIsluDCb/rc8tnYa0V/HOg24jQn8
         qYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ayvxe2EAB4cUmGWla4/oJywXaI0yoIq8zFejuAo7UNE=;
        b=Y+uB/cEBtcBG/ZUzFQl/uBsGcFIOaMKgD71HWkJOsOb4k7FDdtvOAiXBIwi3WHBPjI
         61RI6WJC5eUKbJrE8rttn9xQ7PiOnoPbO0jaAPvo86ZEsj+wzCFI68sd0SypSdzWhzEI
         fXDGyhctSp0SSqimUNqI8HySNHgQ2izYFUL/u9tHeuOmUsl0n1J8Gi8KdnTlHUs9Imq2
         q1ZO0OQBK3ByOiQdS+Ih1MBZ+SY/LjZk/Rjv3eKdTv3undp+ghRqnfFoJCTHsildrGH+
         vfsVNS4OUZ4ET2uxUX6xPZZ16heF98hcLPSusJpOztrxNFL7PDtMHXSwLiSkqtNsujGv
         1S+w==
X-Gm-Message-State: ACrzQf1y4hBoxSky5YEk0EtvK7eXrDPVhUAiFtwnHovLNKKHAI/OHVDL
        6hYjWUZrTv6OM3sxFlxVjkoRvLV5Po0=
X-Google-Smtp-Source: AMsMyM4POxjudjxdVAJfRQtF8p0/XFK9A4HoR/x3S64ZZApWP1Tk2/yOUt+OrqyYzdi8ZYsywiwRUw==
X-Received: by 2002:a05:6402:40c2:b0:44f:963d:1ab4 with SMTP id z2-20020a05640240c200b0044f963d1ab4mr19575318edb.319.1663668793161;
        Tue, 20 Sep 2022 03:13:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s25-20020a05640217d900b0044792480994sm992349edy.68.2022.09.20.03.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:13:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oaaFb-001Gtu-2N;
        Tue, 20 Sep 2022 12:13:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Skrab Sah <skrab.sah@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: what if i use makeheader tool to generate c header file, it
 would be accepted.
Date:   Tue, 20 Sep 2022 11:58:51 +0200
References: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
 <220919.86zgev635z.gmgdl@evledraar.gmail.com> <xmqqbkrbb6ua.fsf@gitster.g>
 <CA+J78MWvOEbJY6+NcLFn0SJGMZn=N7QUMwc=Bta+uHicvD892w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CA+J78MWvOEbJY6+NcLFn0SJGMZn=N7QUMwc=Bta+uHicvD892w@mail.gmail.com>
Message-ID: <220920.86illi5p6w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 20 2022, Skrab Sah wrote:

> Let me elaborate to you, how and why I wanted to implement the
> makeheaders tool in the project.
>
> First of all, this program will automatically generate c header(.h)
> files for specified c source(.c) files, which will help the developer.
>
> Here the test shows how the tool can be implemented in different
> cases: https://github.com/skrab-sah/makeheaders-test
>
>
> pros:
>     1. it will slightly reduce the size of the project.
>     2. no need to declare anything in the header file, which is time
> consuming and a headache for developers.

Sure, this all sound interesting in principle, and I think the answer is
definitely "we're not opposed in principle, but if you're interested
let's see patches".

But whether this is worthwhile is something that really can't be
answered until someone (i.e. you) puts in the legwork of implementing
it.

You'll then run into various trade-offs you'd have to make, and issues
you may not have forseen. Just some I can think of offhand:

 * It's unclear if you mean that we'd commit the generated files or
   not. If "not" then our Makefile will need to learn to do two-stage
   compilation. I.e. we'd ship a copy of the makeheader tool, build
   that, build the headers, and then do our "real" build.

   I happen to have an implementation of that "two-stage" compilation
   for entirely different reasons (being able to do configure/probes for
   our compilation), but *just* doing that is non-trivial.

 * The way we document various APIs now is via manually curated header
   files, e.g. how would a strbuf.h look like in this model you're
   proposing?

   Obviously we could move those comments to the *.c file, but right now
   we have a convention of implementation comments going in the *.c
   file, but the API docs going in the *.h.

   We could tell them apart with "/*" v.s. "/**" comments, as we do
   now. But part of the point of having them in the *.h file is that you
   can easily skim the docs & APi definition. Putting the docs in the
   much bigger *.c file wouldn't be nice.

 * We'd have another not-quite-compiler C-parser running on git.git,
   right now we basically have a dependency on spatch's parsing. See
   5cf88fd8b05 (git-compat-util.h: use "UNUSED", not "UNUSED(var)",
   2022-08-25).

   Is this parser smart enough to handle all the edge cases? E.g. for
   KHASH_INIT() we define interfaces via a macro-indirection, so an
   auto-generated *.h needs to resolve the macros in the *.c file.
