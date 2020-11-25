Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7001C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435232075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 18:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=powertools-tech.com header.i=@powertools-tech.com header.b="FfJZ7lQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbgKYSb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 13:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbgKYSb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 13:31:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABC2C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 10:31:26 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so2872423wrw.10
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=powertools-tech.com; s=gsuite;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L6F69PZ7MFCzXqPYzWcRsH1Qs1hF5mLUP+/m2qDAt4U=;
        b=FfJZ7lQzDfBDep+BGczlPAcvhA20wfq7jVYckySMQYlmHkapx/knn/aR8rsj9ZFzN9
         4SC8aKRtHtIZxImtPJABu6f65bg3fjaNuMgN8TR26CYufAjJFxNlgJ1HBhoOr6O7mRkT
         e9tzBPz5S4YiXH6VwA9W6ggLp1wgMlPQkaJN6Vg8suvEqj5llZnQU4SfQKE7NYpQR3v8
         5hIHNvUcczHozt/u6juGbFLWXvLi5NzdKjdx7T3G3cH2EdG17CNFtqZNKdAdEvN3Uwvk
         iQ00sqkrrz1p6jIWEwVAD+vKjd8fNAiwoxYJuE0aDsnoUDcbUZyXC9tVemnQAt8DKb6X
         qmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L6F69PZ7MFCzXqPYzWcRsH1Qs1hF5mLUP+/m2qDAt4U=;
        b=jSUGojQSCk5LPdQ9k8FJ7lnQdS/+YooSxX924za8cv1gIpSgJ3zKnwDas2HIrkDVoh
         A9bk+If8LjYTrmVQ+Kbp+02z1nFB/7zTSczQVMDonBmlJ9jory1tivkYGYO9E1+nddAh
         MR7Qh9AZ+5OF0w8UqocLP9YdLBzvKaeP9ZP4aaJZvaibNoX6IZGOkeuz3gAmpGhvQWt5
         kchZRIUY2vi/HysypfBm0jRC6eUuq8YEu4ylj/tDcxZLcJb/aXOQSUpw6c7Q6RSRlLA6
         LelIqT0OTdvNnbc92PKnPxadNJ6gNAW8zm6zR90LfxW9+x4rHG4bL8Z2ne9gcg5E+Gqx
         g6MA==
X-Gm-Message-State: AOAM530z5+U8l2QzDGceEKEsGIOH+dYtSXgxXR37lzn5YzReuXZlPoaZ
        mw4TW76WNOsL9pf1VOqGRXO/MWpIj/0vcoFs
X-Google-Smtp-Source: ABdhPJzOkzEIqDfmFLUy7bI/55vG1Xul+rP6cPxjJfIQFf3hgIXK4cekOvYqGIoQPAvLjan+fARtDA==
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr5685025wrt.150.1606329084999;
        Wed, 25 Nov 2020 10:31:24 -0800 (PST)
Received: from localhost (96.192.189.46.rev.vodafone.pt. [46.189.192.96])
        by smtp.gmail.com with ESMTPSA id d3sm5292052wrr.2.2020.11.25.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 10:31:24 -0800 (PST)
Date:   Wed, 25 Nov 2020 18:31:23 +0000
From:   =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Jeff King <peff@peff.net>
Subject: [PATCH v3] crendential-store: use timeout when locking file
Message-ID: <20201125183123.47praa6hcgrgrib4@safonso-t430>
References: <xmqq4kleif26.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4kleif26.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When holding the lock for rewriting the credential file, use a timeout
to avoid race conditions when the credentials file needs to be updated
in parallel.

An example would be doing `fetch --all` on a repository with several
remotes that need credentials, using parallel fetching.

The timeout can be configured using "credentialStore.lockTimeoutMS",
defaulting to 1 second.

Signed-off-by: Simão Afonso <simao.afonso@powertools-tech.com>
---

lockTimeoutMS sounds like the consensual name, implemented.

 Documentation/config/credential.txt | 6 ++++++
 builtin/credential-store.c          | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
index 9d01641c2..512f31876 100644
--- a/Documentation/config/credential.txt
+++ b/Documentation/config/credential.txt
@@ -28,3 +28,9 @@ credential.<url>.*::
 
 credentialCache.ignoreSIGHUP::
 	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
+
+credentialStore.lockTimeoutMS::
+	The length of time, in milliseconds, for git-credential-store to retry
+	when trying to lock the credentials file. Value 0 means not to retry at
+	all; -1 means to try indefinitely. Default is 1000 (i.e., retry for
+	1s).
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 5331ab151..ae3c1ba75 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "config.h"
 #include "lockfile.h"
 #include "credential.h"
 #include "string-list.h"
@@ -58,8 +59,11 @@ static void print_line(struct strbuf *buf)
 static void rewrite_credential_file(const char *fn, struct credential *c,
 				    struct strbuf *extra)
 {
-	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
-		die_errno("unable to get credential storage lock");
+	int timeout_ms = 1000;
+
+	git_config_get_int("credentialstore.locktimeoutms", &timeout_ms);
+	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
+		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
 	if (extra)
 		print_line(extra);
 	parse_credential_file(fn, c, NULL, print_line);
-- 
2.29.2

