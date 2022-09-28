Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71635C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiI1Imc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiI1IkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D306A6AF2
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso721710wma.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=myuiZFa3fiDQ0+AgZ+0uIZ8dxuaxMNW8nWU5ksjJZ3A=;
        b=dIWXxJoKkt9Vs5fR9Y0CMMg14rnrmwn0KRHiPiLe2GDpz79LPaCdYPi4HFdpfHt8Vw
         kG1FJpUsSnC5CcE3swBbCLVIm1SC88ZTUC31CnDoD0itIAUQsP6O0GWwRTI5yLfwltuj
         M51dwRbEwMxWebQDp9YqI/cwo6ROrkFrOFSWzzPNIJalzd9oO58PuEL518FsumKK6h/K
         xru+HW/vuV+eTY1rhvYCqdKEllgZyHIau+J7z6O3qtsasGOmlBzFhiEsjvsZzJ3dHrPV
         JQjl92HMpX+CPAjWGwlEswyFw4vvVt/zEjgvw6uH/16tkB0V/5jH1wAXj25/9/+92RPe
         Zv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=myuiZFa3fiDQ0+AgZ+0uIZ8dxuaxMNW8nWU5ksjJZ3A=;
        b=DEpBc7Q4AB0fSxTMc7UiMgOus1F8KDtoOmg3fh97G2+zsd15sr3/oTKVvFHDR08brg
         WA8Qd+Bg55V8zXzCpcEqJKdHVdHO8ODkDjN3D1ieC888kqv3CF3ofFR59500yi5brbhI
         2R7tszicvs/vnw98RG47dkpIzLfRPcn81/62HMAsq6opjNHQ5rACo4RnbnIyhVQhfUmc
         4WOPEBU5g/E2u1y+m95Us0SXmU6YneRBsb+8esjORzkEJe+98Y/quwTLOOmA6+4B/ZdC
         gbiCrFN+CB3Z5NafrNIDtHdpgB/MeJxEr+HwAJwRTuYQk7DCNMRKDan+9R5Ff1fQhuxQ
         FYMg==
X-Gm-Message-State: ACrzQf1wHZLUAWZ9yqyirtmloS0xUDtwi46pHLAUHxhFGV4qKvx0huWl
        Knangw/B43KciO0fiFR8CPgsEy92X4nwmQ==
X-Google-Smtp-Source: AMsMyM6wUnNmdAMdPFmFBiPB+QibZxYvQt8GjyiUPlPwvmSyuoS2xs80JY9XwcWWks2Twjg4eXp8zw==
X-Received: by 2002:a05:600c:2286:b0:3b4:85b0:1c3c with SMTP id 6-20020a05600c228600b003b485b01c3cmr5810146wmf.21.1664354413511;
        Wed, 28 Sep 2022 01:40:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 35/35] tests: assert consistent whitespace in -h output
Date:   Wed, 28 Sep 2022 10:39:30 +0200
Message-Id: <patch-v2-35.35-c92a4f52a8c-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the *.txt and *.c output assertions which asserts that
for "-h" lines that aren't the "usage: " or " or: " lines they start
with the same amount of whitespace. This ensures that we won't have
buggy output like:

   [...]
   or: git tag [-n[<num>]]
               [...]
       [--create-reflog] [...]

Which should instead be like this instead, i.e. the options lines
should be aligned:

   [...]
   or: git tag [-n[<num>]]
               [...]
               [--create-reflog] [...]

It would be better to be able to use "test_cmp" here, i.e. to
construct the output we expect, and compare it against the actual
output.

For most built-in commands this would be rather straightforward. In
"t0450-txt-doc-vs-help.sh" we already compute the whitespace that a
"git-$builtin" needs, and strip away "usage: " or " or: " from the
start of lines. The problem is:

 * For commands that implement subcommands, such as "git bundle", we
   don't know whether e.g. "git bundle create" is the subcommand
   "create", or the argument "create" to "bundle" for the purposes of
   alignment.

   We *do* have that information from the *.txt version, since the
   part within the ''-quotes should be the command & subcommand, but
   that isn't consistent (e.g. see "git bundle" and "git
   commit-graph", only the latter is correct), and parsing that out
   would be non-trivial.

 * If we were to make this stricter we have various
   non-parse_options() users (e.g. "git diff-tree") that don't have the
   nicely aligned output which we've had since
   4631cfc20bd (parse-options: properly align continued usage output,
   2021-09-21).

So rather than make perfect the enemy of the good let's assert that
for those lines that are indented they should all use the same
indentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 9b1c70ef40c..5c1d01d2c66 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -129,6 +129,21 @@ do
 		! grep "$HT" help.raw
 	'
 
+	test_expect_success "$builtin -h output has consistent spacing" '
+		builtin_to_synopsis "$builtin" >help.raw &&
+		sed -n \
+			-e "/^ / {
+				s/[^ ].*//;
+				p;
+			}" \
+			<help.raw >help &&
+		sort -u help >help.ws &&
+		if test -s help.ws
+		then
+			test_line_count = 1 help.ws
+		fi
+	'
+
 	txt="$(builtin_to_txt "$builtin")" &&
 	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
 
-- 
2.38.0.rc1.925.gb61c5ccd7da

