Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BFC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E5B2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olW8kmg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFJVTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgFJVTh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC095C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so3944008wrv.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=24+EQLdEtdTw4Hh6W+l6EEDtsf8a/Ytytgm+i93Q6AU=;
        b=olW8kmg7t8r3AYBXoTQDO8ZMf/UT2XSwl7yMEVYZVy6J7k8QvCw1jD5ixMXKxfAa3Q
         JO3xd8AWQuQLnFxhY6WWBegnlHSxIkW6OehF3HnMFHpKES6JkCvsvsMIfeIWvfybDlKD
         il19+iHbLhk5NqY2zt02mNqej6U87OoYQ2Aazm4m+7Gp/D1BoNX6bk56QkjchGS+q+i+
         cT34g+jnG7MbsSAw15O72gg8vdUMRcv8xgb5mm6vi68N4DWOd0rbiiAuFC1jUk3NfheA
         7DHVuCdLTvrBtA1jAra01oQ266rj7RetIV0t3O8hTHTPllVEQQZYE2ApEu9qYH6eQsT3
         /2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=24+EQLdEtdTw4Hh6W+l6EEDtsf8a/Ytytgm+i93Q6AU=;
        b=rxd/vza/JYZ3LAuSBtuhytNMKsuAGl5HtzadRdVPrRb2YeNjv8Tm0igzWqVQUy8o1L
         TkOhkpE3PeveVdZ6r3bTfPiRXFrvnYp0hfPbMWvtS6FRHk45scj0534rY4ZbvpEcOZTM
         y4SWqO3SjdRdmLe+Oad/rgPDUvjt/CNQ3wII6Tizj4wwK5GCKxR2WoNZOZAcia/ZZ+PQ
         QA1x1drHxPvDiXyNtnYGon4IGhgFnoaW7T7jdBECjImc73xgospo9zj1O8rCeZK5OZDC
         PXRjKB6bjkYO0jLBai72Ji0aHp9WCEwGtWKSWBylgqcQyEAnZY8C5nDMe4tINEchXj2v
         zvIQ==
X-Gm-Message-State: AOAM530Oeo1XLYS35Ind/MoTt5wzpdoYgyIZPsMrELb4gmhaU8LpKyK7
        zCEaHDBocimXCO+52WKTVNMYyvQK
X-Google-Smtp-Source: ABdhPJyvUMJJ8dk8q2sn6v85JoDUVXKAGg7I3wxmxXEnCGLnkQhka9sT0qGHHBQRyHv5RKIyv3BCUg==
X-Received: by 2002:adf:fc81:: with SMTP id g1mr5901189wrr.156.1591823974537;
        Wed, 10 Jun 2020 14:19:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm1591898wrb.14.2020.06.10.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:34 -0700 (PDT)
Message-Id: <06a2cea051c01ebee38c9910425171f112daf41a.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:23 +0000
Subject: [PATCH 2/9] remote: respect `core.defaultBranchName`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When guessing the default branch name of a remote, and there are no refs
to guess from, we want to go with the preference specified by the user
for the fall-back.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 534c6426f1e..95fa8cc78e0 100644
--- a/remote.c
+++ b/remote.c
@@ -256,7 +256,7 @@ static void read_remotes_file(struct remote *remote)
 
 static void read_branches_file(struct remote *remote)
 {
-	char *frag;
+	char *frag, *default_branch_name = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen_or_warn(git_path("branches/%s", remote->name), "r");
 
@@ -276,7 +276,7 @@ static void read_branches_file(struct remote *remote)
 
 	/*
 	 * The branches file would have URL and optionally
-	 * #branch specified.  The "master" (or specified) branch is
+	 * #branch specified.  The default (or specified) branch is
 	 * fetched and stored in the local branch matching the
 	 * remote name.
 	 */
@@ -284,7 +284,7 @@ static void read_branches_file(struct remote *remote)
 	if (frag)
 		*(frag++) = '\0';
 	else
-		frag = "master";
+		frag = default_branch_name = git_default_branch_name(1);
 
 	add_url_alias(remote, strbuf_detach(&buf, NULL));
 	strbuf_addf(&buf, "refs/heads/%s:refs/heads/%s",
@@ -299,6 +299,7 @@ static void read_branches_file(struct remote *remote)
 	strbuf_addf(&buf, "HEAD:refs/heads/%s", frag);
 	refspec_append(&remote->push, buf.buf);
 	remote->fetch_tags = 1; /* always auto-follow */
+	free(default_branch_name);
 	strbuf_release(&buf);
 }
 
@@ -2099,7 +2100,10 @@ struct ref *guess_remote_head(const struct ref *head,
 
 	/* If refs/heads/master could be right, it is. */
 	if (!all) {
-		r = find_ref_by_name(refs, "refs/heads/master");
+		char *name = git_default_branch_name(0);
+
+		r = find_ref_by_name(refs, name);
+		free(name);
 		if (r && oideq(&r->old_oid, &head->old_oid))
 			return copy_ref(r);
 	}
-- 
gitgitgadget

