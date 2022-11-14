Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD3C43219
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiKNKJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiKNKJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F48D13DCA
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f27so27068529eje.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USo0Fm+m8TjrOSn37SA8tzocXlOIslLiowmTEoh/pZc=;
        b=mn0O0wAIUxN2i7wLBnZNlPTGAK0hgHtAEKaqAaS7+r7lS0ZJMH/oZ01FDI+KQlUgwP
         5/klX2tZ4Au2IMXQsg846HA90c1RNMqJ/zMoI0K+u7QI6QiKC7c2HqnJ3p6ZF5/HBBPt
         c9AkATrTu4aDvtzXYxPJjcZzrf+nFGylNDO8EuhvcHPj7dfSysYDXkb5dhLTH0lwt5KO
         8f7uokS0BwzhLM+Bfk8M4hzugwKwBjjD+7GvJM/H14eUugR+IGnrkAiwHCw7RoFqPowo
         w0YDC4wbc+nma6LVtSIrI6KN1VC369J0oT8/4KE1wxSM+TZBlVEc2Gk19a6Y09oNho5w
         bJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USo0Fm+m8TjrOSn37SA8tzocXlOIslLiowmTEoh/pZc=;
        b=P//9JCgtMonyAM0Ntx53D+y5nZ7VNr4YdPpGHcRt7345diW8dy/nx1UOxRT9JkSdDp
         YH+ietM9OuqIohePeEKnnz4Xl1unZ2kBJOoNFpMj55GvFn9Xe5HFwQcyIAwDSEudRrVA
         vrfwbwiF3ku89Eu0y6HGPBmkei/qkYMGy7bVyZm0molnieoH/jQodwsJFHC+BydbJgQc
         c+IQJ5jykJ92wpNO05R1LL4HQd8746aQ+3C0UJ/eTqJ4aXxfuAqn0w6CoU/0yS9KdGMW
         0tkMei0LsX2xFfgRNDkhnnUa96Fu1wQwtFbILCEYrQ7nLS38qRKvIRLRs9aUNiebtbrz
         gP0A==
X-Gm-Message-State: ANoB5pmBhTsEWT7W56t1G+Hfy8LVqmizpzLW0oStkiWuL/NUFiCkxLRu
        hpsp0eb3o1/THpWH6JCkH62SHhcvQryPtQ==
X-Google-Smtp-Source: AA0mqf5YPNKHtilqQ1P5iC95HON7lT6FL1/ia8VGPjTtJzEWFy4YZW8MidnhCNFETbvAWzio6+NIhg==
X-Received: by 2002:a17:907:c78d:b0:7af:113a:7416 with SMTP id tz13-20020a170907c78d00b007af113a7416mr659503ejc.16.1668420537791;
        Mon, 14 Nov 2022 02:08:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:08:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] submodule--helper: "deinit" has never used "--super-prefix"
Date:   Mon, 14 Nov 2022 11:08:43 +0100
Message-Id: <patch-v2-03.10-a7a1f9487dc-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "deinit_submodule()" function has never been able to use the "git
--super-prefix". It will call "absorb_git_dir_into_superproject()",
but it will only do so from the top-level project.

If "absorbgitdirs" recurses it will use the "path" passed to
"absorb_git_dir_into_superproject()" in "deinit_submodule()" as its
starting "--super-prefix".

So, let's introduce a "get_submodule_displaypath_sp()" helper, and
make our existing "get_submodule_displaypath()" a wrapper for it. In a
subsequent commit the wrapper will be going away, as the rest of the
commands here will stop using the global "get_super_prefix()".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 427e793e204..c4d5e029b37 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -113,10 +113,9 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 }
 
 /* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *get_submodule_displaypath_sp(const char *path, const char *prefix,
+					  const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -132,6 +131,13 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	return get_submodule_displaypath_sp(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -1365,7 +1371,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	if (!sub || !sub->name)
 		goto cleanup;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath_sp(path, prefix, NULL);
 
 	/* remove the submodule work tree (unless the user already did it) */
 	if (is_directory(path)) {
-- 
2.38.0.1471.ge4d8947e7aa

