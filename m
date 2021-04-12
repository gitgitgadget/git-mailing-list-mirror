Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53FC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBC761241
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhDLLCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbhDLLCn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:02:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17BC06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:02:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so19562468ejc.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nkbouTSqAteJg0J6I3ZnsDQyVo4DBt5lsHS8ZOZZOY=;
        b=dd6L/MSmzDApNBHbLkvMaBoE8/rc2+n/aHAyAZw95wEXcqUD0TrOovM1kfpc0+UDP4
         X07mqgz43D4yntFWy62bPTNGPlWAEzQqs41MkAmOJSmjwmXEKWPEQLzgeBW3TMpObeSd
         bOfWoiCf7qr+tyQq7V21rxqK3gYTAzO6hqBpOXItKeulVpIlM9Nj3Y16K5x7feYMjMu4
         vNoGW3gXgWC2av8t6W03k3o5Sc5qIX0Co5b+eVAD2nwjoAtp2U1CUtiPw6GGt+VRUS5S
         Pb3JQXfnHivk2FPycDySoNyINmFV8gq7tye3Af+gKOWlj8QgdqkRghc8hHC5mUBsuOHC
         iVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nkbouTSqAteJg0J6I3ZnsDQyVo4DBt5lsHS8ZOZZOY=;
        b=J2+/AngTXH+g6NlVnd8bkOk9jXVfx8ntDfh7Z/LWnkXOLXKhv41QbMvEuZuISANAlU
         WR3114eNZ5fuoPJfoyrSnfGY/Vw9bllNHjVkmOvut8R6D3waYjMorOMj4sNd8RNBkNS+
         lZvjPOlGqA10O14UnzzLjHcfTG6Qll19Bbo3L2fWliStE/ze+txYexCR8EMCt3lSVScl
         71mYOnTDEnOXtWlPJaV5fHE+1ZqweBo3JxWFWMnZPFrOrcFE0WCMcCytNxQjo8mx39Dl
         rW46zJp8Ra65u35yhiPBEbcQwqd5qucBsDFkptR0lBroiq0xT0uhg2fkmy3zQ09aRhP3
         mkrw==
X-Gm-Message-State: AOAM533C7audlFqqtdnow666dVr6TnaBJhq+jv1acf8phYxHuZehljdD
        k4pjcAR1HJ4W1u2im2/988k5s5exBBt1bg==
X-Google-Smtp-Source: ABdhPJyLNLQzTr5wRsAW72aqlBVF2ZRzov3tmjZh/oqF6b7j//m401iTlgFbmq2e+qr+l2DIpbsdIA==
X-Received: by 2002:a17:906:11d8:: with SMTP id o24mr7319574eja.386.1618225341631;
        Mon, 12 Apr 2021 04:02:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm2691765ejk.102.2021.04.12.04.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:02:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] C99: harder dependency on variadic macros
Date:   Mon, 12 Apr 2021 13:02:16 +0200
Message-Id: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] which has been out since v2.31.0 we've had a hard dependency
on variadic macros.

Removing the relevant always-off-unless-you-monkeypatch-the-source
code may be too aggressive for Junio's "Let's give it enough time"[2].

But I'm submitting this because of brian m. carlson's note[3] about
wanting to submit more general patches for declaring a hard dependency
on all of C99.

Whatever anyone thinks of that this harder dependency on C99 variadic
macros would be a subset of such a change, so it makes sense to
consider it first. Let's see if anyone has an issue with this landing
before brian's suggested larger change.

1. https://lore.kernel.org/git/YBJLgY+CWtS9TeVb@coredump.intra.peff.net/
2. https://lore.kernel.org/git/xmqq5z3hy4fq.fsf@gitster.c.googlers.com/
3. https://lore.kernel.org/git/YHOLo36MfuTj6YeD@camp.crustytoothpaste.net/

Ævar Arnfjörð Bjarmason (2):
  git-compat-util.h: clarify comment on GCC-specific code
  C99 support: remove non-HAVE_VARIADIC_MACROS code

 Documentation/CodingGuidelines |  3 ++
 banned.h                       |  5 ---
 git-compat-util.h              | 25 +++++-------
 trace.c                        | 73 ----------------------------------
 trace.h                        | 62 -----------------------------
 trace2.c                       | 39 ------------------
 trace2.h                       | 25 ------------
 usage.c                        | 10 -----
 8 files changed, 12 insertions(+), 230 deletions(-)

-- 
2.31.1.631.gb80e078001e

