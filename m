Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85340C43219
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKDN0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiKDNZp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27D2F01C
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:24:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so13272402ejc.4
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3Z9tE72IOxadGKVWpxWvrVBBsZdn0l7frAptRBkjcA=;
        b=M115uXgy7KZYHV0q1Hjgi1fVMLqZ2JhdUphjEovZoU+S6IwDR3gTuxR2l+IJGcFLPL
         Ip6SPPVBQdelKbYdqz1ev4KvYhG4HjqV35QXcDqxWuvC74U9wcJG5EpqBK26y4CVuJfY
         YCrYMeCTK9K5C5vgg+DY1MmrNLqVyPGu3/IGl+sP/SQo7NqKfKWZWoGMGEa16MGAGZEZ
         QHBw/ZVw1UhOjK9CAAzwFaCvhk2h2bgWUoavCAszLlbox6ZWLXXIlpiB6PSPgU5b1bEF
         Ul0NwDbILRPilauPBkQdMG6RcQDtR+r5UWti3I4mGThBNylAUDkr64FzB10z9CrxXRrc
         YGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3Z9tE72IOxadGKVWpxWvrVBBsZdn0l7frAptRBkjcA=;
        b=2fGCQtky4vh7c/T9Teppo9z6E8x+0JEvDbRVdOg4Ex2vEfJOB95jYcx8yTRLbeu6Hc
         1+MwZ0L6jEaUYW4+RGWSgPhQGLjYsj2px3fU3yyu5yFMjsMLZPUuYIPJxT9/n+fELq4t
         NQDk19X4p77OrZ2+wgOJU9JFiky8y5Z0zQEyxdzoNgK8ZiIiCXDI5oDToPk7T9XIKcKd
         EFwP48fNPTKrkU9mnRuBbvVzS2PRGGdni9hXkW2ICiWQePrgoRX/iF9VjWjiEVyr/vWI
         lygA00KfQENcSOz+rgzB7NZNZ/31btul44ahkwfTujnVQQfN8NGTVDm1gMn1aRTg13do
         +rlA==
X-Gm-Message-State: ACrzQf21TX0jooPU/IOcKNxU4pQ/QnD/AKnjjTMABV1kgmRjbPAMOvfn
        H91jEVj71srU05iLbTP2YVF31LvmTEN0+w==
X-Google-Smtp-Source: AMsMyM7+YGuTuleE98+zpfPDXuu92LB/J5fLmK8j+CZyVaSLjAH3uDFBYZNuk2KKE9UHx0tz7ELNPQ==
X-Received: by 2002:a17:906:f888:b0:78d:d762:5457 with SMTP id lg8-20020a170906f88800b0078dd7625457mr315827ejb.67.1667568296566;
        Fri, 04 Nov 2022 06:24:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:56 -0700 (PDT)
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
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 04/13] bisect run: fix "--log" eating regression in v2.30.0
Date:   Fri,  4 Nov 2022 14:22:41 +0100
Message-Id: <patch-04.13-b10deee4827-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13) reimplemented parts of "git bisect run" in
C we started parsing the command line that we'd pass to "run" with
cmd_bisect__helper().

Unfortunately this meant that we started eating "--log" and "--no-log"
on the command-line.

In the general case the fix for this would be more involved, but
luckily we don't support any other option here (well, the other
CMDMODE options, but that edge case is too obscure to worry about).

As noted in [1] we can simply remove the "--no-log" option. It was
added in 0f30233a11f (bisect--helper: `bisect_write` shell function in
C, 2019-01-02), but has never been used.

Reported-by: Lukáš Doktor <ldoktor@redhat.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c    | 4 +---
 t/t6030-bisect-porcelain.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ee1509c198a..eb66ad491cd 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1294,7 +1294,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
@@ -1318,8 +1318,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 30124b6f059..dc83034f036 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -306,7 +306,7 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' '
 	EOF_ERR
 '
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' '
+test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' '
 	test_bisect_run_args --log foo --no-log bar <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<--log>
 	<foo>
-- 
2.38.0.1452.g710f45c7951

