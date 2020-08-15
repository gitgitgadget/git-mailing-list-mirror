Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFEC433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF95206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcSWt9Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgHOVxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgHOVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA97C00214D
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so5723301pjx.5
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tx+seKi60p48rZDrSvhq06rOfr3LSqzdUw+gGKvrWf8=;
        b=QcSWt9MmTgmA0dI6x/WPwNtQapO1h0NYoQ6MXjGD0XwWAqyThUfsRHffhlH35Rnpkp
         0AttPe6jkrIDIjoIdC2fz9ArYQ24L7urzYD2qCWFRnQYkqf7SVHQctaof63nJeU9pru9
         e/Xa5N7LRL6h4AlH7lFaCyj9krDeVvchHCTiQ5SMho0GXd+SSVUQzMY/GoKoMxzbCTnX
         +JQ9Be4i7BbBvErUwVeFRXbtCbQeD8s9B+q3kTNp4SnSKD522UJ8zCgnGhCWbEMMZ06/
         0H/C0eGgxz3ekhfLW1ZBUzbVAh626zWXg51Z+obySKlmQO503aLHqa3eJOI44sDr39z9
         79FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tx+seKi60p48rZDrSvhq06rOfr3LSqzdUw+gGKvrWf8=;
        b=N21I8wjRw5ah3mriGuqFibnqFt/kOSfctCVyY1rwnM7vKaD6Eoz8XeeDEPgDTMf0No
         d7zs0iyzDLLWiNpEnYwebJ/XjH4mMS6Q7kaRTrajFrtRyD17yaJEsQSZEFfLYdW+YFZF
         HLjP+3yXU9j6H+YCaAihqNxsl2RT5c73FsVZkoE6a3dNajuxQdAtsE/4XznB9d4y+4uO
         kzgKOsYSrN5XJEx1ncTRBHVoe0q9aK/P+0PnptUumpvI7Z5dsx8AD3BWTZ6L6KDhqflb
         KWK5rOK4h0zDojudoWJQv4jNjnR19zlIs6flNNmxmurxyDAqnBeiMvyslqamLxRvYD0F
         FIhA==
X-Gm-Message-State: AOAM531nkMaGBAeZR6MPXsX7dysTaY2txDTw8dZ3Ziq/RzmDGTLu3Msu
        Iw8aTnPWAADGYaqAhxc9VTI=
X-Google-Smtp-Source: ABdhPJxbpV5/wm1zJAV+LFuZZ2YNRiMtfhLAoQ89aCXg6uAo1EeHAdLXyoMbP5sFXqJCGEUDAOwFVA==
X-Received: by 2002:a17:90a:1e65:: with SMTP id w92mr6321289pjw.187.1597511876194;
        Sat, 15 Aug 2020 10:17:56 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x13sm11040596pga.30.2020.08.15.10.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 10:17:55 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v17 08/10] t5411: test updates of remote-tracking branches
Date:   Sat, 15 Aug 2020 13:17:38 -0400
Message-Id: <20200815171740.6257-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200518094039.757-1-worldhello.net@gmail.com>
References: <20200518094039.757-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In order to test update of remote-tracking branches for special refs,
add new "remote.origin.fetch" settings and test cases.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 27d58edd14..8eec3a1ed8 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -1,3 +1,18 @@
+test_expect_success "setup git config for remote-tracking of special refs" '
+	(
+		cd workbench &&
+		if ! git config --get-all remote.origin.fetch | grep refs/for/
+		then
+			git config --add remote.origin.fetch \
+				"+refs/for/*:refs/t/for/*" &&
+			git config --add remote.origin.fetch \
+				"+refs/pull/*:refs/t/pull/*" &&
+			git config --add remote.origin.fetch \
+				"+refs/changes/*:refs/t/changes/*"
+		fi
+	)
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -58,6 +73,17 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	test_cmp expect actual
 '
 
+test_expect_success "proc-receive: check remote-tracking #1 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -120,6 +146,17 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	test_cmp expect actual
 '
 
+test_expect_success "proc-receive: check remote-tracking #2 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -167,3 +204,14 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	EOF
 	test_cmp expect actual
 '
+
+test_expect_success "proc-receive: check remote-tracking #3 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
-- 
2.28.0

