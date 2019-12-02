Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6361C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C89206E4
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oOiVGN1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfLBT6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:58:01 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:41378 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfLBT6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:58:00 -0500
Received: by mail-pf1-f202.google.com with SMTP id x6so510316pfx.8
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oH0BzhA4j3deiaqXsxtU9TOc1dj4ztjW0UuPMW1CofY=;
        b=oOiVGN1ZxVvL+4db1aRbj8cBN4Fc37yf0uOMeTVXQfR5+H0EV8lGm7EqaJyJuXSWJa
         e1uAEhE0Qd170DAG6u4QUIbiSgRGQnaMcGD3Ylx6IdNYBRrM21TTdqE8Vn0GBPWdPARK
         hSFyR/W4mAdLqCW4uD2j+GC8AyL0n99MDXoeghv+pN+PUgGPp5ROnARhMsK8OgZHND/l
         Mdtc2//R7L15ZwoqbmQJXj2M0gxeegrMv4MzIIoXferJ/nM/RS9GL+qN00Rtc/m3NHxS
         A/9tsYMFxuKgM+zuZUnFCQocZpB1bpPA0lYtrQfp4ku6lK/J6RkPDJQo79Cct/IW3aCn
         eIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oH0BzhA4j3deiaqXsxtU9TOc1dj4ztjW0UuPMW1CofY=;
        b=jadwQ89n5tDFaJkoCTLgk83SN2dEFWqM3LPXAZLdID8x4Nv9Tsda8b3JP1p54HZHI/
         kXKHyQaOREc6UUwf9E2qKzyY8ez5oZS5Y+RJazOE2zAEV3i3qhKmmNUaI2IRUHTCpXxN
         TKTsAqAFCH8+pOkI3AXH5sOLfyqcsBKao2CDsRssVsvqogVqIHYS3ndQmBSYbdjR9DU1
         VmwQ0DdXgNZIuA9mtklwcGeZ6nL1YOr8NP2VXtj3hScj0svnWRYVHQfUCW3avqD7A7+U
         0uBje9jY6yIIRNyou/ULGS58IDrXb7Xwa16FVVkQc2JY2SLdvxJQ9j19X6WFJMRMWCfs
         WCEw==
X-Gm-Message-State: APjAAAUuNiq38Cj3fU9gixumG133pkgO7cOrbZNKiwAs7b5ChYfkQVkJ
        hC0gEEpTSj6vtOasIViNKZcl2qDtlgXukhytiNfdHQbdGbA6KuXxGJcKLXELL4H39HS8TmUqBB3
        ilGNU5wQInS+BWmkXZQSPX9GyUGxradQtAfSlns/mwk9S1BQRTE+GXPZPArMec9RtRbLBB57lYF
        rH
X-Google-Smtp-Source: APXvYqxLk4KmFNuq1oRoOfxaCo7HnQEaUsy82yo+lDsZYI3mG88YepBzctDlrSESxmU9fBICcqr+n4eptEFpC+2rqGb9
X-Received: by 2002:a63:1013:: with SMTP id f19mr834629pgl.289.1575316679707;
 Mon, 02 Dec 2019 11:57:59 -0800 (PST)
Date:   Mon,  2 Dec 2019 11:57:51 -0800
In-Reply-To: <cover.1575316490.git.jonathantanmy@google.com>
Message-Id: <6de0eeac4ca2a3b5c35ad1ffaaa436ebbef3a27c.1575316490.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1574731649.git.jonathantanmy@google.com> <cover.1575316490.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2 1/2] Doc: explain submodule.alternateErrorStrategy
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 31224cbdc7 ("clone: recursive and reference option triggers
submodule alternates", 2016-08-17) taught Git to support the
configuration options "submodule.alternateLocation" and
"submodule.alternateErrorStrategy" on a superproject.

If "submodule.alternateLocation" is configured to "superproject" on a
superproject, whenever a submodule of that superproject is cloned, it
instead computes the analogous alternate path for that submodule from
$GIT_DIR/objects/info/alternates of the superproject, and references it.

The "submodule.alternateErrorStrategy" option determines what happens
if that alternate cannot be referenced. However, it is not clear that
the clone proceeds as if no alternate was specified when that option is
not set to "die" (as can be seen in the tests in 31224cbdc7). Therefore,
document it accordingly.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/submodule.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 0a1293b051..b33177151c 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -79,4 +79,6 @@ submodule.alternateLocation::
 submodule.alternateErrorStrategy::
 	Specifies how to treat errors with the alternates for a submodule
 	as computed via `submodule.alternateLocation`. Possible values are
-	`ignore`, `info`, `die`. Default is `die`.
+	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
+	or `info`, and if there is an error with the computed alternate, the
+	clone proceeds as if no alternate was specified.
-- 
2.24.0.393.g34dc348eaf-goog

