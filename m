Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2601C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8F61056
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhDISsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhDISrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B808C0613D7
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so2829572wrt.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ScUW1NORBj4GwPLuBugHT/djgCpDbeqS4S84yTVmdXU=;
        b=EvHxdE+I4oJo069+5ik2t1DMZ3l0qLOdntmladGeO54WpLES2Paw9m/5KbLMLYJ+WC
         MDis6kFfAkN08/fCdqQitOfFMXizGBt/yeLobRvUFVfanMhHxKNYPop2LPNqUHrRbijC
         QaCcCQgEv8SE5T5HeEj0dwZoEQteQ/bkBANH7jAdbimePKAfQWCEHe76/yujz/GDZpV8
         YdQby2tUO6abptM2BUE+S4hzaKQdBtCWH5MKhfRsUQzTrTOcsi9GcHRz0XHUM593Ay/x
         IMAvJRJ3Tcm7zZoKzGfY78+d9HtarOxGeRoDcafRghp9vKv7+/UEa+NpqiY7l8E5lGYi
         PzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ScUW1NORBj4GwPLuBugHT/djgCpDbeqS4S84yTVmdXU=;
        b=lPSdP3HNIY4a0f3nQmv5UxUuKo1T/7wFHr9KbhqJGyKzMbAnY/3TFMKwwfInERX6y7
         LXIi3A+EOYdgFJr8kmGVPASxRLt6WnvDcXqyGN0KGlY2b6hMQyCvIp/wfGK6jqOFuEya
         T2GrfIqCAydsUzAvWSNG5/xc/8ntz9RaQkXKmDTr/9NpdD1j/jhrtObK+qgWXv6/1aWe
         Q+LTT88jSbEtezUH9Pqiw5Xul6yekFfdFROBAUEN/tdcmsS4JZBaVwuPbMwMz1+iQaD9
         Xw8lltfwh63j8N7nmxd/HfABf5zeyzOIGSS4yCHqRMn66cNoeo+JqTRd3dd2lX4kvQJz
         MaGA==
X-Gm-Message-State: AOAM531PcV61ok8K3MmFgN12OTj/yyZo7seRdeHVsoXJ5a2pRx+uhs+S
        XlSbQR6Jr3Dw20EFoQAMpn2xQTzde04=
X-Google-Smtp-Source: ABdhPJyoNCMhQ7IseUXhSN18KC3hU2zvGosJWGntPPGvekcddIYPKYN3sMlUTpSG6N1dFfVtgdHFmg==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr10659125wru.92.1617994055973;
        Fri, 09 Apr 2021 11:47:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm5529955wri.32.2021.04.09.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:35 -0700 (PDT)
Message-Id: <9ae15b94881369fa1cbd09fc2de9cc94c30edb2d.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:23 +0000
Subject: [PATCH 04/12] bloom: clear each bloom_key after use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

fill_bloom_key() allocates memory into bloom_key, we need to clean that
up once the key is no longer needed.

This fixes the following leak which was found while running t0002-t0099.
Although this leak is happening in code being called from a test-helper,
the same code is also used in various locations around git, and could
presumably happen during normal usage too.

Direct leak of 308 byte(s) in 11 object(s) allocated from:
    #0 0x49a5e2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x6f4032 in xcalloc wrapper.c:140:8
    #2 0x4f2905 in fill_bloom_key bloom.c:137:28
    #3 0x4f34c1 in get_or_compute_bloom_filter bloom.c:284:4
    #4 0x4cb484 in get_bloom_filter_for_commit t/helper/test-bloom.c:43:11
    #5 0x4cb072 in cmd__bloom t/helper/test-bloom.c:97:3
    #6 0x4ca7ef in cmd_main t/helper/test-tool.c:121:11
    #7 0x4caace in main common-main.c:52:11
    #8 0x7f798af95349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 308 byte(s) leaked in 11 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 bloom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bloom.c b/bloom.c
index 52b87474c6eb..5e297038bb1f 100644
--- a/bloom.c
+++ b/bloom.c
@@ -283,6 +283,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			struct bloom_key key;
 			fill_bloom_key(e->path, strlen(e->path), &key, settings);
 			add_key_to_filter(&key, filter, settings);
+			clear_bloom_key(&key);
 		}
 
 	cleanup:
-- 
gitgitgadget

