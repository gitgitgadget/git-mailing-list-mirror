Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0DC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309662076A
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEUbWeaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgI3XX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3XXz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 19:23:55 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AEEC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 16:23:55 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id k18so1696427oou.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 16:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YCqO1rMkqP8Qnyyn6/0+3AgL7R7BOqOfQ60I4aaUM9c=;
        b=NEUbWeaYMD9ZVyEAVAVUAQf0U0P0ltBB6yDpcWFaPDEn/JLx4Vx4FE0P1r1vpQwtLu
         vIp5cGIwCSA1eoyxrAW6M8p90mXguTxqDs/ufNJENwUS+0TY3aj5lfgvWVUDrJpemLNe
         i7f2IJ0QQeTTpHWgFeNa5rGsy+qTVlGkiFjQh/rhogN+NDARM2rKMSRJFly2W52WAbBH
         UT+uhFq880NkGkGrP4xUJJuN/gzhL1HBfE5+/Lcf1oCirKoYANcPxCNoxcx4SmF5V6m/
         iGerj9NBoSajo/I/8RXdNlmj6tdxYfFe/HE/4wPe7q7jGCN0I6Lqmjy0YBhNRdPbH+I+
         rJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YCqO1rMkqP8Qnyyn6/0+3AgL7R7BOqOfQ60I4aaUM9c=;
        b=p1NiAxSyhEuek4lOs+x1F7iWeM9ru5xTwkgekEXfVtUG3Q5fdsjLXL7z7baCDKJ21j
         kUZsST9QsAhS/ZuOYix3yj1aTf+NAapqSXERW2FdIvP3mln+r9G5w9OnBrpa8LGKb/Hx
         MMixXVj6+rDK2uKQFf9X0BpxV4C+ZYJP5qz5+PanwwZsO1oLMYINc7hKCjR4M9PH2i7P
         L02gcT6tsKOviFguR66EL+naU2bs1o7r3DL02BhgCV8u8Pf9WyQ3toQUjS438ivSS9QK
         CT0T+7LrwKFxgtX94jA5bOwL4WMvJkG0AKO86HgHR6wHOAVMk64ykZmwT61o5rbUICoM
         mocw==
X-Gm-Message-State: AOAM532ES5v2168nGfZhf1TQ3BauIVfKvo13kvW+tVh/eGJVOl87W24X
        sVgFWru64ESpK4IMtLPV5VhT/QmF57Vc2fWtYpiom95bb91OcoKoDTD7zW4ccfRaBsiAgM+l0Tt
        88fVXzxDUUYYQoQ1y6Lx4IAyuJUluoYnh4UDwcrO7YFpCazXUCEr5RUG+6D6M
X-Google-Smtp-Source: ABdhPJx6jhjepRZ7OA36bCGgVa4raWp+SQSRx2oFmLNEdYjd+3mlPcdBgqdBr0Q7a5iGIP/JOD/hjjtR8DKx
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a9d:4b18:: with SMTP id
 q24mr2918798otf.265.1601508234928; Wed, 30 Sep 2020 16:23:54 -0700 (PDT)
Date:   Wed, 30 Sep 2020 23:21:38 +0000
In-Reply-To: <20200930232138.3656304-1-shengfa@google.com>
Message-Id: <20200930232138.3656304-2-shengfa@google.com>
Mime-Version: 1.0
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
 <20200930232138.3656304-1-shengfa@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     git@vger.kernel.org
Cc:     nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu,
        gitster@pobox.com, Shengfa Lin <shengfa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users requested hiding location in the world from source control
trail. This is an implementation to read user.hideTimezone in
cmd_commit and set timezone to UTC if it's true.

Added a brief explanation of the new field in Documentation
and added tests for true/false and reset-author

Signed-off-by: Shengfa Lin <shengfa@google.com>
---
 Documentation/config/user.txt   |  4 ++++
 builtin/commit.c                |  5 +++++
 t/t7527-commit-hide-timezone.sh | 37 +++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100755 t/t7527-commit-hide-timezone.sh

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 59aec7c3ae..bd6813f527 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -36,3 +36,7 @@ user.signingKey::
 	commit, you can override the default selection with this variable.
 	This option is passed unchanged to gpg's --local-user parameter,
 	so you may specify a key using any method that gpg supports.
+
+user.hideTimezone::
+  Override TZ to UTC for Git commits to hide user's timezone in commit
+  date
diff --git a/builtin/commit.c b/builtin/commit.c
index 42b964e0ca..fb1cbb8a39 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1569,6 +1569,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
+  git_config(git_default_config, NULL);
+  int hide_timezone = 0;
+  if (!git_config_get_bool("user.hideTimezone", &hide_timezone)  && hide_timezone)
+    setenv("TZ", "UTC", 1);
+
 	if (get_oid("HEAD", &oid))
 		current_head = NULL;
 	else {
diff --git a/t/t7527-commit-hide-timezone.sh b/t/t7527-commit-hide-timezone.sh
new file mode 100755
index 0000000000..41ed9c27da
--- /dev/null
+++ b/t/t7527-commit-hide-timezone.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='git-commit can override local timezone setting by reading user.hideTimezone from config'
+
+. ./test-lib.sh
+
+test_expect_success 'commit date shows timezone offset +0300 when user.hideTimezone is false' '
+        git config user.hideTimezone false &&
+        echo test1 >> file &&
+        git add file &&
+        # unset GIT_AUTHOR_DATE from test_tick
+        unset GIT_AUTHOR_DATE &&
+        TZ=Europe/Istanbul git commit -m initial &&
+        git log -1 > output &&
+        grep "Date: .* +0300" output
+'
+
+test_expect_success 'commit date shows timezone offset +0000 when user.hideTimezone is true and reset' '
+        git config user.hideTimezone true &&
+        git commit --amend --reset-author &&
+        git log -1 > output &&
+        grep "Date: .* +0000" output
+'
+
+test_expect_success 'commit date shows timezone offset +0000 even TZ setting says otherwise' '
+        git config user.hideTimezone true &&
+        echo test2 >> file &&
+        git add file &&
+        # TZ setting corresponding to -0600 or -0500 depending on DST
+        # unset GIT_AUTHOR_DATE from test_tick
+        unset GIT_AUTHOR_DATE &&
+        TZ=America/Chicago git commit -m test2 &&
+        git log -1 > output &&
+        grep "Date: .* +0000" output
+'
+
+test_done
-- 
2.28.0.709.gb0816b6eb0-goog

