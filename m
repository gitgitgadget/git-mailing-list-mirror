Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5211C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DCA60EB8
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhJVSWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhJVSWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:22:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81784C061767
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v127so3674809wme.5
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U09sdpyXOpQAiokID9yBMbAGXHIjD+Y6V6QVoUGqhxQ=;
        b=Rrl7Hp00lSjAY5f8vgyfQJhGadFMQWzE2JwCJLnuu8WmtifdrC+6ihQFkmi39OFW3W
         lDfRYDH2tSd0dQDjd6xMXijwq2bdVFlQDyb0pnuiM2YKyFfnjLeliTcrfyq2Lp4ozSOG
         EjCFMvPAlATK23K4VVEEZlHw4YhAE4scjgs8e5TDEqySWXONLxuBWyekcDxJeiwi0W2V
         KRgsPZ9TTP60cDxBfDdPrG42xIOq4WUEGaDvUkgHRkR6/QH253J/vErvnUQlsFBJjRUy
         p8148ewMJqtsavemEYQu1pFQ+GtL1XhxphOFd1TzqFqtkql/yZDt/0KoBfp/p0iLMC+L
         5ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U09sdpyXOpQAiokID9yBMbAGXHIjD+Y6V6QVoUGqhxQ=;
        b=xXCnzLCSYyDCy1/Jc58iYxxUBjbpTCV+QrM6GkazVCyq7LPdkFGeI4PQQPzKdwa7u2
         e9xaPRbH5x6aiR086YfyU6dwgpY1B+/GbkNmFzZjQbyeV/f1Ff3Ew7TeoXFxKtSZhQ2I
         6oE/NNb4rLIakSAwxrWFIQqPYxrRfPD8Bbt/BAC1edUZYHkqF+NUq28JjZTnrx48+o+K
         3B8wK8T6XeG4Q9LETE0AgX+WZL3xjWSioIoYpkhk2JLOXkgcxlDWy3RnfmIf4LLhtaXx
         n/hvTUEazVcVfk91GurJxHqbOZ+qJ3kUTqByx9CD9VdlUg3OTkNpevvF8bsXsojsn9mR
         l+Rw==
X-Gm-Message-State: AOAM5335wLunD6a+f0QVCQIvf9hiLtwXt1KzNy+dlYkfLabIzVbeVtnN
        +ZB329aOObwzuaqpetC8121D739nK5fJwg==
X-Google-Smtp-Source: ABdhPJwyUy4Jo/BTnCb0JhLqpg09FhUNjO+iaLnQ3tedt1ajBu0jM+jX51tHrNXxztoQNel26+h6+g==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr30961498wmc.126.1634926785835;
        Fri, 22 Oct 2021 11:19:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm8587242wms.5.2021.10.22.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:19:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] config.c: free(expanded) before die(), work around GCC oddity
Date:   Fri, 22 Oct 2021 20:19:38 +0200
Message-Id: <patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On my GCC version (10.2.1-6), but not the clang I have available t0017
will fail under SANITIZE=leak on optimization levels higher than -O0,
which is annoying when combined with the change in 956d2e4639b (tests:
add a test mode for SANITIZE=leak, run it in CI, 2021-09-23).

We really do have a memory leak here in either case, as e.g. running
the pre-image under valgrind(1) will reveal. It's documented
SANITIZE=leak (and "address", which exhibits the same behavior) might
interact with compiler optimization in this way in some cases. Since
this function is called recursively it's going to be especially
interesting as an optimization target.

Let's work around this issue by freeing the "expanded" memory before
we call die(), using a combination of the "goto cleanup" pattern
introduced in a preceding commit, and the newly introduced
die_message() function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index c5873f3a706..c36e85c2077 100644
--- a/config.c
+++ b/config.c
@@ -132,6 +132,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	int ret = 0;
 	struct strbuf buf = STRBUF_INIT;
 	char *expanded;
+	int exit_with = 0;
 
 	if (!path)
 		return config_error_nonbool("include.path");
@@ -161,17 +162,21 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	}
 
 	if (!access_or_die(path, R_OK, 0)) {
-		if (++inc->depth > MAX_INCLUDE_DEPTH)
-			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
-			    !cf ? "<unknown>" :
-			    cf->name ? cf->name :
-			    "the command line");
+		if (++inc->depth > MAX_INCLUDE_DEPTH) {
+			exit_with = die_message(_(include_depth_advice),
+						MAX_INCLUDE_DEPTH, path,
+						!cf ? "<unknown>" : cf->name ?
+						cf->name : "the command line");
+			goto cleanup;
+		}
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
 	}
 cleanup:
 	strbuf_release(&buf);
 	free(expanded);
+	if (exit_with)
+		exit(exit_with);
 	return ret;
 }
 
-- 
2.33.1.1494.g88b39a443e1

