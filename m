Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BDDC432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5FC206F4
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 23:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="RqnwXY0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKUXns (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:43:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35068 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKUXnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 18:43:46 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so5728912ior.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 15:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dK4J9yIZihntmIhE/Qq5A1X/CJOFYxYGhPoTxYXuQ3A=;
        b=RqnwXY0JNfC6eWSxDNiuerN9mjUewq/vt8fYlCn4Ex8LeQHh7rvIuknuTzDHFPVqQr
         MXH6AJmX4EW+uUWvypv3/17NojK4X4J3etXuBaLSiykfY1iI94sBhAp73UDhBgaOXzM0
         B0HL7uHQVO0VTyg5RVmepA1MQq2tWxIbB8PCdS2MUJCh/gcN+YW8GZRDnfPh10XYTGu5
         UQxHMWjZOm3SExlcroJ6SiAIxIoi8lVTeLhQUcsNBdoAnusTxVOxfpyvyucOGu5lYyj2
         fR4VIjl+pr1JX8frRzyju6+WUyCb0a0dL7LwRNwhO7l4a+xDqmfq36/lb6FcsITYXYf5
         nuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dK4J9yIZihntmIhE/Qq5A1X/CJOFYxYGhPoTxYXuQ3A=;
        b=iL9Is6SdErGjFuLxjF5T+Mf+gb7Rq/tXAeFJS8SefmniYufOcJrMhE+rW/EepK6L1g
         WVWkgV1/9iNL+B5BNMvEFryQAgdigBCU2+35Y7Tih8VytIpy6vm2QDjmoLo+TQr8Gd3c
         QBAP1kMcbVI8P7Ip7l+cTbiRDWR/10Qmvkncs9xiOvYdkhCtpt9/FjIXny2vQow4Axfl
         XNGiozaL69qXgr0llvhHDdq7SfqdR05+KkjLKlqH6FM2Vd8PcTEChuUCX1G9CiQAxN+X
         yztJR7VvOOofFu+NCx10FTr+F0uSyxvnMME/u/dqCHpXU746tVCEbOfdd0gIS6fjLMfv
         mzRA==
X-Gm-Message-State: APjAAAV9wyj8mUJ483u/f0i86NjCvxXxRCGxp3deNuG4Wo5Z9NYLzwjg
        4FYrULG1xJoMN9RwVfGmShaTL2BczlQ=
X-Google-Smtp-Source: APXvYqzfer7QsEcb4NZCfeauPlKhAvWR6aq5IgJa/csxRZcNt1DIMPtWVEguBj95q24Q9ugCElu24A==
X-Received: by 2002:a6b:6512:: with SMTP id z18mr9936177iob.282.1574379825046;
        Thu, 21 Nov 2019 15:43:45 -0800 (PST)
Received: from localhost ([182.232.28.41])
        by smtp.gmail.com with ESMTPSA id s18sm4923715pfc.120.2019.11.21.15.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 15:43:44 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v3 1/2] gpg-interface: refactor the free-and-xmemdupz pattern
Date:   Thu, 21 Nov 2019 23:43:35 +0000
Message-Id: <20191121234336.26300-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121234336.26300-1-hji@dyntopia.com>
References: <20191116215850.3919-1-hji@dyntopia.com>
 <20191121234336.26300-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces a static replace_cstring() function.  This
function simplifies the continuous pattern of free-and-xmemdupz() for
GPG status line parsing.

The benefit of having it in a single helper function is that it helps
avoid the need for duplicate code that does the same thing.  It also
helps avoid potential memleaks if parsing of new status lines are
introduced in the future.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 gpg-interface.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index d60115ca40..b4c4443287 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -105,6 +105,17 @@ static struct {
 	{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
 };
 
+static void replace_cstring(const char **field, const char *line,
+			    const char *next)
+{
+	free(*field);
+
+	if (line && next)
+		*field = xmemdupz(line, next - line);
+	else
+		*field = NULL;
+}
+
 static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
@@ -136,21 +147,18 @@ static void parse_gpg_output(struct signature_check *sigc)
 				/* Do we have key information? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
 					next = strchrnul(line, ' ');
-					free(sigc->key);
-					sigc->key = xmemdupz(line, next - line);
+					replace_cstring(&sigc->key, line, next);
 					/* Do we have signer information? */
 					if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID)) {
 						line = next + 1;
 						next = strchrnul(line, '\n');
-						free(sigc->signer);
-						sigc->signer = xmemdupz(line, next - line);
+						replace_cstring(&sigc->signer, line, next);
 					}
 				}
 				/* Do we have fingerprint? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
 					next = strchrnul(line, ' ');
-					free(sigc->fingerprint);
-					sigc->fingerprint = xmemdupz(line, next - line);
+					replace_cstring(&sigc->fingerprint, line, next);
 
 					/* Skip interim fields */
 					for (j = 9; j > 0; j--) {
@@ -162,7 +170,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 
 					next = strchrnul(line, '\n');
 					free(sigc->primary_key_fingerprint);
-					sigc->primary_key_fingerprint = xmemdupz(line, next - line);
+					replace_cstring(&sigc->primary_key_fingerprint,
+							line, next);
 				}
 
 				break;
-- 
2.24.0.157.gba9f894af8

