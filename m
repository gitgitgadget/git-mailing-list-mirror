Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4EC433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12782070A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrTCN3nE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgERJlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgERJlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:41:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A5C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:41:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k7so4899170pjs.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28PbK5WFm6kOZCpJfE1+mG2fweQk8EJ1Ar4rsBxXJOE=;
        b=GrTCN3nEvimz6GjNCVjY8jUrEBSoTWfqLzPhPQEE9KOUzl5ehOPSj8sv60lDjwmV9g
         ErwRBhXrC5RCytQBZmwOvTNqg0Yg2LKmulLB8kck1oT7cjDua6KrbLOnmsthW9020BA8
         T+H/JgSif80wGhz9DYiqFw0riMFYL1Ajlkg+0PdyE1tJhFGXl6z4pj0zq1sVRizEB1K4
         v5pcSUlK85NcTnBGayo6Nuybw9vtzy0YOt/tm2iswD4nHK8srdiLksqLMF/p1zcFOSI1
         3GnZM66zs3nTS5GYG79l6QCXy5WOmFUAAKDl41Dej1/tPQh11eqrZWQvAwcZFzZ2kvC6
         ZRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28PbK5WFm6kOZCpJfE1+mG2fweQk8EJ1Ar4rsBxXJOE=;
        b=FXIAarTJg5m83rOFLoVwqyJUGOaieA4Jh7EdyCqDlwRkqK3XGqfs5EfjyVoiR0Oqyk
         wg2Sw7S0kx9Mm1T7zQU+A3UJSMAlqvv28hfMGzqz2ONYsCpeBi78Gg6ennFmKn8V9NEl
         12tzxlnj2VzJ7VdyYc+GlH/N49n6Fh4yRqsSQWBCqeGz26EA6eW3lvSLz76+ebxSun56
         XDU1GnEV0HOmYqje3nSvGaTucc9VKHSMlJOO6uLR00fBA/7QHY1NUHmGL77EKPOszu1/
         ZmxGBtotlHh39hHRoMotNhNhhNc03KcEma06JxO0SMgsg7UxAzgckNmOBmQ98nFSSLI0
         ZmQA==
X-Gm-Message-State: AOAM533EVIZx9VL/qg0AMh3ePCadcYesx7xwfbyyoCYZhXsMRioDnede
        YOWYvVJAJhW+B00wOmfwR8A=
X-Google-Smtp-Source: ABdhPJxEucvfu69Vi8JQ7qYzhHWE+97OYISGsVno3F7Db9mnFqc2ZlVNK5858yHsNaYSeMTdpuOpZw==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id mw13mr17504545pjb.218.1589794859741;
        Mon, 18 May 2020 02:40:59 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e1sm8119867pjv.54.2020.05.18.02.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:40:59 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v16 10/11] transport: parse report options for tracking refs
Date:   Mon, 18 May 2020 05:40:38 -0400
Message-Id: <20200518094039.757-11-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200507161057.12690-1-worldhello.net@gmail.com>
References: <20200507161057.12690-1-worldhello.net@gmail.com>
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
index 5baa30dd74..cd01f82f5c 100644
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
+	struct ref_push_report_options *options;
+
+	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
+		return;
+
+	options = ref->report.options;
+	if (!options)
+		update_tracking_ref(remote, ref->name, &ref->new_oid,
+				    ref->deletion, verbose);
+	else
+		for (; options; options = options->next) {
+			refname = options->ref_name ? (char *)options->ref_name : ref->name;
+			new_oid = options->new_oid ? options->new_oid : &ref->new_oid;
+			update_tracking_ref(remote, refname, new_oid,
+					    is_null_oid(new_oid), verbose);
+		}
+}
+
 static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     struct ref_push_report_options *options,
-- 
2.26.1.120.g98702cf3e9

