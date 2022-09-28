Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82384C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiI1Ik5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiI1Ij4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817661B2E
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n10so18575767wrw.12
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gxoBX1f+hTRMytu2zJoIheky0o6Re84eu4l4B5KisO4=;
        b=Nh3HzC81ozCWPB/tG+xPHrwWC2muIt5YymB+aO8l4nPY8RCc22QksmZQXveI1L5Ej8
         E6R6tvQaoNbnLqvO/v5NdjgpALuJ8RrLc44KbAd51zq5X7WIDKrORKIKcpheyfs5GsZ2
         xNVWGpBuis47Ubmq1NFpaKd1id+0pO2um6u1b6b1sqaySm/IuwqYzsbMMQFX89fBBp3L
         mV8orFoNRT1F5mwg2gFhgR42OoFCPUuVppWptC5aWRsDHt0oWCggO9BszMDLnsx6NT4k
         n97wjft3PPc9Xud0UuUnosHHxHXVkWiWUlJfaKPQYV+4/bAxt5QJOpLdfPO55gFwO4rt
         Hw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gxoBX1f+hTRMytu2zJoIheky0o6Re84eu4l4B5KisO4=;
        b=Z9k8RrA/IUc7s5evrMiBhVvxsS4rK1HUxVBYCI5tEnOXSwX4eq5tWnkOrUQXfabsNw
         YH7KUHtmJnseG1T0T9ZSFLH7sGzPTWw1yMY7ribO2hDEeGHUlV2yw/ZCfE8MxzXlJ6Vr
         x83YxMjsTmOOSLEtjWF5YhcCCuyvXfR7NkrPHZ7xRoYE+OFO57l3jvUgCQlPyeOybPcc
         XXvMJAbkE8I/fZDy7dk4BCv/lig5OeFClEOg/SYNafmE7FCPdcHctawpp+Wo7Xb/yfXk
         TqwVPWNxYrt+m8cBZ1AeBB9euezx59PnGsxZH40IrSgSYFgRb7mTbRi6RK8eOHHI2+2P
         i+kg==
X-Gm-Message-State: ACrzQf0kl4laBoyHF61cl09LU8OaUep/3QWQVjjXx6cx0/HXycUV/Dgs
        eDK1KKgwqrn5E+r//NaXRkfzEaoO2kKdeg==
X-Google-Smtp-Source: AMsMyM6tyTyNHSJCl+a/8XFJRuBA0klgizPohyUmIAMIj6y/MeBHysGKcc2Qm0iwoQ96L9oiY2F15w==
X-Received: by 2002:a05:6000:15c7:b0:22a:f70b:490 with SMTP id y7-20020a05600015c700b0022af70b0490mr18996953wry.489.1664354391663;
        Wed, 28 Sep 2022 01:39:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:50 -0700 (PDT)
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
Subject: [PATCH v2 15/35] doc txt & -h consistency: use "<options>", not "<options>..."
Date:   Wed, 28 Sep 2022 10:39:10 +0200
Message-Id: <patch-v2-15.35-28e1edaf68e-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's arguably more correct to say "[<option>...]" than either of these
forms, but the vast majority of our documentation uses the
"[<options>]" form to indicate an arbitrary number of options, let's
do the same in these cases, which were the odd ones out.

In the case of "mv" let's add the missing "[]" to indicate that these
are optional.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mv.txt     | 2 +-
 Documentation/git-status.txt | 2 +-
 builtin/pack-objects.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 79449bf98fe..972a055fbd8 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -9,7 +9,7 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' <options>... <args>...
+'git mv' [<options>] <args>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 54a4b29b473..5e438a7fdc1 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -9,7 +9,7 @@ git-status - Show the working tree status
 SYNOPSIS
 --------
 [verse]
-'git status' [<options>...] [--] [<pathspec>...]
+'git status' [<options>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05cafc..573d0b20b76 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -180,8 +180,8 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
-	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
-	N_("git pack-objects [<options>...] <base-name> [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>]"),
+	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-list>]"),
 	NULL
 };
 
-- 
2.38.0.rc1.925.gb61c5ccd7da

