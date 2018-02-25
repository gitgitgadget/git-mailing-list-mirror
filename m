Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C971F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeBYLTN (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:19:13 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40121 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeBYLTM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:19:12 -0500
Received: by mail-pl0-f68.google.com with SMTP id i6so7627423plt.7
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lnNpC8MvhaUt81EA0tBJ33hlInTHlFfNLtEuLifSDw=;
        b=jhhIFmqfWw7N9pDzL5Ltf6ASAAbyYdJ8ghfRGJpQXoD6JHm/7Wf18a6QALiFt32G60
         EX7b0IshOFDUrTSLPhpR4aN6ZGhyDBxbNn+FcoMMxrXTrBD/JDpf4lVu8j2Tzd8ZsK1T
         MCu++ofSZc3etUR2KS4ehyvwAA4/YcfxZageCSAcbaukbBLU3OPbTk0bQ45kScY1oNaJ
         c3Rf6evj+q0xGJTUuOKIwmk8oQf1j+CBSGE8CqWnvH3adCpbALESh+94RyZ27HbT40FA
         4CiKehETX9HXcqUCXOizNML4uIc522DwcV9UFLrPGIcfnNxy6xueCKHQfHaILsmd80M9
         DxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lnNpC8MvhaUt81EA0tBJ33hlInTHlFfNLtEuLifSDw=;
        b=W9cY1zczLBreqHulIzZw6mSynIcmUafqihQzZm4u7QJqHH0wGDrrrCsLLJAoPyCVZ/
         B810jtjTzvDWe9vMS0pxn+1H9+g7uI6V7z8BjJj02SGvYBEzK9FV3iCDgUQQfwPxOi2/
         rhWDXPIqW6PJ49A1LVPPVHpf8tKx26o2OStSBbi/5QxTc4LgpDSMKz8hTUDf4Cd158K6
         wDLC2VmrSP2p6b5uMKJCPSXZIZADQIyN8LxJGbPIG7vWRsYcJ4h5qUOGK80dIE6gq1ti
         ybt+YhbKcTul6RyF6UVJ09RgjG/hVyVkFetJjmjTulHVwOV80SW/U0fGjjpTrQTK/Uj8
         bAPA==
X-Gm-Message-State: APf1xPByW7S+cmnp0akn/7M2FiLLVBIBwa+ZyUpXwcJH3add8yBjLZsw
        dti4bNd10dY0MfFfd5zW16c=
X-Google-Smtp-Source: AH8x227l4qmp74pnQBaaevJWbtencun9JLaCLpUQvxMoU7zqfGsF+3TPJ7qK7UtAsTj6BcFvnp8Y0g==
X-Received: by 2002:a17:902:2904:: with SMTP id g4-v6mr7207539plb.170.1519557552054;
        Sun, 25 Feb 2018 03:19:12 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id m3sm11166924pgs.90.2018.02.25.03.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 03:19:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Feb 2018 18:19:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH v3 4/6] index-pack: check (and optionally set) hash algo based on input file
Date:   Sun, 25 Feb 2018 18:18:38 +0700
Message-Id: <20180225111840.16421-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180225111840.16421-1-pclouds@gmail.com>
References: <20180224033429.9656-1-pclouds@gmail.com>
 <20180225111840.16421-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After 454253f059 (builtin/index-pack: improve hash function abstraction
- 2018-02-01), index-pack uses the_hash_algo for hashing. If "git
index-pack" is executed without a repository, we do not know what hash
algorithm to be used and the_hash_algo in theory could be undefined.

Since there should be some information about the hash algorithm in the
input pack file, we can initialize the correct hash algorithm with that
if the_hash_algo is not yet initialized. This assumes that pack files
with new hash algorithm MUST step up pack version.

While at there, make sure the hash algorithm requested by the pack file
and configured by the repository (if we're running with a repo) are
consistent.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c | 29 ++++++++++++++++++++++++++++-
 repository.h         |  5 +++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7e3e1a461c..2c75f28b41 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -326,10 +326,34 @@ static const char *open_pack_file(const char *pack_name)
 		output_fd = -1;
 		nothread_data.pack_fd = input_fd;
 	}
-	the_hash_algo->init_fn(&input_ctx);
 	return pack_name;
 }
 
+static void prepare_hash_algo(uint32_t pack_version)
+{
+	int pack_algo_id;
+	const struct git_hash_algo *pack_algo;
+
+	switch (pack_version) {
+	case 2:
+	case 3:
+		pack_algo_id = GIT_HASH_SHA1;
+		break;
+	default:
+		die("BUG: how to determine hash algo for version %d?",
+		    pack_version);
+	}
+
+	if (!repo_has_valid_hash_algo(the_repository)) /* running without repo */
+		repo_set_hash_algo(the_repository, pack_algo_id);
+
+	pack_algo = &hash_algos[pack_algo_id];
+	if (the_hash_algo->format_id != pack_algo->format_id)
+		die(_("incompatible hash algorithm, "
+		      "configured for %s but the pack file needs %s"),
+		    the_hash_algo->name, pack_algo->name);
+}
+
 static void parse_pack_header(void)
 {
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
@@ -341,6 +365,9 @@ static void parse_pack_header(void)
 		die(_("pack version %"PRIu32" unsupported"),
 			ntohl(hdr->hdr_version));
 
+	prepare_hash_algo(ntohl(hdr->hdr_version));
+	the_hash_algo->init_fn(&input_ctx);
+
 	nr_objects = ntohl(hdr->hdr_entries);
 	use(sizeof(struct pack_header));
 }
diff --git a/repository.h b/repository.h
index 5092df3700..02c695bc74 100644
--- a/repository.h
+++ b/repository.h
@@ -113,4 +113,9 @@ static inline const struct git_hash_algo *repo_get_hash_algo(
 	return repo->hash_algo;
 }
 
+static inline int repo_has_valid_hash_algo(const struct repository *repo)
+{
+	return repo->hash_algo != NULL;
+}
+
 #endif /* REPOSITORY_H */
-- 
2.16.1.435.g8f24da2e1a

