Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A615C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiHBPqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiHBPqV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9DC140F5
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l4so18418320wrm.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E8zyqF84uEdemwVXSztkP8PfkZ4mVwKo6YwS6kgiY+g=;
        b=FyJkn+QDsvUYLFEmJ4pUlrj4weU/HSGUpCUhkeGSN7kSlIeuYZIq4KhlmBSMGWn0W5
         WUdWQCGl0A0hUaTyW23i5gxWblukP3xZSImH5ImsGZdf6eF7Wd8aYgtFCO7OMvxWSg3S
         KOnbpUyzXWaYebDO+N5mK4isQCvD4GFBpqelYA194PDOozPuBD6nG6kCOpJWfupyXFOH
         CSk/P/KuJ/T4wG4T2sBCe2RX/qvS6WcG40EPmYVx1Qwn5HWVO0rwoHk2YQQ3gQVEIMtS
         +wKxEbRXgA6QVP7ffGwa0OA5CclRJnmvk6IMDnwKz9zu7Pd7D8veCNjkvGzNrzXbYwi6
         /AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E8zyqF84uEdemwVXSztkP8PfkZ4mVwKo6YwS6kgiY+g=;
        b=xv0d2IO6paO8wDGXYKxTb4nB4T9VEaNyp0g9ZhjvlgFxKHaVGf6peaam8tCIN1Ixcx
         ON+smkhrUpGeUKOIw9sJgaeJ2TN3eoegXhypzzhKX+kC5j9aH+hMZHv4zzboEk2evNjv
         lW5KtEhpMPzNg0vCx74SQCqNerI8vimc8RUq8GW8wkAdndD1iVxLK563J5BI78JFmUw9
         XncdO/yd2vvk4GQJD1kvKWAlps7ZRWYsy1/0X16eXQNlBgJbf1yBoUKqMFuVqPc43A9e
         7wvtcPZnbD5rP2StvTDaIqwNTQ5nKNLNEuZY7R16lqty/P4IeNWgBq0oaduaG43a7AiI
         kK+Q==
X-Gm-Message-State: ACgBeo2QIqbVRNQQS7u8MYzg+XUsEdnKKlOu5/xzMpqBjLOsv7aivGfm
        gHTvyPEsMZwem04PGnYuIE61IH0M6Rm0Kw==
X-Google-Smtp-Source: AA6agR7AJFXRfYp4gBIxE4pvg5nt2d+UKPe3vnp6mHjJvK7fd3aFL36IM1hUxnmoaEPu8gZ6Va52kA==
X-Received: by 2002:a5d:630c:0:b0:21f:157f:f77b with SMTP id i12-20020a5d630c000000b0021f157ff77bmr12510202wru.614.1659455177947;
        Tue, 02 Aug 2022 08:46:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/28] submodule tests: test usage behavior
Date:   Tue,  2 Aug 2022 17:45:45 +0200
Message-Id: <patch-v2-01.28-daa5d3f9962-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test what exit code and output we emit on "git submodule -h", how we
handle "--" when no subcommand is specified, and how the top-level
"--recursive" option is handled.

For "-h" this doesn't make sense, but let's test for it so that any
subsequent eventual behavior change will become clear.

For "--" this follows up on 68cabbfda36 (submodule: document default
behavior, 2019-02-15) and tests that "status" doesn't don't support
the "--" delimiter. There's no intrinsically good reason not to
support that. We behave this way due to edge cases in
git-submodule.sh's implementation, but as with "-h" let's assert our
current long-standing behavior for now.

For "--recursive" the exclusion of it from the top-level appears to
have been an omission in 15fc56a8536 (git submodule foreach: Add
--recursive to recurse into nested submodules, 2009-08-19), there
doesn't seem to be a reason not to support it alongside "--quiet" and
"--cached", but let's likewise assert our existing behavior for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e7cec2e457a..b858871a953 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -14,6 +14,32 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'submodule usage: -h' '
+	git submodule -h >out 2>err &&
+	grep "^usage: git submodule" out &&
+	test_must_be_empty err
+'
+
+test_expect_success 'submodule usage: --recursive' '
+	test_expect_code 1 git submodule --recursive >out 2>err &&
+	grep "^usage: git submodule" err &&
+	test_must_be_empty out
+'
+
+test_expect_success 'submodule usage: status --' '
+	test_expect_code 1 git submodule -- &&
+	test_expect_code 1 git submodule --end-of-options
+'
+
+for opt in '--quiet' '--cached'
+do
+	test_expect_success "submodule usage: status $opt" '
+		git submodule $opt &&
+		git submodule status $opt &&
+		git submodule $opt status
+	'
+done
+
 test_expect_success 'submodule deinit works on empty repository' '
 	git submodule deinit --all
 '
-- 
2.37.1.1233.ge8b09efaedc

