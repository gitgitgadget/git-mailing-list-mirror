Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F987C32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiHUOCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiHUOBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914D2315E
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h24so10290245wrb.8
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/BXkNIZuQZcqwvR1YS6WwXCh2UDmC/R30dGiRyT55ug=;
        b=iVdRHTOIUgDZlh3zZuDbRaAqeYTcTVElW2dmjsCFfP31Wc5pBbBLkG+H/UTH19i7Os
         pdSRwwMaJzRGLiCf+l+nIqxy06yY0X0gnP0tHAUg1GBmLQuuFT0yLIFXh9XWncfD8FT/
         Ko0rNLZszo4DETaPKASXL7x23rRFNLg6PjCmJMMXoro0U82IIsT4OT5TWsskgmCUZy7s
         lVIua6mFn6jwXCsDDwGvssHuO48sMwK8t52V9rWp5mQ2nYlR1jd0dVLOjYxYddNWWw/2
         Ha+48AxuphyLObFQdBDYJNPz2x4MeQBSUYflkit4mUyyofc0Cxr3A+rG+WutQoyWMrJr
         QxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/BXkNIZuQZcqwvR1YS6WwXCh2UDmC/R30dGiRyT55ug=;
        b=LF9kGwLsi4j1ybok4nDTJrEEX1q2Q38KssLnV9eabyAjzD1j6FCje7di0wjXMMq/I3
         0q7svghqYRsVhk7dkDG9QToc+6x191rmwlOgbyfTRwG4qDW0CgNMvZc3UcJMceZu3y9p
         naVLoqq8OEpRWbKx/lJF7fdiSVGJxWEdFS2g8Jh1UArETJgf5d1jfMcJn/tzYEGIoY3o
         GezKNXa4GkGbNkaMW2aF5I4GKbLoRJvDPHJ67DqJVzescKwKBoiq5J889wkptAXQ1Zbv
         qMLYPtZFscTlU5EVMSd39KqqMd0yjqobKel5OuWHPmxYFLlIKvRUSODDqAaBtTiXPEO6
         XsWQ==
X-Gm-Message-State: ACgBeo0ZTs3LdUmulPghpDcrWPhOPFaiRyRqgnDbnf1bE74dNLiDRjVl
        R7Nz+3o4+u90j6rwjlMxAaYdkJv+7TJAmfzn
X-Google-Smtp-Source: AA6agR64eH5jaKD+8N3WOwkbIj1FCTQBAe9Ik1XsyfgRlUf/lrI7q/C8jQWBYUbKTBDdWeNX7TaDcg==
X-Received: by 2002:a5d:4305:0:b0:225:55ed:9654 with SMTP id h5-20020a5d4305000000b0022555ed9654mr1267282wrq.709.1661090478038;
        Sun, 21 Aug 2022 07:01:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 14/17] submodule--helper: fix a memory leak in print_status()
Date:   Sun, 21 Aug 2022 15:59:38 +0200
Message-Id: <patch-v6-14.17-38ceb0a36ab-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in print_status(), the compute_rev_name() function
implemented in this file will return a strbuf_detach()'d value, or
NULL.

This leak has existed since this code was added in
a9f8a37584a (submodule: port submodule subcommand 'status' from shell
to C, 2017-10-06), but in 0b5e2ea7cf3 (submodule--helper: don't print
null in 'submodule status', 2018-04-18) we added a "const"
intermediate variable for the return value, that "const" should be
removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8d55090ee2e..e75d7fa2e10 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -583,10 +583,11 @@ static void print_status(unsigned int flags, char state, const char *path,
 	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
 
 	if (state == ' ' || state == '+') {
-		const char *name = compute_rev_name(path, oid_to_hex(oid));
+		char *name = compute_rev_name(path, oid_to_hex(oid));
 
 		if (name)
 			printf(" (%s)", name);
+		free(name);
 	}
 
 	printf("\n");
-- 
2.37.2.1279.g64dec4e13cf

