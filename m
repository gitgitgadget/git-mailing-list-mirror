Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16BC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DBF20679
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbhAZWCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbhAZS4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:56:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307FC0617A9
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:56:03 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id q10so2089014pjd.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GC+Qe+I81O5/IqKRwi2EvOEyoChYPCdppBq1qYYRUEo=;
        b=D5gR4kiwNfStIgTk3uwgL5Y4YnE+ckMmtTQLOjYe81fqGYyVr0ymkCYNknREBNa1eG
         L9tkecbfQ63CTbx5Aj2RIQ8e5uRuVR7FoNXu80rkdj/myWQAKlkibu3Bbu5I/jiHrfXa
         +9Mus5HM2H+rApH+wdH7WSS5bgKIW/Zgqd1NAJDr8IBTHD0S+cwCUiKIiLyB54XOh5KO
         kB3+r7apWgScDBtyWAs6/ObnKlcsbUnH11nc8CNQnBa9CD6AWYpHz6NlJqukSWUAjEnM
         i4LKIHie57xyb4rfBPzm6VDvJMMwPSiMUD45dmD26siRnytCySR6Wrl3e+QW0ESxldnR
         RD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GC+Qe+I81O5/IqKRwi2EvOEyoChYPCdppBq1qYYRUEo=;
        b=h3UDn4FB/IV4uEodgQHx49rd2SNqacq/YUiGJ+reFoNcXd1s5tn0c9RilqLIyNU+6S
         PrUngd/kmOyLP8Jri2NfcTbAmtlufE6Tp/7ZCvUR9gEr01mx11JKrs6UMfZEf6fa+kJz
         5EJZNWTSeFChw26mJpo4Rxa3bFc3N89P/nNiKbAwUkpMXgmZ97BsUq1lW2tfsDwTLIj3
         o7IMj44hiZdla3b1V+Fm7f7m6nigu/7Pf1rJP4aWNS3dxrkQ21nOuxJ3orgL9R7XTF6V
         TvB+t+1vHytO2p1enNWmhy9eGWdw4mAGZ8xXIF3g7mvpDs90p1B8guXno2ifXQE2uJ0s
         JlEw==
X-Gm-Message-State: AOAM533rVVWMMFnfXEovspRIqqv44WYDY530Vw/RPfexaM0gyc++WeaX
        2BrbEh1PtaeMNhsHw0dK44GSAxyjrZ/KMyGGQnZTyc1BTKat+ihOyfIP2lm1F9OFU7vYad4Uw6d
        1WZojrzIZWcCaomzd4zfz7ckLIKIDXh6sev9LzgiLddT+UClrBUfLtTGkOoYPuvBTz/fI+gkUNB
        r/
X-Google-Smtp-Source: ABdhPJwW4o0P2NMSgNFwQl4Mk+VfJq8sUbukxjC4BdOvfCz2fPpezDxe6dZ2wPLm1a4BEPjS9VXBgiO2uHzy/SzIXQrn
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:f181:: with SMTP id
 bv1mr1205129pjb.57.1611687362692; Tue, 26 Jan 2021 10:56:02 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:55:55 -0800
In-Reply-To: <cover.1611686656.git.jonathantanmy@google.com>
Message-Id: <32e16dfdbd3f54c0d4b39cbd555e66aa3950fffd.1611686656.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com> <cover.1611686656.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning, we choose the default branch based on the remote HEAD.
But if there is no remote HEAD reported (which could happen if the
target of the remote HEAD is unborn), we'll fall back to using our local
init.defaultBranch. Traditionally this hasn't been a big deal, because
most repos used "master" as the default. But these days it is likely to
cause confusion if the server and client implementations choose
different values (e.g., if the remote started with "main", we may choose
"master" locally, create commits there, and then the user is surprised
when they push to "master" and not "main").

To solve this, the remote needs to communicate the target of the HEAD
symref, even if it is unborn, and "git clone" needs to use this
information.

Currently, symrefs that have unborn targets (such as in this case) are
not communicated by the protocol. Teach Git to advertise and support the
"unborn" feature in "ls-refs" (by default, this is advertised, but
server administrators may turn this off through the lsrefs.allowunborn
config). This feature indicates that "ls-refs" supports the "unborn"
argument; when it is specified, "ls-refs" will send the HEAD symref with
the name of its unborn target.

This change is only for protocol v2. A similar change for protocol v0
would require independent protocol design (there being no analogous
position to signal support for "unborn") and client-side plumbing of the
data required, so the scope of this patch set is limited to protocol v2.

The client side will be updated to use this in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt                |  2 +
 Documentation/config/lsrefs.txt         |  3 ++
 Documentation/technical/protocol-v2.txt | 10 ++++-
 ls-refs.c                               | 53 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 serve.c                                 |  2 +-
 t/t5701-git-serve.sh                    |  2 +-
 7 files changed, 66 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6ba50b1104..d08e83a148 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -398,6 +398,8 @@ include::config/interactive.txt[]
 
 include::config/log.txt[]
 
