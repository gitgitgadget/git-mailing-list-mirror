Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473461F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeBUBz3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:29 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44410 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeBUBzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:23 -0500
Received: by mail-pl0-f66.google.com with SMTP id w21so81985plp.11
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxzUF57AKm37/HbwwMAz6DGIcZYpRQ6SeGPBJmRTbhY=;
        b=NewsQ4ckvzhpvhZ+yROwDSqFQN+ssL8Y4NY9voyzumjLNiAIDuKUervjnAA+Y0q4Xs
         de7nMcQuzgCqk9DgpdQstFCdXSvDiSBsf8607dmjweuOrZmmD7L+sL7totPPkkOKhHAT
         j0PF4LY9/iIpe9CxDNYy1o1GwPzLBKxsYp2Fzaq0yL2qZfVOKeJxFocVLlCxLC/tAxuM
         e4K1rHbkPEpLavn8xPNvJZbWO8J2ASbwjh+9+z06JjGqLnR/XyMC3Z3Mzl2qGX7qbJZ3
         oRljFBt7wbjf+Z4DJT6nJJnLnibVw0wRa9QCmmvkuu7K/auKYHfNKFa38XtaPyHEzDuR
         zXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxzUF57AKm37/HbwwMAz6DGIcZYpRQ6SeGPBJmRTbhY=;
        b=dbyy1kmgMYhnyrpSKkscelEfrgUIQvWCYDwAng+J4PkxTtbbCdcJQkgLDMi+ipoffF
         i4LX4pYr6Pk+gutH3Axzj0bbh/c/A7Sgrz5uxFTdKZqm5itp8HgkQl3sDZjs4GBPkX+r
         JjZYJHl+V5e4gEGxclZaWeoavW8+of9Vb+1joakVKU+o226kxGNH9NfT2GLNXo3+G3mp
         DA8D634cR/8kNXrul0aAKLZp5RnCLuI9dHmy6JLfkmcY6OEJ/o16paj/qnrY1wXW3Njp
         X8f8RaLFxYZs0tJs7c8bt0/PLepfKd88K2p0zcP3sYwCs7iHUOXNxcdB9H//ZRMLwEXi
         Qwlg==
X-Gm-Message-State: APf1xPABvyG3XBQ+MmES47fZl9uD3191FaT7Ptnuxx2pjVeuX2+swXvg
        zQQ3RAigfMcFJt8lMO3T5VYqOQ==
X-Google-Smtp-Source: AH8x227eCtREjZZ/WHBX41GFUKOMEfEpRrLr6X0wL19yKamL/9T1ZF9aN5Je++Tc+GY1PJ1jezSj+Q==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15-v6mr1531643plr.214.1519178122339;
        Tue, 20 Feb 2018 17:55:22 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y21sm11303494pfd.17.2018.02.20.17.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 26/27] sha1_file: allow map_sha1_file to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:29 -0800
Message-Id: <20180221015430.96054-27-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 146358fe33..5d93677783 100644
--- a/object-store.h
+++ b/object-store.h
@@ -129,7 +129,6 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
-#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 522804d9f0..a20f811a07 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -964,9 +964,10 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct repository *r,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(the_repository, NULL, sha1, size);
+	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-- 
2.16.1.291.g4437f3f132-goog

