Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F51420899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbdHIBXI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:08 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32897 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbdHIBXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:05 -0400
Received: by mail-pf0-f182.google.com with SMTP id h68so21348605pfk.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=goqHquDUxRlyweLvwmJ2877CEfkyQvCdVSieRxQ2iE4=;
        b=BYKyp2EJ1Mu9HobZ4VXLX2Pyry+29CxZtT7De1QUGEZlu6vmITSOlb/hHHOLANhdur
         Qcup35WIVDrELANT77B3aJgsCkK9/vYxHAti4HKJ33NtqchpT5dzq/0XRD8EtPQNBEr5
         aRNPUSDb2rChpeNRX8lxaR56jjCXuqi9PDCuHLA4lYEcvy/ePzuvYQB6Fy94h2H7CWtd
         JsqgknWsKNoKqAu2TE3YEYuS/oCcmTmlXBiav3LrbiJWvSIYOElJID57lI2FerZ6qWxH
         FONYvyXkZQE83AVL51WB+6H44Ag5jK5p6aePUKxtXQuOJ16KZSbSj1VPLa57Itme13uU
         rSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=goqHquDUxRlyweLvwmJ2877CEfkyQvCdVSieRxQ2iE4=;
        b=cfmg1D8J21JJ8Cht8tTxcx4o6IWnn89M0aLH74MCgYSMQs1f0txLSHqMeP5UUAYvcr
         GHF7Q7bVI20oF2gdZly1GsY9vX4BuDizkZKE5SIhNQeNGfTqDp+OTd6RtXaPXXxEJ7pe
         Yv7WPqEfovoXw7qA8TRVHS58NIY1iGMK15FqcQmOWKIllIW0w/BqBHgatc1eQdGUrqXD
         EyAX4DoojAeH/cKiyCeLjnNbj9aenBq3QsyzdurStqpVj7Skm0uhfqJDZbyBFP2mhLdI
         pmmASBPnog6bStwyOMI5dy6+DGGGq+zummEjBVlcucaA7xGY7Xx1gnuf7DADdEBg08ZG
         lcIA==
X-Gm-Message-State: AHYfb5iQk4JmaHxIK6JeQRb2WtPPbNwUblljZAXJQh78VQ8DvvBmKINN
        KchwFTFRa/HMHzUjsYBUFg==
X-Received: by 10.84.218.3 with SMTP id q3mr6870407pli.282.1502241784094;
        Tue, 08 Aug 2017 18:23:04 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:03 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 02/25] pack: move static state variables
Date:   Tue,  8 Aug 2017 18:22:34 -0700
Message-Id: <e175b8d792e47984a522955877dbbdd07249014b.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sha1_file.c declares some static variables that store packfile-related
state. Move them to packfile.c.

They are temporarily made global, but subsequent commits will restore
their scope back to static.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 pack.h      |  9 +++++++++
 packfile.c  | 14 ++++++++++++++
 sha1_file.c | 13 -------------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/pack.h b/pack.h
index 63bfde00c..7fcd45f7b 100644
--- a/pack.h
+++ b/pack.h
@@ -124,4 +124,13 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
+extern unsigned int pack_used_ctr;
+extern unsigned int pack_mmap_calls;
+extern unsigned int peak_pack_open_windows;
+extern unsigned int pack_open_windows;
+extern unsigned int pack_open_fds;
+extern unsigned int pack_max_fds;
+extern size_t peak_pack_mapped;
+extern size_t pack_mapped;
+
 #endif
diff --git a/packfile.c b/packfile.c
index 0d191dfd6..0f46e0617 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "mru.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -21,3 +22,16 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 	static struct strbuf buf = STRBUF_INIT;
 	return odb_pack_name(&buf, sha1, "idx");
 }
+
+unsigned int pack_used_ctr;
+unsigned int pack_mmap_calls;
+unsigned int peak_pack_open_windows;
+unsigned int pack_open_windows;
+unsigned int pack_open_fds;
+unsigned int pack_max_fds;
+size_t peak_pack_mapped;
+size_t pack_mapped;
+struct packed_git *packed_git;
+
+static struct mru packed_git_mru_storage;
+struct mru *packed_git_mru = &packed_git_mru_storage;
diff --git a/sha1_file.c b/sha1_file.c
index 7e511ce9e..4d95e21eb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -682,19 +682,6 @@ static int has_loose_object(const unsigned char *sha1)
 	return check_and_freshen(sha1, 0);
 }
 
-static unsigned int pack_used_ctr;
-static unsigned int pack_mmap_calls;
-static unsigned int peak_pack_open_windows;
-static unsigned int pack_open_windows;
-static unsigned int pack_open_fds;
-static unsigned int pack_max_fds;
-static size_t peak_pack_mapped;
-static size_t pack_mapped;
-struct packed_git *packed_git;
-
-static struct mru packed_git_mru_storage;
-struct mru *packed_git_mru = &packed_git_mru_storage;
-
 void pack_report(void)
 {
 	fprintf(stderr,
-- 
2.14.0.434.g98096fd7a8-goog

