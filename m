Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2137C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C7461364
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhDYORP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhDYORJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E7C06175F
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so53135795wrr.2
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wcg85AEdtfOMCaUZXhnfDMMdyHFv/3Ywlth4J1G5IVM=;
        b=WqnzotVj5cdUYyF8F/cxNGeQssAYRAbclNnqbFIDqkb+gz8grmQW346TSombbkxDFy
         quyGyVmvweZTICeduZtskPfnMZ1y1tsl1yWxP8GrQrUb3KKxjk55ZzX8vXBDKIrEYNsM
         AOaIrOuLxQ9PvZd/sXsm2Z+wduw9djfVDjdlqirGEDV+wnRpL6Ur2AB8pfZHJ23TGV2i
         HAjg1f0qfrRtCQgTxSbRSfvdkf14KU4CQHu1V3TCl7TwD7kYPZj6dBuDEwXK+5RiHkw3
         Dc+7QSh/YkseOSqcxKfUrk7F7w8EB/9vemLhd43xI9hsetZhhkF1kl3CcB0RH/AptQKY
         DVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wcg85AEdtfOMCaUZXhnfDMMdyHFv/3Ywlth4J1G5IVM=;
        b=ENaxzYp379OaCzAv8HUrFBetYxAVblJiYwBtRhpgTc7oA395lk+siQxFmZMa4mfTcL
         VByWRZW7EfakGrOBAcieSExsxG9h96xNvCZXTv4gUPB5w4d7PBiUcsIHlrI/9OV3kwie
         We5b5Y/vKfD8OPe5MPlyLnLJXRX/k9dB4HsUKzJWk+iu0l+WwzG8UL/svfGHx5WSyOL3
         mcywoNgyHCPF7EK0TVO9IwN/UD0E2Ew5EXshItdN1W06jKeffOlEaKSonOUdN1yOoGUN
         vOcq+SEKmJFKtqt7Dh33raVS5y/IzB+pLsFj++6DrFCAMqonCaOu9BOfc5r8hK/GDJN6
         mbDQ==
X-Gm-Message-State: AOAM531s9+yjZwN3Y5YbqklvPH2JcBOg9xGIlE+GSNV8iR8o3i+VHmTL
        ySs7cyY1UZIvkrR3fwhQtaCMYomrjSk=
X-Google-Smtp-Source: ABdhPJwnYOPUSSGIeiCFdW+tB72PhGXOv3lTxIpPdyByuZ8uVBU3rQm3p8dU0mabFE4E9Z2GFFwF6w==
X-Received: by 2002:adf:db4f:: with SMTP id f15mr17113774wrj.99.1619360187852;
        Sun, 25 Apr 2021 07:16:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm15986660wmi.19.2021.04.25.07.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:27 -0700 (PDT)
Message-Id: <a67168677477c18e9ee1416f3e4e5701e1eebcb6.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:18 +0000
Subject: [PATCH v2 11/12] builtin/rebase: release git_format_patch_opt too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

options.git_format_patch_opt can be populated during cmd_rebase's setup,
and will therefore leak on return. Although we could just UNLEAK all of
options, we choose to strbuf_release() the individual member, which matches
the existing pattern (where we're freeing invidual members of options).

Leak found when running t0021:

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x49ab79 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9ac296 in xrealloc wrapper.c:126:8
    #2 0x93b13d in strbuf_grow strbuf.c:98:2
    #3 0x93bd3a in strbuf_add strbuf.c:295:2
    #4 0x60ae92 in strbuf_addstr strbuf.h:304:2
    #5 0x605f17 in cmd_rebase builtin/rebase.c:1759:3
    #6 0x4cd91d in run_builtin git.c:467:11
    #7 0x4cb5f3 in handle_builtin git.c:719:3
    #8 0x4ccf47 in run_argv git.c:808:4
    #9 0x4caf49 in cmd_main git.c:939:19
    #10 0x69dbfe in main common-main.c:52:11
    #11 0x7f66dae91349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 24 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/rebase.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ed1da1760e4c..a756fba23330 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -2109,6 +2109,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.head_name);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
+	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	return ret;
 }
-- 
gitgitgadget