+include::config/lsrefs.txt[]
+
 include::config/mailinfo.txt[]
 
 include::config/mailmap.txt[]
diff --git a/Documentation/config/lsrefs.txt b/Documentation/config/lsrefs.txt
new file mode 100644
index 0000000000..dcbec11aaa
--- /dev/null
+++ b/Documentation/config/lsrefs.txt
@@ -0,0 +1,3 @@
+lsrefs.allowUnborn::
+	Allow the server to send information about unborn symrefs during the
+	protocol v2 ref advertisement.
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 85daeb5d9e..4707511c10 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -192,11 +192,19 @@ ls-refs takes in the following arguments:
 	When specified, only references having a prefix matching one of
 	the provided prefixes are displayed.
 
+If the 'unborn' feature is advertised the following argument can be
+included in the client's request.
+
+    unborn
+	The server may send symrefs pointing to unborn branches in the form
+	"unborn <refname> symref-target:<target>".
+
 The output of ls-refs is as follows:
 
     output = *ref
 	     flush-pkt
-    ref = PKT-LINE(obj-id SP refname *(SP ref-attribute) LF)
+    obj-id-or-unborn = (obj-id | "unborn")
+    ref = PKT-LINE(obj-id-or-unborn SP refname *(SP ref-attribute) LF)
     ref-attribute = (symref | peeled)
     symref = "symref-target:" symref-target
     peeled = "peeled:" obj-id
diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..4077adeb6a 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -32,6 +32,8 @@ struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
 	struct strvec prefixes;
+	unsigned allow_unborn : 1;
+	unsigned unborn : 1;
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
@@ -47,7 +49,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	if (!ref_match(&data->prefixes, refname_nons))
 		return 0;
 
-	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	if (oid)
+		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	else
+		strbuf_addf(&refline, "unborn %s", refname_nons);
 	if (data->symrefs && flag & REF_ISSYMREF) {
 		struct object_id unused;
 		const char *symref_target = resolve_ref_unsafe(refname, 0,
@@ -74,8 +79,30 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int ls_refs_config(const char *var, const char *value, void *data)
+static void send_possibly_unborn_head(struct ls_refs_data *data)
 {
+	struct strbuf namespaced = STRBUF_INIT;
+	struct object_id oid;
+	int flag;
+	int oid_is_null;
+
+	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
+	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
+		return; /* bad ref */
+	oid_is_null = is_null_oid(&oid);
+	if (!oid_is_null ||
+	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
+		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
+	strbuf_release(&namespaced);
+}
+
+static int ls_refs_config(const char *var, const char *value, void *cb_data)
+{
+	struct ls_refs_data *data = cb_data;
+
+	if (!strcmp("lsrefs.allowunborn", var))
+		data->allow_unborn = git_config_bool(var, value);
+
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
 	 * config. This may need to eventually be expanded to "receive", but we
@@ -91,7 +118,8 @@ int ls_refs(struct repository *r, struct strvec *keys,
 
 	memset(&data, 0, sizeof(data));
 
-	git_config(ls_refs_config, NULL);
+	data.allow_unborn = 1;
+	git_config(ls_refs_config, &data);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
@@ -103,14 +131,31 @@ int ls_refs(struct repository *r, struct strvec *keys,
 			data.symrefs = 1;
 		else if (skip_prefix(arg, "ref-prefix ", &out))
 			strvec_push(&data.prefixes, out);
+		else if (data.allow_unborn && !strcmp("unborn", arg))
+			data.unborn = 1;
 	}
 
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ls-refs arguments"));
 
-	head_ref_namespaced(send_ref, &data);
+	send_possibly_unborn_head(&data);
 	for_each_namespaced_ref(send_ref, &data);
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
 	return 0;
 }
+
+int ls_refs_advertise(struct repository *r, struct strbuf *value)
+{
+	if (value) {
+		int allow_unborn_value;
+
+		if (repo_config_get_bool(the_repository,
+					 "lsrefs.allowunborn",
+					 &allow_unborn_value) ||
+		    allow_unborn_value)
+			strbuf_addstr(value, "unborn");
+	}
+
+	return 1;
+}
diff --git a/ls-refs.h b/ls-refs.h
index 7b33a7c6b8..a99e4be0bd 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -6,5 +6,6 @@ struct strvec;
 struct packet_reader;
 int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request);
+int ls_refs_advertise(struct repository *r, struct strbuf *value);
 
 #endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index eec2fe6f29..ac20c72763 100644
--- a/serve.c
+++ b/serve.c
@@ -73,7 +73,7 @@ struct protocol_capability {
 
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
-	{ "ls-refs", always_advertise, ls_refs },
+	{ "ls-refs", ls_refs_advertise, ls_refs },
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index a1f5fdc9fd..df29504161 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -12,7 +12,7 @@ test_expect_success 'test capability advertisement' '
 	cat >expect <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
-	ls-refs
+	ls-refs=unborn
 	fetch=shallow
 	server-option
 	object-format=$(test_oid algo)
-- 
2.30.0.280.ga3ce27912f-goog

