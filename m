Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FD2C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjARMrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjARMqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17FA1DB9D
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y19so15755739edc.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2fJJud2NPAFFQ9AJyYBbG+qE8iKqwaUyGWWhxkOPUM=;
        b=YIeuXamOH2M2fM4koi43DA3gMnmc104ijJWkowuZO/fSKDmRbST+BQ0qxVM8lHl1Cj
         LAcKuNkr6+6fD5tDWE9n2cidMmSJRzlHwTaywfmX+Bw0EZi1eHWYZw/V8ZdUYlo2Je/9
         OssighjBcwdyfQvCV+y6d8xove/ufI9yX7IGBn5KanbRDrwPEAfgNEgWhGzbNnlq3VGq
         NLZCF+bfFHWITiRkL55nNRy7TYF8+qaA5CFwiIOgx6E3jZBRRfEN7kb3vQ+7mLcAXOZG
         uqu5LvxTZzLQMgdKdDrpwB0yXkqOUkk5hW1XhxJWjwTbz0M9oyjRQKeUaaKmc8RUflLg
         YmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2fJJud2NPAFFQ9AJyYBbG+qE8iKqwaUyGWWhxkOPUM=;
        b=OJ54E1rhM9VWaB+3sFetapYHf7+db32V3/DM+4lRaw78QomsmXIkxTubpKRt46hTbF
         3x4DwTifGm2IhhhMaNweC1vZ0vUvAq99NJ3pXaH3p/JnBRsLIiKE50aS3e7dLTJMo8xK
         f4r8CWNHDaN/YD57L03TRO2NizcpTZMWXfdtk+yzYLsv+bRueMFiA5E6xAuuFkiPN83K
         06euqWcPT+PAxRfjeXCMnqNeqszHERqdyi+0SGcLw4NGUhWz89oJE6T9546MzPyYi0bW
         0DIwF8UbNs+ZiCBHyqYQRK39jVs1BcOPd6QE9Wpt54kWcO/8QUJ8xarZKI+5u3pcv/UZ
         7vpA==
X-Gm-Message-State: AFqh2ko2i93rCvU6GpqrToQERH6eybyw9QKKaY9fs05PblSZzv5730Yr
        nGfSya+bNpFzxlLWQHjDjnyS8dGenp2/Zw==
X-Google-Smtp-Source: AMrXdXvSewyurShwgltlKzx0/nYgEtPZdxs1fhLHmcwkOwZDRAsYC+5FP5DPQ+9ZlqZwIlk0yuraTg==
X-Received: by 2002:a05:6402:60b:b0:470:25cf:99d1 with SMTP id n11-20020a056402060b00b0047025cf99d1mr6974941edv.31.1674043724266;
        Wed, 18 Jan 2023 04:08:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/19] commit-graph: fix a parse_options_concat() leak
Date:   Wed, 18 Jan 2023 13:08:24 +0100
Message-Id: <patch-v5-11.19-5770b9eb764-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the parse_options_concat() was added to this file in
84e4484f128 (commit-graph: use parse_options_concat(), 2021-08-23) we
wouldn't free() it if we returned early in these cases.

Since "result" is 0 by default we can "goto cleanup" in both cases,
and only need to set "result" if write_commit_graph_reachable() fails.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0102ac8540e..93704f95a9d 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -269,8 +269,8 @@ static int graph_write(int argc, const char **argv, const char *prefix)
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(odb, flags, &write_opts))
-			return 1;
-		return 0;
+			result = 1;
+		goto cleanup;
 	}
 
 	if (opts.stdin_packs) {
-- 
2.39.0.1225.g30a3d88132d

