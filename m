Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBEFC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B516B61205
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhKJBqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhKJBqq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:46:46 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653EC0613F5
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:43:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f4so3827290edx.12
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYTVApSzvo6rij7Ku21eXe2bY2z0lyyjIwpnjfawSeI=;
        b=jeQ5BLSRJYWMVoLetTHHQBJMwNhljyfjEfPLSxB3qXbQgds1wDFtwM7Golc4xlhskE
         NbIKZOkvPpCaixBu+ZVYapDMoeVqL3FF4CeGK8gXqTG8vvX+iIYCaajBYmxpDdT3/2Ij
         oeUfg46h+1EYf5QY1b2o3N6n2tX9igQ0sssZSkefh4WX/HTa1vnUZeTtCpHGYqjaXDno
         bw0joH9Su/qfg+Uk6QCrA2Z9ryrwo2bz6L4A2pzoLGN6zk2ms/8DuGcna1VGThwbnmG/
         //yuTtT0LkzeO9uTj8JkY7YuVVZ4Vn9e+Frvco1ONcEdZZbOOQUx8npME5UwW3QBxE1x
         nXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYTVApSzvo6rij7Ku21eXe2bY2z0lyyjIwpnjfawSeI=;
        b=ThcyQO6zaWAuvs64pDGL4lMvas+QTLy0KcT4YuA3Z6ObkubBy73Nib5wurcVjee97M
         ELSz9HPjQcN4tYPOotSu7BDHI1owy89ex8KN42aeBOsQpD6joCxkuncUniTSdG7/snv9
         I/y2XcHsgb4T6putagqH7NBYzde4JWbQFHmYP02MVlXpGWtG06/cj3qDrxq9sArA4N3o
         WzUhvLXbe8uUB7EO6+yttzTVCt+xFbG4xlD6KOozhaZGD9F9pMkkJcnuvsVLZ1IQIZ79
         xK2vtGV46R2CGEO0xKQ5Di22ZXbAjokUUasCn5UJxzZOJ7QxaIVfkBgg+CfX7vYc+3Wg
         xRIA==
X-Gm-Message-State: AOAM5335aFfAHkq+wwub+fc+DnuiSNKWK2xDTvxeL8lGr6678h0oSGtD
        QAUsBWJB87E2CRBXYQ61oAg4bIsVZE0fVQ==
X-Google-Smtp-Source: ABdhPJyWx0MV1DEh3Jcbv0ebNpJhrWxjNLf5njU+Mc4nQi+XQWBF10g7/gTort9foDzgKkm2O0TiuA==
X-Received: by 2002:a05:6402:438f:: with SMTP id o15mr16500228edc.235.1636508638067;
        Tue, 09 Nov 2021 17:43:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qf8sm9369252ejc.8.2021.11.09.17.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:43:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] grep.c: don't pass along NULL callback value
Date:   Wed, 10 Nov 2021 02:43:47 +0100
Message-Id: <patch-v2-5.8-d0f0ac6c7ae-20211110T013632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() top stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.34.0.rc1.741.gab7bfd97031

