Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A5BC6377E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4C360FDA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhGUW76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhGUW7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C090C061798
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 14-20020a05600c028eb0290228f19cb433so500078wmk.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjCaLSGbAjqhHi6teFpMeBlb6dBdZbPdb7mwWDfoaPU=;
        b=mQe1RRtJq1IdQ0NSepenoqoCUckhPtcam4+JrxM3rdq8+oVJcES+TkY/uECXSE5Gza
         LE3O2dYnsrXFoT+4iDPeVNK6ok64qKzGh4IBwS7b7ITd9oyUoWpab4sk3Xd1EMcwtGVr
         UvfakpOYs56/MYBySlmZDCjPx8JEGVKFXtHI8kS7S4YU+PRldlYboox7qmpWzNUq6Pwk
         1sPlFWeunreuerVVAUyj+JVfgZgM1MKu2ZFrQt4PgvcQeKyFfEZoV019tuALn+tyXImx
         UyVLr6TsGg4xueaShELn4/ZTK/0/Tz72mJYL5MOCCWjE14xbtHBy2ss5aneCH3zuYBtx
         f6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjCaLSGbAjqhHi6teFpMeBlb6dBdZbPdb7mwWDfoaPU=;
        b=aldfSmf3FMyp5MMxWxSbL6bTB2RDiaId6Tf5iXcnYV0jUrQW6w084i9+4tRsAROzRe
         bdrIFoYdy5nCv9tSRfVmpnmY8R+KD95icW/I8kwZMrRio0P0+KBZRS1QVwJ+9K6jc6xJ
         Kum61fTb+cNmgKXE0m9rbnWJ8DQpR+3flZNUSQxOZ7RhM1N4uSopumTttULbyXxZVNFe
         fGLfAI0kt2nqCgxpziSs/WmbIjpcNjXay8B5MKSkDuF9gexgYnpAyKEUV2MPGAQUp8+c
         mVPVGljvj4YTErnocHQmRTj6FBBWcv00vK31PpTW2kVmofHT4L29yn+cDWuFmPqS+Sji
         Hiyg==
X-Gm-Message-State: AOAM531tj8C1yOGET1HubhwGPyxjuNonrU+iwHmn3jdkr6vp1S+aWbbm
        QHMv4T79I0SosYJbGLK6KXZe6ijRHN6vFg==
X-Google-Smtp-Source: ABdhPJyxARqZ2vO1iXi/lH0YU5MMGk3HQrncySzi89NV5b94ndifh81LBZ3Ow+D6Eyur2w90tRNGcg==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr6326223wmk.102.1626910825696;
        Wed, 21 Jul 2021 16:40:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/12] upload-pack: document and rename --advertise-refs
Date:   Thu, 22 Jul 2021 01:40:11 +0200
Message-Id: <patch-10.12-c6870b5f18a-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --advertise-refs documentation in git-upload-pack added in
9812f2136b3 (upload-pack.c: use parse-options API, 2016-05-31) hasn't
been entirely true ever since v2 support was implemented in
e52449b6722 (connect: request remote refs using v2, 2018-03-15). Under
v2 we don't advertise the refs at all, but rather dump the
capabilities header.

This option has always been an obscure internal implementation detail,
it wasn't even documented for git-receive-pack. Since it has exactly
one user let's rename it to --http-backend-info-refs, which is more
accurate and points the reader in the right direction. Let's also
cross-link this from the protocol v1 and v2 documentation.

I'm retaining a hidden --advertise-refs alias in case there's any
external users of this, and making both options hidden to the bash
completion (as with most other internal-only options).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-receive-pack.txt        |  5 +++++
 Documentation/git-upload-pack.txt         | 12 ++++++++----
 Documentation/technical/http-protocol.txt |  3 +++
 Documentation/technical/protocol-v2.txt   |  3 +++
 builtin/receive-pack.c                    |  3 ++-
 builtin/upload-pack.c                     |  5 +++--
 http-backend.c                            |  2 +-
 t/t5555-http-smart-common.sh              | 14 ++++++++++++++
 8 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 25702ed7307..014a78409b9 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -41,6 +41,11 @@ OPTIONS
 <directory>::
 	The repository to sync into.
 
