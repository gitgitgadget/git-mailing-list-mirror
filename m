Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B407FC677F1
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjAQRML (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjAQRLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C4C442C0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y19so12433036edc.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2fJJud2NPAFFQ9AJyYBbG+qE8iKqwaUyGWWhxkOPUM=;
        b=Dar/Mbk2EZZ5v9Zf0AmpTRY3G/E2nqVcl27SSeeVEDVNxvvxmKU+MsFlOV3IYhG8Wc
         3kY2mwkCX/d3P4lUnm7f+ykP9wJ0S7BkY11wmEnQcVq+pirxSRzaGMOA73pFI7qWlSXx
         Qf1shW6Ycg1TGkcF82QrCzJhC3JSwnGIk2fl5kvZbitBmpldOHJ2QtY9bdgFveOe2650
         u9aL2FDwOUy3Z4ooCYgDNOoo29zxRtHR9SLBcJ784z/XkibofaTxO+9XJg3D5T+MZC4t
         KI9G4uoMu0aYgxSFZNXDETvKwGmSSl3cTvEahP5NMJ44PVBRyjgosYLN9+T1BiT/lR0I
         YtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2fJJud2NPAFFQ9AJyYBbG+qE8iKqwaUyGWWhxkOPUM=;
        b=N6lb2wixkEtLJGmpcIrUUSQGgkda646KwtPkm2ToyiCGErIdNDA/jVuQUsEEqMRHTp
         q9D7+i+9Ibs1GV28ajtkJNvJuRGEcQDLhpUpBehStqK5LwhUDT8tSQlh1zNfBRj4h9Ri
         lV5GXI8SAtmGieKZ9WC7r2y3sULq27Mz6OuBi+ZHs8z5UOT88FAqXYtRRn8g79A375Rl
         cDXZNgpKR9muzzLTVt46SzYhvUxh8rNjlaOlzXI9uwqTCXFI8WKVYmE61IQrzFmMU0b/
         iQjMozMLv4rRgcSvV8Ne+TUupbnmB2Vevktt/x96F5eXg7KBJhcSPKOqyEgRhqEiUGKv
         M3mQ==
X-Gm-Message-State: AFqh2kpmQYJEBDa28jpHc7p/ycJht7Om65rgkiKxfBLThmX3s0uSuoFD
        VwNFrq9bl/FMF2WGyJiLGfogKrUPSmYtwg==
X-Google-Smtp-Source: AMrXdXunyNfEq5IiJ1/Vs9yk1EW+8yNlJzjXuxy5AYEDP6k96fUYePIXOYq7K537DqDhOXlUjg6L5Q==
X-Received: by 2002:a05:6402:209:b0:47e:15ec:155e with SMTP id t9-20020a056402020900b0047e15ec155emr3642779edv.26.1673975495350;
        Tue, 17 Jan 2023 09:11:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/19] commit-graph: fix a parse_options_concat() leak
Date:   Tue, 17 Jan 2023 18:11:16 +0100
Message-Id: <patch-v4-11.19-ab31d8d10da-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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

