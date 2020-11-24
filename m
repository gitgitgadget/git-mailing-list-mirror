Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3DEC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E37620857
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=powertools-tech.com header.i=@powertools-tech.com header.b="a2Xe3NDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKXTcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKXTcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 14:32:12 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F95C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:32:12 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so55212wmh.4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=powertools-tech.com; s=gsuite;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=95ObWto5iafo0Q6KDkAabAPYaTQqKdypaN5Yab+mIvg=;
        b=a2Xe3NDvr8UXrsX5dvoAxXL771CGlGlZ1TAZP1vC+RTTAhbakZTp1rr+LZC0cEqRDA
         +Gd2aJABODaUxjVLNfuu4klb/sUwJqprc9w+UoDwecQlntW0C99wvZiPirwwA4TgMQDs
         +a9YEBanHTq3NrC52n1Eb01Q2qBy/0Rt+zLsqSr5IK0M250IbWMVoa0qNmHtc35bHXYT
         1N3pvu7VmCmSN5R1mQbnJhEAwWkpB8eneVll0kXWiptvo/3lbqweRKcdroKZsVfOXUoZ
         9v+H8WiAzx5A64vRb3FBmy7v/hj2DwUFcFEhRJyQqiv6dT+OViK1htekyJwu38u8TKF8
         /HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=95ObWto5iafo0Q6KDkAabAPYaTQqKdypaN5Yab+mIvg=;
        b=DiAIj9AIuQg4rG5E56YqRoQecN7wBJKV0+9NEpgCNQ4vUEgK15Rih/1/NQn9Isu9K1
         p0mEx1FSXctdwXzjfOHds4GzdC4sHyNX/E+xVXBRNBicr1+xCiH7rNbObBRoCHS+fyuT
         TjooW4YbFnEQkui6/shOd7D/LfTFwfdjM03gIpkohj/W875L2XfWT2lnzl0DQwVCFTVg
         /fZnxSqIMQy17NT7Px3r8emhlyhiXBbpAFDiObTdSUDsvH6WxdP54SaagJuFC+HnGqQH
         OuP92ce8I3o3PYsxtkyiEsx1Mp8y9OzveE3vMSbt8zJ/TNsFxKFur5jx+QkvM0BoKhYX
         cWVw==
X-Gm-Message-State: AOAM5312VFspw2JUolC30NqyUN+Ye0Pr1sXytJhMWjoOlIcffEVRvBUB
        lUqWrV2b9XkiptQzVRBiTYWWC0hbmQQe0ha7
X-Google-Smtp-Source: ABdhPJxBJlQMV13a0R8eHc50xkM6f7MdvYEdOHyP/s38tEhQZOw1yVPa2yNBnGB0pQOkE3EWqGlB2g==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr35658wme.23.1606246330646;
        Tue, 24 Nov 2020 11:32:10 -0800 (PST)
Received: from localhost (96.192.189.46.rev.vodafone.pt. [46.189.192.96])
        by smtp.gmail.com with ESMTPSA id q17sm32457862wro.36.2020.11.24.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:32:09 -0800 (PST)
Date:   Tue, 24 Nov 2020 19:32:08 +0000
From:   =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Jeff King <peff@peff.net>
Subject: [PATCH v2] crendential-store: use timeout when locking file
Message-ID: <20201124193208.74fe4mticgkbxou3@safonso-t430>
References: <xmqq361v334r.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq361v334r.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When holding the lock for rewriting the credential file, use a timeout
to avoid race conditions when the credentials file needs to be updated
in parallel.

An example would be doing `fetch --all` on a repository with several
remotes that need credentials, using parallel fetching.

The timeout can be configured using "credentialStore.fileTimeout",
defaulting to 1 second.

Signed-off-by: Simão Afonso <simao.afonso@powertools-tech.com>
---

Thanks for the review.
I got stuck with work and only got around to tweak this now.

I added a configurable timeout with the old value as default. I think
that txt file is the only documentation that requires update for a new
configuration value.

 Documentation/config/credential.txt | 6 ++++++
 builtin/credential-store.c          | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
index 9d01641c2..132e04b47 100644
--- a/Documentation/config/credential.txt
+++ b/Documentation/config/credential.txt
@@ -28,3 +28,9 @@ credential.<url>.*::
 
 credentialCache.ignoreSIGHUP::
 	Tell git-credential-cache--daemon to ignore SIGHUP, instead of quitting.
+
+credentialStore.fileTimeout::
+	The length of time, in milliseconds, for git-credential-store to retry
+	when trying to lock the credentials file. Value 0 means not to retry at
+	all; -1 means to try indefinitely. Default is 1000 (i.e., retry for
+	1s).
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 5331ab151..82284176e 100644
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
+	git_config_get_int("credentialstore.filetimeout", &timeout_ms);
+
+	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
+		die_errno("unable to get credential storage lock in %d ms", timeout_ms);
 	if (extra)
 		print_line(extra);
 	parse_credential_file(fn, c, NULL, print_line);
-- 
2.29.2

