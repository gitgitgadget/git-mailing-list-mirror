Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8511FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdFPT2z (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 15:28:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36577 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdFPT2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so7465520wrb.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JbHNlHGRVS3oi5SNoyKjIhXFc6bmxio4uNGjIfUe1g=;
        b=GvPR0t7n8c7PkdLRZqkguOIfLlBN4PpX9FEWqOAlLLaZMzAGPb/L2dNCdzvke7IB9l
         ONoAXlAL8GmC8JEWA+PbU1D4p1Xcv3IHOhLfuVnMbgC06Nw0kNYzKC3oi3Bzw/caP/gT
         aj0JUf0L1HBGON/qsWhr1s15s+he0VRVi1cydXmAnvqKWxxr2MrtdDCYG8DAwBbMxOtN
         hARgn9pG7Zq/LswJXKRLlyd24LFCkUwUYfwD1AEob/N0RcoAyzu6Sl7GmPL8O1vu7Xft
         HlUIg6ws2hvNUhL2DBNH4n+hUN/1O27HbPAwzUisw3yqJJTZTqKwNSyg1e98B0hK2y1N
         2kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JbHNlHGRVS3oi5SNoyKjIhXFc6bmxio4uNGjIfUe1g=;
        b=nkg38fB25/yzqfqwGwhOQRZKqBWdLDSybmoG+GXadn72MAxoywHpw9OA4leTNTd2C8
         0gkD7w5QQ5F92r7brkXJcjd62a9RxORIiQA3PqepCmGlefGqNnJDLLNAn6pPGGUAvDpN
         s9ehRVlUgBhx17D+7DwL+yx7pi1hcAOVm3Uu8nLwZ7l5dbkzpMtsv43obhzF6osV15sh
         hXL8vBbxkWujYx2BSPtyEGyiD/UypDWwi+aH8FkfFSx5Ctec/Ycdjd8UE+pY3jiKBy5Q
         x42vtaoZhqccfEJerh0vHm2ldfiqk/RgcH7YSHwKS4SOOCea2Iuqgc2QoQQOcLAiCAdJ
         gIig==
X-Gm-Message-State: AKS2vOw3rywagpqVQeHoQo8Gp2Or8YV7fiUknMnfmfLxB3vE8F+eDPrc
        CGFzoRFKIjnlFucD
X-Received: by 10.223.171.226 with SMTP id s89mr6258519wrc.38.1497641332295;
        Fri, 16 Jun 2017 12:28:52 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id c71sm2658026wmh.21.2017.06.16.12.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 12:28:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] remote.c: don't pass copies of refspecs to add_{fetch,push}_refspec()
Date:   Fri, 16 Jun 2017 21:28:34 +0200
Message-Id: <20170616192837.11035-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.501.g45ae33cbf
In-Reply-To: <20170616192837.11035-1-szeder.dev@gmail.com>
References: <20170616192837.11035-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently neither add_fetch_refspec() nor add_push_refspec() duplicate
the refspecs before appending them to an array of refspecs, therefore
all their callers pass them copies of refspecs.  Soon we won't store
refspecs as strings, therefore passing duplicated strings to these
functions will not be necessary.

Perform the copying inside these functions and modify their callers to
either not pass duplicates or free() them to avoid leaks.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c |  3 +--
 remote.c        | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 869e093ff..5b72d853f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1054,8 +1054,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	remote = remote_get(option_origin);
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
 		    branch_top.buf);
-	add_and_parse_fetch_refspec(remote,
-				    strbuf_detach(&default_refspec, NULL));
+	add_and_parse_fetch_refspec(remote, default_refspec.buf);
 
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
diff --git a/remote.c b/remote.c
index a021decee..d23518afd 100644
--- a/remote.c
+++ b/remote.c
@@ -91,7 +91,7 @@ static void add_push_refspec(struct remote *remote, const char *ref)
 	ALLOC_GROW(remote->push_refspec,
 		   remote->push_refspec_nr + 1,
 		   remote->push_refspec_alloc);
-	remote->push_refspec[remote->push_refspec_nr++] = ref;
+	remote->push_refspec[remote->push_refspec_nr++] = strdup(ref);
 }
 
 static void add_fetch_refspec(struct remote *remote, const char *ref)
@@ -99,7 +99,7 @@ static void add_fetch_refspec(struct remote *remote, const char *ref)
 	ALLOC_GROW(remote->fetch_refspec,
 		   remote->fetch_refspec_nr + 1,
 		   remote->fetch_refspec_alloc);
-	remote->fetch_refspec[remote->fetch_refspec_nr++] = ref;
+	remote->fetch_refspec[remote->fetch_refspec_nr++] = strdup(ref);
 }
 
 static void add_url(struct remote *remote, const char *url)
@@ -265,9 +265,9 @@ static void read_remotes_file(struct remote *remote)
 		if (skip_prefix(buf.buf, "URL:", &v))
 			add_url_alias(remote, xstrdup(skip_spaces(v)));
 		else if (skip_prefix(buf.buf, "Push:", &v))
-			add_push_refspec(remote, xstrdup(skip_spaces(v)));
+			add_push_refspec(remote, skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Pull:", &v))
-			add_fetch_refspec(remote, xstrdup(skip_spaces(v)));
+			add_fetch_refspec(remote, skip_spaces(v));
 	}
 	strbuf_release(&buf);
 	fclose(f);
@@ -306,15 +306,20 @@ static void read_branches_file(struct remote *remote)
 		frag = "master";
 
 	add_url_alias(remote, strbuf_detach(&buf, NULL));
-	add_fetch_refspec(remote, xstrfmt("refs/heads/%s:refs/heads/%s",
-					  frag, remote->name));
+
+	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s", frag, remote->name);
+	add_fetch_refspec(remote, buf.buf);
+	strbuf_reset(&buf);
 
 	/*
 	 * Cogito compatible push: push current HEAD to remote #branch
 	 * (master if missing)
 	 */
-	add_push_refspec(remote, xstrfmt("HEAD:refs/heads/%s", frag));
+	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
+	add_push_refspec(remote, buf.buf);
 	remote->fetch_tags = 1; /* always auto-follow */
+
+	strbuf_release(&buf);
 }
 
 static int handle_config(const char *key, const char *value, void *cb)
@@ -398,11 +403,13 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_push_refspec(remote, v);
+		free((char*)v);
 	} else if (!strcmp(subkey, "fetch")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_fetch_refspec(remote, v);
+		free((char*)v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
-- 
2.13.1.505.g7cc9fcafb

