Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A46CC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjAJFpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjAJFoK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C654084D
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:02 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id az20so6730584ejc.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g93NVg2PymlFEP0Ee00h8xm1bjSzEbRSGsOcQLkisQ=;
        b=XkovYGvqoCxkVKj2uAI811q2pVPJLcu3UMN1cD7VTUumAWrk1atnRQhnIYQexHNvgr
         E8A4iO69wtMHrxEKYlx90VQ7FwVJxf08eQ4rdM/c4ladqz4FQ03giPMGII8XRvCQWjze
         d3qH3jVkxLdNpcX/9IWat9FNGmqRAAKb80t+T1hsXCPhNRvoEpsr+oXdx0pNX0AKN3dj
         wYPGb2m33z0N1s7ZcglCha0OlFq/2vcb08oIQuts5Gwz7djQeACg+PuDuAuLXim+s/+3
         aKvmh+Vi5I8OQWY4gYDnVN2psiEnHnlJGYOKm8et7IDKaxz4oaahsga3Zp3b1LT53wbl
         1SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g93NVg2PymlFEP0Ee00h8xm1bjSzEbRSGsOcQLkisQ=;
        b=MEKzSTND3YLINStUJf6NQ2rNtCHUkKA5o2rc+Jxl4rOzHnzTOJ36iYvLKcP0+LgWtI
         2CPeFFxuSsZKttpxeeCexTBKXp00h/Ra/C1al4LPhDJPvwWJDQ+9mYNKu74LfW+Vsf7V
         dP2ncgaiWoVlRN7B1MT/G9H+rmgNMsrB8V8nXeKRtwZ62wJXoQtddWtTGdqSaMHXKdSg
         VQ7Pn7ZQpoBBThx1V2mueIe2fIoTx+/3Q+GGSPq6GsH1jXjsm/2SjB9CfJgyMnmgsy3z
         zQe8v3sEXafeLZxzdFc1T8N93Y/IVdoeEFcKcLyRWa4BB/7NtirLd2AygkLPYx9sXUkK
         hjrg==
X-Gm-Message-State: AFqh2kqLElVNn0iK5MQgQqSIBo7MWleHsoe7kgiI1z9e2E7NpNW04CiC
        RKitsfg/nKFmOB4NtSSFpcDTEhdCKZlGKA==
X-Google-Smtp-Source: AMrXdXtoMY5OLwT3ELX2AMfK2L9+fBD/PdIG4iD3GzYGbAn7RKL3Kstbk7ejGuSB2W6oMBJ4+b4TuA==
X-Received: by 2002:a17:906:8d0f:b0:7c1:7c38:f079 with SMTP id rv15-20020a1709068d0f00b007c17c38f079mr41754285ejc.71.1673329440652;
        Mon, 09 Jan 2023 21:44:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/19] commit-graph: fix a parse_options_concat() leak
Date:   Tue, 10 Jan 2023 06:43:31 +0100
Message-Id: <patch-v3-11.19-dfb52dbd1c4-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
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
2.39.0.1195.gabc92c078c4

