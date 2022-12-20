Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F3C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 14:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiLTO3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiLTO2t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 09:28:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BD21C92D
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:27:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so8345355wma.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dLuQhOrH4UHx4Pyo9bw3JTCwRhtrlO920iIdnfWHhGs=;
        b=KOS5v0sOLAVY58jSJIi6mi8pK6Yck5tfT6jXK7fPGO3pri6a0ATWioQbZgz7qR5qx7
         1NOAXNqrL0JDJ1aldddwd4u3EcSHrE7C9EyGZSuBYW8mjT5bBrptN0j2LGelx9Kje8L6
         dVataUoLklIT9a4PLePy4Y39fl1yVn+vq/QxaZzw09WZuYDF7qX2l/xCcrqBFJPvNVYR
         TsrHf2cJabdXfxVN+SusVU4QQK1e1dr5uFa1IasPPZOKsxCrhvFank8nCTjAE0QMfKNk
         CduW4FcRteFNm9NFntw77b2Morm5rjg0gIlnw5CxPc7Kws5h8vSeX5kvaPgDRhwVhnUt
         BwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLuQhOrH4UHx4Pyo9bw3JTCwRhtrlO920iIdnfWHhGs=;
        b=kzQVbg8yX5gq4vms1JblPG2l59qhqOKDYZap77On2fj7Z/m+S5mKSn9ItQb6qBQQWs
         io0e2d3ysbfuI2dHjOYK49UmuRZqm6mD79HMFl1zTCM2NDuAV9qOxcOLHuNZipuhY+JX
         1HSh2gcsA89KTUi3pC0lGf0sK7sb5e90HPQP9mcGr+a8YSXo3klZlzs524qQsHwPPc3H
         N8Zry5EUfjz6YENCcGb/Crpfr5r0cDXLxmy/iMb4QDgIrq0mmjwUPz/R4Zunpw6UNZCm
         sBUwmK1tQj74tywGJd2SApkscAZQvN0kF1gnqEPuqFExUsCiVhJJF9zRAtwS3mzkb/MF
         yong==
X-Gm-Message-State: AFqh2kpHo999AJrhNZ3tr7RJuytcfesG1q9DcXMB+cUPS3gd7+xZ0c8Y
        pFR1/sI1Laum3Yr0CypnIHi4zRKEmys=
X-Google-Smtp-Source: AMrXdXs9DD022zEYvacdMrKhFYEzKcA5EsHIEjWrRXrNKsS7XEp50+Ul9TJMFVJQAxiS1XLyWynTpQ==
X-Received: by 2002:a05:600c:4e48:b0:3c6:e62e:2e67 with SMTP id e8-20020a05600c4e4800b003c6e62e2e67mr1742944wmq.2.1671546460266;
        Tue, 20 Dec 2022 06:27:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4-20020a1ccc04000000b003cfa80443a0sm15430502wmb.35.2022.12.20.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:27:39 -0800 (PST)
Message-Id: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 14:27:38 +0000
Subject: [PATCH] dir: check for single file cone patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     William Sprent <williams@unity3d.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Sprent <williams@unity3d.com>

The sparse checkout documentation states that the cone mode pattern set
is limited to patterns that either recursively include directories or
patterns that match all files in a directory. In the sparse checkout
file, the former manifest in the form:

    /A/B/C/

while the latter become a pair of patterns either in the form:

    /A/B/
    !/A/B/*/

or in the special case of matching the toplevel files:

    /*
    !/*/

The 'add_pattern_to_hashsets()' function contains checks which serve to
disable cone-mode when non-cone patterns are encountered. However, these
do not catch when the pattern list attempts to match a single file or
directory, e.g. a pattern in the form:

    /A/B/C

This causes sparse-checkout to exhibit unexpected behaviour when such a
pattern is in the sparse-checkout file and cone mode is enabled.
Concretely, with the pattern like the above, sparse-checkout, in
non-cone mode, will only include the directory or file located at
'/A/B/C'. However, with cone mode enabled, sparse-checkout will instead
just manifest the toplevel files but not any file located at '/A/B/C'.

Relatedly, issues occur when supplying the same kind of filter when
partial cloning with '--filter=sparse:oid=<oid>'. 'upload-pack' will
correctly just include the objects that match the non-cone pattern
matching. Which means that checking out the newly cloned repo with the
same filter, but with cone mode enabled, fails due to missing objects.

To fix these issues, add a cone mode pattern check that asserts that
every pattern is either a directory match or the pattern '/*'. Add a
test to verify the new pattern check and modify another to reflect that
non-directory patterns are caught earlier.

Signed-off-by: William Sprent <williams@unity3d.com>
---
    dir: check for single file cone patterns
    
    I ran into this confusing behaviour when working with sparse-checkout
    patterns. If my interpretation of the documentation is correct, then I
    think comes from git not being strict enough when checking cone mode
    patterns.
    
    Thanks, William

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1446%2Fwilliams-unity%2Fws%2Fsparse-checkout-pattern-match-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1446/williams-unity/ws/sparse-checkout-pattern-match-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1446

 dir.c                              |  7 +++++++
 t/t1091-sparse-checkout-builtin.sh | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index fbdb24fc819..a122aeb2aa3 100644
--- a/dir.c
+++ b/dir.c
@@ -732,6 +732,13 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		goto clear_hashmaps;
 	}
 
+	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
+	    !!strcmp(given->pattern, "/*")) {
+		/* Not a cone pattern. */
+		warning(_("unrecognized pattern: '%s'"), given->pattern);
+		goto clear_hashmaps;
+	}
+
 	prev = given->pattern;
 	cur = given->pattern + 1;
 	next = given->pattern + 2;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b563d6c263e..627267be153 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -238,7 +238,7 @@ test_expect_success 'cone mode: match patterns' '
 test_expect_success 'cone mode: warn on bad pattern' '
 	test_when_finished mv sparse-checkout repo/.git/info/ &&
 	cp repo/.git/info/sparse-checkout . &&
-	echo "!/deep/deeper/*" >>repo/.git/info/sparse-checkout &&
+	echo "!/deep/deeper/*/" >>repo/.git/info/sparse-checkout &&
 	git -C repo read-tree -mu HEAD 2>err &&
 	test_i18ngrep "unrecognized negative pattern" err
 '
@@ -667,6 +667,15 @@ test_expect_success 'pattern-checks: starting "*"' '
 	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
 '
 
+test_expect_success 'pattern-checks: non directory pattern' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/deep/deeper1/a
+	EOF
+	check_read_tree_errors repo deep "disabling cone pattern matching" &&
+	check_files repo/deep deeper1 &&
+	check_files repo/deep/deeper1 a
+'
+
 test_expect_success 'pattern-checks: contained glob characters' '
 	for c in "[a]" "\\" "?" "*"
 	do

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
