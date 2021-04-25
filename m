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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE77C43462
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DFD6128B
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhDYORI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhDYORG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827EC061756
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso3663013wmq.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NBCuBsyzyid5FYNFzT/nqU+gxu/TAB8898oEPkxFX2Q=;
        b=dxKEVanRMxloG/pW21QwesWNGkSqUY7iPS0ertcKPnQ11Y+rT0j0FGLNythVZbaw/x
         IOvfq7hkWQ4Igv1ugbLgdeG2bhckexNU453BpR7Qjo7T1cKfrSDQMkfAJCHN2U9XVNyM
         scMTSE7PKFOElGSD2Tx3ZjVNjwq8UPSqIbDkTcVMAo3EElIjnVH3slh7IS/n4/ubHUIm
         tp5ydv02fh0xE+zIH0uw0JnL/QiHAsWGOSuFDRn2UQDn+EYnAJzmCyErnfWrb1/+iyS8
         /KH6QOe5e4quxLQvLNvDpJQFTGmykq9kRYvscXPiVLQP/PF8nndmr8LdgAwrm3rhVqd/
         6Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NBCuBsyzyid5FYNFzT/nqU+gxu/TAB8898oEPkxFX2Q=;
        b=q6tlrEn5vJXGHixjTPZGWiWJsZOE8WFYOcV3fvYhHvhWb/0u0bfzs5AHz+X0C0KDOk
         7GxmB8Kp9B8L1jJwfwo4lYRWnhEvHygHrNrNhEYZ/nvUfNj0YTgKFBGuwFaJONerCdmE
         4Q+iXK4+0g4hCVIkcaBspEfPIo4FG8P/KkAg1H72q7nnVr7QE8pdgw5u3fbx/xBoTIgT
         pfirRPq0lgdTPqkkY6sJkh6iFay9EuR+GSRP5WvtNENrGwaoHdI4sV9Ieyj+HonKNDeZ
         J94BgUi5pruW2YGWhIAPmxREEtiHsTn1b2iaj1PFN2HJ+0eLzaIqtGV1jHUuGvnZoW5Y
         SlsA==
X-Gm-Message-State: AOAM530wuom3hX++bmoRL1h2zhEHo7vFWw927985kewAJDs48t6Exsao
        6ONValE8IugjQoJHe/LmC5HLw+4NWS8=
X-Google-Smtp-Source: ABdhPJwTgGt5Pi8jhhL0QFn/yfUB5+i8sZpVABpvdhqppSExBVfAcwFYfKmS9g7ViHseVR815claLQ==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr15615060wmi.160.1619360185226;
        Sun, 25 Apr 2021 07:16:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm18429088wrt.0.2021.04.25.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
Message-Id: <0ae6224e01bc5d7da47b844600e64e44d7805fdb.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:13 +0000
Subject: [PATCH v2 06/12] builtin/bugreport: don't leak prefixed filename
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

prefix_filename() returns newly allocated memory, and strbuf_addstr()
doesn't take ownership of its inputs. Therefore we have to make sure to
store and free prefix_filename()'s result.

As this leak is in cmd_bugreport(), we could just as well UNLEAK the
prefix - but there's no good reason not to just free it properly. This
leak was found while running t0091, see output below:

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x49ab79 in realloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9acc66 in xrealloc wrapper.c:126:8
    #2 0x93baed in strbuf_grow strbuf.c:98:2
    #3 0x93c6ea in strbuf_add strbuf.c:295:2
    #4 0x69f162 in strbuf_addstr ./strbuf.h:304:2
    #5 0x69f083 in prefix_filename abspath.c:277:2
    #6 0x4fb275 in cmd_bugreport builtin/bugreport.c:146:9
    #7 0x4cd91d in run_builtin git.c:467:11
    #8 0x4cb5f3 in handle_builtin git.c:719:3
    #9 0x4ccf47 in run_argv git.c:808:4
    #10 0x4caf49 in cmd_main git.c:939:19
    #11 0x69df9e in main common-main.c:52:11
    #12 0x7f523a987349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/bugreport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index ad3cc9c02f62..9915a5841def 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -129,6 +129,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
+	char *prefixed_filename;
 
 	const struct option bugreport_options[] = {
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
@@ -142,9 +143,9 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 			     bugreport_usage, 0);
 
 	/* Prepare the path to put the result */
-	strbuf_addstr(&report_path,
-		      prefix_filename(prefix,
-				      option_output ? option_output : ""));
+	prefixed_filename = prefix_filename(prefix,
+					    option_output ? option_output : "");
+	strbuf_addstr(&report_path, prefixed_filename);
 	strbuf_complete(&report_path, '/');
 
 	strbuf_addstr(&report_path, "git-bugreport-");
@@ -189,6 +190,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	fprintf(stderr, _("Created new report at '%s'.\n"),
 		user_relative_path);
 
+	free(prefixed_filename);
 	UNLEAK(buffer);
 	UNLEAK(report_path);
 	return !!launch_editor(report_path.buf, NULL, NULL);
-- 
gitgitgadget

