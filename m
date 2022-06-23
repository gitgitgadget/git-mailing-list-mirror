Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C0C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiFWLAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiFWLAN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:00:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599034AE17
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:00:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t5so7749515eje.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=N2RnS4EdJYCpO0Xxr11zvAStZQdXWuZOa7KMCvgN2dQ=;
        b=EeHasJWpzajcCrKARRqq9KI1mHJfvd8YPpVtcQTCFfz7MW4/GVzbDFEZ4Q128DfO1t
         dT5wfaCfocE6jaE9BOZqWHY1sjhzAZfB5loGGYAPtIC+czGN13z7eX9OuFmXoMymaGln
         48+qB3nQHc27lhm/I81x8Dr9NCW0+ck6cc9q64mhNeXE8kGA6EQQNx55/pjAy9G63CrW
         V8w/YvnfayK0WoBDnru/eYLPiWZuphxpGFAweTkoW44hntjX/h3HjYcby+Z7MZOqfikv
         jcT3gwqGdeTPNghhagA3WuKa1LLKiuHyLLzNz4ffaDx67HdfStNPR3Zfo/If+pFgVFSA
         cWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=N2RnS4EdJYCpO0Xxr11zvAStZQdXWuZOa7KMCvgN2dQ=;
        b=ZYhhQkm3pSWPxaUzjOxqRZldQihPoRkHqVGUH1VZzEBLHTt0IN+r9tf87sxH1scmd4
         gyawv6swJvtJtS8bCiy7l3J7zJcjbiBfXwoNdJYB9GOtCu/D30JcwFBtDuVibp6NzAxJ
         itkIgX+TuVwg7X/rUmKTOaZaUpM6M91/bSiT6FTGMU24FCj5mkfK3oR2BwWMVISFJSjr
         NiuSNnem7Tr9B4MtPz0fpDnhmNEUylhcsacnxRswwviUFdwel8dTIYNttgdFT1PYv8VU
         1itz4bLt3cOq3tyBa117Bi0WOvVQW97/Mgw70B1RM8I9mkGO5oBy4JcmLnzTIicmtgiB
         Xhmw==
X-Gm-Message-State: AJIora/PzUL1FI72hYNrIWyT63ezkxkjLAqCt513SgCqq6TlecbglfVY
        AGa1qk/220pX8apXVVK9Mw0=
X-Google-Smtp-Source: AGRyM1vaT3+ZzNIKspIQ79mOIW83udyVGwc4fF6Wzy6FR7kJmM52rYet8Fp6P5NbdMfJa+hrgphvsQ==
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id dd6-20020a1709069b8600b006fed37fb29dmr7576766ejc.327.1655982010748;
        Thu, 23 Jun 2022 04:00:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id hb44-20020a170907162c00b006ff59151e34sm10654445ejc.39.2022.06.23.04.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:00:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4KZF-000sNe-Ix;
        Thu, 23 Jun 2022 13:00:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>
Subject: hx/unpack-streaming (was: What's cooking in git.git (Jun 2022, #07;
 Wed, 22))
Date:   Thu, 23 Jun 2022 12:59:11 +0200
References: <xmqq7d584hqb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d584hqb.fsf@gitster.g>
Message-ID: <220623.86o7yjk5l2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 22 2022, Junio C Hamano wrote:

> * hx/unpack-streaming (2022-06-13) 6 commits
>  - unpack-objects: use stream_loose_object() to unpack large objects
>  - core doc: modernize core.bigFileThreshold documentation
>  - object-file.c: add "stream_loose_object()" to handle large object
>  - object-file.c: factor out deflate part of write_loose_object()
>  - object-file.c: refactor write_loose_object() to several steps
>  - unpack-objects: low memory footprint for get_data() in dry_run mode
>
>  Allow large objects read from a packstream to be streamed into a
>  loose object file straight, without having to keep it in-core as a
>  whole.
>
>  Will merge to 'next'?
>  source: <cover.1654914555.git.chiyutianyi@gmail.com>

I've thoroughly reviewed this topic both now & in the past, and I think
it's ready to be merged down.
