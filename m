Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE1FC43461
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014E4611B0
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbhEQQor (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhEQQoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4862EC026CFC
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v6so7875039ljj.5
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05utSWV2L/QiUJh2+Jr8LiKrgu2RAKe6xUFhGGiDPWs=;
        b=j4AHLKXEmhXs0tmlcL8DZOcRRRZmy+ClYBsX054nl/lyFiNF1qBk3DsAv5WjwhA/uM
         tRVa8b97Kh5mFAYOdnUEs5DVPEHjmE8S+FdNXE5FmAMKcs4/CYQeye9i3FnBKQ50otLD
         ac9xCln0IaBF5q9Tuz2e+YQHS8KvEJPtQ+RQlmqxg4GgpHkg7877SNEXNzf4xnp9G1K1
         MNLOmZXq4f3jGtSvRDXX52Wd11jD0Lfm+4f+DUek/UALPxw8tmYYjomB8wgeNoK1puLL
         vLAO6ggZZt4kohzHL42t+M6PWLSQfQs1XP5Exb4rLFjnb9rRqcPfVbxx+AnLtaWeTBnF
         XLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05utSWV2L/QiUJh2+Jr8LiKrgu2RAKe6xUFhGGiDPWs=;
        b=W0YLLcwMmmZOF6WOlKPJawKfpe4rCq41xof5EN7FjvvGMyGZ5CM1/cY4e4QdkuNxw+
         0yoq6a4V6r2TGrzfA4jLaseKZ4ydI2XKOTz2UStxZ1TgKxlkWMzcarPogH8z9frU1HA4
         XIKGf2aN5asLn/uBDs807gpOR7CrPms5e1U3evcIIXxWBUGLW3zVCvOMMa34/U1EsAaB
         HD2ebKOziF+mZYs8cdlR39kdO8jLAy+//P6lbndVCbbOP/mApk8ibZMoGHPWYUHLuZSf
         WldGP7kWVnJs12r9odmgo6FXlShVxyoALNEQQ1t8b2ph0mZlQLKoCroTSiwfR2vuaV39
         lQzQ==
X-Gm-Message-State: AOAM532O2r+OhfNlJ12ULujjKHXDTkw60Pc5Y8b9vQX2XQZKDNr9DV2e
        eV8M7X+UHNoweYdTJ5YjIfc=
X-Google-Smtp-Source: ABdhPJxSI47H26h2Gx6M6uoXMJ9u5PDaWlVX49MKgOKUvhCoxcKEJw1QfuTJVOO7WThLP42/42oqhQ==
X-Received: by 2002:a2e:9615:: with SMTP id v21mr128438ljh.184.1621267121871;
        Mon, 17 May 2021 08:58:41 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 4/9] t4013: test "git diff-index -m"
Date:   Mon, 17 May 2021 18:58:13 +0300
Message-Id: <20210517155818.32224-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-m in "git diff-index" means "match missing", that differs
from its meaning in "git diff". Let's check it in diff-index.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e53ca7aa503f..c35cc73d08bd 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -493,6 +493,19 @@ test_expect_success 'git config log.diffMerges first-parent vs -m' '
 	test_cmp expected actual
 '
 
+# -m in "git diff-index" means "match missing", that differs
+# from its meaning in "git diff". Let's check it in diff-index.
+# The line in the output for removed file should disappear when
+# we provide -m in diff-index.
+test_expect_success 'git diff-index -m' '
+	rm -f file1 &&
+	git diff-index HEAD >without-m &&
+	lines_count=$(wc -l <without-m) &&
+	git diff-index -m HEAD >with-m &&
+	git restore file1 &&
+	test_line_count = $((lines_count - 1)) with-m
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

