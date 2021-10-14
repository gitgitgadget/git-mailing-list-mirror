Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D1C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1B961130
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhJNAJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJNAIw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C7CC06176F
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m22so13967537wrb.0
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Jb7ESRNUDqbmp+WOVWaLABeIGo2jgSgvBcuodkix7A=;
        b=pPi1nD5t4asUpep69HIkGuFKckINCSlRVnZEOSYqtKjk+9HB0kNbnEcE5lM0EwfD9U
         WXxe7+3u54Ev6oQkc1859MW0kSDhYdePH6M0e+I34A15SGFaZTzPB6wItd0YS4ByTLin
         QN/tc7XVZcZXvxNR757xNTR9tIolWcZND9De/ve4foJZY0gBc+Pc/JH+4rmedDT2N372
         rSTrFuXHiIL+tHcKFPGs3SR6rUgaIbmU0vq7kjq2p9FWRyipwdbyVLLWAa6eRJjhZZFl
         0i9Xkd0XzFJ0x6aNgxSZSQ8Iacmqkx8bwC/mGrtpxypvbFqMkl+s42PdQg7Kgk+avZmy
         v71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Jb7ESRNUDqbmp+WOVWaLABeIGo2jgSgvBcuodkix7A=;
        b=Ftsk0mDnxsTSHlkLiKre5IokCic/A9DL+imZGWJpFAre79mi5z+mHI8FRuErxiURbh
         lWglaHiEDMoXorkCSGdoyW74MVTx7HlG/Zmpu3tKVQ/BdgvNbBs6K6pJY6L/choaJiCk
         pAUrWbnG9g0xdXcGjkxTW75XgJkmjtSLIaVtZYbzGRj0sa/m0ZtlcCfqrSSaAVctsZSt
         V4ZT9sf2GhivF+8n89/kz5KQNYHF/w3ydny0DL/3EXIqQag1rHTT6HoZYVqncQ4cm+Dd
         NpoY5OmSHGUABNl8YvxOInPxFlgJz1Ym1HujVM9JSC6xtezLOdkyc5LkUrRcZXOp5hAj
         xjLw==
X-Gm-Message-State: AOAM532r/aIpGwexjahYOFP+MkIb6z2lqmlP0bPTa0X2O/xzYhvMQGjR
        p6gvrP9RPF54hfHCLbImF4LQeC8RpPnVbQ==
X-Google-Smtp-Source: ABdhPJzkhPfXf14Rfwhxhkm9wiZUuV4K42sj7b7O2leNzAraFFvOnAxtzmtuouXr5vkmsMtUayz+Wg==
X-Received: by 2002:a05:600c:21cc:: with SMTP id x12mr7664038wmj.8.1634170004321;
        Wed, 13 Oct 2021 17:06:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/20] refs tests: ignore ignore errno in test-ref-store helper
Date:   Thu, 14 Oct 2021 02:06:25 +0200
Message-Id: <patch-13.20-954633bcbb2-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmd_resolve_ref() function has always ignored errno on failure,
but let's do so explicitly when using the refs_resolve_ref_unsafe()
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-ref-store.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..2f91fb9b227 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -123,9 +123,10 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
 	int flags;
 	const char *ref;
+	int ignore_errno;
 
-	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-				      &oid, &flags);
+	ref = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+				      &oid, &flags, &ignore_errno);
 	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
 }
-- 
2.33.1.1346.g48288c3c089

