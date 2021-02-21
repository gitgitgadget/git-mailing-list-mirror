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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C116C433E0
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5C64DD3
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 19:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhBUT0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 14:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBUT0E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 14:26:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E1C061786
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 11:25:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v22so19189151edx.13
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 11:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3y5v+yKRLwcDj8tWztSFDeD42xQOR51di7LkQYl2NRc=;
        b=coiaVY0q2bU7V1nz/n6Dn2lq5oAu9ZMrM0f9xcINqdJTifMix/LPFJqKWlB/bF/tqi
         SMvY+D1bw0k+NJcc9+WygXQgvzPOSTGjJzp1+oFo9n3LEXdhFYIA/PcqBf4EFVu6ZZYu
         +ICkFAbnYJ06kBt/rGRg9MfNjRYgiP+gVe4jWL16lpru6CeE2mC3etN3gVeb/y3IQ7sF
         j7l2CitNIMWmaWstcDKLDQ0suOsy+MHVOSK/6y4Voj7EHSA4/e520I5sTrFUrPVgIYYl
         v3L87tiFn7gnpVrb7VvYX4kotV1+rfjevMk2nuru4j0LkOjnuWw1OUak1sULVlwBPrVX
         tvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3y5v+yKRLwcDj8tWztSFDeD42xQOR51di7LkQYl2NRc=;
        b=Ht5a+WVU3zS+oI09WjMZjAXLZqgVJyiYNCzuAQS7KdXFZJlNOn+A44bYWE/7A0p3RX
         t6JwjAQHZdDLXjflS9hPG9m0Cm1ae8V/dpW4jNL6MsfhXax0tOdGdJ1Yhh7BYmggje3S
         Arpu5XTUilmgX2svP3skntdJfBAZMdGb32IDzXi9+4/ZyNWa/Vmf4gK5n8C60EhY2YHo
         QOZ4G9q/7XYN+rbeHuxRJmUiQ+lYhpZOVdBzHsI1c5atjc4NwO6wkI+IIdHqbB45M9qV
         kJBBN0HO63ps2k4DHmaD6VbT/4+oxTKzg1b7UAiMaPLebKnDZqBZxuTyQAtV0iTEpUCx
         nacQ==
X-Gm-Message-State: AOAM531PSxmTGNyBkhlEHCnV1wsB/6WOCQRIqdbyT18V4zHU1dkhL9cG
        lNFzQMCOLpu3OmmeEajD3OHWu8bwPjY=
X-Google-Smtp-Source: ABdhPJzTM15oU4NE4yDkw9FJU0pfD1AO9IylE4chMAyMSD2aklu3NIh2HtoZhVY7HQCborQYZcE9qQ==
X-Received: by 2002:a05:6402:22a8:: with SMTP id cx8mr19939403edb.376.1613935522402;
        Sun, 21 Feb 2021 11:25:22 -0800 (PST)
Received: from localhost.localdomain (94-21-146-126.pool.digikabel.hu. [94.21.146.126])
        by smtp.gmail.com with ESMTPSA id hd9sm7982026ejc.30.2021.02.21.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 11:25:22 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
Date:   Sun, 21 Feb 2021 20:25:12 +0100
Message-Id: <20210221192512.3096291-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.30.1.940.gce394404de
In-Reply-To: <20210221192512.3096291-1-szeder.dev@gmail.com>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many test helper functions we verify that they were invoked with
sensible parameters, and call BUG() to abort the test script when the
parameters are buggy.  6a67c75948 (test-lib-functions: restrict
test_must_fail usage, 2020-07-07) added such a parameter verification
to 'test_must_fail', but it didn't report the error with BUG(), like
we usually do.

As discussed in detail in the previous patch, BUG() didn't really work
in 'test_must_fail' back then, but it resolved those issues, so let's
use BUG() in this case as well.

The two tests checking that 'test_must_fail' recognizes invalid
parameters need some updates:

  - BUG() calls 'exit 1' to abort the test script, but we don't want
    that to happen while testing 'test_must_fail' itself, so in those
    tests we must invoke that function in a subshell.
  - These tests check that 'test_must_fail' failed with the
    appropriate error message, but BUG() sends its error message to a
    different file descriptor, so update the redirection accordingly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0000-basic.sh        | 4 ++--
 t/test-lib-functions.sh | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index a6e570d674..b9d5c6c404 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1315,12 +1315,12 @@ test_expect_success 'test_must_fail on a failing git command with env' '
 '
 
 test_expect_success 'test_must_fail rejects a non-git command' '
-	! test_must_fail grep ^$ notafile 2>err &&
+	! ( test_must_fail grep ^$ notafile ) 7>err &&
 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
 test_expect_success 'test_must_fail rejects a non-git command with env' '
-	! test_must_fail env var1=a var2=b grep ^$ notafile 2>err &&
+	! ( test_must_fail env var1=a var2=b grep ^$ notafile ) 7>err &&
 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a40c1c5d83..cdbc59e4f0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -910,8 +910,7 @@ test_must_fail () {
 	esac
 	if ! test_must_fail_acceptable "$@"
 	then
-		echo >&6 "test_must_fail: only 'git' is allowed: $*"
-		return 1
+		BUG "test_must_fail: only 'git' is allowed: $*"
 	fi
 	"$@" 2>&6
 	exit_code=$?
-- 
2.30.1.940.gce394404de

