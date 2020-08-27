Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF61C433E4
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1BC2177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZVYF49H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgH0PqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgH0PqF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:46:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C06C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so3647569pgm.7
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzpVpH2QQIb6fCbHeazA0gPEJCh0ZbpnssJfToDB8rg=;
        b=iZVYF49HWwFRoHjZAwwvDTBAYOsMhEWPSlOWqDRfTWWS8kdUGTzhzuceeOWUGaqxAE
         nKq04g1TB5dSy6UwT3u+bqJ7Q2vafhCR4lpvk8WEdcI0XEgvaFnBvK2wqkqwRG4mDLTY
         cQZTBHsrsUD3QNsW4Cu8sYL0xb0l4c0v5zIHdsec2trJDgJH9qnVrgVpbjSE5IMcdrTF
         ZStipDXrS0qNbB3362rJFbusklOZxxgDkFpBe26rbMlv7lBohkHc43tugSwqBitur7uA
         ehyCO3gkko/oConnpM8KU10otRQ01F8rVW/GhP9/1hKnp0yO7M+yKY9eyn+NbTaxFpPY
         Jb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzpVpH2QQIb6fCbHeazA0gPEJCh0ZbpnssJfToDB8rg=;
        b=qzH4GnHepu3U8X0Uo0KUfUd8fBUv6l2QCCHpgZT9YejqGtuSlaZgrNU8GNp0OYPEy0
         +fBbr2z2qaqOtARtboSEFELf9k9fLDoJnQOp+1JZ+Os6JigSmcolnvkMEv1JHH885/tU
         +wf7i8ub1zMkNLPuBXRyUQ3qi4i6vkYJK/txYyliFJgvM0ONhwY7PLo3DA8xXafYnJ+V
         m+MnvrRla2XL3aRawOaWqEYj2YV60rwuiQ1u4VV7Yd73mxc8WvqdxhH+sZ0eGkdeEqdz
         Ci2dpWTZY/MERsZuWJvouWrroWlFOdxWjEjbhpVEbSUJjytz6Tl02y0velUCH0E24JAd
         UWzQ==
X-Gm-Message-State: AOAM532t95RBKIGhZkeHRTgPNRNI5Kph8M2GKSsmPmtfC6Rp8/ibFrOn
        41TaY8Qg1YuYs1eq74xy1OU=
X-Google-Smtp-Source: ABdhPJxisEMIEK380upIXqFHk8A/nFowAY4DOLW5fITy6E4TkRqDfyY42G3JbEyx9BS30i8tA6qcMA==
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr16823892plk.52.1598543164899;
        Thu, 27 Aug 2020 08:46:04 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:46:04 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 09/10] transport: parse report options for tracking refs
Date:   Thu, 27 Aug 2020 11:45:50 -0400
Message-Id: <20200827154551.5966-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
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
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 22 ++++++++---
 transport.c                                   | 37 +++++++++++++++----
 2 files changed, 45 insertions(+), 14 deletions(-)

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
index 75e97a0c20..213ec69d7a 100644
--- a/transport.c
+++ b/transport.c
@@ -436,29 +436,50 @@ int transport_refs_pushed(struct ref *ref)
 	return 0;
 }
 
-void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
+static void update_one_tracking_ref(struct remote *remote, char *refname,
+				    struct object_id *new_oid, int deletion,
+				    int verbose)
 {
 	struct refspec_item rs;
 
-	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
-		return;
-
 	memset(&rs, 0, sizeof(rs));
-	rs.src = ref->name;
+	rs.src = refname;
 	rs.dst = NULL;
 
 	if (!remote_find_tracking(remote, &rs)) {
 		if (verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
-		if (ref->deletion) {
+		if (deletion)
 			delete_ref(NULL, rs.dst, NULL, 0);
-		} else
-			update_ref("update by push", rs.dst, &ref->new_oid,
+		else
+			update_ref("update by push", rs.dst, new_oid,
 				   NULL, 0, 0);
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
+		update_one_tracking_ref(remote, ref->name, &ref->new_oid,
+					ref->deletion, verbose);
+	else
+		for (; report; report = report->next) {
+			refname = report->ref_name ? (char *)report->ref_name : ref->name;
+			new_oid = report->new_oid ? report->new_oid : &ref->new_oid;
+			update_one_tracking_ref(remote, refname, new_oid,
+						is_null_oid(new_oid), verbose);
+		}
+}
+
 static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     struct ref_push_report *report,
-- 
2.26.2.543.g44b58e439b

