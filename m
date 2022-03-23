Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B6FC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbiCWUeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbiCWUeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC78C7FC
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso1553304wmr.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rlmQLEVr8xLFPyX9V/i4jPu+ZINxT5NasGNuK62l/T8=;
        b=Fb9t3N2R/h8Fw05O8RuYbn5AB3gi4+r1/Wm3j0veY+NvpIpWf8/LShUXbKpQM5Rvym
         +uqTbohMh2L0SHHOxNOoBpH9I1u88GGp14E3JcKvFpPXCL3OtsjydlCDo9a/ejanqhJU
         k+hbmrsmD4WvPvhcTwaJSM54UujxtJatiyxWqN5eVmt+ufYWwkWa3meirlnYe39EM5aL
         6pYddX+p/vSNTGPlMQ6n2b+9wNZ7ZA/DXgwsdg0ymrTjPqlIA/IMSme+m0LU87TQfJSz
         iTQZviq+K+hR6zm/Io9VevS2ayGXifn07Z3rk+cecU0TQvvW+C7BhZckdZ+EhnX1Y3vW
         4lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlmQLEVr8xLFPyX9V/i4jPu+ZINxT5NasGNuK62l/T8=;
        b=nkIlONtDJgjwypydjN2IuBjmpCeWxQ4q1N60+aFmyJRaTWbFa2JQmnRdBLgnnCwXxc
         OaWmel2sxGktnlOmI8JUo1rrAIlmEYzv4bB4NG3PM0r4RxEsNRV+Wfev9qhWQjQ+4Axq
         ILiqpEjnXSlmPAI7qdNUyW06Og7raCWrihTGdK+ODxCMVDE7gtOkI08TUfZX2CJGGteI
         UfKF0KM22tSw30CM4EIaCpoe0vG/oTcZeXvPI1Bsaupz92o4uN/6TP+jSKwqkUZEYJD7
         DeUyIEiORH+fCda9wNhv7EO5z8c55Wnn/vkLLavoe0gs5+2AUkORuJfBsZbnbvVLZkU8
         iieA==
X-Gm-Message-State: AOAM532RO7UdZ2728Kvaki+AgIe71w1AhD0S/wzl2eyFK53W/vefGAfg
        aKbGmKLmWwYkGiWVYU6GLyZ0hw6/8wQfMA==
X-Google-Smtp-Source: ABdhPJxnVSBEuzrrSyyyLzC9NDeWvb8mgrm+xvE2j+l4l7dJEIvRYpmcZ5p9kq1rSspeNZQ9GTcMJA==
X-Received: by 2002:a7b:cc87:0:b0:38c:b60d:2320 with SMTP id p7-20020a7bcc87000000b0038cb60d2320mr1774023wma.82.1648067558991;
        Wed, 23 Mar 2022 13:32:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/27] revisions API users: use release_revisions() in submodule.c edge case
Date:   Wed, 23 Mar 2022 21:32:04 +0100
Message-Id: <patch-v2-14.27-38f4f1c4ecb-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() on the the "struct rev_info" in
show_submodule_diff_summary() where we need to pre-initialize with "{
0 }" to make sure that we won't segfault when calling
release_revisions().

Most functions that use "struct rev_info" will call
repo_init_revisions() early, which will do an equivalent memset(). In
this case we might "goto out" before doing the equivalent of that
operation, see the "goto" on "(!left || !right || !sub)" added in
8e6df65015f (submodule: refactor show_submodule_summary with helper
function, 2016-08-31).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 0510cb193b6..285c1896c9e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -638,7 +638,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
-	struct rev_info rev;
+	struct rev_info rev = { 0 };
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct repository *sub;
@@ -664,6 +664,7 @@ void show_submodule_diff_summary(struct diff_options *o, const char *path,
 	print_submodule_diff_summary(sub, &rev, o);
 
 out:
+	release_revisions(&rev);
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	clear_commit_marks(left, ~0);
-- 
2.35.1.1452.ga7cfc89151f

