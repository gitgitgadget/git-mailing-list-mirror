Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F566C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiCINTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiCINTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC8D1786A3
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso2932293wms.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHiJnIvrZHx+9imn0V7zl5eJcSDu7XGSWtF+N+CTu7w=;
        b=C5ZNQ2U/aXabCiAPD6etzCSu2w4wzYcmCMJDeCbKqdi3uatGgGA/Ai5PfyarrnMWba
         my2v5+1gH/+Kw0Gvu0/0bH8iUGlE6ZnklZe0wURlh08OTjrvj/l8ia+xsiqItClq85hF
         y7IQ8tgu2SKKaSy9yOv4iKuToi2+m1xdYEEMdPJE1ZTKwdladoyllLl8CqMagDV2Cvpf
         AAkLSWDMur9sELqUFc3yXIJsWNaB0dAlrAnz/9TP7e+z69oiDZuiEfKZgZBwWQrFPjKx
         vMuNlENwYmSBoJxBguPLzvlLjwBv87uFF9CbZ6OGFy5IRHFskgB6kZLh+lB/UqDCyi4D
         pvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHiJnIvrZHx+9imn0V7zl5eJcSDu7XGSWtF+N+CTu7w=;
        b=nXqmPTm4Nv0y8QnKJk+XpDjzKyV6urfjSp0Qbk+Au8VVE9Ex9BGC9zXgbcw4MW94yl
         XSxbjUuqzy/8kag/2G2zRqh6mX++tdBgeo1YZ38VxGF2AVhU90zZyDQCqbgBayr3jjAX
         7yG8Fj6GSPvO6QZYeqaj3VjeLfRgFySOToYyvA0uKFyZd9d3tF4SFoDbiACSq/15naoH
         ofG9M+3xATBIJBF8t/0bp61m1ulzdB5IOwLUbVN9lO71Y5xxk30pj20EMF9MlWMZAC6D
         ShE5k+ImkbgnfxTjS7VpqB91lBBcwnrc9YGTmCISfb0c45NSz5s4ZcNFHekkRzM3kaeT
         L6AQ==
X-Gm-Message-State: AOAM5331cdU+KbQi5c7IzsMnJsmF/oiUBjng0Fl068rrv81GjUptBv1q
        koyC+K5DN1BXcGLGlQXmLmfzCX0CfU0HKg==
X-Google-Smtp-Source: ABdhPJzuoX8XfJaW/ooahb/QXKU9ILVqg0PjfZqiQJMnWBVM3oscoVHF95W75tkQw91GncYmSa/psA==
X-Received: by 2002:a05:600c:4307:b0:389:4f8f:f189 with SMTP id p7-20020a05600c430700b003894f8ff189mr3297972wme.29.1646831873627;
        Wed, 09 Mar 2022 05:17:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/24] revisions API users: use release_revisions() with UNLEAK()
Date:   Wed,  9 Mar 2022 14:16:41 +0100
Message-Id: <patch-11.24-a93c8838257-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
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
2.35.1.1295.g6b025d3e231

