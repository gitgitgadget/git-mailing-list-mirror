Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D893AC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBFXIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBFXIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE21731E30
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mf7so38748642ejc.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmixHhC7LutftPQ/kAv4923i0unNbfH9yhhc4dqrDYE=;
        b=qOiBbcYJFIba9cD/iHXkFQg84QAqqnLT4ELCTlJPv4bWgyRNIUgp7+VHfKATGGYnOV
         vN4729EhSx1jjj72rFOTSXuK9jsek2KgtHYFmkLb6a6m5vRy+s0sK08/6wbFkKUGEl/C
         j0IbixoKZ/4emRrOCYS6/rTOr/ItrgQrUB+RV/oO0xGmMTgjToud2iDSapmukX//wnyW
         9G5vMqw/JxeH/VxMh+j7FwtIB72vs36lcq7homj/uvzoMZ7eNq80LQ7jUpgNxAn+ThhD
         nJKIyjNwUaIWAY3H8sxgyzgDTmJNxTiiKlzerT1vF++hJsYmQ9Uyi0FD15ENfhRFB00g
         9Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmixHhC7LutftPQ/kAv4923i0unNbfH9yhhc4dqrDYE=;
        b=u3WF05koA0hwKX+VkmEXEy7XZL5DsBlkqGCPoK5jwbMhE67IxEwjC7K6TFKs9ebhZh
         kd9h5LurAhRxcdoXQG6bA0dpS0CQCcTbeNk5x/kZUuZ+mbendsN+YbOs9+D8D9xzYOWJ
         EUkmgEAZfHCtUhRJzOmdF24kA2hINDiDVse9mExGC337tbS4mkHpICDf1mywKu0azUC5
         FitbaOaEkedSQXLPcOUItMBjxyYQaRvv4lO7rqeUy1Rew7dgcU6eIgm4eT5+65W3FPOd
         gpUihqdIbwYjsFKeRhpb0ZTSrx+Hp5BsYiRwwu2AyPT5S22JSOCRWfMTGt/O1jC5BNSl
         Mwyg==
X-Gm-Message-State: AO0yUKWiJrZfxW3Gkoof3hZ556jBMsbieR1ImEzwqRTZWCkTTY1IIXxI
        fJxu/O/w4YyPRdI0Jq7RGUtrrp5aqBRVM0UM
X-Google-Smtp-Source: AK7set9G7yTbMFhqz/v2lHNKPsQzzOG+m2zbuk0T4+0G5/RegSEnx87futAeR784K6x9QakYlwcbYA==
X-Received: by 2002:a17:907:8a03:b0:7c1:458b:a946 with SMTP id sc3-20020a1709078a0300b007c1458ba946mr1433741ejc.0.1675724900284;
        Mon, 06 Feb 2023 15:08:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 11/19] commit-graph: fix a parse_options_concat() leak
Date:   Tue,  7 Feb 2023 00:07:46 +0100
Message-Id: <patch-v7-11.19-badf54d5240-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

