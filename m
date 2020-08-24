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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6EEC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F232B2067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOIt3KP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHXRmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgHXRmW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FBC061796
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so4584449pjd.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGGKBcITccHjiRJHVfcma4u6SOE3ZV+JtgU29AUPZdc=;
        b=DOIt3KP8QT64C6t5ehvz4FYsMjAT5dujD2H7WNW4x8zVwiPCxxKqjChmOrfiOwy1Gn
         J4KfhHeFqOkiSIPt+eMJZ9taVpQHpzB+vbv4XjFRrmfG1NgF986mtkMH0bfEV8xV2UP9
         3+NZMj6fuQj6Y9ZSvpcs6BO0eP97RF/2VxSS465C6EPfiqTn3cXdW4b2VvaQeiGn0bJQ
         J1X1g5wTltqfX76y2LJoSStLSSWA9HI4uXbXfL/O0duH7T4MZC4VVpyP3s2Rs1liZbRW
         cSFJyL/ybwOV3WNoQjl6QA6/BWALpvg7XTnlzmGn3GGOylkhFgf89ZAe9QQ3K0CbzRpt
         5HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGGKBcITccHjiRJHVfcma4u6SOE3ZV+JtgU29AUPZdc=;
        b=JXzO9llqsu10WdTHPTXyUveKv7HFPPS/wW5962CDprVcZ7XLptX/1mqvRma29NFH4L
         qZXir8bVeDNmGtfGxwHI2pciNP8j8PPY6ZmA21CsYI7Wy+ALaa4MGqGPgNaCZhlM2z5y
         4Fy2YMyL5A8cotnOTEl5m+s3p8gaiHo7iGID5u8GTB9uIWca5GsSRkUlWwlzhqRBMpJv
         DC+3tcNqJG0f5lE8hBwy1+q1QtPvAhLm9iTyyTTN5ZdBWNan6DWicVQMdiGh0XB6AmQW
         CC19jOGmAapA+oijkSEd5Gzcm0FvRMkMyfLnE6Ntk1V1Un/LY1T40i+edr1Jrf5NydZ0
         lnXw==
X-Gm-Message-State: AOAM5314muc+DnvcZ9NuDVCwh0myvAcCUVBkXU9whNVukZifFejHKWZI
        HUzKKJEuAmASFI0JruUtCN4=
X-Google-Smtp-Source: ABdhPJzVLp1Tj2CWPPwEwsP4WFxp4EjYsdvuXebCaSguIV0oKe/O6RCtDFX1oIB7HrpqyVHiLa+Wfw==
X-Received: by 2002:a17:90a:6a8d:: with SMTP id u13mr317275pjj.166.1598290941568;
        Mon, 24 Aug 2020 10:42:21 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:21 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 09/10] transport: parse report options for tracking refs
Date:   Mon, 24 Aug 2020 13:42:01 -0400
Message-Id: <20200824174202.11710-10-worldhello.net@gmail.com>
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

When pushing a pseudo reference (such as "refs/for/master/topic"), may
create or update one or more references.  The real names of the
references will be stored in the report options.  Parse report options
to create or update remote-tracking branches properly.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 22 +++++++---
 transport.c                                   | 40 ++++++++++++++-----
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 8eec3a1ed8..73283d81e8 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -78,10 +78,14 @@ test_expect_success "proc-receive: check remote-tracking #1 ($PROTOCOL)" '
 		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/t/for/master/topic
+	<COMMIT-A> refs/t/changes/24/124/1
+	<COMMIT-B> refs/t/changes/25/125/1
+	<COMMIT-B> refs/t/for/master/topic
 	EOF
 	test_cmp expect actual &&
-	git -C workbench update-ref -d refs/t/for/master/topic
+	git -C workbench update-ref -d refs/t/for/master/topic &&
+	git -C workbench update-ref -d refs/t/changes/24/124/1 &&
+	git -C workbench update-ref -d refs/t/changes/25/125/1
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
@@ -151,10 +155,14 @@ test_expect_success "proc-receive: check remote-tracking #2 ($PROTOCOL)" '
 		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/t/for/master/topic
+	<COMMIT-A> refs/t/changes/24/124/1
+	<COMMIT-A> refs/t/changes/25/125/1
+	<COMMIT-B> refs/t/for/master/topic
 	EOF
 	test_cmp expect actual &&
-	git -C workbench update-ref -d refs/t/for/master/topic
+	git -C workbench update-ref -d refs/t/for/master/topic &&
+	git -C workbench update-ref -d refs/t/changes/24/124/1 &&
+	git -C workbench update-ref -d refs/t/changes/25/125/1
 '
 
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
@@ -210,8 +218,10 @@ test_expect_success "proc-receive: check remote-tracking #3 ($PROTOCOL)" '
 		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-	<COMMIT-A> refs/t/for/master/topic
+	<COMMIT-A> refs/t/changes/23/123/1
+	<COMMIT-B> refs/t/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
-	git -C workbench update-ref -d refs/t/for/master/topic
+	git -C workbench update-ref -d refs/t/changes/24/124/1 &&
+	git -C workbench update-ref -d refs/t/changes/25/125/2
 '
diff --git a/transport.c b/transport.c
index e146de6c4e..7d37baea64 100644
--- a/transport.c
+++ b/transport.c
@@ -437,28 +437,48 @@ int transport_refs_pushed(struct ref *ref)
 	return 0;
 }
 
-void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
+static void update_tracking_ref(struct remote *remote, char *refname,
+				struct object_id *new_oid, int deletion,
+				int verbose)
 {
 	struct refspec_item rs;
 
-	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
-		return;
-
-	rs.src = ref->name;
+	rs.src = refname;
 	rs.dst = NULL;
-
 	if (!remote_find_tracking(remote, &rs)) {
 		if (verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
-		if (ref->deletion) {
+		if (deletion)
 			delete_ref(NULL, rs.dst, NULL, 0);
-		} else
-			update_ref("update by push", rs.dst, &ref->new_oid,
-				   NULL, 0, 0);
+		else
+			update_ref("update by push", rs.dst, new_oid,
+				NULL, 0, 0);
 		free(rs.dst);
 	}
 }
 
+void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
+{
+	char *refname;
+	struct object_id *new_oid;
+	struct ref_push_report *report;
+
+	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
+		return;
+
+	report = ref->report;
+	if (!report)
+		update_tracking_ref(remote, ref->name, &ref->new_oid,
+				    ref->deletion, verbose);
+	else
+		for (; report; report = report->next) {
+			refname = report->ref_name ? (char *)report->ref_name : ref->name;
+			new_oid = report->new_oid ? report->new_oid : &ref->new_oid;
+			update_tracking_ref(remote, refname, new_oid,
+					    is_null_oid(new_oid), verbose);
+		}
+}
+
 static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     struct ref_push_report *report,
-- 
2.26.2.543.ge7de2a6e37

