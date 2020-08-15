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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304AAC433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF512053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3B3XSC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgHOWDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgHOVvL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE35C00217C
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so5512694plz.10
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSdqNxAxMsOh1Tyf9kvR1W1yBNuUnxLAKkzUWjILpoc=;
        b=L3B3XSC+kRNJwLgjppputT5wmbBufx2i0GANFo/EXd6CT8N7Oz7dwevm9CSPgezPN+
         qhKrZveWAobvWt6khHNUXxFA7d6eENtxAuGPYJhtIRTKkARhFqtA5/wj+utEyIWL2llH
         wt1ie6ejTqf7zyGHg2MSbWJ0BGvfh68R16v8r17snftG1FdIfGsGW4p4+OfPaVhrpS7w
         5zbG+ZnzrqvJkx7WpH6/BBjtR0db1fUxcanUFOdDRlnBpiFIRjWYehZgzCygUNSyrRGi
         ztQGl4P8rYOwEuopSZM71J2+69PhduZPwNiWSZx0plavEWHfrL9dG1RLoU3TZlgY6LAk
         zaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSdqNxAxMsOh1Tyf9kvR1W1yBNuUnxLAKkzUWjILpoc=;
        b=Uj5HdnP8bmQdnXFaMKowrvGAm4XcYqmoI7iP1YTtIsmcaYh8YYLqTX836+ThY4hLvV
         m+/aKKNrUrO2H5nsnPtQ+QcFSm0n3K0NiZAVlhprnx6TfUxQAYxbhzJXXWMISzuguEJU
         VWMA5ZSsILsOknTkVJopT1qAnRXVbXU6FxmCxinkfbbAU9/MV0FHb5QdGlpx8xo6Unkv
         4oRSEM/jlDsT1uM6x81So+Z2zKmXYzdUlRzZIPi16TDCNo9ntWtuIIhBeVuSZfjwIMJa
         JTLQC2oAWnUS5goZKK9I5G2MlGJ2w2N0mulXFVj0pVSBx5MmkOAKcRbnzWgNnxzV1cdi
         LmAw==
X-Gm-Message-State: AOAM5336b64k7x+IsF/YvBuzRm3HLa4iKjsTWc3yY7B9uDtFYvVB760j
        s/rzG6gJ2d2GeNep4U2fRvxBJX39TI4=
X-Google-Smtp-Source: ABdhPJwiWyhOZWkne05RQN5S/thxBY4jx2Ubak1Q6ZjUWlVWVhEC2jBbCti3cSUTPnyQjVBsGUdCWQ==
X-Received: by 2002:a17:902:8347:: with SMTP id z7mr2680945pln.20.1597511877128;
        Sat, 15 Aug 2020 10:17:57 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x13sm11040596pga.30.2020.08.15.10.17.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 10:17:56 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v17 09/10] transport: parse report options for tracking refs
Date:   Sat, 15 Aug 2020 13:17:39 -0400
Message-Id: <20200815171740.6257-10-worldhello.net@gmail.com>
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
index 10f7dbbcd0..fe0c73fa88 100644
--- a/transport.c
+++ b/transport.c
@@ -436,28 +436,48 @@ int transport_refs_pushed(struct ref *ref)
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
2.28.0

