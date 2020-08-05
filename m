Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DCDC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1BD20842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVVVbMgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHEBV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgHEBVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:21:08 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D9C061757
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:21:08 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s29so10813988qtc.12
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V/JMEPevwFwEsza3SZ1pzsNtyh/xUJw94pjt6KT4hlE=;
        b=rVVVbMgTFMSwzP5JQ+nbIYvkScgnZE+GVyoK3cMAaBVRcOk28YuD8ds0Kw/W31Jfmu
         xLxIb5GHtELPTwD1PfDtO23Ueui2a8ZRxAUOrtkfImuFr6Kge8GyzRkKXT2/qmjfU/qn
         m3j5gGMSapG6W8pXfhfZ0JNmSS/lR4XzGU16GyYjAHYznToY6lB1tg7aGB8AKRbiroGH
         bQe7ynRtG/sZjqJdVx8+HB2QRaGDOUAERfRG1YKUTwJpOC9xbafsCWhLeOMcg4iTc/n7
         1/tfZ36pO9Pc2cK8NdoYlgdU7iRQL8P66cZjtnr6XkIxMvTRbSMUumj3fiIMw1PaJwGY
         HAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V/JMEPevwFwEsza3SZ1pzsNtyh/xUJw94pjt6KT4hlE=;
        b=V0yLC+TkFCxiV6E9tZQXOx8idjY2qWND8l42iYEb4kKxIXW/8UBzDWGMRFWUkDvF+i
         0x8s6/SVA6H2UHH3yNvRu6JyAsIULPaTJM3n7tNT+lBTQ6McNUHnuR305A3CpBEi8v5y
         ZgqL6/NyVKlLbVw3ax0bpKde7Kn+SzqskbF+Ccu0dnz2BBR4yy8Y5XhDID5T91l5W3FU
         SfOg7266WmnCcGcTqmteGZfz5+kvTGcIg6Yrt2nVFBIOc16qkyj97R2PkZssYB7pfcvO
         gBQfg5s0AEBRP1OIMF1fyy+bnWG9vcCC95qtA/T1SWoEaILi5iMORAOitukhFtqtdicE
         HajQ==
X-Gm-Message-State: AOAM530fT8uM6JGH1B2gklWnOojddSkgJe43kQ3c8sHliPYYujSZ+K8P
        OPaIY6uddVgTuC7HVZXEaBO6cpmo2RxRrF7gRHTrUPCjX4BSznwJ7nNpIxFS35GvRvpD7ymwGF4
        PxR2yr1TQJRmurngM0BkRiuQ5KQ+nTrvxs+/LY1YTm/5bNun+sSEhqo5olrkIh2gAJBwRfi+w3g
        Rq
X-Google-Smtp-Source: ABdhPJwEzOb0bdha0mTmtB0UGO4Fa3uF/Ft3qRwJXv4iN1x9U1ragBzTOwgth0mpm1zfrr/2Rv8FPjlBFLL04Vuj0ETq
X-Received: by 2002:a05:6214:140d:: with SMTP id n13mr1224699qvx.69.1596590467219;
 Tue, 04 Aug 2020 18:21:07 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:50 -0700
In-Reply-To: <cover.1596590295.git.jonathantanmy@google.com>
Message-Id: <38bbad333e3eda1322943e29efabad9d9c6a996a.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1596590295.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 7/7] promisor-remote: use subprocess to fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 promisor-remote.c             | 46 ++++++++++++++++-------------------
 t/t0410-partial-clone.sh      |  2 +-
 t/t4067-diff-partial-clone.sh |  8 +++---
 t/t5601-clone.sh              |  2 +-
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index baaea12fd6..6e647610e9 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -3,6 +3,7 @@
 #include "promisor-remote.h"
 #include "config.h"
 #include "transport.h"
+#include "argv-array.h"
 
 static char *repository_format_partial_clone;
 static const char *core_partial_clone_filter_default;
@@ -12,39 +13,34 @@ void set_repository_format_partial_clone(char *partial_clone)
 	repository_format_partial_clone = xstrdup_or_null(partial_clone);
 }
 
-static int fetch_refs(const char *remote_name, struct ref *ref)
-{
-	struct remote *remote;
-	struct transport *transport;
-	int res;
-
-	remote = remote_get(remote_name);
-	if (!remote->url[0])
-		die(_("Remote with no URL"));
-	transport = transport_get(remote, remote->url[0]);
-
-	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	res = transport_fetch_refs(transport, ref);
-
-	return res;
-}
-
 static int fetch_objects(const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
 {
-	struct ref *ref = NULL;
+	struct child_process child = CHILD_PROCESS_INIT;
 	int i;
+	FILE *child_in;
+
+	child.git_cmd = 1;
+	child.in = -1;
+	argv_array_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=null",
+			 "fetch", remote_name, "--no-tags",
+			 "--no-write-fetch-head", "--recurse-submodules=no",
+			 "--filter=blob:none", "--stdin", NULL);
+	if (start_command(&child))
+		die(_("promisor-remote: unable to fork off fetch subprocess"));
+	child_in = xfdopen(child.in, "w");
 
 	for (i = 0; i < oid_nr; i++) {
-		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
-		oidcpy(&new_ref->old_oid, &oids[i]);
-		new_ref->exact_oid = 1;
-		new_ref->next = ref;
-		ref = new_ref;
+		if (fputs(oid_to_hex(&oids[i]), child_in) < 0)
+			die_errno(_("promisor-remote: could not write to fetch subprocess"));
+		if (fputc('\n', child_in) < 0)
+			die_errno(_("promisor-remote: could not write to fetch subprocess"));
 	}
-	return fetch_refs(remote_name, ref);
+
+	if (fclose(child_in) < 0)
+		die_errno(_("promisor-remote: could not close stdin to fetch subprocess"));
+	return finish_command(&child) ? -1 : 0;
 }
 
 static struct promisor_remote *promisors;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 463dc3a8be..3e454f934e 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -203,7 +203,7 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 	rm -rf repo/.git/objects/* &&
 	rm -f trace &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C repo cat-file -p "$HASH" &&
-	grep "git< fetch=.*ref-in-want" trace
+	grep "fetch< fetch=.*ref-in-want" trace
 '
 
 test_expect_success 'fetching of missing objects from another promisor remote' '
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index ef8e0e9cb0..804f2a82e8 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -20,7 +20,7 @@ test_expect_success 'git show batches blobs' '
 	# Ensure that there is exactly 1 negotiation by checking that there is
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
@@ -44,7 +44,7 @@ test_expect_success 'diff batches blobs' '
 	# Ensure that there is exactly 1 negotiation by checking that there is
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
@@ -127,7 +127,7 @@ test_expect_success 'diff with rename detection batches blobs' '
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD >out &&
 	grep ":100644 100644.*R[0-9][0-9][0-9].*b.*c" out &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
@@ -175,7 +175,7 @@ test_expect_success 'diff --break-rewrites fetches only if necessary, and batche
 	# by checking that there is only 1 "done" line sent. ("done" marks the
 	# end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --break-rewrites --raw -M HEAD^ HEAD &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 84ea2a3eb7..f82b0dbb5a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -702,7 +702,7 @@ test_expect_success 'batch missing blob request during checkout' '
 	# Ensure that there is only one negotiation by checking that there is
 	# only "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client checkout HEAD^ &&
-	grep "git> done" trace >done_lines &&
+	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
 
-- 
2.28.0.163.g6104cc2f0b6-goog

