Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B2DC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4012074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ztvj04WQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgFJU5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgFJU5h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE3C03E96F
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e82so3276524ybh.12
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dAdeE1q74RUTuOow1MiM3IstSGRLsgP6iKELLj5CsKQ=;
        b=Ztvj04WQhfy2U7VwRAyM8AI65aLd35b6L8WpByNVr4ytQ1inRi5wpS6GUHRklNS8u2
         hiG5oXYKliMs200S8xLHC/T8zN3aEzGFPFEf84XRor9Q7h9vRm5pK2Q2nn8xhdPqiZpE
         6WZbTNv9+UEk9ZOZPTmlkU0ERn5dF8F3UntqfS4JRlRi4veU+TPUF2++1gwZ9OxiVlS9
         XmUqGm0yIRSBbkywycgANyDPl/iRvKJEfYPcF+eYTQpGQ2WXL45ohF7XHgJoqrcwOVYE
         TqXd992LHzyRC8UuGM0wNTnF6EaxtmhCIdt2lqdwAolh0xknX6TzHiQLsHDia+0N7cRH
         WJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dAdeE1q74RUTuOow1MiM3IstSGRLsgP6iKELLj5CsKQ=;
        b=DypRrF84b15wpaJeciHTbDEEIlvRFhBK1iSp2zEvFnQI9qVWnv3LZuIWjGTLPCZewE
         gRUNoBm6JUrFsdeQF+sTa8Yt8rm6Y6iewk0ucoX+N/lMQhTetGk3CEhiavrsGMZg5OIj
         wtqMDgmtT3CsCQ4l+C+I5JRgKCgQsuNeB+MLBbxejrlPCtqdid2h3LUFYN0srQS3jLzk
         eSIbNjEa9xpct6SehcvKBB1L4v17g566aH+z80pgnidJygd9JcabkEEAuJD5pd36lCum
         iJ4wI7WIh1AEE25XIwe1aBgPBbNPmuQizfnj6qdEmDQpLs1xZtG3jKQTvmf/hexHwKWc
         UK4Q==
X-Gm-Message-State: AOAM532hI7hQJKg1ExYJ7vPftLfvKk/wYOdDZOyGMM0c6xjqqlCddsed
        9TsgT5YiSGG+0byaCW1qUf+8Li4HP5A4j7rhIpe7x6QfuNi4yxGCQPz8nrbuqeauZMJcWz8GUCi
        3MOmCeP7Iwb6pRgPQstqLJf+GG7D9OD78XzbzqiSo6bBcGilrFpYb/sFisJCxYnYqsfk7wGs1EB
        8S
X-Google-Smtp-Source: ABdhPJyY1XBZqHGK7Nz447rtdBKCNTO5FAP9suxQtSOKMmznHBI5MG/5KE0SiXFYuWaihays2ECBI3gbYZBWqHG1vDFl
X-Received: by 2002:a25:aaec:: with SMTP id t99mr8534439ybi.337.1591822655558;
 Wed, 10 Jun 2020 13:57:35 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:19 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <6994b22b0fd36ece6cf6d9967f0d5c1f8f9481ac.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 5/9] Documentation: order protocol v2 sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current C Git implementation expects Git servers to follow a
specific order of sections when transmitting protocol v2 responses, but
this is not explicit in the documentation. Make the order explicit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 7e3766cafb..995f07481e 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -325,11 +325,11 @@ included in the client's request:
 
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
-header.
+header. Most sections are sent only when the packfile is sent.
 
-    output = *section
-    section = (acknowledgments | shallow-info | wanted-refs | packfile)
-	      (flush-pkt | delim-pkt)
+    output = acknowledgements flush-pkt |
+	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
+	     [wanted-refs delim-pkt] packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -351,9 +351,10 @@ header.
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
     acknowledgments section
-	* If the client determines that it is finished with negotiations
-	  by sending a "done" line, the acknowledgments sections MUST be
-	  omitted from the server's response.
+	* If the client determines that it is finished with negotiations by
+	  sending a "done" line (thus requiring the server to send a packfile),
+	  the acknowledgments sections MUST be omitted from the server's
+	  response.
 
 	* Always begins with the section header "acknowledgments"
 
@@ -404,9 +405,6 @@ header.
 	  which the client has not indicated was shallow as a part of
 	  its request.
 
-	* This section is only included if a packfile section is also
-	  included in the response.
-
     wanted-refs section
 	* This section is only included if the client has requested a
 	  ref using a 'want-ref' line and if a packfile section is also
-- 
2.27.0.278.ge193c7cf3a9-goog

