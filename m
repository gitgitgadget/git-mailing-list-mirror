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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD9C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823026115B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhDISsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhDISry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A0FC061765
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so3475316wmi.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EgvL8Tim5Qse6K85mBC18YqCLcmDb4YH42pvN8D/GEU=;
        b=XLJW3ISq55+11wbQe5b81rmulL8AdWlfkOzaFVyfcbHS725aru9YuDzCyyLAkin+Ms
         ZC6x5wo9mgt4tTl/HHYY1j8lDRSMKQUuVdpU0ETaK27YKzusKGdMQO+r/l8afvDZdRhV
         1V7dqwPtVcI9sNBvxwmdodi5Rl1WxHAynEjmGmwsAvqHjcKlUB5WFfTRarhYAXW6iJf6
         bQh/1Z4wnsrBAA9GGElyXcNe1cQ1fJlLCE51gkP6rLCl7FM3aTQt+/DeyaVxwPCBFqUs
         vBAVNDbZkACrQ6SDEkzAL4T2+VkNcCKm/M9fVzSnxZAHAclDSrX8VvSHA6NG7RXlxdqm
         5+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EgvL8Tim5Qse6K85mBC18YqCLcmDb4YH42pvN8D/GEU=;
        b=XjAbnGtPcRjloFxFRjJBL6oNBGZgQQspQ4R/4Jj6fWAeQ0Pa+ZPBzcFoRedksemrVA
         HF/L2Ru6scXUIrza8sDopXII77BOSqGlmh+IBzYkbtdjEPoU5KyvqnY0T49yzJJLrmsI
         QLs4Sl+Crju6AiN3sWBsoLsbw82COK06QtG0aXlWHPC7d0//LoaLXhctXJvFPMpX8j7v
         hipqE+8YNo3hSz1Kvy7n68sRsg+oyzXO1TNOqHaxY+fo4cPl7IeGwdbC4Gy2vPqlfwow
         dOOQwIYpCt/UlQQk/OpPONNaooS66e+XDKxFDz9Od+pcNeRNcuvVrKTjLk4pwEXQ/yb7
         DYgw==
X-Gm-Message-State: AOAM5321xjKiUt+9xZg/RMLxb2duKspXAPlUOOm5zXKBCt/DifOxSh+P
        J+lSEK1MKuP4Ez0WqcleJPI15MWQWaE=
X-Google-Smtp-Source: ABdhPJxPZYp68iXVUmOZnx5PehwQRLqRI/t4zBldWVf4yU7yWiQo8hI4zlfWF+JUDpUszYTfHrQvrg==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr3893872wmg.22.1617994059629;
        Fri, 09 Apr 2021 11:47:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v189sm5098344wme.39.2021.04.09.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:39 -0700 (PDT)
Message-Id: <c17e296bcb1476050306a29065ca3599767ff2b4.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:30 +0000
Subject: [PATCH 11/12] builtin/rebase: release git_format_patch_opt too
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
index 783b526f6e75..c0cd2c40c7d8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -2108,6 +2108,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.head_name);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
+	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	return ret;
 }
-- 
gitgitgadget

