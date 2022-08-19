Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2550C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiHSDWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiHSDV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:21:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA8C7FB0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r69so2768497pgr.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zUJxeVBSLQhBv1hy0UZ1JJHVb3nKuQodY61E0cnhUOg=;
        b=prnmAvc2ODuJP1vPz/w+Nsc63ZVD65ZCd2QxRdbP0IhRF9TYrAcpsikE3AjH0kdWBt
         TDNfnc567zNpEBJ33zhUNz7XwthQ2K9Bcimkpb4BNnxjuja91DiTZaz88b5hjV64j3v/
         aTIaGc0agOtFjbF9G/3lsAUCxPevEcPxhFCWdn3FQUeq+kKfWF2w0/sjvca9t68JrV+u
         bACQ1/0NL+rfWAkpoYsF+orqeSg0iUmQ+6pTOGG05YWKiBtod8jUDjJXBPb4T9EyXTKJ
         gHR4Rne3WXF8wTj5rw6B7U4OZMp2B0kuIYXKPGM4TWtuChC2eEDzhcESZhQeI25c3cKm
         HUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zUJxeVBSLQhBv1hy0UZ1JJHVb3nKuQodY61E0cnhUOg=;
        b=4crgjy5VAxAcBZa6aIHR3KL0ev1KBlCMlSVaLfJAHlhKYnqAzRAqCJcv8PBjWhyNWJ
         195gJrekfjCADMJwXJ4XQOPRqrcgYMS/OX8WFwLJm4XjmzQpMfIXnBkj+1NBDEe6OyUU
         xmQDbEViUh6yKzBBvilWJXulsZxcDlDAk3xwNobBVzpRCQd7TSgkrn7Sz5yeTrkw6O8z
         hN49xbz8GHCITJxY6oXf7cvLZ651gA0XZKvkM+Zs+4b0x65TNGRUtuDZaf0Y8Rf4UQSg
         p6LvOgzf9Ke6769RyJQLJDmiYB6pbRFZk7dcTFHXaaWDUUZcT1UYpZ5JGIMBA9UdN9bT
         cg2A==
X-Gm-Message-State: ACgBeo1XVbx8i6VC923142Xkw13o7oJ6ob1AiSuftD9Geo/Q6g9HfFmR
        R4Xz3gOXIRQtnbUmANkaiHFD2K7PZns=
X-Google-Smtp-Source: AA6agR7AQf1Immh4lixSZzB8pxCzCYwbHEVHXtPC97XCma59POgXbxIR46cQJaMO/whgaNPUX8uDlQ==
X-Received: by 2002:a65:5847:0:b0:42a:df5:1035 with SMTP id s7-20020a655847000000b0042a0df51035mr3755227pgr.248.1660879314873;
        Thu, 18 Aug 2022 20:21:54 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:21:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 3/9] refs: add new field in transaction for running transaction hook
Date:   Fri, 19 Aug 2022 11:21:41 +0800
Message-Id: <20220819032147.28841-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add a new field "hook_flags" in transaction, and only run the
"reference-transaction" hook if the specific flag is turned on.

The "reference-transaction" hook has three states: prepared, committed,
and aborted. To update a reference, git may create two seperate
transactions, one for loose reference and one for packed ref-store. This
may cause duplicate running of the hook for same references. The new
field "hook_flags" in the transaction can turn off running a specific
transaction. In some scenarios, we may only want to turn off certain
states of a transaction, such as "committed" and "aborted", but want to
turn on the "prepared" state of the hook to do some pre-checks, so the
"hook_flags" field has three bits to control running of the three states
of the hook.

By calling the "ref_store_transaction_begin()" function, all the flags
of the "hook_flags" field for the new initialized transaction will be
turned on. The new function "ref_store_transaction_begin_extended()"
will be used in later commits with a specific "hook_flags" field to
initialize a new transaction.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c               | 25 +++++++++++++++++++++++--
 refs.h               |  3 +++
 refs/refs-internal.h |  8 ++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 90bcb27168..48b69460e2 100644
--- a/refs.c
+++ b/refs.c
@@ -998,17 +998,27 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	return 1;
 }
 
-struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
-						    struct strbuf *err)
+struct ref_transaction *ref_store_transaction_begin_extended(struct ref_store *refs,
+							     unsigned int hook_flags,
+							     struct strbuf *err)
 {
 	struct ref_transaction *tr;
 	assert(err);
 
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store = refs;
+	tr->hook_flags = hook_flags;
 	return tr;
 }
 
+struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    struct strbuf *err)
+{
+	return ref_store_transaction_begin_extended(refs,
+						    REF_TRANSACTION_RUN_ALL_HOOKS,
+						    err);
+}
+
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return ref_store_transaction_begin(get_main_ref_store(the_repository), err);
@@ -2074,6 +2084,17 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	const char *hook;
 	int ret = 0, i;
 
+	if (!strcmp(state, "prepared")) {
+		if (!(transaction->hook_flags & REF_TRANSACTION_RUN_PREPARED_HOOK))
+			return 0;
+	} else if (!strcmp(state, "committed")) {
+		if (!(transaction->hook_flags & REF_TRANSACTION_RUN_COMMITTED_HOOK))
+			return 0;
+	} else if (!strcmp(state, "aborted")) {
+		if (!(transaction->hook_flags & REF_TRANSACTION_RUN_ABORTED_HOOK))
+			return 0;
+	}
+
 	hook = find_hook("reference-transaction");
 	if (!hook)
 		return ret;
diff --git a/refs.h b/refs.h
index 47cb9edbaa..715127ab58 100644
--- a/refs.h
+++ b/refs.h
@@ -570,6 +570,9 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
+struct ref_transaction *ref_store_transaction_begin_extended(struct ref_store *refs,
+							     unsigned int hook_flags,
+							     struct strbuf *err);
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 						    struct strbuf *err);
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 69f93b0e2a..5220d1980d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -201,6 +201,13 @@ enum ref_transaction_state {
 	REF_TRANSACTION_CLOSED   = 2
 };
 
+#define REF_TRANSACTION_RUN_PREPARED_HOOK (1 << 0)
+#define REF_TRANSACTION_RUN_COMMITTED_HOOK (1 << 1)
+#define REF_TRANSACTION_RUN_ABORTED_HOOK (1 << 2)
+#define REF_TRANSACTION_RUN_ALL_HOOKS         \
+	(REF_TRANSACTION_RUN_PREPARED_HOOK  | \
+	 REF_TRANSACTION_RUN_COMMITTED_HOOK | \
+	 REF_TRANSACTION_RUN_ABORTED_HOOK)
 /*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
@@ -212,6 +219,7 @@ struct ref_transaction {
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
+	unsigned int hook_flags;
 	void *backend_data;
 };
 
-- 
2.36.1.25.gc87d5ad63a.dirty