+--http-backend-info-refs::
+	Used by linkgit:git-http-backend[1] to serve up
+	`$GIT_URL/info/refs?service=git-receive-pack` requests. See
+	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
+
 PRE-RECEIVE HOOK
 ----------------
 Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 9822c1eb1ad..739416ec83d 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -36,10 +36,14 @@ OPTIONS
 	This fits with the HTTP POST request processing model where
 	a program may read the request, write a response, and must exit.
 
---advertise-refs::
-	Only the initial ref advertisement is output, and the program exits
-	immediately. This fits with the HTTP GET request model, where
-	no request content is received but a response must be produced.
+--http-backend-info-refs::
+	Used by linkgit:git-http-backend[1] to serve up
+	`$GIT_URL/info/refs?service=git-upload-pack` requests. See
+	"Smart Clients" in link:technical/http-protocol.html[the HTTP
+	transfer protocols] documentation and "HTTP Transport" in
+	link:technical/protocol-v2.html[the Git Wire Protocol, Version
+	2] documentation. Also understood by
+	linkgit:git-receive-pack[1].
 
 <directory>::
 	The repository to sync from.
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 96d89ea9b22..cc5126cfeda 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -225,6 +225,9 @@ The client may send Extra Parameters (see
 Documentation/technical/pack-protocol.txt) as a colon-separated string
 in the Git-Protocol HTTP header.
 
+Uses the `--http-backend-info-refs` option to
+linkgit:git-upload-pack[1].
+
 Dumb Server Response
 ^^^^^^^^^^^^^^^^^^^^
 Dumb servers MUST respond with the dumb server reply format.
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 1040d853198..213538f1d0e 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -81,6 +81,9 @@ A v2 server would reply:
 Subsequent requests are then made directly to the service
 `$GIT_URL/git-upload-pack`. (This works the same for git-receive-pack).
 
+Uses the `--http-backend-info-refs` option to
+linkgit:git-upload-pack[1].
+
 Capability Advertisement
 ------------------------
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a34742513ac..b12820dbd6c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2478,7 +2478,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
 		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
-		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
+		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs, NULL),
+		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
 		OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL),
 		OPT_END()
 	};
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 8506030a648..125af53885f 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -22,8 +22,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
 			 N_("quit after a single request/response exchange")),
-		OPT_BOOL(0, "advertise-refs", &advertise_refs,
-			 N_("exit immediately after initial ref advertisement")),
+		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs,
+				N_("serve up the info/refs for git-http-backend")),
+		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
 		OPT_BOOL(0, "strict", &strict,
 			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
 		OPT_INTEGER(0, "timeout", &timeout,
diff --git a/http-backend.c b/http-backend.c
index d37463cec8b..838374edb91 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -534,7 +534,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 
 	if (service_name) {
 		const char *argv[] = {NULL /* service name */,
-			"--advertise-refs",
+			"--http-backend-info-refs",
 			".", NULL};
 		struct rpc_service *svc = select_service(hdr, service_name);
 
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index 389ee96987b..8d9d6a556f0 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -6,6 +6,20 @@ test_expect_success 'setup' '
 	test_commit --no-tag initial
 '
 
+test_expect_success 'git upload-pack --http-backend-info-refs and --advertise-refs are aliased' '
+	git upload-pack --http-backend-info-refs . >expected 2>err.expected &&
+	git upload-pack --advertise-refs . >actual 2>err.actual &&
+	test_cmp err.expected err.actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git receive-pack --http-backend-info-refs and --advertise-refs are aliased' '
+	git receive-pack --http-backend-info-refs . >expected 2>err.expected &&
+	git receive-pack --advertise-refs . >actual 2>err.actual &&
+	test_cmp err.expected err.actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'git upload-pack --advertise-refs' '
 	cat >expect <<-EOF &&
 	$(git rev-parse HEAD) HEAD
-- 
2.32.0.955.ge7c5360f7e7

