Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E1C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0900061037
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbhHZTRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243360AbhHZTRP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 15:17:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A1C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 12:16:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2882864wma.0
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fhDnwZjUSttlyqoEwZLT6cWqLdr2lF2pbnM2NxANCuw=;
        b=ie6dFG7NfJsyQ55isUmudbi3yqs7M8YdqRRRZRuxPr293UjHDTdSet4yAQZLco2vyb
         RlMi3q8T4cqiWE9xVGd2+WI6WSRoboY0v87VuO8Ai1GDIjO8FjcKuHWIB+8BojHFPv96
         VJXPUziU6RtQ9Kpot5Sxf2usS0PMdyTuQ5AJYQ2NNdMf1vBdQicXLaO4AzGltvNovx+1
         UmBP4MGW0n4hairei7pFUc7VmBJmG9tv5szhytcYSpyF/XUFwrSKoFesKWik9ezgw1vX
         pulrcYN744HpFveSBIptpJua+7MtNrcFwUs6DLVkGGdw7Dm2O8UFWWucNpb3qSsxZxZ8
         ZEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fhDnwZjUSttlyqoEwZLT6cWqLdr2lF2pbnM2NxANCuw=;
        b=RRzCU80EPOucP1BxLVCj7C+flsToeI8Qlx0S/gpXnlfuk+L4fc2iwxtKEr9CEXq6mC
         8LXZcONym4pTSXhgydoAVpun1W9eJ/jPvmYbZ2begQHzuyGeBT0bCdse65F/AYUdkrG8
         j2UdwfLSvBI3Lc9bzdvtzWwdUtp/mKHTA8ag0ECtT8Hz+ndC+Ae3MWLAJx8JaUjnUnyB
         AwdA/jSskETYfTyDfaC8BuDwtVMPrWpKO/O3nlAWM8vTBlD9vHGpsQvi+AfOC8oPuUiY
         zXPQK1DN3fXweDKdSQ2VrabsCo4ZuKeQezmdFMNlRQQ2zvAxVFK3rjW1cNnNU6jeQ/7C
         8ymA==
X-Gm-Message-State: AOAM533wxj1AB5R7dO59AQqWN4N8K3bTMCKLLCtZYuGis0340dpHHLrJ
        FtbeQ8cbaBEQo92zakmfuAI=
X-Google-Smtp-Source: ABdhPJy3MypakL5Fg6i1WLa4Ow5zwH4nsOFRlA+40OxEi+nrMAonXvmlGjeBlu4vPNym4K8lNzjkhg==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr15900703wmk.102.1630005385830;
        Thu, 26 Aug 2021 12:16:25 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z6sm3356801wmp.1.2021.08.26.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:16:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2] branch: allow deleting dangling branches with --force
Date:   Thu, 26 Aug 2021 21:12:24 +0200
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <325d64e9-8a31-6ba0-73f2-5e9d67b8682f@web.de>
Message-ID: <87eeagyq2f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 26 2021, Ren=C3=A9 Scharfe wrote:

> - Added Reported-by and Helped-by.

Thanks, this whole thing looks good to me.

> - Made test independent of ref store.

Also thanks. Just my 0.02: I think even with v1 this patch is fine to go
in (but thanks for the re-roll!). I.e. under a full run of the testsuite
with reftable a bunch of things are broken currently.

It's not really that much more effort to just fix up code like in the v1
of this patch when we get to fixing those with the reftable integration,
and putting the onus on patch authors on testing that topic in "seen"
with their tests is probably not a good time investment overall
v.s. just fixing them in bulk later.

Particularly since in this case we can make it refstore independent,
since it's about a disappearing loose object, but in some other cases
it's either the whole test that needs to be skipped, or we'd be better
off with some helpers to produce the corruption in one way under
REFFILES, and in another way under !REFFILES....
