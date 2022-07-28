Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66398C19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiG1QrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiG1Qq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:46:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E65FAC2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:46:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so2983282wrw.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TkxC4OT3VRbvPXtE8vuzLvY0VtVIFj75g9u6pKhTQK4=;
        b=ExvKtc+QKu1EsOtGhtqqQQP1nJHBA7h3p9XjFMbbWWChrrB/0KlAmvMtorAEUOFlP5
         4OqFwPV8DqAY/lq4DKrN9NvxEDqYhz734rWHVYK31GUA4Nt8BNzbFPsA4uqOiK245fZU
         Hz4tfcyxU/Po80mjM3pA0gQ8OLSzn7De1Pt47+a9DAlTaI6JOBWIAQLtx5OxA13hI4Ii
         auMDweIUw517//olONeY5RT+W2RSmpf57Nbv3Uzya2MBEhrssokUAaqd4+DopFVaUOYb
         qBbOc2I8hNwhWET4BHBxGh+dDsIb84/Xqhh5Ad6U9KIKv+JTtEH6P5tHsnZmJY0qJLHy
         SNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TkxC4OT3VRbvPXtE8vuzLvY0VtVIFj75g9u6pKhTQK4=;
        b=YVAmVziBIdc/PAv0F+RHqREhk9lAx/BEHaPmJvSamHhCY5ntjp1zlvBZuChZ6qF9HQ
         4h0xCg7ncMbhHcSzCnkTntaf3FPlaL4ajWJ+hvLF7Qf1wmzh6hECV7gN6hnvjWdOIeYz
         LKa8LQ1jm9zuXj3AaHNt1jyN2P3MXp74XfkU4D0qsTqfXTnQV+ojd1mvCDYhj0hxVrN/
         tXPiu3dyTlm3Ktb2UA2Zm4bbSS3uRYHjqPlytjis5wPheJO7NWDmX+T36rSLd9NzUUv1
         tAnh/zqiYK805R7QJ/VDGpIT1VWNvjN0z0pRIloIaER7hKH/OYHJkcVrPJmYVohk/ek2
         rd6g==
X-Gm-Message-State: AJIora9kR3RvfPNpvZvQ4JxPsvvubG9KfPW7ULQQAPsNmWbEsF9iX2dA
        5UzDyzoqmT3GeAG+2DO/ldRoBBVoQjT0Rg==
X-Google-Smtp-Source: AGRyM1vexEpjr3FozttJAKULUpVOO91XRw7Km5lUvs0JBn1UiQqf5dLqdN2EIgobV24YnBxS1DK9SA==
X-Received: by 2002:a5d:6e05:0:b0:21e:ff2e:e378 with SMTP id h5-20020a5d6e05000000b0021eff2ee378mr2460957wrz.190.1659026811930;
        Thu, 28 Jul 2022 09:46:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0021efc75914esm1495403wrt.79.2022.07.28.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:46:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 1/9] help.c: BUG() out if "help --guides" can't remove "git" prefixes
Date:   Thu, 28 Jul 2022 18:46:40 +0200
Message-Id: <patch-v6-1.9-f3588319057-20220728T164243Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 929d9192828 (git docs: split "User-facing file
formats" off from "Guides", 2021-06-04) to be more strict about the
prefix trimming of the "guides" category.

There are no guides in the command-list.txt that don't start with
"git", and we're unlikely to ever add any, if we do we can remove this
BUG() invocation, but in the meantime this makes the intent more
clear.

While we're at it remove a stray newline that had been added after the
"return name;" statement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 41c41c2aa11..80d516abb0b 100644
--- a/help.c
+++ b/help.c
@@ -44,13 +44,19 @@ static struct category_description main_categories[] = {
 static const char *drop_prefix(const char *name, uint32_t category)
 {
 	const char *new_name;
+	const char *prefix;
 
 	if (skip_prefix(name, "git-", &new_name))
 		return new_name;
-	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
+	switch (category) {
+	case CAT_guide:
+		prefix = "git";
+		if (!skip_prefix(name, prefix, &new_name))
+			BUG("'%s' in category #%d should have '%s' prefix",
+			    name, category, prefix);
 		return new_name;
+	}
 	return name;
-
 }
 
 static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
-- 
2.37.1.1197.g7ed548b7807

