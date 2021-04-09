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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF41FC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7662061106
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhDISsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbhDISrz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76115C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x15so6588211wrq.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S6z0G57DdP3GQ5/enY3+6YG3xUz1kWofC9ozxQR0rBI=;
        b=LN1vhwNC6YIhcx1KZZvk/u3tHblmaIuCwqUpcV8ol7i6G3fTieEN631YFoPxy5cGa/
         tXbd83eDl0cnGC1UkiexTqrtH7noeC5uAb8lmFXDlRzJxINMk4rt5Tqt6nlJIZ9Gn/uJ
         1KHwFExrHVSccnYiUqVYMboZgdGrheMK3ny+ejle91Ysll/bP8EaVn5GbUeLgKSaDwks
         j0NUnG4mERjwB3q5IBWwGf+VuESIliwLPKb0LlkMpcv62VhXhwcL1Q6X1eZSOv9+7r+M
         CoVL9qoJHMsU59C6EPnXSeWfK4T9hM3jwpPT19PtlvPF5FUOGWoq2jPgAY/xfREYKn9J
         ORYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S6z0G57DdP3GQ5/enY3+6YG3xUz1kWofC9ozxQR0rBI=;
        b=Al9BXHj7IT0HULKn1GX7nN5QOwREmxjGmRmASZg/zs1ryQ+3O4j7I8OdAUadBYJOkN
         mYphZqq3nBEeyB0pkw2lbRev+Jd79kb2uDRwz82sasTAP94ubPQ2e3G9TqqIG0YCCYwZ
         QM6z67mIRMH+EFV90WyPdZX0QsS0dT7WSajPs2twzM5SHYTFEHEOz/2uMWKtlnojHz6h
         7JXLp7r4galj9OQSgimnL6PvBkrx0EJVmvE+sLUtPVVW3erIdOSwWSFuxmUq9Oa7SDmA
         6wcRFT66La44GG2dF/b85m5/im54cd+epK37qawkAb/dKK3keeBgZH1fW3aAyuiWbqoQ
         Jhmg==
X-Gm-Message-State: AOAM533s44gjs6pJe6SdSsoK7HQSK13q0cyPNzonk/6rS0ji95ADmN64
        EgByG6U2RY4O44DZXveUbuaOCNb5A54=
X-Google-Smtp-Source: ABdhPJyPO3dlY96Kg1o5MG1834byByJ9TjOUzQOWBGM+zFvEnMI6mfZO2LIrIJwSXoQsoX6lzzFlLg==
X-Received: by 2002:a05:6000:250:: with SMTP id m16mr19672876wrz.325.1617994060164;
        Fri, 09 Apr 2021 11:47:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m128sm6081083wmm.14.2021.04.09.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:39 -0700 (PDT)
Message-Id: <db1b151e2a151a0ba1ee1f8ead47480c1236113d.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:31 +0000
Subject: [PATCH 12/12] builtin/rm: avoid leaking pathspec and seen
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

parse_pathspec() populates pathspec, hence we need to clear it once it's
no longer needed. seen is xcalloc'd within the same function and
likewise needs to be freed once its no longer needed.

cmd_rm() has multiple early returns, therefore we need to clear or free
as soon as this data is no longer needed, as opposed to doing a cleanup
at the end.

LSAN output from t0020:

Direct leak of 112 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac0a4 in do_xmalloc wrapper.c:41:8
    #2 0x9ac07a in xmalloc wrapper.c:62:9
    #3 0x873277 in parse_pathspec pathspec.c:582:2
    #4 0x646ffa in cmd_rm builtin/rm.c:266:2
    #5 0x4cd91d in run_builtin git.c:467:11
    #6 0x4cb5f3 in handle_builtin git.c:719:3
    #7 0x4ccf47 in run_argv git.c:808:4
    #8 0x4caf49 in cmd_main git.c:939:19
    #9 0x69dc0e in main common-main.c:52:11
    #10 0x7f948825b349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 65 byte(s) in 1 object(s) allocated from:
    #0 0x49ab79 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9ac2a6 in xrealloc wrapper.c:126:8
    #2 0x93b14d in strbuf_grow strbuf.c:98:2
    #3 0x93ccf6 in strbuf_vaddf strbuf.c:392:3
    #4 0x93f726 in xstrvfmt strbuf.c:979:2
    #5 0x93f8b3 in xstrfmt strbuf.c:989:8
    #6 0x92ad8a in prefix_path_gently setup.c:115:15
    #7 0x873a8d in init_pathspec_item pathspec.c:439:11
    #8 0x87334f in parse_pathspec pathspec.c:589:3
    #9 0x646ffa in cmd_rm builtin/rm.c:266:2
    #10 0x4cd91d in run_builtin git.c:467:11
    #11 0x4cb5f3 in handle_builtin git.c:719:3
    #12 0x4ccf47 in run_argv git.c:808:4
    #13 0x4caf49 in cmd_main git.c:939:19
    #14 0x69dc0e in main common-main.c:52:11
    #15 0x7f948825b349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 15 byte(s) in 1 object(s) allocated from:
    #0 0x486834 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9ac048 in xstrdup wrapper.c:29:14
    #2 0x873ba2 in init_pathspec_item pathspec.c:468:20
    #3 0x87334f in parse_pathspec pathspec.c:589:3
    #4 0x646ffa in cmd_rm builtin/rm.c:266:2
    #5 0x4cd91d in run_builtin git.c:467:11
    #6 0x4cb5f3 in handle_builtin git.c:719:3
    #7 0x4ccf47 in run_argv git.c:808:4
    #8 0x4caf49 in cmd_main git.c:939:19
    #9 0x69dc0e in main common-main.c:52:11
    #10 0x7f948825b349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Direct leak of 1 byte(s) in 1 object(s) allocated from:
    #0 0x49a9d2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x9ac392 in xcalloc wrapper.c:140:8
    #2 0x647108 in cmd_rm builtin/rm.c:294:9
    #3 0x4cd91d in run_builtin git.c:467:11
    #4 0x4cb5f3 in handle_builtin git.c:719:3
    #5 0x4ccf47 in run_argv git.c:808:4
    #6 0x4caf49 in cmd_main git.c:939:19
    #7 0x69dbfe in main common-main.c:52:11
    #8 0x7f4fac1b0349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/rm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f02..2927678d37b6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -327,6 +327,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!seen_any)
 			exit(0);
 	}
+	clear_pathspec(&pathspec);
+	free(seen);
 
 	if (!index_only)
 		submodules_absorb_gitdir_if_needed();
-- 
gitgitgadget
