Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B6C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiI1Ikt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiI1Iju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE574F39D
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z6so18669426wrq.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5DvpVEcYHqwEevBs/DLcETS2acbK/YYF1WwmxdBMMaQ=;
        b=RbYopG5whlOSJvzm4y1rjKHQtt4jeemQKo5CTLLaLEBjciivPvuFllYzKx7eSrwitf
         f0jNWO09CX7pxCaWGIf5S3kvlA4NKTXwg5OpF+oNZb/1t3R8zgFMdZ5022k+tEyK3Uzr
         T4gfS1bQVAIyIZ2+sOr9+jkkdQv4r5BhWt83t3fnGjPMvX0xXHIEXstTHhXZ1Gk34AUU
         La+DIbgvoJIC+rB64bOMoPjoHxr1yKOZqXsC/CZgGlQ7ZL3SiYBXigN7pl1b+/jdv5EY
         0+YHwAo6xSENdHpIIzh/f166gJ+xK3GeVCO5DVGPfv5IFNP+VH5nkVhJaT2jf7pHhcjt
         7A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5DvpVEcYHqwEevBs/DLcETS2acbK/YYF1WwmxdBMMaQ=;
        b=7/sgwWuMO05ibt1hHmZp3i7nSre5mLasKRliCdtvL/XO4NMcx1+Kf6iic3x4d4YKzy
         ArSRgbB8piSPxyucW4YfIfJ+7/K/WSCXtjbqDzWIArv4XSwAzPpgnJbnayQSxM5Au0kw
         g9Bo28+FiIivnP1ekuGKQf6phCI/gZQWWeY2qUifQsoUiMC3C2j5GQ5GaUjya1KyMNqa
         3Wu1co6VacsnlI7tZeMKLo6gNrjlFaK/zOWEQkmts1faPFw+x92v4cfQANMJpVS6NmcN
         eSu4Zl2GJ+139lhJaDpqIS/jIi2hlK1t3js3IYGEu5MVDJPD5t63Cx4oJ/Dsl99/sObO
         qv7w==
X-Gm-Message-State: ACrzQf20hMijmGOXAhRXcQSs2GJr5lMXlzn9gLthHHbqvKmJOlM6EYsb
        m1tV0GGEpKMhd2cRKC6EyREhozTK0NVn5Q==
X-Google-Smtp-Source: AMsMyM51iTov5r/zJarCDYvnkHKHWiEik72kGkEddtJBh2VytI0NwQ4it/j7UqHVpJK3/N7IFS30+A==
X-Received: by 2002:adf:e186:0:b0:22a:3329:540f with SMTP id az6-20020adfe186000000b0022a3329540fmr19595384wrb.278.1664354387378;
        Wed, 28 Sep 2022 01:39:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:46 -0700 (PDT)
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
Subject: [PATCH v2 11/35] doc txt & -h consistency: add "-z" to cat-file "-h"
Date:   Wed, 28 Sep 2022 10:39:06 +0200
Message-Id: <patch-v2-11.35-aaa36012fa2-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in db9d67f2e9c (builtin/cat-file.c: support NUL-delimited
input with `-z`, 2022-07-22), before that change the SYNOPSIS and "-h"
output were the same, but not afterwards.

That change followed a similar earlier divergence in
473fa2df08d (Documentation: add --batch-command to cat-file synopsis,
2022-04-07). Subsequent commits will fix this sort of thing more
systematically, but let's fix this one as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4c..fa7bd891692 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -893,7 +893,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
 		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
-		   "             [--textconv | --filters]"),
+		   "             [--textconv | --filters] [-z]"),
 		N_("git cat-file (--textconv | --filters)\n"
 		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 		NULL
-- 
2.38.0.rc1.925.gb61c5ccd7da

