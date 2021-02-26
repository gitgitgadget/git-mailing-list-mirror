Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5839CC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1F064EF3
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZQYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 11:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBZQYo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 11:24:44 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4CC061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:24:02 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id k5so4739750qvu.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GG0YbwBbiLQH4GPgWl4mDr+O6b5gV58qar1WXqyRjek=;
        b=UcOSvQgn/otZpC0Lj/srjadz5wJ0+FPBAPFyA82vkFhYCPltjIG3YQYtaQFs3Zr35/
         kW5G09gB6ZbKpQlP02+T4bJS2fjdhU55usfzq7oXdtFg0E6R/dSG0XrvGLdyTELHh49V
         kOIMXWXJ/MnSvBOJ3/0P0tbEHtl/5R0y5FEWLDw/dfug/AaF+H4EBr+Bch32xXoQmPTg
         f8eQQR9oY/16xnsKXgddFdprlqX5YfcD7g9OkOfEWvwtKwzwYgFrKMSZUuGJW0Jcbalo
         O5l8umAKAr+VeN33EViqBA4DsOvtgaXDYRoCqFzkDEfkAzdI1rv91gaJwcczjfzbGklB
         ytCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GG0YbwBbiLQH4GPgWl4mDr+O6b5gV58qar1WXqyRjek=;
        b=AMsiaB/ZbHTpfeI72E1/8ogI4Xz672PUdKvdKFwsRw2fsNaNCWUMTToGn8EllAaej0
         MyShbIn99u4AtY9uGY0xulPoIihyUvVgN9TCT14aZ7wzJVgdHAhXS/XBTvszw6ULFG5R
         4Fx5WGkEsj7OzIDWN6wNVQtwYtMmDDYIjr6toMftzIjxBxajy1ZQm5QnMl5B0NTnNYg7
         A08Mb4+EJrUOExDWkN9NHqOsSeTWXC4Nq8lPKiISDBkuMUF5p4MPurhrqhU9wHjRx2kQ
         YTKWPxVgRrIf2lFxoyjvm3tta5PUn2o0TiMQv7d8BfZsOEPaDMl/yG5v9RdyeYuOzu9Z
         ndwQ==
X-Gm-Message-State: AOAM532yvJc0Ph3hSFDkUwzuA8Oip+fTSWqYZZXvh71gPsQI4503hXpy
        kDZl+X6WFYF/15ucUmsYboyqt4T7aefymQ==
X-Google-Smtp-Source: ABdhPJyDXs6OHb+yqbK88g8/NaVZNYIweyJ7pZvMrRElxLk9N9fsH1vtn09mFk1+WIjuTbMyUBzeDw==
X-Received: by 2002:a05:6214:242f:: with SMTP id gy15mr3120191qvb.17.1614356640906;
        Fri, 26 Feb 2021 08:24:00 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o43sm3289317qtb.28.2021.02.26.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:24:00 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     prohaska@zib.de, martin.agren@gmail.com, gitster@pobox.com
Subject: [PATCH v2] convert: fail gracefully upon missing clean cmd on required filter
Date:   Fri, 26 Feb 2021 13:23:54 -0300
Message-Id: <ead5b3145c0cbf726c2fe06f5c95536373c85265.1614354223.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
References: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gitattributes documentation mentions that either the clean cmd or
the smudge cmd can be left unspecified in a filter definition. However,
when the filter is marked as 'required', the absence of any one of these
two should be treated as an error. Git already fails under these
circumstances, but not always in a pleasant way: omitting a clean cmd in
a required filter triggers an assertion error which leaves the user with
a quite verbose message:

git: convert.c:1459: convert_to_git_filter_fd: Assertion "ca.drv->clean || ca.drv->process" failed.

This assertion is not really necessary, as the apply_filter() call below
it already performs the same check. And when this condition is not met,
the function returns 0, making the caller die() with a much nicer
message. (Also note that die()-ing here is the right behavior as
`would_convert_to_git_filter_fd() == true` is a precondition to use
convert_to_git_filter_fd(), and the former is only true when the filter
is required.) So remove the assertion and add two regression tests to
make sure that git fails nicely when either the smudge or clean command
is missing on a required filter.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changes since v1: didn't remove the first assertion and adjusted the
commit message. Thanks for catching that, Martin.

 convert.c             |  1 -
 t/t0021-conversion.sh | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index ee360c2f07..2c2c2adf61 100644
--- a/convert.c
+++ b/convert.c
@@ -1456,7 +1456,6 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	convert_attrs(istate, &ca, path);
 
 	assert(ca.drv);
-	assert(ca.drv->clean || ca.drv->process);
 
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL, NULL))
 		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e828ee964c..4f8415d419 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -257,6 +257,30 @@ test_expect_success 'required filter clean failure' '
 	test_must_fail git add test.fc
 '
 
+test_expect_success 'required filter with absent clean field' '
+	test_config filter.absentclean.smudge cat &&
+	test_config filter.absentclean.required true &&
+
+	echo "*.ac filter=absentclean" >.gitattributes &&
+
+	echo test >test.ac &&
+	test_must_fail git add test.ac 2>stderr &&
+	test_i18ngrep "fatal: test.ac: clean filter .absentclean. failed" stderr
+'
+
+test_expect_success 'required filter with absent smudge field' '
+	test_config filter.absentsmudge.clean cat &&
+	test_config filter.absentsmudge.required true &&
+
+	echo "*.as filter=absentsmudge" >.gitattributes &&
+
+	echo test >test.as &&
+	git add test.as &&
+	rm -f test.as &&
+	test_must_fail git checkout -- test.as 2>stderr &&
+	test_i18ngrep "fatal: test.as: smudge filter absentsmudge failed" stderr
+'
+
 test_expect_success 'filtering large input to small output should use little memory' '
 	test_config filter.devnull.clean "cat >/dev/null" &&
 	test_config filter.devnull.required true &&
-- 
2.30.1

