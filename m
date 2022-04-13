Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD23C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiDMUFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbiDMUEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A897CB32
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m14so4172167wrb.6
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmK8+zC6kJ13KICrtg4WkxHtH3v9Bphmr7dWkSKJcao=;
        b=OIFIEF4egTVqjRs0vo75q0PDezCzf0fIjOBbGIUa/LnWvVyZSZrI9XsSref9C6+Q4c
         qU8/isVDFajLAO3pm1I3UQ3HLFQQtAPgO1zsf7nQ23yjeaoGuZzn7hsW6O9CdEOuwJkH
         7s5TKly8Yq7X/oTCNIyahZaAmbqLj04nCB40x6vLEVyl+Ab6L0jMXUmREr+J9oui69xE
         3MR6eHlKGVRvbBjuP22jbIUO6lAWtQ6CJMzmVAZVGGc53YWFB2mA9SvY78D0uAmM/WYc
         1olxzslb/3pBTtQequwgHZBfTGRx0VnhB1WlVaR5Egx8lRwfLSkBPONMtJELCyFOPCwH
         F6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmK8+zC6kJ13KICrtg4WkxHtH3v9Bphmr7dWkSKJcao=;
        b=h3gZx3xiVTBTD0/WHHOorQUhUt1CLTlxs+cNRh/1A/+f2JX0p5VdeLX7F2UDAZ+YAQ
         nJtzGX6alvwqRpPceDgJyZYCdkRl5MVMR18frg5eyRL9b7prWBk6d+hWm4ZDGioHhfBz
         YRXqm8JQkIooKa/xWb+bDplq6R4nBVlV4kVDgebD4gEOq1MdHlYGx4hDDapdX6GxIvtc
         w2heUX0mPjHi7lhb9WZcJkMYal0qadc/ENv3icUgx8eApvhyYFSSpUw+Ps+WIlKfIo0d
         Z2j+jDGw4Hlzrc0dJzYNtsDEmaPItOEM61WrBA8C0/IhJFlK4RfzwW4APmMi559POAIf
         Te7g==
X-Gm-Message-State: AOAM532Y3GGwV6EdSo+LYgMgpmRp2GP2acu5ZECexrCwj+SLTuzIqWgs
        BGdX9JMrJNF3EzS42EB8iduuIfB4BiUCbQ==
X-Google-Smtp-Source: ABdhPJyZp1Lf0oojlWFKMKpDh+XYjWg+LCVfTEYlNjf3CHbuaPrGQ78afHzX9JQTJWDinu0iE4sttA==
X-Received: by 2002:a05:6000:8c:b0:207:a4dc:dfab with SMTP id m12-20020a056000008c00b00207a4dcdfabmr335434wrx.441.1649880134089;
        Wed, 13 Apr 2022 13:02:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 14/27] revisions API users: use release_revisions() with UNLEAK()
Date:   Wed, 13 Apr 2022 22:01:43 +0200
Message-Id: <patch-v6-14.27-31ce58da43d-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a release_revisions() with those "struct rev_list" users which
already "UNLEAK" the struct. It may seem odd to simultaneously attempt
to free() memory, but also to explicitly ignore whether we have memory
leaks in the same.

As explained in preceding commits this is being done to use the
built-in commands as a guinea pig for whether the release_revisions()
function works as expected, we'd like to test e.g. whether we segfault
as we change it. In subsequent commits we'll then remove these
UNLEAK() as the function is made to free the memory that caused us to
add them in the first place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-index.c | 4 +++-
 builtin/diff.c       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 5fd23ab5b6c..3a83183c312 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -71,5 +71,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	}
 	result = run_diff_index(&rev, option);
 	UNLEAK(rev);
-	return diff_result_code(&rev.diffopt, result);
+	result = diff_result_code(&rev.diffopt, result);
+	release_revisions(&rev);
+	return result;
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index bb7fafca618..dd48336da56 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -595,6 +595,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	UNLEAK(rev);
+	release_revisions(&rev);
 	UNLEAK(ent);
 	UNLEAK(blob);
 	return result;
-- 
2.36.0.rc2.843.g193535c2aa7

