Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFCC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjBBJxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjBBJx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46478A7D
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso892400wmq.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy408xK5SnIuhFLEcKXEl0w1IcVRfyBxKJsx3W6yrRs=;
        b=Dvq5tc5BJ6n5TbaLqnPt42+/38jWnKLNZapBWA7NNqli21BRWxWnJVsej/fbw6NSKx
         lPCRZTB91UL6Gq9oJfJXVbs8JHZz/PKjytbh4u5xuwAwnxiUA08aIAmY+N7z1TNATGhP
         uwQyDy/vJTnBh6OEGhhLWo7ZjCSxJKDKl/UbG3SgFXijaKRlZ11p5z0VR8XyLlyGcMVm
         4maRn+bmSKJlgQkXaRzRIy7AKWZbzyox1cu8qw5CgqOa9IUwNwNMn54ECaz0U1ow5dQQ
         Sld+QWumlE8NJ3KalBiBnAZUxT1aBIoeI7WzQbg++ykIrxBpaRShvM2Zs2fv0BcETesM
         M+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy408xK5SnIuhFLEcKXEl0w1IcVRfyBxKJsx3W6yrRs=;
        b=N+UavKy2vMAZ99Ggh8JM6FeFrzbWtDHJ5EKyCLCLke0RghQThYISjquhRBe7cqQmTu
         LUrHKEP+kbEnHLmlBk6trJpuobs5cuK1YI84HFmk/0X9lUJks+SKGqZoz14pUyI6EVeY
         QCCKeJmdsm0/GzRM4L9gRVlUTJyGyqrWlPNJB1bwptG/258I7dINHbiSbvJCeL9BsvQL
         4fj70I547Z0JoDy3Soq+6gAhbb+jNWWs345EN+j4N2XGY2QbpuzeF1TFbQZ4RpVsG8W5
         E8NwVOpP4uw/28L8UQuFWw1lwi2vNMuE7ufjrYXVsB3Bv2Sadmn/zgbX4hR64J4FhgGl
         UAiw==
X-Gm-Message-State: AO0yUKUMHVJja2kcC1aHtkgiW1M4voLn+haWfnu60ujeY3t336NJDZBq
        DKVfHvUyjmI7wD0KOoCytjyeXyN8Ohevz1ci
X-Google-Smtp-Source: AK7set98WifiH0siTeXSnQf3ejnEPnAvkqzKVfxw38Iupcd4Wvpg04tsB70Wq3+h/QZfOu0JdSGiPA==
X-Received: by 2002:a05:600c:4f46:b0:3dc:557f:6124 with SMTP id m6-20020a05600c4f4600b003dc557f6124mr5276318wmq.5.1675331587892;
        Thu, 02 Feb 2023 01:53:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 11/19] commit-graph: fix a parse_options_concat() leak
Date:   Thu,  2 Feb 2023 10:52:42 +0100
Message-Id: <patch-v6-11.19-65e25377791-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
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
2.39.1.1392.g63e6d408230

