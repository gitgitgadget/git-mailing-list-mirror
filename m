Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3519BC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123CA22CAF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5Kdgoft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHEXHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgHEXHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:07:02 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952A1C061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 16:07:02 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id 41so27669510plb.23
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 16:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FAyVPvJu1WMhX0Rbh6CNZ4MCADqexJxcUbFl3cE+jqA=;
        b=o5KdgoftY1J9Z3xQkvt0r+VwvgaakDqNHlnWW4PoSlGv+s+3csDVSsmoylZMP6KSy9
         TACiZ2iJl3sGgeC2fGndTUWAvZxT4km3Lj1jDfUHcIJB9SQB/JkPqXVcGnUdvfBie9/u
         0KIQsGr0O55P43e3Myu+sly1bXDs3J8YPBHTWVDCy15gdKhBmrK2uz4vpAQwvwTVu6w9
         63t/rvGq1pi7WghKwK1HugtOVb0fPqqCbeMLoWZucq04GqCVxrF7uLrMwmgo77Zykwrl
         2IkDKtnAxN2W1CJnjvIl5uWSE8mrWmX0gc7IEuZSYlI/WPenAy3xrg7B3qsYy6pdvre9
         4pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FAyVPvJu1WMhX0Rbh6CNZ4MCADqexJxcUbFl3cE+jqA=;
        b=orbF9tr97PvdJEKDxNFk9GU2RoSM9yiFTRnciq0MdPjICqw7rFZmjXmHhBe4vLXYxL
         y1DMecze3jGBtBL8OU06kYXzCHkstO3eo3QgXoZ5JgQ9KC7s7mVd21wx45WZTY7VBFIm
         3ALTb7ZWdzfildhJGXX41m0MShj43xH6tFXnTD1N50hHtCR2Rxv9cBa5HNke/gmXv7xC
         6S6pBMYnWh69yFNKQ6O0ox2bt8Gu8G1eMt32z/5bO1VDMq1CEKJUS48/93DiD5RYCceG
         oT9YfcxMvAPwDFQSvhHs8H3rN3RbxZwOZlIrzsL8uhL14KiOZY0zHKCy3DoTUCvVIB3j
         5xwQ==
X-Gm-Message-State: AOAM5322k6d/u7IAcaQY9XAJc1Y3fqjbkryjjn9AizRoxRudkd6qAgRW
        Wc9hCjieaQSrlX5WRmtbJpqOhhklGXmPwMr9LvMKEx9k3pN5DWGgdsxjpzd0MamqG3L7mlpLiyT
        xVcUzpuXbcnWLYhfkW3MDRNBZZU4wZ5E3ebdfVSoFBOYMUt6NCEJ+BJ3rClb4C4HOI415yFqNmi
        8+
X-Google-Smtp-Source: ABdhPJz+YhFveAUi4AQTV4O5Ea97c5u5VnhVGmrIUijDjFqJbwPaKZ9lJmKFG2nqohb9DTYHj1V3s/PTesdrf7Y/0VnM
X-Received: by 2002:a17:90a:1a13:: with SMTP id 19mr5013069pjk.167.1596668820567;
 Wed, 05 Aug 2020 16:07:00 -0700 (PDT)
Date:   Wed,  5 Aug 2020 16:06:50 -0700
In-Reply-To: <cover.1596668156.git.jonathantanmy@google.com>
Message-Id: <fa09987fb010042fdcbd3ce539b783b92bb640d6.1596668156.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200728010403.95142-1-jonathantanmy@google.com> <cover.1596668156.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 2/4] apply: do not lazy fetch when applying binary
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying a binary patch, as an optimization, "apply" checks if the
postimage is already present. During this fetch, it is perfectly
expected for the postimage not to be present, so there is no need to
lazy-fetch missing objects. Teach "apply" not to lazy-fetch in this
case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 apply.c       |  2 +-
 t/t4150-am.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 8bff604dbe..402d80602a 100644
--- a/apply.c
+++ b/apply.c
@@ -3178,7 +3178,7 @@ static int apply_binary(struct apply_state *state,
 		return 0; /* deletion patch */
 	}
 
-	if (has_object_file(&oid)) {
+	if (has_object(the_repository, &oid, 0)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bda4586a79..94a2c76522 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1133,4 +1133,20 @@ test_expect_success 'am and .gitattibutes' '
 	)
 '
 
+test_expect_success 'apply binary blob in partial clone' '
+	printf "\\000" >binary &&
+	git add binary &&
+	git commit -m "binary blob" &&
+	git format-patch --stdout -m HEAD^ >patch &&
+
+	test_create_repo server &&
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:none "file://$(pwd)/server" client &&
+	test_when_finished "rm -rf client" &&
+
+	# Exercise to make sure that it works
+	git -C client am ../patch
+'
+
 test_done
-- 
2.28.0.236.gb10cc79966-goog

