Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC96F1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeBXAsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:54 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41734 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBXAsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:23 -0500
Received: by mail-pl0-f68.google.com with SMTP id k8so5843358pli.8
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zr8rEOtnBVz/0UWWSoqMIQtpm2j/76rVcXhf9AzSI+U=;
        b=HnHT/nX8lmrEsV4Ggl3mzFaNyzt5pBGhNy2w2sMtX2UgzsuRqKEEYWDlM3UZVNH8EW
         k5k0/02wNRvS7sbBc8WicYE7GPAagHugzQyqBIXcW/b+gJDd4rMInZRp55qNLVwUzT2C
         +SRdtjEu4CCWcWOePeJa6yRE3GnFObchCm54N5Pjvcl1HrtHQK6jYXk7wWeSscQEGXTq
         Ug/TmX7qzS4q2G0QnSt8T/rytdJ48l7dInBjxPnFVPlaaWSz+7FK9mEPPQZTG7VQO94W
         j9M9mItiKoXKS5f/nYkXEAoxIJ4LMGpEdfqNbQGYooKeuAxi3lQ4QfxlbwbPAIJyfIIt
         S/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zr8rEOtnBVz/0UWWSoqMIQtpm2j/76rVcXhf9AzSI+U=;
        b=C7dcHk9agib2R4yOVobHuVz9HQgmm+A3rlHL3spFeB7FFmNmz686liexr+jiZSvFJW
         UyLjrgKnAAAnCbJScPsS+5mOKECnxSLXna9ZSejjgSRmdZ1iJ6hz+6EcI703+8WnpUhN
         ES3skv0bmu7jt9PSHl78t5eo7EJYdnWbs/Y3ORxAg3H7R4LoFpZxpYdPgrnqOPjsQVDH
         gfWibV4RCpo6taKbgo4V7V/pK01UAVKK0bGiSTJbKX9sqFpVrnsmAUSBy7GN5/DQEo69
         S7KTvpwYubG+h98ZYZw3SH0AMKGtguoV65byr3qtIVn+XN6tK70Tvbnn378H01S0wT8+
         vi4Q==
X-Gm-Message-State: APf1xPCEeqFrmYIJmdrv7Fv7LsrlADcf/y8knMNPglCJuNd2hlgJXPKN
        QdLUY8A+6THU5L62SUvnd6Gl9PXUMzY=
X-Google-Smtp-Source: AH8x224VvU2W1gvw1ImhlWF50yIi9CrKX8dJB3cDupvXR00b//TzTEaF/JeG+EbHCfidOiAk1xpXbg==
X-Received: by 2002:a17:902:d203:: with SMTP id t3-v6mr3349326ply.70.1519433303156;
        Fri, 23 Feb 2018 16:48:23 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 7sm7548841pft.84.2018.02.23.16.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 18/27] sha1_file: add repository argument to open_sha1_file
Date:   Fri, 23 Feb 2018 16:47:45 -0800
Message-Id: <20180224004754.129721-19-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the open_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b7e6e4a9bfc..7e471e0cf4b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -898,7 +898,9 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
+static int open_sha1_file_the_repository(const unsigned char *sha1,
+					 const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -941,7 +943,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(the_repository, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.291.g4437f3f132-goog

