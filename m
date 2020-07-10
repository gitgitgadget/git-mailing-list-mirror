Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3EC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A17620725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+zU179F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGJQsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJQr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:47:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76304C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:47:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so6551317wmi.4
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=molETwuGaszKETlW0HceY5amLv6CUSe98xbvC1vd/mA=;
        b=L+zU179FZNP2jbE+w4dkrQ4TbhSWgvxHDnJSRHSrPNg6DzE81twY4zy6envlfGugUr
         PdYJyk9HC93oRN9EdyNzxMApFjbYONFbwvc+eBjqC0DXScJ+ELL4G0ksMsWZfYHZ6433
         ndp5g9q9hMMVr8MbQJPPV30cQjRQtNzgAqqe7eXPSkT+z1/cRyx9uzUEt8dJyIVFK14f
         3TXI5xrCe2+q5cbK3E30rD++GChKebJ5EtXyKOibDnD2gXJ9EKs1R+ayqvVplvhgFTz+
         k+PFsJaY6gtBQeR9rh7RHnngohNZOq8c/CWdLr+8anMe1OuOpiuJgjE64blYVmU3BoC5
         wwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=molETwuGaszKETlW0HceY5amLv6CUSe98xbvC1vd/mA=;
        b=Rp9vcXUwma60YEQUb9ZU6RLpGaQWR//fKDl67hpFyeUk5JgDgAUFe2kadIIm/UGg3m
         OH/rjIshC7nlpvyNQbQwBCZT+IuJBhBCvmQV/3TrdbR0J/TunSJSKB9KjZnFZ1Fr31ba
         tljOXxl1Bm6Hyjr51tteOnYee2dhM2dPwsoHmlI41fZdx/g0Tk/l3Hsts+9+IIf9fGQP
         fBVJvUduSkJfRgnvqgCgJEjbZv4AYIeCE4BICQn3Cco7JKTSAr7RsHuII3iqyuLSB6Wi
         ezMsKj+WxBbDZpPJYyPOUAYJcHdiCQrOgrN7TbP5P/CNv6zwGHJNT+8UDBFZD1hE+OTD
         vp9Q==
X-Gm-Message-State: AOAM533breTKs7mLstyaI7hs2grfTctt0+e0ABsxc4MBlmhOrszEjTaM
        YRo0BFxFrWGVJFtvJj28sRFocX6m85k=
X-Google-Smtp-Source: ABdhPJxIAmjakxEE4LmpYU3QcqEQdIgRiy4EuYAHzlnJcfR1EbE1qosJ6C5vSqyBARwtVeEn3kd8nw==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr5922424wmj.63.1594399677968;
        Fri, 10 Jul 2020 09:47:57 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.54])
        by smtp.gmail.com with ESMTPSA id m4sm9883385wmi.48.2020.07.10.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:47:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/3] Documentation: clarify %(contents:XXXX) doc
Date:   Fri, 10 Jul 2020 18:47:37 +0200
Message-Id: <20200710164739.6616-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.347.gb620d8b0da
In-Reply-To: <20200710164739.6616-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
 <20200710164739.6616-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's avoid a big dense paragraph by using an unordered
list for the %(contents:XXXX) format specifiers.

While at it let's also make the following improvements:

  - Let's not describe %(contents) using "complete message"
    as it's not clear what an incomplete message is.

  - Let's improve how the "subject" and "body" are
    described.

  - Let's state that "signature" is only available for
    tag objects.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6dcd39f6f6..b739412c30 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -232,12 +232,24 @@ Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
 
-The complete message in a commit and tag object is `contents`.
-Its first line is `contents:subject`, where subject is the concatenation
-of all lines of the commit message up to the first blank line.  The next
-line is `contents:body`, where body is all of the lines after the first
-blank line.  The optional GPG signature is `contents:signature`.  The
-first `N` lines of the message is obtained using `contents:lines=N`.
+The message in a commit or a tag object is `contents`, from which
+`contents:<part>` can be used to extract various parts out of:
+
+contents:subject::
+	The first paragraph of the message, which typically is a
+	single line, is taken as the "subject" of the commit or the
+	tag message.
+
+contents:body::
+	The remainder of the commit or the tag message that follows
+	the "subject".
+
+contents:signature::
+	The optional GPG signature of the tag.
+
+contents:lines=N::
+	The first `N` lines of the message.
+
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
 are obtained as `trailers` (or by using the historical alias
 `contents:trailers`).  Non-trailer lines from the trailer block can be omitted
-- 
2.27.0.347.gb620d8b0da

