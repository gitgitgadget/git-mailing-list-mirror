Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE93C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1CB60F6D
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhIEHf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhIEHfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:35:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5901C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:34:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b10so4919647wru.0
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TId0iXXuU5qfYjHWgloKVpq71kf1fx4mIYLE44B5AYE=;
        b=BVDMHYtcADvyUEVL4sT/EeCpp+Wfzr6gsLJStB+P1h6rk92yyRqMlFc0NhkURUVsPK
         tBEldHFCd87MBuyo1eXF33QmERp++YitGz/4I7csDFLOIjKNaaqFA6WC7NC2Jy+htIQz
         C1IC2EafQb6iuWhm3q4cWUmjDFFoRA+98d1D9X2bt9HmybvL+SOpNzfYgQbVDuKrn0k3
         iTIQeOLI5J2CpwdJ6a7kzZ9MeAwKCKq64fEbIR3p0q31n2aWHDehI3JxwvJeopgXUP9R
         aM1MDrNdky8dv89sZMNDfDt1KTCikCiacyuPXBrZBu34jnrsXavlsSAihJicPAEQKNXt
         3wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TId0iXXuU5qfYjHWgloKVpq71kf1fx4mIYLE44B5AYE=;
        b=lGcfnlaKR4J9teg5Np/GJXAU7FdMRUZLi72sdvPd7wr93GU5UC6dW0Xdzgp6+uuH+n
         AFoNdfna01ql1s0SKD+ZWyo++8KZtxWzdRrd9O6lL1ocLJnWGssqRF+hz1WdmHQc45Of
         M5E9o7r16IJ3ZYpbeYXzVsRi5l4wAips3lveMdpCWfZ8qSmDmEwv0inGNX5mByf2v/2u
         sbdeWA7SxX/BK2Et/YRITt8setNRPXrcnoLA+r3kIshiaw/vWRw7LDLggL3J2zldaRXm
         E/eEEH8plpUl/DAvwnIdzEU59EhFJmuhBqKPnVDT/7hFZ85ReTKYXm6OsVADqVfvXPHH
         Ivfg==
X-Gm-Message-State: AOAM530zVSp/af1m0Zr44IwfnFSPYTgJSOE+1oc7UkPNyNBQW9Ag/oSf
        ll83MqRFofY/riFzKenT+yWYHt33Nk8UzA==
X-Google-Smtp-Source: ABdhPJxJq/ZiPOpowAo4Tp9L3nr7I7dpWNhMQ0kf1Z5gWbFsxNsAZOleXlmD0GmEtD5ZeRXDp4h2aQ==
X-Received: by 2002:a5d:620d:: with SMTP id y13mr7159789wru.45.1630827291105;
        Sun, 05 Sep 2021 00:34:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm4218734wrc.31.2021.09.05.00.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:34:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/4] bundle API: change "flags" to be "extra_index_pack_args"
Date:   Sun,  5 Sep 2021 09:34:43 +0200
Message-Id: <patch-v4-2.4-9255c766484-20210905T072750Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.813.g41c39388776
In-Reply-To: <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c |  4 +++-
 bundle.c         | 12 ++++++------
 bundle.h         |  7 +++++--
 transport.c      |  6 +++++-
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 053a51bea1b..9b86c8529c7 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -166,6 +166,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	char *bundle_file;
+	struct strvec extra_index_pack_args = STRVEC_INIT;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_unbundle_usage, options, &bundle_file);
@@ -177,7 +178,8 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
-	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
+	ret = !!unbundle(the_repository, &header, bundle_fd,
+			 &extra_index_pack_args) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:
diff --git a/bundle.c b/bundle.c
index ab63f402261..a0bb687b0f4 100644
--- a/bundle.c
+++ b/bundle.c
@@ -569,18 +569,18 @@ int create_bundle(struct repository *r, const char *path,
 }
 
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, int flags)
+	     int bundle_fd, struct strvec *extra_index_pack_args)
 {
-	const char *argv_index_pack[] = {"index-pack",
-					 "--fix-thin", "--stdin", NULL, NULL};
 	struct child_process ip = CHILD_PROCESS_INIT;
+	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
-	if (flags & BUNDLE_VERBOSE)
-		argv_index_pack[3] = "-v";
+	if (extra_index_pack_args) {
+		strvec_pushv(&ip.args, extra_index_pack_args->v);
+		strvec_clear(extra_index_pack_args);
+	}
 
 	if (verify_bundle(r, header, 0))
 		return -1;
-	ip.argv = argv_index_pack;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
diff --git a/bundle.h b/bundle.h
index 84a6df1b65d..06009fe6b1f 100644
--- a/bundle.h
+++ b/bundle.h
@@ -26,16 +26,19 @@ int create_bundle(struct repository *r, const char *path,
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
+ * Provide "extra_index_pack_args" to pass any extra arguments
+ * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
+ * "extra_index_pack_args" (if any) will be strvec_clear()'d for you.
  */
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, int flags);
+	     int bundle_fd, struct strvec *extra_index_pack_args);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 17e9629710a..ab9b03ae9ff 100644
--- a/transport.c
+++ b/transport.c
@@ -162,12 +162,16 @@ static int fetch_refs_from_bundle(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
+	struct strvec extra_index_pack_args = STRVEC_INIT;
 	int ret;
 
+	if (transport->progress)
+		strvec_push(&extra_index_pack_args, "-v");
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
2.33.0.813.g41c39388776

