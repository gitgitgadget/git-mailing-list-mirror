Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5FAC4727F
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AF620BED
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWfFKHRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgI2DhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbgI2DhD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:37:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00893C0613D3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so3674181wrt.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mzDa/dPyZvcONscHHtJ1SdY8o9RJAneA4hRG9HZS0ss=;
        b=cWfFKHRrmeN+r261cuD12hvqYFRZrFe/FtyHM4SudgfqGBZdunalIe+3Hv7js712wC
         azBiQAfhwgd/fkfQU1ZCyIzm7uMa8BXfA+bnxuLXHmLzDks/nazqccGkXW2YOl7b2ARj
         LamnjEZcls8Qm/H6NfpWgAcjlWlCtxeavJSPc44NqXbPGpsabb6kp88tvYaemJMraUhf
         Xs7p/R6doIS3JnQQbRMqh6qpJqoDjUZB/2Semd9wRXBJTMwZFIvaQqG9wFPzxtNh8nAs
         u9plLKfvli07AZg+v/bwMbEpS6E/tEuOCnrg83m9et/w11Zy3GxlWhhTMCX4/k+zXPN+
         ofzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mzDa/dPyZvcONscHHtJ1SdY8o9RJAneA4hRG9HZS0ss=;
        b=P1X50S6VJRtpC5YasKpNofGJjlTHomsoTSRFwA0UX9JU/wMMeszOwcWkS9GZOSgdV7
         4PPeYAP+rb2BoDIPWFro6m1Jvdz9OoockRD+zI/KUvQURxEBk+02jEnY4dZhxTlcXsx4
         ZxWOp/hU1Ttg88pgaCJ7bFUxAgj/VS+/7WqH6at3ozt6cMVTxsk58schE7RhMLLxb7Lh
         ob4S8KZrU3g5avazRxO44eoJSJFGjlrTXNvaVjnyXti1PBWpDQIxqcmbE3g3sz/RpN0Z
         dre5Ci3/cQpg2556ec0TqIU4etYAt/9IiW7sCZ0DI5ufj1MgjjGkLdmmuMygJMl1nlz5
         Wo/g==
X-Gm-Message-State: AOAM5306970Hm+r3Vcv8GIOaZtjRidDyvk7K1oCBpEtQ8sWrIdqQloY+
        8aBXp+6ENuoxNn8m784tbTSKuYbvRvM=
X-Google-Smtp-Source: ABdhPJwUwsX1kK93AuJL7pso8mMtASBcoDPsavmNX5WOm1WeDpmlg5l6pBB5O+YUJXoyGqRieGbGyw==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr1542812wrt.267.1601350621474;
        Mon, 28 Sep 2020 20:37:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i33sm4249233wri.79.2020.09.28.20.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:37:01 -0700 (PDT)
Message-Id: <99f4d765b475ca7d73dec2dd1367fe2cb0f358d8.1601350615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:54 +0000
Subject: [PATCH v2 6/7] clone: read new remote name from remote_name instead
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
 builtin/clone.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 673f7b68c3..7fdd00cd95 100644
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
@@ -1008,8 +1009,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (!option_origin)
-		option_origin = "origin";
+	if (option_origin)
+		remote_name = option_origin;
 
 	if (!valid_remote_name(remote_name))
 		die(_("'%s' is not a valid remote name"), remote_name);
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

