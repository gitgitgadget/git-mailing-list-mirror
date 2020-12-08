Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF26C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 01:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2086221FD
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 01:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgLHBcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgLHBcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 20:32:11 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501FC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 17:31:25 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i11so13084734qvo.11
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 17:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=nP0ch+rpC1OH0pzccZrCiB2i54pz1HQP/KcsTc58oD4=;
        b=Z6636E3NaFuv4sNNWdXoPqIw2O1f41vJKMcMPYjPLff4Qx12mvm5wms522DXKtIB1S
         iO6oEp62AQuBr52tt+H2VDbmNWWVDSak+inW9OEnMs3sXOQeukJgdKjUCQGB5JnfI1kf
         PTnPOFcX4FjLBOgszOXbJTEIwoi5GtIfl23HuBLbABkLZYZ5IqGxGb1/phcAjAm8/bMy
         gvK/VZw4A2Xu8vdSIhCRR7XgniTirBrO1g02sX6MUZcXBgJpoxuOii1V3++ZfsRR/wOS
         nXwp/T9u/sJ1a7EEDIeSn6W4GeLHQOKvT3GWtWjR9ckN7HBqozjdB5+y8df76pONEyvF
         19ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=nP0ch+rpC1OH0pzccZrCiB2i54pz1HQP/KcsTc58oD4=;
        b=RNlKQnHr/VQg39PpycjTVOutxmQ/MNdI9JGlUB+CGi42HIy5lUa267sio5GOOzUk2O
         Rdo7f132LUK/ic7FVfznYiqAGaQo7bY2wu7axhKbY0UK9CM3r9X71b1Stks0UBGKxr7j
         Qe4Fd/g1r1s55kheOtucaJ19Ky79WR6LC/7yOzsyE0Fh6RvRbufLPU3UiGdP5SKhV6CN
         Y9kB/GtrrcXPa4XpdqBeuxTv0Kxkw6A3OTMOkx9wlglntr/hhz5X7RpsT/s6ymDZvT5C
         A9pUpkg6opFxA4TIUaI7ZLx8IeyzQ0DDuz74lqp4ECHCUNhXvHt4KiM7fFw1kTYcHUPR
         DvGQ==
X-Gm-Message-State: AOAM533uxv9X6KaMMtIoKS2wRmdWrJ9kK93UGMajkQ4qFuIfCb5rRidU
        fKSvwxaYXWGV+9jq6exLOzl3yhaGJ3Ff9+mLfPU3O/6RrVoP6PeO7FkM08jZ9CbldjkZeHCDZBS
        M7YxvU3cg6VOwy81pnQIL9yQo1FlTd+tiRtobacxDFBB9iF4oIBfy+dJ5p/YTUTxIx4sXC82+SC
        zS
X-Google-Smtp-Source: ABdhPJx5kE0e+xuQANnxVoRyo6oqvKvLC4lhhRCrX08OvydMI3davFJwMiM4eodpME54JdUJPU8hX5EHlH3SCIe4QR5o
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:d68d:: with SMTP id
 k13mr24776482qvi.62.1607391084587; Mon, 07 Dec 2020 17:31:24 -0800 (PST)
Date:   Mon,  7 Dec 2020 17:31:20 -0800
Message-Id: <20201208013121.677494-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Cloning empty repository uses locally configured default branch name
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning an empty repository, a local branch is created. But its
name is not the name of the branch that the remote HEAD points to - it
is the locally configured default branch name. This issue arose at
$DAYJOB and, from my memory, it is also not an uncommon workflow to
configure things online on a repo host and then use "git clone" so that
things like remotes are automatically configured.

Has anyone looked into solutions for this? Both protocol v0 and v2 do
not send symref information about unborn branches (v0 because, as
protocol-capabilities.txt says, "servers SHOULD include this capability
for the HEAD symref if it is one of the refs being sent"; v2 because
a symref is included only if it refers to one of the refs being sent).
In protocol v2, this could be done by adding a capability to ls-remote
(maybe, "unborn"), and in protocol v0, this could be done either by
updating the existing "symref" capability to be written even when the
target branch is unborn (which is potentially backwards incompatible) or
introducing a new capability which is like "symref".

A small issue is that upload-pack protocol v0 doesn't even write the
blank ref line ("000...000 capabilities^{}") if HEAD points to an unborn
branch, but that can be fixed as in the patch below.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 upload-pack.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 1006bebd50..d2359a8560 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1179,18 +1179,15 @@ static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 		strbuf_addf(buf, " symref=%s:%s", item->string, (char *)item->util);
 }
 
-static int send_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cb_data)
+static const char *capabilities = "multi_ack thin-pack side-band"
+	" side-band-64k ofs-delta shallow deepen-since deepen-not"
+	" deepen-relative no-progress include-tag multi_ack_detailed";
+
+static void write_ref_lines(const char *refname_nons,
+			    const struct object_id *oid,
+			    const struct object_id *peeled,
+			    struct upload_pack_data *data)
 {
-	static const char *capabilities = "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow deepen-since deepen-not"
-		" deepen-relative no-progress include-tag multi_ack_detailed";
-	const char *refname_nons = strip_namespace(refname);
-	struct object_id peeled;
-	struct upload_pack_data *data = cb_data;
-
-	if (mark_our_ref(refname_nons, refname, oid))
-		return 0;
 
 	if (capabilities) {
 		struct strbuf symref_info = STRBUF_INIT;
@@ -1213,8 +1210,23 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		packet_write_fmt(1, "%s %s\n", oid_to_hex(oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_ref(refname, &peeled))
-		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
+	if (peeled)
+		packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(peeled), refname_nons);
+}
+
+static int send_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cb_data)
+{
+	const char *refname_nons = strip_namespace(refname);
+	struct object_id peeled;
+	struct upload_pack_data *data = cb_data;
+
+	if (mark_our_ref(refname_nons, refname, oid))
+		return 0;
+	write_ref_lines(refname_nons,
+			oid,
+			peel_ref(refname, &peeled) ? NULL : &peeled,
+			data);
 	return 0;
 }
 
@@ -1332,6 +1344,8 @@ void upload_pack(struct upload_pack_options *options)
 		reset_timeout(data.timeout);
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
+		if (capabilities)
+			write_ref_lines("capabilities^{}", &null_oid, NULL, &data);
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-- 
2.29.2.576.ga3fc446d84-goog

