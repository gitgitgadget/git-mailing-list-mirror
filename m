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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A507C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A03761105
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhDISsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhDISrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0FC0613D9
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so6558873wrz.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NBCuBsyzyid5FYNFzT/nqU+gxu/TAB8898oEPkxFX2Q=;
        b=a4f/Nrh5B86+m0/OWNg14ETj+lFTVNIN5mk/hlhvMNiECxAxmkF0HIITwXzDTX5pVL
         MxJqkOF2VBSUcNGY490AFDxVJG51IkRoZ85y+NeZo1eEtJG1lgPYNqCtOeVq8kscU9lw
         PLyWGABpi8DuuNkmeV2GmFpbFC/hsyjR4BFWs4YrrtyYw/JiA6J2OTyKCK0/9a5KLhIZ
         lr5NUCUUDVoERNmKtnT3dx2y+Vgo4g2ebB95lNHHmQlPWbIlurMpIbAHpwruIsMMbLy4
         r3EikH6k8ZIoPkBaEeWG8GUybZJEpDXWqUusTpd4ERepJA31LX4CV1T4SNSTOp6GNgIx
         lioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NBCuBsyzyid5FYNFzT/nqU+gxu/TAB8898oEPkxFX2Q=;
        b=VXo0G+PDmrtocvMo/YSYM8nXAzjPwm5wYlZNXLrCiN/2qfa6L4bwxVuntmJxKKV9Qd
         l64+PaCFN/fgH9xBLsNQxTqlXUAL341Y1eZwUWi/bxGEPIsKz8bSvIobHWuHPPRyw7NM
         8suREkVr/Perm8ly8OdsgDo3jlMXZnek8pT9cURhH4MgucrQlLkMrr3LkAD3i6FYc+O0
         bkv2S/iGGS78A7yBtO5ZDOLcQKSoNIIYjxoc8W6UTtMZKPuGv4epyVIsmDNVP7iIbUXX
         oGqeDEcxt6W+4D6kBpRaryBH/4eA8LR5Q866UatwQ3Ezgajt2ZrXXqZK7EN5k48vqGo7
         XoiQ==
X-Gm-Message-State: AOAM53216ZeVje7MGZtDcrlQ/Iol/hKkSXpwbP18bC7f8TJtVVaxFf+1
        anpKgKagbKF37RUPhxYci9jBWSydIIQ=
X-Google-Smtp-Source: ABdhPJy1+gehYLJ7YHUJ/sGV22A+Ass1cZ/n6bn9gU2T/O4pc0IJLLTQ7p0UCFQXuwZ+QVTGqRmRlw==
X-Received: by 2002:adf:fd0b:: with SMTP id e11mr14866824wrr.347.1617994057006;
        Fri, 09 Apr 2021 11:47:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm6596438wrw.63.2021.04.09.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:36 -0700 (PDT)
Message-Id: <24129e3e633dbcf7c70f2962a330dc067e161712.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:25 +0000
Subject: [PATCH 06/12] builtin/bugreport: don't leak prefixed filename
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

