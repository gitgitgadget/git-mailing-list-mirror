Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7CFC4167B
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKDN0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiKDNZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556772D1E5
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:24:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y69so7575620ede.5
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7VX4bKD34xxVKoj6G/KVNG1sJHYoZhR8IFk+CdxIxk=;
        b=JdZLpgeuM66g3xSCyAQPEJp/uA1mIJm2KMiLGyxPmDUJA3alKBgxUQc6VJ3GaHioHI
         IPQsdSBG3QUOTowEJ+hyO88/tQ5bRinY1/XeiPh6PLvj+zgs26b9N1j0HEfqr28zhZoN
         foB8nVkV4UyLSiIM7QzJqKZA+KeHMS7fT2RKfVB4+DIZaIPczEEDXNvRQhMbi8cLYvVJ
         v0FUvKxPz+JCvV8UC2primf+GSNkDFg5fbgMv7G9/O/jjkxjBtYXdztCQxVHVTvprqta
         MeqgHPMNMv1OqIf+eT/U26McjV3tCXA8MugsCZr0YShdwzy6ToT9dBCC6B0esdjHx6lJ
         /HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7VX4bKD34xxVKoj6G/KVNG1sJHYoZhR8IFk+CdxIxk=;
        b=CONh3U31XtEM/ahT7ntvu3vneHezVy4pRt8IgVQ2iVHPeQ6B05FJ1BS6KF918b2Po/
         Mdszsog36WCFKhl52xucSyBS/3dxlbYjkWy4D0+IuRHZh7P4OV5DR8KMdbEO1gnKguzJ
         ujDozjSibHk9V+WmIHt47Pic4/pPqr1kDSpO0lgjFntIdaO4ZL9uOD31DMLlQ+GTFh9Z
         B8aoEkR+YXS+eG6taS+X++o8eOJglQUqK+yKsWpZPEtCOWZAy99XfdiWKnmCVL70jGiE
         R/+Lm3XdYX9QsG1YpOadDgQBRU0ctkP4rCONmPVZ+nf4s9MdjfX0IWLZUCZWPRf4ccL4
         KJFQ==
X-Gm-Message-State: ACrzQf2cwr9blSfeeE7QjMwpWMPl1pBMQHVUOtCpNAi+U34t6qR+hS4x
        2OxExDGLAz/N8O+qfQPs+xamhyFZmvQbGg==
X-Google-Smtp-Source: AMsMyM71lPumdqrpmgJuczWSHQzfZXnirKfp7yXw1rglzTpgHhuiIMuqJ0fFvsG3IrEO+sN8RxiO8A==
X-Received: by 2002:a05:6402:22a5:b0:462:b393:f281 with SMTP id cx5-20020a05640222a500b00462b393f281mr36068265edb.379.1667568294572;
        Fri, 04 Nov 2022 06:24:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/13] bisect: refactor bisect_run() to match CodingGuidelines
Date:   Fri,  4 Nov 2022 14:22:39 +0100
Message-Id: <patch-02.13-4af93ec9aa3-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We didn't add "{}" to all "if/else" branches, and one "error" was
mis-indented. Let's fix that first, which makes subsequent commits
smaller. In the case of the "if" we can simply early return instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28ef7ec2a48..7dd90da72d3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1185,13 +1185,12 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
-	if (argc)
-		sq_quote_argv(&command, argv);
-	else {
+	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
 	}
 
+	sq_quote_argv(&command, argv);
 	strvec_push(&run_args, command.buf);
 
 	while (1) {
@@ -1265,7 +1264,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect--helper --bisect-state"
-			" %s' exited with error code %d"), new_state, res);
+				" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
 		}
-- 
2.38.0.1452.g710f45c7951

