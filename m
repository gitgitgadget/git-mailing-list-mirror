Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B83AC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE8C61008
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhHWLDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhHWLDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:03:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB84C061760
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f5so25603656wrm.13
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ISXoiK5WzcZ/eeZfVh17mCi0hGY8BpVQTieO3Zfoq9I=;
        b=f6AaVEIzlYzSvw10Uj3KSkh64PppWhFWpHC5+bw+wa0R4pC3KqSS3wVtxUG79jjeyV
         Q3hFqBy5XU9g3xGafjjCNndZQJzAQex26YfzLNRUD5HL+JwOhvH0tKQHjAcvkmybvxXc
         Ir1HAQ9HKlpk9Vygzszc6r84JlvDp69n7dhv9uHNaopy1agz/+NzHhoplxL8vfMpQxFf
         yAkPExRtYu4UmysyJzZGF0spvVbVYFY+/mKvt4Yke9rgvwuSKz5Z+vbAkHOdOvAzKe89
         /20IuOxAgxm6pG+Gkp6h6d5zg9rlRa8oMPwTlRc6/Fp3/IjXAXLdYZInjjz6VkXGx3mc
         Q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ISXoiK5WzcZ/eeZfVh17mCi0hGY8BpVQTieO3Zfoq9I=;
        b=V8EIZSAyEePDoKCQAoKTIP7Ejmqj/k72CfD4NJC5LVxEYZbHshzi63Z/KjIcNgXWDX
         ubWoHx3FHBSu0plZGPSnOf3iIWidJa54orRpvjFxg4SLdCBsCzfAuauwfpkEyfPsra4+
         0DcYDE/zGStEn/4MqlnLIc3sDEZbicPzksBXyN8P738UEcbkUIKX0FoEsrDNeqXYjpOD
         2LaLhSqmVpsEOxvLGWX/j/r9LhIqtPou2UrVpXs6N33qmbTGdtWIRQqL6wmvYHGXASKj
         p23uvswj7foYktjCt1MTJrl81psialLuhlpAdnuN5xpvrcs2WncT0AIcZf5d/akx90Dp
         fG0A==
X-Gm-Message-State: AOAM533my+D6PIzOOkrXWXeWtje3dYThdOat9R11rDgVcWXhwvQ5qI2G
        HK0pt0p21WwQsYMd6kyknQOL1mUZMo7DbzmD
X-Google-Smtp-Source: ABdhPJwpjFO+aZ2eLJXonoM2HCzOPPEk+3ysSpPJNoUwYsIcf8ENK0ERgRQnAO5bzK/QMGEqK1n5uQ==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr13051933wrn.300.1629716586576;
        Mon, 23 Aug 2021 04:03:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19sm13255493wmi.4.2021.08.23.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:03:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] bundle API: change "flags" to be "extra_index_pack_args"
Date:   Mon, 23 Aug 2021 13:02:57 +0200
Message-Id: <patch-v2-2.4-3d7bd9c33be-20210823T110136Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "flags" parameter was added in be042aff24c (Teach progress
eye-candy to fetch_refs_from_bundle(), 2011-09-18) there's never been
more than the one flag: BUNDLE_VERBOSE.

Let's have the only caller who cares about that pass "-v" itself
instead through new "extra_index_pack_args" parameter. The flexibility
of being able to pass arbitrary arguments to "unbundle" will be used
in a subsequent commit.

We could pass NULL explicitly in cmd_bundle_unbundle(), but let's
instead initialize an empty strvec and pass it, in anticipation of a
subsequent commit wanting to add arguments to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c |  5 +++--
 bundle.c         | 17 +++++++++++------
 bundle.h         |  8 ++++++--
 transport.c      |  5 ++++-
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 053a51bea1b..10f6f45770a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -165,7 +165,8 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_END()
 	};
-	char *bundle_file;
+	char* bundle_file;
+	struct strvec extra_args = STRVEC_INIT;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_unbundle_usage, options, &bundle_file);
@@ -177,7 +178,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
-	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
+	ret = !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:
diff --git a/bundle.c b/bundle.c
index ab63f402261..16d7e7f86f8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -569,18 +569,23 @@ int create_bundle(struct repository *r, const char *path,
 }
 
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, int flags)
+	     int bundle_fd, struct strvec *extra_index_pack_args)
 {
-	const char *argv_index_pack[] = {"index-pack",
-					 "--fix-thin", "--stdin", NULL, NULL};
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int i;
 
-	if (flags & BUNDLE_VERBOSE)
-		argv_index_pack[3] = "-v";
+	strvec_push(&ip.args, "index-pack");
+	strvec_push(&ip.args, "--fix-thin");
+	strvec_push(&ip.args, "--stdin");
+	if (extra_index_pack_args) {
+		struct strvec *extra = extra_index_pack_args;
+		for (i = 0; i < extra->nr; i++)
+			strvec_push(&ip.args, extra->v[i]);
+		strvec_clear(extra_index_pack_args);
+	}
 
 	if (verify_bundle(r, header, 0))
 		return -1;
-	ip.argv = argv_index_pack;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
diff --git a/bundle.h b/bundle.h
index 84a6df1b65d..d47a7a3c69c 100644
--- a/bundle.h
+++ b/bundle.h
@@ -26,16 +26,20 @@ int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options,
 		  int version);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
-#define BUNDLE_VERBOSE 1
 
 /**
  * Unbundle after reading the header with read_bundle_header().
  *
  * We'll invoke "git index-pack --stdin --fix-thin" for you on the
  * provided `bundle_fd` from read_bundle_header().
+ *
+ * Provide extra_index_pack_args to pass any extra arguments
+ * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
+ * extra_index_pack_args (if any) will be strvec_clear()'d for you
+ * (like the run-command.h API itself does).
  */
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, int flags);
+	     int bundle_fd, struct strvec *extra_index_pack_args);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 17e9629710a..8bc4b5fcd3c 100644
--- a/transport.c
+++ b/transport.c
@@ -162,12 +162,15 @@ static int fetch_refs_from_bundle(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
+	struct strvec extra_index_pack_args = STRVEC_INIT;
 	int ret;
 
+	strvec_push(&extra_index_pack_args, "-v");
+
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle(transport, 0, NULL);
 	ret = unbundle(the_repository, &data->header, data->fd,
-			   transport->progress ? BUNDLE_VERBOSE : 0);
+		       &extra_index_pack_args);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
2.33.0.662.g438caf9576d

