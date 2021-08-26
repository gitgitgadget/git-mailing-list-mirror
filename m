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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D595C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580046054E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbhHZOGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242841AbhHZOGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 10:06:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714BC0613D9
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u9so5258821wrg.8
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ps8HRtoNAscl+odIZ94LR++flJGNyECZhOpaNUkHcaM=;
        b=Fo4Lf//QEP51jZ5oAn2WmJ9re5TjGc/ImCzX1X943OEXU78163DGhFvBVXzPgYwhOK
         9TODOCZFqKMCoZx5uhoaQmIjdkGrc38M0CdK+LFmW27rFohvAThZDlzUtIPCCXmCkPuD
         gRsIiah8l2X8LQOEF0RVYbImt9Xtluubm/l7v12Vbt/QRlE3gxB60mFRq7tu8qsvVr9M
         kA6A1w3jjB26+djUU8jRleCSgJOJGLSdvvW+29qYL+a99USYDjH9WHtIi9xAGiml/Atr
         mGB+m0DHb5+3yaPxh4UFEjcUBJHK2MuROUznY/aCg6LZnjEn5FGvriKCA4288mPq8o/K
         FV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ps8HRtoNAscl+odIZ94LR++flJGNyECZhOpaNUkHcaM=;
        b=HDQ8L+pqc4yj+p4Qnwl3rhXzKm8tPNJUz1TCkAMW/g0Q0OwrvWDCSlKRGNmOou4Gts
         fXELyqmxc98z2jyrF6A6tGBFJeIGu6w+ZFARbxg3c3nAVWqCZ3V+++wWlDaTWgTDyKxs
         fH7CPflQF9DoUK3BjJa5+R8bxtUA6p5306rJ1AmHI1NKbS4py1YJKSWZkjpD7Fvzr/3C
         vq6VJ2gMfnTP6krJ3DZSZJXRk50peBl0F/dCcF707BHuBA8n0pfleG9JUB4TfJEvCpyY
         nW0vWGaNK9jKaCwbbxOjdTz3TdtfySE7N7keKX5P2LqJAgxvmJQL0NDWFjIKS0QOjfxY
         CLeg==
X-Gm-Message-State: AOAM530spuOCkvpCUcl1VB46TyR1u1vQsAzuVeUgAcuX71C9EHM04caP
        fc7TMr70+kU2YMMnW560qEvETgovY+PcfA==
X-Google-Smtp-Source: ABdhPJzcZg62Fmk+iYOLHo0A4A7Gul1RXgvqa6uCzhXBjo/GHUVCn3f1HzvqkLyx66D70LeI6Er69g==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr4181722wrw.357.1629986757618;
        Thu, 26 Aug 2021 07:05:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm2471987wms.33.2021.08.26.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:05:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] bundle API: change "flags" to be "extra_index_pack_args"
Date:   Thu, 26 Aug 2021 16:05:49 +0200
Message-Id: <patch-v3-3.5-637039634e7-20210826T140414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
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
 builtin/bundle.c |  2 +-
 bundle.c         | 14 ++++++++------
 bundle.h         |  8 ++++++--
 transport.c      |  6 +++++-
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 053a51bea1b..f9360c32c6c 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -177,7 +177,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
-	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
+	ret = !!unbundle(the_repository, &header, bundle_fd, NULL) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:
diff --git a/bundle.c b/bundle.c
index ab63f402261..10d20bb0c48 100644
--- a/bundle.c
+++ b/bundle.c
@@ -569,18 +569,20 @@ int create_bundle(struct repository *r, const char *path,
 }
 
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, int flags)
+	     int bundle_fd, struct strvec *extra_index_pack_args)
 {
-	const char *argv_index_pack[] = {"index-pack",
-					 "--fix-thin", "--stdin", NULL, NULL};
 	struct child_process ip = CHILD_PROCESS_INIT;
 
-	if (flags & BUNDLE_VERBOSE)
-		argv_index_pack[3] = "-v";
+	strvec_push(&ip.args, "index-pack");
+	strvec_push(&ip.args, "--fix-thin");
+	strvec_push(&ip.args, "--stdin");
+	if (extra_index_pack_args) {
+		strvec_pushvec(&ip.args, extra_index_pack_args);
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
index 17e9629710a..99b2498e5dd 100644
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
+		       transport->progress ? &extra_index_pack_args : NULL);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
2.33.0.733.ga72a4f1c2e1

