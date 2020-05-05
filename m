Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8011AC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F07B206EB
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upp10mKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgEEBjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727795AbgEEBjr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:39:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DBDC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:39:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q124so279083pgq.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DbGokjD3txFLKPUsBfkxheLIouclb1CyZ1AqTYIaho=;
        b=upp10mKtJqZurfhOjAZIu4Gix+rFOqNhflC1ojcWA5qjgxnRU9fLJfM66idcOnqYdc
         Hxa+OglfKd2OfkFSxSeuh6FjtMBk9IL50devv+f8DNlxn86bIBzpZUJIp+x7tq+aK5K4
         K7AFTKcrh9VSgjtWaPxbx2hF1YivjPPBKstCMZXkFwkrHlwUl88O/jGObWX+hxInJVuK
         FQ65XkiQXKO1SoYHHmG0SGcB/lzUFj/me14biH5pIOZKygx5wc15Nc1oEgX004a0zM4I
         n+d3iEDkNg8A2qJIjZEi/Wei6w5TM7fVcxkpszeLHJzBp9bEx24S0P2Yk/viWELPguj0
         iKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DbGokjD3txFLKPUsBfkxheLIouclb1CyZ1AqTYIaho=;
        b=SjX3fhCX9opXrPsa3oHKkYsGUj1YgXIOn4o3Sy3cYlLR7qqI+v6wMqZBtgPRxAa0J3
         y+msv5hJjiEtcHZCciRpEpavI8iz+tQnkOJFP0yKufAxQ2sK2tOw8er7xHIrTKFHMPlY
         63e5XzCIQfvus2SpXlVGmF53vWk03Glb6HCuiaTkePRBK5z3IQPi0nyadpnSgIVsNXDS
         bOOvuSmeZrzilNlZpgVPt+yNfAIXvL4CZVnSrnMo3EYammNSm0rf14Z/J/WRsGfvwGI2
         xlwuVW9FVgZR5g8g2iQCrPlhE+YJfsifIu5TVIYCU2+raQkctzUIbxY4ybIn6FcOL7rg
         Fwgw==
X-Gm-Message-State: AGi0PuZ2+GgAw+zTHxLIKXlo1Ab05xhCX/e0+ofhlD63GBMFbRSX2dKk
        wUoxWMeK/MpXv5PgKAHZTUrzTEjC
X-Google-Smtp-Source: APiQypKjFavCUAVVr9qFNX0frFy5LXdFpTJMfzm563UyArJdt2T4OhYzi1JmYR1/ojyEhda1CQUKig==
X-Received: by 2002:aa7:84c5:: with SMTP id x5mr796594pfn.277.1588642786309;
        Mon, 04 May 2020 18:39:46 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e196sm352027pfh.43.2020.05.04.18.39.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 18:39:45 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 4/4] credential: document protocol updates
Date:   Mon,  4 May 2020 18:39:08 -0700
Message-Id: <20200505013908.4596-5-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200505013908.4596-1-carenas@gmail.com>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document protocol changes after CVE-2020-11008, while at it do some
minor improvements for clarity and consitency.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-credential.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 6f0c7ca80f..73a287e634 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -104,7 +104,7 @@ INPUT/OUTPUT FORMAT
 credential information in its standard input/output. This information
 can correspond either to keys for which `git credential` will obtain
 the login/password information (e.g. host, protocol, path), or to the
-actual credential data to be obtained (login/password).
+actual credential data to be obtained (username/password).
 
 The credential is split into a set of named attributes, with one
 attribute per line. Each attribute is
@@ -123,7 +123,8 @@ Git understands the following attributes:
 
 `host`::
 
-	The remote hostname for a network credential.
+	The remote hostname for a network credential.  This includes
+	the port number if one was specified.
 
 `path`::
 
@@ -134,7 +135,7 @@ Git understands the following attributes:
 `username`::
 
 	The credential's username, if we already have one (e.g., from a
-	URL, from the user, or from a previously run helper).
+	URL, the configuration, the user, or from a previously run helper).
 
 `password`::
 
@@ -146,8 +147,11 @@ Git understands the following attributes:
 	value is parsed as a URL and treated as if its constituent parts
 	were read (e.g., `url=https://example.com` would behave as if
 	`protocol=https` and `host=example.com` had been provided). This
-	can help callers avoid parsing URLs themselves.  Note that any
-	components which are missing from the URL (e.g., there is no
-	username in the example above) will be set to empty; if you want
-	to provide a URL and override some attributes, provide the URL
-	attribute first, followed by any overrides.
+	can help callers avoid parsing URLs themselves.
+
+	Note that specifying a protocol is mandatory and if the URL
+	type doesn't require a hostname (like for cert://) then an
+	empty ("")  hostname will be generated.
+
+	Components which are missing from the URL (e.g., there is no
+	username in the example above) will be left unset.
-- 
2.26.2.686.gfaf46a9ccd

