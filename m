Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031E420986
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756396AbcJGVIV (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:21 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36118 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbcJGVIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:11 -0400
Received: by mail-qt0-f193.google.com with SMTP id y38so1614080qta.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f2hXt0zFQ/AlYkeWoQsjLhKS2iXk2GWktnyNrJKk7No=;
        b=DbjX/QJ84YpOxHuBsQpW4V73fm5utZa7hfxeU0bL42ImXg3IL8/CEdnRf2gIgOBvHZ
         tjQW+VpZyopq/gAPvsOjoft6P8oCjE8xTaMQvFVW9h7xqZelec/rVTFzN5yR2lqW0ime
         W80TF4HZmt4PwU36KLBbNy+ivdxdV22NlJdeO0k8/YAr5Rw7JQ7VpJxnAQNpJlFmktOh
         rTzRyzeAi8KBrnbk+98w7s7dFqc/7PR++vtOekQr26hmWogKIk1qigbBtWQ8nTeoMDvD
         0jm48b9DHm/efXlC0rF82Y45Z64Dt/G795B0b5RwVbJEVxUft/On0/pSutR3XkOCe9jK
         npYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f2hXt0zFQ/AlYkeWoQsjLhKS2iXk2GWktnyNrJKk7No=;
        b=QlJm32GaEUOK75ivkZ+o4Fv3i9ycvvYiGAt0lJfwPePiXT3Q1qNEJPg+JYxDbiW6d4
         LpPU3FCsXhxttlkUBSRFvs49d43T1xKgq3ncVFU09MPg8XaMY2wEMVv1lVhJrYy6g7pV
         k9Ug7QZUhnW+d+UjF5DtdpGmPsPwxtT57VrEL61coBXvNLw+kajCgxRE+OvwC7pnBE1P
         mTX5+WEpX/RrEOI/lw5V5fpd0ncTLVHMpzHkwY2SWpACnt6WnKOAt7EiSzwBgbYPtGem
         0arKD63H/8LNUFvSQGaur4Q9sU2M0PENeQL127AFtyieVC9ANegkKtJ7unyKiJw5wrGE
         cZJw==
X-Gm-Message-State: AA6/9Rm4c9M5vX2KrKNdtR+1heiUyQ+8NIQhQUaroUvqRhIUKAtX7zvaTrGZvBly9GXY48yi
X-Received: by 10.200.37.120 with SMTP id 53mr19564165qtn.44.1475874448371;
        Fri, 07 Oct 2016 14:07:28 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:27 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v4 1/7] gpg-interface, tag: add GPG_VERIFY_QUIET flag
Date:   Fri,  7 Oct 2016 17:07:15 -0400
Message-Id: <20161007210721.20437-2-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
References: <20161007210721.20437-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

Functions that print git object information may require that the
gpg-interface functions be silent. Add GPG_VERIFY_QUIET flag and prevent
print_signature_buffer from being called if flag is set.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 gpg-interface.h | 1 +
 tag.c           | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885..85dc982 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,6 +3,7 @@
 
 #define GPG_VERIFY_VERBOSE	1
 #define GPG_VERIFY_RAW		2
+#define GPG_VERIFY_QUIET	4
 
 struct signature_check {
 	char *payload;
diff --git a/tag.c b/tag.c
index d1dcd18..291073f 100644
--- a/tag.c
+++ b/tag.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "gpg-interface.h"
 
 const char *tag_type = "tag";
 
@@ -24,7 +25,9 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 
 	ret = check_signature(buf, payload_size, buf + payload_size,
 				size - payload_size, &sigc);
-	print_signature_buffer(&sigc, flags);
+
+	if (!(flags & GPG_VERIFY_QUIET))
+		print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
 	return ret;
-- 
2.10.0

