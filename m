Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD0DC433E4
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD7C2074D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyrcWOv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHXRml (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHXRmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39263C061575
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so5210980pfn.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbjBKbEB2r1yCYXKtStnZ7+mr9/hXSOM9JTZLF1YMEs=;
        b=UyrcWOv+UesAENMZGs3ugA231m7fVy3DQyuwMm4xu3Ds/uvsEf56PhJtfqenrWPWVr
         chp56Ke1O3dUdsNMaFY1AWUHjRyJBFQL8DDEc0b89xxmJiFdi/9SDHv+Blx3XB2iOzpk
         EZp3+CzEQ/wBm3SnssONbWRn7d6oHlwIjI2MbI/6Pjb0Sr5JT2Qlxdgsjcbpc58VcxIR
         nF/9tPpwnVtksgU9jIp/VdOygu6ho+H4/JdET+Si4K77FDPWJ80MjqA6cjOTs6eDPfUn
         MXImYGur2qbXFob/4BmJIf3PXgI3mQvtOzkqAx9y0L/EefDKR640ODrCG6itrVl5zwjk
         zaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbjBKbEB2r1yCYXKtStnZ7+mr9/hXSOM9JTZLF1YMEs=;
        b=CIUuhxwgrf/1MTq+8Fgd0Olj0o4uB6hpYg6WDY8VaBCqFgYaDwxeQ79KvcseQ0/LWR
         Rjn8SvJzKuaFPLcSRxtCXsB9k5ibOCpgo5TXPNHigA9cc6EBnEN0y4vRKXAZtgzGqfYG
         Qi42kWXjtA9OIN7tV9rD2CJ2GEaYkvcyXvl8i6xHvg4KMnO78KqkAakkCGDLcM8MnWcc
         AoFN+N5zd0NSP4mPiUYook9rDWOFt6R9OecH0owHJPuy5QHT7y8Q7+s0FXewAyhETOvB
         oPT2Njshwtj3BHJPuQIsmeR9BUxebh0FKQZqNqpTQkCqqec0yokmYiUk54KXmfA8BOKb
         YtGg==
X-Gm-Message-State: AOAM533q0+Sq5XEBaPUueoSMzzNPMepo5cy5LzQx06aZ8vHNsWyBEiVC
        yJb2qqbkb+cm47Wr9rQvfNs=
X-Google-Smtp-Source: ABdhPJznFJDwFxBrr8bjWqgR8vGFBkQo5Z9upv4fbrNmp4ovTu2il1tBdEf6gKWKGWREtQeUKoV3Ng==
X-Received: by 2002:aa7:9386:: with SMTP id t6mr5060758pfe.220.1598290940618;
        Mon, 24 Aug 2020 10:42:20 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:20 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 08/10] t5411: test updates of remote-tracking branches
Date:   Mon, 24 Aug 2020 13:42:00 -0400
Message-Id: <20200824174202.11710-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200815171740.6257-1-worldhello.net@gmail.com>
References: <20200815171740.6257-1-worldhello.net@gmail.com>
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
2.26.2.543.ge7de2a6e37

