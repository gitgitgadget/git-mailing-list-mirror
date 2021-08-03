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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AFAC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4FA60EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbhHCTkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbhHCTj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58637C06139E
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so114542wms.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XIgSkEUfrDm87A9P0WKS1uqytWn8OXDyB3PoFjrnvU=;
        b=H/Wb44wK6CGItFPLdtkAs1TrlYXSilb2dlHUqLfUfVkWtp2QsqsW56c76EohXAk7wZ
         Vp5ZhYYrKMUu8c+7p6xJ1Ei0JkXQI/XSbc3W1nRwTZb5c4LR8znV3TtFiCuTt0B1f/P5
         JdR30uap6KnLSVLd3ZJ3gsfOOLF+6YhFqEbxrTTt++osgCeq/SMjPdqOgdxttCv1SZHc
         uCiT6ONSOUkHZrjEdV+KZEn73o4/uzaWOkG3Jztylp9qQ3chew5TDpxaiZUMWbI2JMN6
         HAyCLTl5RlTVn/RRHTIxvDRD7MSEOkHWn4k5mn2/El61Oyt0ZP2KTfYRg8r75RDiVA6c
         5Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XIgSkEUfrDm87A9P0WKS1uqytWn8OXDyB3PoFjrnvU=;
        b=sPxyaUIqmhRmjRSN2dWdtVurWjTAMmfEj/GAbtkegIAGDAy4ll/hyqHiGU++RTgZ5I
         xnsdTP4+dxGRHQnNI4R9CX7DPBz+hiUGm5mFQTHS6lEkHgOfRl3YdT7qZQivKxAvnYgu
         mKbCutnDP3tGNux4UqH0rAUwolRlwd0HV+KAu7tlcD49DGWtUIsmWAf6T/AGdPfD12MN
         u1ybp/ArDT84Q1a1BRvgkcJKTUNu8Jp/vbi0aa+mhCTKaYdfvGeHPEHNNQU9IsumoVGO
         StxgRagmiphNwadenQ7txqaqzHEJ3ud55/jd/6PInOtOFpRJUn3CTg4eqit4xocfVTsA
         F4Ww==
X-Gm-Message-State: AOAM533TUDlZLdE7e+VVr3RON1DuyiYYlOAyJW8FkU07n4cI4HR+soyf
        jqT227fMYQI+mzxV8pIXJuhEuRGUwpK9ZA==
X-Google-Smtp-Source: ABdhPJwLJNwCqIO7nreWq1L3+yN0KUaZwk6+pDacESE2sZ9/M/4fN3GFUOsQl2k4QOEjGUJ7Nq0clw==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr5771692wmc.138.1628019576384;
        Tue, 03 Aug 2021 12:39:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 27/36] transport: convert pre-push hook to hook.h
Date:   Tue,  3 Aug 2021 21:38:53 +0200
Message-Id: <patch-v4-27.36-3f24e056410-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-push hook away from run-command.h to and over to the new
hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport.c | 56 ++++++++++++++---------------------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/transport.c b/transport.c
index 77e196f75f5..4ca8fc0391d 100644
--- a/transport.c
+++ b/transport.c
@@ -1203,63 +1203,35 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
-	int ret = 0, x;
+	int ret = 0;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf;
-	const char *argv[4];
-
-	if (!(argv[0] = find_hook("pre-push")))
-		return 0;
-
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
-	argv[3] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
-
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
+	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
 
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	strbuf_init(&buf, 256);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
 	for (r = remote_refs; r; r = r->next) {
+		struct strbuf buf = STRBUF_INIT;
+
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
 		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
+		strbuf_addf(&buf, "%s %s %s %s",
 			 r->peer_ref->name, oid_to_hex(&r->new_oid),
 			 r->name, oid_to_hex(&r->old_oid));
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		string_list_append(&to_stdin, strbuf_detach(&buf, NULL));
 	}
 
-	strbuf_release(&buf);
-
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
-
-	sigchain_pop(SIGPIPE);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	ret = run_hooks_oneshot("pre-push", &opt);
+	to_stdin.strdup_strings = 1;
+	string_list_clear(&to_stdin, 0);
 
 	return ret;
 }
-- 
2.33.0.rc0.595.ge31e012651d

