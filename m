Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2626C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352101AbiBDNNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350186AbiBDNNq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:13:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C9C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:13:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ah7so19224254ejc.4
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hctFs1YK2z2hEsZ9Nq3PCtopdCJv5OAP+FpjFb08qvM=;
        b=pB9kJzIuGDzKdA0vvwb+4iCX2x0iZ6E5ptBIZSvwBJeNIfzXsvRlH8onSTR9mAUtWs
         qiXJG62Nqy7DuKnfYHbBEBtj9GDFQdijWFCWAr7I3KP32SsRvI8YikFUSomlTkl7usGx
         /ZGIAN5ppHSRSIhrmnvbLqPEns9DEXkHvjVsRQam69/d7X25k5kOTIgr1KiXgouL/Ef0
         9cetPHcZXqNXw9LGU7JaoG3hgsfZU++BbVMNCyA+rZISfXuM19wW1b26uK2drI4ubIV8
         rOdvKgcSnDYD6S8JBQcBCAohTqqdElsneGMWzq1faZlbDulWwUH/ET1dYV7DlLQUgMu2
         y0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hctFs1YK2z2hEsZ9Nq3PCtopdCJv5OAP+FpjFb08qvM=;
        b=AOs3IiAk3MIX7fPLBlPglXCYvMFCggyEHpgxEBfqZeQom6RBGaq3Rq9pFtCZdHKIag
         eGVnlhc57jyGO/JDRhFTOeDVUn+eCepOytfaGRS5I2DH29HsK3PLlYpsNjk0xx5h5VTa
         N+yxXGfdGR85S0kdkfsnUGm9Q9Ue7EnJkeXrkJa8TyKxoDWXmGWgg7r7/O9qUeKEZszR
         eJH3doO4NYH5eFRivFeR1UuoQfvrOosPYgw3Y1BdKG8wxyqPROvBVJqROv7x80rPLwQg
         Ozezt7ShDd6o/G4ymzBK0lWrWeW3zPyMZ2nlSx53HfQgG6sufuZaD5zvLgmiHiPZPjDS
         MlWQ==
X-Gm-Message-State: AOAM532WBvDg3TtSOROq4hYuKkJv9CEDV54iK/P2Xcnc2bHz1vbhZwcd
        FmcpNCWDT1hoKvj55pDgrlQ=
X-Google-Smtp-Source: ABdhPJxXquwG2J6WpLF4eCLadWSyBY8BnTh1SZ67t797D6PM2+8dBE7wXQVA+EpMmNqo0DX/laXsMQ==
X-Received: by 2002:a17:906:794a:: with SMTP id l10mr2585952ejo.754.1643980424263;
        Fri, 04 Feb 2022 05:13:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w6sm819011edd.50.2022.02.04.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:13:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFyPH-0065zb-15;
        Fri, 04 Feb 2022 14:13:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: ab/only-single-progress-at-once (was: What's cooking in git.git
 (Feb 2022, #01; Thu, 3))
Date:   Fri, 04 Feb 2022 14:11:58 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.86wnia22rd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * ab/only-single-progress-at-once (2022-01-07) 7 commits
>  - *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop commands on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leak in "test-progress" helper
>
>  Further tweaks on progress API.
>
>  Getting there.
>  source: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>

I sent a re-roll of this yesterday, which I'm only noting here in case
you missed it on account of me screwing up the In-Reply-Chain for that
topic (it traveled between v7..v8, including being attached to an
unrelated thread for another topic of mine, oops!):

https://lore.kernel.org/git/cover-v9-0.9-00000000000-20220203T213350Z-avara=
b@gmail.com/

That re-roll should address all the feedback Ren=C3=A9 and Johannes
Altmanningerhad on the v8.
