Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FBAC433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68D661A0A
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhJCMbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJCMbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 08:31:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25AC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 05:29:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c4so9278249pls.6
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Et/0kg4oqqlXETsgCOA1jUbnwh3zRsXlgKH9Jo/Wnyw=;
        b=N2qJVGxzKgEyDepFBvLMMljwYbJNQZSPmm+viKxprumrJSN184qLSf1AYQmfS3rCkv
         +NH+Kpq4zVfvfQTADC3cpatAgxlgnyWHJCJ+YoiN/O2+Ftn4pfeGBXgN9nvOI0oQpdXV
         nrABBiEiRtkUCYNx4N0VZ6C7ZmzcS+YoU5MSpE31V8cZD2Ntiy7whyLKfvY6FNJ48YaA
         F8KTolkcbneVQphXRxYuqBOZUDHVXKtynla1x/qVtpeTt9VYOQfDpSFzf/O3GeWNdxce
         +qIzZHIGDb4by7dwaWhAmZ14GLUGKLdCUfbhY1fvGCiX8pm4rep5Pig3dJdZRmtGn/35
         Kksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Et/0kg4oqqlXETsgCOA1jUbnwh3zRsXlgKH9Jo/Wnyw=;
        b=0yW+AMZxOq8aKSIh08UuSgH088IEMd+RRRhpTJZ24L8aO8a0zt+8ad8pBQfwUUc00X
         DTkcojurfmz/mkEYVRTZFRjYz+1F1RU2ZHwuG+2HdCti7yXhc+0knz9qH7XgjasQnPgj
         xCHsFvaWgkntbtKRrKYHgLZnkV9+UTimnjb8mF61TfUZKEtgMwGh494KCnnYM6yPMwLf
         FA5AQNx3pawOWNP6P09z+pG3KZqqIqmb9KxQFv/MJAgR2szZegoCDJUOJPZwPkBoLC6N
         epY+ClC9ldOTSL4w9HzHYgGHenyu+lsDqhXUvsDfj+rE1Rq/fG/o4+hlFb1j9mjL58gf
         1vGA==
X-Gm-Message-State: AOAM533uY8YAVO3GJR0/nu8f5rlkIDUXH5GKB461xjGyg5dn/htc/sf4
        5GBZQRpIp10FotgECLfrvgSlwSnUgvgaXg==
X-Google-Smtp-Source: ABdhPJzu7p+OaRVW8Qphlj31nDFz2L6Rlo8cdk47eLszyAFHkUCuC/LDygBdxm4ib3SFIzYtDqUkmA==
X-Received: by 2002:a17:90b:17ca:: with SMTP id me10mr30871038pjb.171.1633264197295;
        Sun, 03 Oct 2021 05:29:57 -0700 (PDT)
Received: from ubuntu.mate (subs09b-223-255-225-231.three.co.id. [223.255.225.231])
        by smtp.gmail.com with ESMTPSA id k17sm8476394pfu.82.2021.10.03.05.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:29:57 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Ryan Anderson <ryan@michonline.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/3] request-pull: add -o/--output option
Date:   Sun,  3 Oct 2021 19:29:42 +0700
Message-Id: <20211003122943.338199-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003122943.338199-1-bagasdotme@gmail.com>
References: <20211003122943.338199-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add -o option (and long dash counterpart --option), which allow users to
write pull request message to the specified file.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 git-request-pull.sh     | 28 +++++++++++++++++++++++-----
 t/t5150-request-pull.sh | 13 +++++++++++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 88a7a9cf0d..f4d6f846d0 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -7,10 +7,12 @@
 SUBDIRECTORY_OK='Yes'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_STUCKLONG=
-OPTIONS_SPEC='git request-pull [options] start url [end]
+OPTIONS_SPEC="\
+git request-pull [options] start url [end]
 --
-p    show patch text as well
-'
+p            show patch text as well
+o,output=    output pull request to the specified file
+"
 
 . git-sh-setup
 
@@ -18,11 +20,16 @@ GIT_PAGER=
 export GIT_PAGER
 
 patch=
-while	case "$#" in 0) break ;; esac
+out=
+while test $# != 0
 do
 	case "$1" in
 	-p)
 		patch=-p ;;
+	-o|--output)
+		case "$2" in '') usage ;; esac
+		out="$2"
+		shift ;;
 	--)
 		shift; break ;;
 	-*)
@@ -180,6 +187,17 @@ $dash_line" $headrev &&
 
 message=$(display_message) || status=1
 
-echo "$message"
+if test $status -ne 0
+then
+	echo "There's an error when outputting message, exiting"
+	exit $status
+fi
+
+if test -n "$out"
+then
+	echo "$message" > "$out"
+else
+	echo "$message"
+fi
 
 exit $status
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index cb67bac1c4..b87e9c9869 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -168,6 +168,19 @@ test_expect_success 'pull request after push' '
 
 '
 
+test_expect_success 'pull request output with -o' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only main &&
+		git push origin main:for-upstream &&
+		git request-pull -o ../request initial origin main:for-upstream
+	)
+'
+
 test_expect_success 'request asks HEAD to be pulled' '
 
 	rm -fr downstream.git &&
-- 
An old man doll... just what I always wanted! - Clara

