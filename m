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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C59C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8462C60F55
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhG0ABd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhG0ABX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CC8C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b7so13104595wri.8
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qju1N6ujA/tOv7FCsDwQaEoFADjZPcei2gPCJuLcKNk=;
        b=e97imJnpb78YYqPbTz8U9swYT5XU5by+1y007228RB/R8zceYTr0NwEqIm5Dz09Fmk
         jOm6mFLFqR7i4rOPZv9efFQlJ8Y7iRfVJx1wY/6WjY6GBEdJUksJbYP4J14HtzfQWbiY
         s+zbh0RZNdlN7DevrR0GawnJKFmg0Lwx7T/jEcYujJZcRvsaD33hZx1XqGF1JMtmZwb3
         xA78f5TECPbXjwLqSDqC4B9TpiW7hmnA99TKXb5abBo+40lgy+wAppILZI+9gIVY0nep
         UL2WIKjK0HeW0OewQa0sLq9DJyLUMFuVJ1OrY/9NGDgWWbzz5dxxqKIN7e3urrOaChh+
         dOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qju1N6ujA/tOv7FCsDwQaEoFADjZPcei2gPCJuLcKNk=;
        b=FPsWFvcz+Y3uusFhqsfasPNQm4fD+/3Ej0HsWNy0XFD5NEJEVoOlPCX5y3Oj3yVi7o
         ap58fg9wYub6/rmoIRJrQQSzhVXXlmt/m0D9arIZmuqRV3lzoZvq5PG/3rKObrbf9zaD
         PbNMcwawzyXJ4yO77FAl8U4u2OQ32z+1WjjRf5sNMz/CiHRTvetoFBcqzNCnFu31NEOg
         4ZjfVyOTgNTajQAde7pjbHvg19R5tzVt0XVbnjtkpDKCv0a6cijkXS0HbDJ+ZLHMcOMA
         vknUw8U+cofcESLBZu6mg7mUhG6qni/Ienp9oS7jWNLBagbEN/bIWD1IWD3KjDKgF0ve
         /ORg==
X-Gm-Message-State: AOAM530DlZyyEN683U3thHP0IZv+yaC1uBB1Bahp7d8D2qkB0JkTsbO3
        ZXfW/HKkQeCKa6d3gDCEn5kZ01BVyQh+eg==
X-Google-Smtp-Source: ABdhPJxnQCpCwsAN4TikyjWYcwcY7aMRHm0ZWlPxulPyt/QBbDdlHbGKiaHvkKZTSYm7GvchvClDOQ==
X-Received: by 2002:a05:6000:52:: with SMTP id k18mr21111373wrx.270.1627346509305;
        Mon, 26 Jul 2021 17:41:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c16sm1254377wru.82.2021.07.26.17.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:41:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] bundle API: change "flags" to be "extra_index_pack_args"
Date:   Tue, 27 Jul 2021 02:41:40 +0200
Message-Id: <patch-2.4-088e4306d8-20210727T004015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g189fd9ae38
In-Reply-To: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
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
index 053a51bea1..10f6f45770 100644
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
index 15ce62285c..f2b28a2092 100644
--- a/bundle.c
+++ b/bundle.c
@@ -733,18 +733,23 @@ int create_bundle(struct repository *r, const char *path,
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
index 84a6df1b65..d47a7a3c69 100644
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
index 7f3d0d46b3..8781186cf1 100644
--- a/transport.c
+++ b/transport.c
@@ -163,12 +163,15 @@ static int fetch_refs_from_bundle(struct transport *transport,
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
2.32.0.988.g189fd9ae38

