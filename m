Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B544DC47425
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7772F21D43
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKVXuYxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgJADqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbgJADqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8EFC0613D3
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so1470751wmh.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XNltrLCGQ+ZX0AivDc2S4gRxxcleGtS86Y1VRlaQhdA=;
        b=BKVXuYxaBuWSz2XmEbapuhp5TxGm3MjU71hUFkyw2++ve5fVRuMgB4tpPKHTmIQy0D
         c4v9A6Y/Oz388TlLdWhKiUtrq0jV1PBofcUzGyx2ziqJYEgu69bq3r+tht393lIvZE+q
         euuIvHsHWlEx3nAtO5c6Hj7AIoJviQugogWN+sUVkKjkf9H8AJc8Td/ErHj1DKcdOa5g
         C6zQ1+CSYiZd48MNaXCD64bwOoqeerlxa2p/M1oy/fv2u6z0Gknifa7wGoLthxxxptLL
         N+bVPvku58JQrLsFNbteW1XVXCEqnCVOHv8r4UM+fK6S8yGtBqPoNNziBZso4+oZhfSV
         Jhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XNltrLCGQ+ZX0AivDc2S4gRxxcleGtS86Y1VRlaQhdA=;
        b=N/EBzPLtHRpwFLSYwLsneNPYcIxZZA9L7fhngfmd7rPseCWEojuD1HZ2z4Sma0Zhrt
         E3sXYWEORCiRT6JYSuPpJHw3MS7G3ZFNQYFS+1wdcgmS8zOh7cQOXjZ9LWkR7f2L3ech
         1tXOXel7nD7BBSj4xYs2vp1gJKRdiCFYs/qCS1QPRY59xjaD658ejBiNDya4iivTQTMb
         xSt1ZnhEmZtwcSiXNXY683NyyOO1Fwyecs2eRZOjPeCpK+2TfLOqzU0iFs/Z89L+CeFQ
         UbPdrAFdbTpL00IkfTPkCmKZ+llI7BecR/lXWmJjRFmaLzSTkj5zMRFG03Em9iHa8sY5
         9PHw==
X-Gm-Message-State: AOAM5339QapTHwHIygicHfczbQbxJZ/mIGBDo1mN5PVqTy8G+qhoyQHh
        XsUuwsnhVZ38BCEkPxQs6efqLpEI8TM=
X-Google-Smtp-Source: ABdhPJzTA+Xi9b8dOldgoEgRI0OdeWlruKPncbVxd1QMBQk4qO7qbA5R0Po/zyg5XLPDUBVnLdeLig==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr495990wmh.184.1601523983453;
        Wed, 30 Sep 2020 20:46:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm6086065wme.12.2020.09.30.20.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:23 -0700 (PDT)
Message-Id: <c3fba50092f1619b6e9f66614bcdba8d5730f4b2.1601523977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:15 +0000
Subject: [PATCH v3 6/7] clone: read new remote name from remote_name instead
 of option_origin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

In a future patch, the name of the remote created by `git clone` may
come from multiple sources.  To avoid confusion, convert most uses of
option_origin to remote_name, leaving option_origin to exclusively
represent the -o/--origin option.

Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Sean Barag <sean@barag.org>
---
 builtin/clone.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bd67ff7b01..6bcdfa4cd6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,6 +53,7 @@ static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
+static char *remote_name = "origin";
 static char *option_branch = NULL;
 static struct string_list option_not = STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
@@ -721,7 +722,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		if (!option_bare) {
 			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
-			install_branch_config(0, head, option_origin, our->name);
+			install_branch_config(0, head, remote_name, our->name);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(the_repository,
@@ -919,12 +920,12 @@ static void write_refspec_config(const char *src_ref_prefix,
 		}
 		/* Configure the remote */
 		if (value.len) {
-			strbuf_addf(&key, "remote.%s.fetch", option_origin);
+			strbuf_addf(&key, "remote.%s.fetch", remote_name);
 			git_config_set_multivar(key.buf, value.buf, "^$", 0);
 			strbuf_reset(&key);
 
 			if (option_mirror) {
-				strbuf_addf(&key, "remote.%s.mirror", option_origin);
+				strbuf_addf(&key, "remote.%s.mirror", remote_name);
 				git_config_set(key.buf, "true");
 				strbuf_reset(&key);
 			}
@@ -1008,11 +1009,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (!option_origin)
-		option_origin = "origin";
+	if (option_origin)
+		remote_name = option_origin;
 
-	if (!valid_remote_name(option_origin))
-		die(_("'%s' is not a valid remote name"), option_origin);
+	if (!valid_remote_name(remote_name))
+		die(_("'%s' is not a valid remote name"), remote_name);
 
 	repo_name = argv[0];
 
@@ -1163,15 +1164,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		git_config_set("core.bare", "true");
 	} else {
-		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
+		strbuf_addf(&branch_top, "refs/remotes/%s/", remote_name);
 	}
 
-	strbuf_addf(&key, "remote.%s.url", option_origin);
+	strbuf_addf(&key, "remote.%s.url", remote_name);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
 	if (option_no_tags) {
-		strbuf_addf(&key, "remote.%s.tagOpt", option_origin);
+		strbuf_addf(&key, "remote.%s.tagOpt", remote_name);
 		git_config_set(key.buf, "--no-tags");
 		strbuf_reset(&key);
 	}
@@ -1182,7 +1183,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_sparse_checkout && git_sparse_checkout_init(dir))
 		return 1;
 
-	remote = remote_get(option_origin);
+	remote = remote_get(remote_name);
 
 	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
 			branch_top.buf);
@@ -1294,7 +1295,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 			if (!our_head_points_at)
 				die(_("Remote branch %s not found in upstream %s"),
-				    option_branch, option_origin);
+				    option_branch, remote_name);
 		}
 		else
 			our_head_points_at = remote_head_points_at;
@@ -1302,7 +1303,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else {
 		if (option_branch)
 			die(_("Remote branch %s not found in upstream %s"),
-					option_branch, option_origin);
+					option_branch, remote_name);
 
 		warning(_("You appear to have cloned an empty repository."));
 		mapped_refs = NULL;
@@ -1314,7 +1315,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			const char *branch = git_default_branch_name();
 			char *ref = xstrfmt("refs/heads/%s", branch);
 
-			install_branch_config(0, branch, option_origin, ref);
+			install_branch_config(0, branch, remote_name, ref);
 			free(ref);
 		}
 	}
@@ -1323,7 +1324,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
-		partial_clone_register(option_origin, &filter_options);
+		partial_clone_register(remote_name, &filter_options);
 
 	if (is_local)
 		clone_local(path, git_dir);
-- 
gitgitgadget

