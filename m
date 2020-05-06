Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71618C47257
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51491207DD
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmfbqQ2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgEFVsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730070AbgEFVsn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 17:48:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F7C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 14:48:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so1815018pfn.5
        for <git@vger.kernel.org>; Wed, 06 May 2020 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13inzRfMOlffHor+h7wStuH7wnoKqH/fF4t9Dt5wM2g=;
        b=LmfbqQ2/GSmjbxhmPk+4UrytXVGt/Tw5DHBYlMPz+naI+d8tezvLxa0U/ttGgJmYFn
         +TJY0dXrvsUck/b55q3QnEsEN2SJjEYokiy5durtj1NBni9soahnKpdUSwuxNDKAm6En
         QMpgKZzqZorifH5grdsYr9Zvxk6mhSDjJH6lf3kwWxISdtf8meIkECR1IKSAwz6+Gv3/
         m8vRGkgkxgWav/5ykCQ4ogmBKTzL2Jn/hZqn799UPGc5CrlmI9aIqpziFwrpAWsJ7hrS
         XayebTwbGR/fo6qNAkAJIoCSxJQC9toVWK7Eg+z0DRipHp52Kxto9WRP7F0jELdQXr8L
         KiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13inzRfMOlffHor+h7wStuH7wnoKqH/fF4t9Dt5wM2g=;
        b=FmFOmRodJttKOKG3dsNcy5kHa4sg3hCim6mNp/p/KGk1VS1wIn0AIegJW7BHnd1d1X
         pyw/o4lzLAPYlelA6ihfzFFdplmOoiqQH5tcy1YsYA2FO3rKsH7O8ixH12/ZGA3CmloI
         IJ+NKs1mQD2XL5qpUU8jjd6FBn/cRrIbDzWqrN+nejmp6JluxKWx+mlJB64WPmwSAizk
         dr897kAemp22Ds/NV31Nk7HlidGbLnb8eihqpSuOD8KuUaB6K4qQ2QQXv9d6tALVkTQB
         dTRot9SwOGmZq2H7ArZ91h39wOx/xzQvGGycBLdB3z/KXCBOvFUBt//Kj3AQewpDnnkV
         0Qdw==
X-Gm-Message-State: AGi0Pua8Own2THQl2z1+gClkqHH+I956jsXnYAi/woeGY2/enof4Z3+t
        zB2MOsr97J9WUotTQ7Xqo6IiOKrA
X-Google-Smtp-Source: APiQypKkTiXFlwZS2hAvasTkAWB5i4plsWB/QhGmJ3jtAuvCxOY4tQcSl2DpVS6NyJ48W/umKgCe7w==
X-Received: by 2002:a62:3857:: with SMTP id f84mr11086265pfa.56.1588801722267;
        Wed, 06 May 2020 14:48:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z7sm2703432pff.47.2020.05.06.14.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 14:48:41 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 4/4] credential: document protocol updates
Date:   Wed,  6 May 2020 14:47:26 -0700
Message-Id: <20200506214726.81854-5-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200506214726.81854-1-carenas@gmail.com>
References: <20200505013908.4596-1-carenas@gmail.com>
 <20200506214726.81854-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document protocol changes after CVE-2020-11008, including the removal of
references to the override of attributes which is no longer recommended
after CVE-2020-5260 and that might be removed in the future.

While at it do some improvements for clarity and consistency.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-credential.txt | 34 ++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 6f0c7ca80f..8d990e92fd 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -103,17 +103,20 @@ INPUT/OUTPUT FORMAT
 `git credential` reads and/or writes (depending on the action used)
 credential information in its standard input/output. This information
 can correspond either to keys for which `git credential` will obtain
-the login/password information (e.g. host, protocol, path), or to the
-actual credential data to be obtained (login/password).
+the login information (e.g. host, protocol, path), or to the actual
+credential data to be obtained (username/password).
 
 The credential is split into a set of named attributes, with one
-attribute per line. Each attribute is
-specified by a key-value pair, separated by an `=` (equals) sign,
-followed by a newline. The key may contain any bytes except `=`,
-newline, or NUL. The value may contain any bytes except newline or NUL.
+attribute per line. Each attribute is specified by a key-value pair,
+separated by an `=` (equals) sign, followed by a newline.
+
+The key may contain any bytes except `=`, newline, or NUL. The value may
+contain any bytes except newline or NUL.
+
 In both cases, all bytes are treated as-is (i.e., there is no quoting,
 and one cannot transmit a value with newline or NUL in it). The list of
 attributes is terminated by a blank line or end-of-file.
+
 Git understands the following attributes:
 
 `protocol`::
@@ -123,7 +126,8 @@ Git understands the following attributes:
 
 `host`::
 
-	The remote hostname for a network credential.
+	The remote hostname for a network credential.  This includes
+	the port number if one was specified (e.g., "example.com:8088").
 
 `path`::
 
@@ -134,7 +138,7 @@ Git understands the following attributes:
 `username`::
 
 	The credential's username, if we already have one (e.g., from a
-	URL, from the user, or from a previously run helper).
+	URL, the configuration, the user, or from a previously run helper).
 
 `password`::
 
@@ -146,8 +150,12 @@ Git understands the following attributes:
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
+	doesn't specify a hostname (e.g., "cert:///path/to/file") the
+	credential will contain a hostname attribute whose value is an
+	empty string.
+
+	Components which are missing from the URL (e.g., there is no
+	username in the example above) will be left unset.
-- 
2.26.2.686.gfaf46a9ccd

