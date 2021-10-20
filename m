Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F78EC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5279D6109F
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhJTS3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhJTS3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:29:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE57C061749
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 186-20020a1c01c3000000b0030d8315b593so3503479wmb.5
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=585MeI5T4HKkL1g4/bEtwEKVAkTW22WvWZtHm617jsk=;
        b=E8vbnXzOQ4kCvrSnyaq0e6E3nBpKBnUt1hl45ynjZM7REAE4DbbWt6Gn8V5EYqMy9w
         brVqZSGJfJGnbYAbheOPx6ASefr7FYx5QjxjLm4RKQGn1MBdQ/4iO7Ki8WoIDLvnqo9l
         TS7RqDeVD48Ztsz7etJir3UAJESAQDAJEbguxypbMPOnxpnQD3PitMDLt2QddDHpJS2d
         NqoRiCUiBkyPz1u0RxwFAwyjr0s1yT2+/GVVYQ3GTBCmVmB5F+WAxXBtUtHdS2FRa3zZ
         6qUTweGqPVgkMX8yLjUWfZmAedkS3PIDki5T+tABm01nLJnQDmZKLBpCzM3hjO4ZkBB/
         UQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=585MeI5T4HKkL1g4/bEtwEKVAkTW22WvWZtHm617jsk=;
        b=0sc/RnibZkgcQYhD+y781iTuQYUBf0QlMIKNwS9Xj3tTh/aLRPYMgokBGHrShgZLr0
         j7HW3Nb2gvou0Ei7XC24x+21xIUMzGqITUy8LtAgH0K0rUu5elVude263IXUf/LGZNJU
         c522Sa3OKTheq4VZpF7E2PAx7e/SMA+vY2NhZ9vhAXA9zUc1mfqWHvEjHWFxoUzjJK0H
         z6x/PXqJd9zyyrJpkVMHU4nXG6t2+Nbr+SEWulkbUsYLRAEpTKHJ2fGQ/SftZytmzaTt
         dtwg6gXcEF48aBPRVIF2ULTYXGxhCQBJ98XfVwMReWtu0b8/n4BSf9HVA/jamXWjY+cJ
         x8/Q==
X-Gm-Message-State: AOAM5302ZXHUkjveGxAEBprmtKrfCndWURyyNS2ixrAeoa+4cJyBuBAk
        FoaHZMCCitBRvveIMwHl1MY1dzuUjsZaug==
X-Google-Smtp-Source: ABdhPJwJKCW/3CQBcUrVXDRh5WXVQ8XuewnWmswKpuPffILYWLtTwh9qtJCTJW9OSkJ32dvwzcPBlQ==
X-Received: by 2002:a1c:4484:: with SMTP id r126mr15613660wma.150.1634754448893;
        Wed, 20 Oct 2021 11:27:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm3091093wmq.41.2021.10.20.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:27:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] ref-filter API user: add and use a ref_sorting_release()
Date:   Wed, 20 Oct 2021 20:27:20 +0200
Message-Id: <patch-2.3-07062ca276a-20211020T182516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.3-00000000000-20211020T182516Z-avarab@gmail.com>
References: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com> <cover-0.3-00000000000-20211020T182516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a ref_sorting_release() and use it for some of the current API
users, the ref_sorting_default() function and its siblings will do a
malloc() which wasn't being free'd previously.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-ref.c | 2 +-
 builtin/tag.c          | 1 +
 ref-filter.c           | 9 +++++++++
 ref-filter.h           | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 642b4b888fb..16a2c7d57ca 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -96,6 +96,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_array_clear(&array);
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
-	UNLEAK(sorting);
+	ref_sorting_release(sorting);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index ad6c9855914..6fe646710d6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -630,6 +630,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		       find_unique_abbrev(&prev, DEFAULT_ABBREV));
 
 cleanup:
+	ref_sorting_release(sorting);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	strbuf_release(&reflog_msg);
diff --git a/ref-filter.c b/ref-filter.c
index add429be797..282cdad1036 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2705,6 +2705,15 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+void ref_sorting_release(struct ref_sorting *sorting)
+{
+	while (sorting) {
+		struct ref_sorting *next = sorting->next;
+		free(sorting);
+		sorting = next;
+	}
+}
+
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_filter *rf = opt->value;
diff --git a/ref-filter.h b/ref-filter.h
index b636f4389d0..6228458d306 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -127,6 +127,8 @@ void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
 struct ref_sorting *ref_default_sorting(void);
+/* Release a "struct ref_sorting" */
+void ref_sorting_release(struct ref_sorting *);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
-- 
2.33.1.1338.g20da966911a

