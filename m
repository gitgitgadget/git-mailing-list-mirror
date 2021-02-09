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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08842C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1D864EAA
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhBIRft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhBIRec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:34:32 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F77C061797
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:25 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o38so1382357pgm.9
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Nk4q5nd/LypvBzcY+V6YogEme5FDVDhjyQE1s1sJCLE=;
        b=tU+oN6f2MOa+WlLwcg92pN0ihqwBb9bM8q2dlPJwWkuOA3JLIKi5H806j1qf/0zPh7
         uSHI/uCtfKIiQLpqIhTJK6OUuywgKuYvIEd93x4kvfvO6TygOfwJBsa9m12okyGsJ32p
         SX9iLqA42/UQ94borumGItK6cezK4rAZoUWnDmF89gvutAff21xmsCs3bzlYlEXN2qcc
         PQd/GHAIGb0B2k+Qa2OfKyXYpdW1feLoVTY8+Wpnw8m22ak2wyQdShECmklWxp9a40WF
         VIoevhnhHCMr8SFK7nIx70UPfoOR7bdYX0k+OHb+VifBGK8nEFZ8liL7z5YGnPCDOZFh
         SUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nk4q5nd/LypvBzcY+V6YogEme5FDVDhjyQE1s1sJCLE=;
        b=Ao8grYvg5T8C5xnvZy+VICVlzXQhiN7+26HTCuMzTRuTwNrQaSj80luxoYwZyxzHn5
         PY+u18NXkdwzzfySld3oVBElqlQyutzIoNdH8VXbH1e5AzyPpY6rES7qGSnVaKFVgG2/
         XWs40q/1yYz6a0eV08K/2gBuA3ii6jDBhaevwDGMdTrBfInvm1ibPhVyurHNVkY939xc
         DCyJHHrzQ087G6YemoAlYMRAW+0sIpSEAGfQRRQApNPt8zjs79Np9c3w29UKgLkdlvBj
         s9rc9ngTsD6ehGaP7LtqJMmK+pOo64ju2mzT8ZZoIs9oUvmQ0HGogJ18jjLh4CmNLFKu
         gmFA==
X-Gm-Message-State: AOAM533J8CGnJjWKs14QaFeIBkHqnnDUbI3sS70q01ad/JH8Zeh12/59
        7WLgqGtdxfNmv5Vsl7WW9TdAPrlaO1cjUg==
X-Google-Smtp-Source: ABdhPJwumvVl2vUEAQSRbVAAWsZ0OiQAQH6VvRWl1WqN65b92bbfb/P2li/Aym/7jiugnWslFOuu3Q==
X-Received: by 2002:a63:1d1c:: with SMTP id d28mr7830080pgd.216.1612892004426;
        Tue, 09 Feb 2021 09:33:24 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:23 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 10/10] t7001: use `test` rather than `[`
Date:   Tue,  9 Feb 2021 23:02:54 +0530
Message-Id: <20210209173254.17712-11-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, we should use "test"
rather than "[ ... ]" in shell scripts, so let's replace the
"[ ... ]" with "test" in the t7001 test script.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 2e2e60e0d3..002e188549 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -240,10 +240,10 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	git add dirty &&
 	entry="$(git ls-files --stage dirty | cut -f 1)" &&
 	git mv dirty dirty2 &&
-	[ "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" &&
 	echo 2 >dirty2 &&
 	git mv dirty2 dirty &&
-	[ "$entry" = "$(git ls-files --stage dirty | cut -f 1)" ]
+	test "$entry" = "$(git ls-files --stage dirty | cut -f 1)"
 '
 
 rm -f dirty dirty2
@@ -330,7 +330,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	mkdir mod &&
 	git mv sub mod/sub &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -350,7 +350,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	mkdir mod &&
 	git mv sub mod/sub &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -367,7 +367,7 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	mkdir mod &&
 	git -C mod mv ../sub/ . &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
@@ -386,7 +386,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -407,7 +407,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -425,7 +425,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	git mv sub mod/sub 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
-	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
+	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
-- 
2.25.1

