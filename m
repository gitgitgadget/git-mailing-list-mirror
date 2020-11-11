Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A28C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE62074B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5Fu8Q1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKKLcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKKLcN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 06:32:13 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7BC0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:32:12 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i26so1277035pgl.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzgj2gpZcWF/Sl3jO7KOq7W/sWQy7mGJQOhjIqgRweM=;
        b=K5Fu8Q1uRs8Pvxf5NLM58Pt/KSizPHknvwGpLf8QMXqRgH4NGqKc2an4b6DkVsRIkx
         rXJMPpRAZHH2csJYCiIhNEGOAf1IdWnSZi5B3WN6pUN4TuafHg/k387gCqmxudLljjuo
         MtTA3GdlJAxP6/QFvXHkvtk3aEZncxdZm3FOgyzyQVpU7FUPpgt+MhAabeCypIPwfAn5
         jnS/502oWhSJUcejo4987oMD5Je3CH0AdtNnJ0KKj9TSnhfga9+cZzBjpCXzF0tRlwhs
         tkBhu3Tjacf/DKUJTbw9w4RNCYH8gqpq9HPjSEt9ZhP5u5c6W550kfHrD+FJ5ClVSxmK
         CokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzgj2gpZcWF/Sl3jO7KOq7W/sWQy7mGJQOhjIqgRweM=;
        b=Bk+9G0LK1MVKEi2CHEzoPh1NZFM6Ok1AEzv/zg9f5szGYlv1sjsOKiGVxSxxvx8q/z
         DwXDwAUpbYyDO+ojsNbvEq1iHV48JJv905HTxryIM+rIpylLkdv4/NSMtKHaQ12aN3mO
         /pbMJKpSIhIfkzOiF59GW4/L4Z1UgCa6mPfWXI79vGS/MbqdXSd5PkKs8zjCsbr+yZTN
         LB++l/gA0Npg0Mr4fPFGnAp6UQiqQs7yO+qrhAsyYudavZHY8BJGQEujc0gUKVXldXw+
         YOqx4f4Qq9TgZHf1biiP/bdr4C5hwMMvAbcfXzkSV7XZxRGkhkw9LYeEQeCvktAZmKOL
         oUTw==
X-Gm-Message-State: AOAM533T6gSZHpuX0fAz1hPje58YtU5d3FGPt+JejXy+Ons8V6EAOgze
        49h1jcnaK6SOEr15//5ncIg=
X-Google-Smtp-Source: ABdhPJwtnfPji9cW+74VC0xxnXscCnH01NMaLvhRB7k+rFP5lqfzOkx122/h+H2DnFwN5Vy58kCLdQ==
X-Received: by 2002:a63:5b04:: with SMTP id p4mr12984574pgb.369.1605094331783;
        Wed, 11 Nov 2020 03:32:11 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id s19sm2137525pfe.26.2020.11.11.03.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 03:32:11 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 1/3] t5411: new helper filter_out_user_friendly_and_stable_output
Date:   Wed, 11 Nov 2020 19:32:00 +0800
Message-Id: <20201111113202.24911-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.29.0.dirty
In-Reply-To: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

New helper `filter_out_user_friendly_and_stable_output` will call
common helpr function `make_user_friendly_and_stable_output` and use
additional arguments to filter out messages for specific test cases.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh                       |  7 ++++++-
 t/t5411/test-0000-standard-git-push.sh            |  9 ++++-----
 t/t5411/test-0001-standard-git-push--porcelain.sh | 15 +++++++--------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 521a347710..344d13f61a 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -42,7 +42,7 @@ create_commits_in () {
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/  *\$//" \
-		-e "s/   */ /g" \
+		-e "s/  */ /g" \
 		-e "s/'/\"/g" \
 		-e "s/	/    /g" \
 		-e "s/$A/<COMMIT-A>/g" \
@@ -54,3 +54,8 @@ make_user_friendly_and_stable_output () {
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
 		-e "/^error: / d"
 }
+
+filter_out_user_friendly_and_stable_output () {
+	make_user_friendly_and_stable_output |
+		sed -n ${1+"$@"}
+}
diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index 2b04b49367..47b058af7e 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -36,11 +36,10 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
 		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out |
-		sed -n \
-			-e "/^To / { s/   */ /g; p; }" \
-			-e "/^ ! / { s/   */ /g; p; }" \
-			>actual &&
+	filter_out_user_friendly_and_stable_output \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
+		<out >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
 	 ! [rejected] main -> main (non-fast-forward)
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index 747307f8da..bbead12bbb 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -37,16 +37,15 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
 		main \
 		$B:refs/heads/next \
 		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out |
-		sed -n \
-			-e "s/^# GETTEXT POISON #//" \
-			-e "/^To / { s/   */ /g; p; }" \
-			-e "/^! / { s/   */ /g; p; }" \
-			>actual &&
+	filter_out_user_friendly_and_stable_output \
+		-e "s/^# GETTEXT POISON #//" \
+		-e "/^To / { p; }" \
+		-e "/^! / { p; }" \
+		<out >actual &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
-	! refs/heads/main:refs/heads/main [rejected] (non-fast-forward)
-	! <COMMIT-B>:refs/heads/next [rejected] (atomic push failed)
+	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
+	!    <COMMIT-B>:refs/heads/next    [rejected] (atomic push failed)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
-- 
2.29.0.dirty

