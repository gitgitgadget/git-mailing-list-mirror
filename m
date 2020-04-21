Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0EC54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C482076A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB6ahO7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgDUNMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUNMf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:12:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6AC061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so6584399pfg.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpbTyU3zepC+cB3HS5q+NtuYKOns6RRNNtTfLVybn3k=;
        b=FB6ahO7WEY0OLMj89EoowuoGm8r8GueiP+3FKyl2IcOD+x4nPXmUf34BVF3SlSpMV/
         HDmZCuoAhqL7Y8eyt3ZVcJonPFoyHPC28ZTenXGBTX0EecPp3/WA9kidAz5dQ3B7rHnt
         LcKfMrHaY7lKxh8wUbfKRU+MahWmHwhQXqT00DRaAaisU1F9sazU3UZeN2S6bBtCHiPs
         kIrKlGwC0eLI3DHJ/nGMnj7Azt1vO5kYq4mRZ8czDGdTPvOnBrTdlRuA7n2dDSX4Swp7
         /arpwIWisVmh9/Kc6N4keRMv6PIKwh8oS2fxIXJnFJTiDOj2IywWOe1+x4mnVUQyRyQA
         NoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpbTyU3zepC+cB3HS5q+NtuYKOns6RRNNtTfLVybn3k=;
        b=QCp0r5Fb5LNDIRXiAsGE0CW6irE6o71f4FdIsV8AM2XQL5cxWankSKbqsD+7dGn4Kr
         qup0Q1m1FVsSpOPPeIqKgqUhbpItHC5y9ZrvZuD6LNwfZ8wQdyhdIy5zmXN8ng+lIwsA
         o1IvuW+TjW5DRHeqmkMiu3i4GLbp4T3nRf8NFMdlLwPxMar/dzD+Zbi7XojM39086oXG
         FUg7jPldooK5GO0/qxa/dZJ86UZ9EH/8o9DF9IT6PkGRqLuG6qiHv1IEJ1jRnWYIta13
         oIKu0x1mQzgr8rkscnw+wHYRNuY2xQZ/fojxAmaLBA4x2I8VSnoz5rXe4WsBz484jE30
         V5sA==
X-Gm-Message-State: AGi0PuY8vfHNwwU77X1L37py70vlvhlBc4VRfRbvXa4CyOi5WHpgmwmO
        2fP8hNyTzEnCStMYfngY9m120uGWrI4=
X-Google-Smtp-Source: APiQypJUz4bvyDd1oqK+EM7B7xSWf/UWXYS3F2DV8iqdStGq79Ug6r7Aq1M587HBwtgc/Z76tcl80g==
X-Received: by 2002:a63:7c1:: with SMTP id 184mr20688903pgh.77.1587474754645;
        Tue, 21 Apr 2020 06:12:34 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id g2sm2451492pjd.9.2020.04.21.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:12:33 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 1/4] gitfaq: files in .gitignore are tracked
Date:   Tue, 21 Apr 2020 18:42:20 +0530
Message-Id: <20200421131223.29337-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
Git tracking files/paths mentioned in '.gitignore'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 1cf83df118..96767e7c75 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,6 +223,27 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate.  This second, modified
 file is usually ignored to prevent accidentally committing it.
 
+[[files-in-.gitignore-are-tracked]]
+I asked Git to ignore various files, yet they are still tracked::
+	Git ignores files matching the patterns stated in the '.gitignore'.
+	Consequently, `git add` does not add the files/paths matching the
+	pattern in `.gitignore`, meaning they remain untracked; `git status`
+	does not list the aforementioned files/paths as untracked.
+
+	One thing to note is that the `.gitignore` mechanism applies only
+	to the files that are not already tracked. A file/path that is
+	already tracked will stay to be tracked even if you add a pattern
+	that happens to match it to `.gitignore` file.
+
+	This is probably the reason why Git shows some files/paths in the
+	staging area. These entities were being tracked before and later
+	were added in the `.gitignore`, due to which they show up in the
+	staging area.
+
+	To completely ignore and untrack files/paths falling in the above
+	category, it is advised to use `git rm --cached <file>` as well as
+	add these files/paths in the `.gitignore`.
+
 Hooks
 -----
 
-- 
2.20.1

