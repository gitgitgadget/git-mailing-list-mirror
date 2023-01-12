Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755CC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbjALP1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjALP0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B8C21
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz12so45580299ejc.9
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIkorZCai56vpMQTrRCkObBbdC1VRAPQrjHPRlPXwP4=;
        b=OeXGA4TCfCne2DvovdWaFCC+VemKHnMoluiQbljvgclFq4WTpdg0hNhfqjoGVCRpag
         C21QR2MGbMbXb9bZdPAcisZCKErI6tPnvogZtgRXx1Re+m7qZ+/fouIcVz4foz0iOY15
         8oozKOXQzG6lBsGyj/Jc7vHMTtfgn/rf6E544xnxGIjnn99/eSMAGzbKmzksy7DYKKJj
         azZsiXiIcRRnaSAt4yWL6JaDxrE9oiniGva4pKq6VuWyTDW46Csfss2nSXAm0nbg98Pf
         rtutU/xoHmC1Ln4R1/CeXwz4dfHivCcTPHP60O8aYSnYNOOkIauIRB3riZJfx3DyzcMy
         23EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIkorZCai56vpMQTrRCkObBbdC1VRAPQrjHPRlPXwP4=;
        b=gOP5CyyBANMvGTIw2cO0d0eGI0Yb3hjXuYGFhozcLUV+EfMcNeCql/uZgpNZvAt1AP
         /72BJNXIFPbJElIkSsV6YkuQRLdrecmbq0eh3dGe8wcv+2XOddXXBlrroXeg+7jT+1y3
         4u/a5JrWSdamp6De2QsTLDxZAdZUAjM4vnBiyZAzFCE93GSCASHIvI5Xkx1rv/NswIQS
         39mKQs/M2ZeUj4JaLWXNMBiR1udCAjBGFXjXkfLGC6Hd5np9Qos6B0LLoXUHAtTRV4JL
         en+jF9DdUkMLNiUibp6GDUbDfc6GIsaGPWLmAQ0UH8ecrwvJFFSHlO7IHFBg8nl3BPzc
         kXnQ==
X-Gm-Message-State: AFqh2kq65aYyFlsnTftP5hsLMmjhfJLZe7irQY2Y9yMrPvSU2lqiXFrM
        603oYQ2qotsXtrlU6+etHPN6jQZWy4O7aw==
X-Google-Smtp-Source: AMrXdXu64u2Zia3Kg/yUZ2lazs1ujMaHD7nVAHSksWVSjpAv128MuSAHqqdY1UEHWILxhxfnseksGw==
X-Received: by 2002:a17:907:8b12:b0:78d:f457:1062 with SMTP id sz18-20020a1709078b1200b0078df4571062mr66745554ejc.31.1673536760392;
        Thu, 12 Jan 2023 07:19:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b0084d44553af9sm5493291ejc.215.2023.01.12.07.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:19:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] bisect run: fix the error message
Date:   Thu, 12 Jan 2023 16:19:12 +0100
Message-Id: <patch-v2-4.6-4dda1019767-20230112T151651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1215.g1ba3f685d4f
In-Reply-To: <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
the part that prints out an error message when the implicit `git bisect
bad` or `git bisect good` failed.

However, the error message was supposed to print out whether the state
was "good" or "bad", but used a bogus (because non-populated) `args`
variable for it. This was fixed in [1], but as of [2] (when
`bisect--helper` was changed to the present `bisect-state') the error
message still talks about implementation details that should not
concern end users.

Fix that, and add a regression test to ensure that the intended form of
the error message.

1. 80c2e9657f2 (bisect--helper: report actual bisect_state() argument
   on error, 2022-01-18
2. f37d0bdd42d (bisect: fix output regressions in v2.30.0, 2022-11-10)

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect.c            |  2 +-
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 9fc8db06944..0786ebf4012 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1292,7 +1292,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			puts(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'bisect-state %s'"
+			error(_("bisect run failed: 'git bisect %s'"
 				" exited with error code %d"), new_state, res);
 		} else {
 			continue;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9e56b42b5da..0a62ea2b3ce 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1221,4 +1221,14 @@ test_expect_success 'bisect state output with bad commit' '
 	grep -F "waiting for good commit(s), bad commit known" output
 '
 
+test_expect_success 'verify correct error message' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 &&
+	write_script test_script.sh <<-\EOF &&
+	rm .git/BISECT*
+	EOF
+	test_must_fail git bisect run ./test_script.sh 2>error &&
+	grep "git bisect good.*exited with error code" error
+'
+
 test_done
-- 
2.39.0.1215.g1ba3f685d4f

