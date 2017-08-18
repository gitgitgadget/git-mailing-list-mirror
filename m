Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4967B208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbdHRWVs (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:48 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36423 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdHRWU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:57 -0400
Received: by mail-pg0-f46.google.com with SMTP id i12so72234600pgr.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=26IHDmSgd45YwNFJm+6kT+7eyGNP0CZUCVvEFukUA4I=;
        b=MzShwmq57t++/NLxu+xmfinL9OQ3+qRV7w1uFJrIAsQe4TI1XCNZQ2DBbeoC8XCPmv
         +cEjYbtrMf/mF0KrT88W3pH0ekhUynfBOQaLFgrgZSGEkXq8uUCCfhhqtuuwAqSxJbD9
         Y48BgbPPvSdSMn9l0sS1ngnQeSNl3q/R31SEmqjPJ62DAxs4sPKTZgz4iS0sZeUcKJZm
         0rLVIofXfGk0jR+H6MmhEeV93ZkDfLmdAcRtZyEC4kziWbC3p69AGJE3yNolBoRtaqOU
         gzG37HBhvtPbiiYe4bjitv3vwuP+kTA3MXFHyup22b4BXOrGoAj15pDYUSNoaTmAHvqI
         hgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=26IHDmSgd45YwNFJm+6kT+7eyGNP0CZUCVvEFukUA4I=;
        b=tbbg+qikkknwropZsEd/SxpFhDJ6WWtEqIGi5cVSK4H4qnuBMyQ0xbF0AL07aMZzQN
         tvoEwYVJWONmO/WJSE0HKknzfxUFVGnDPIRrkeJcbqLbDJcvbpGTueT4ypHzw1OntKm3
         Rc9R/N0Snx9a3QjYUuuHsDVyoquV3A2QCaqYrha0v6ueQ2aMtA7boO4G04qPAeAAnsmA
         azef/SpBf/xCV999Mli9iA3S3gIHE5XZB8m7DSjASDktJottCPX5Y4yq84jH7uSrbZgW
         5F+O30BdVx6+bG5GsXTJcYqDw+YKH/BxVBD32PnasVaozB7ORGZdJ3NHRx8GTZcQ920/
         pMJg==
X-Gm-Message-State: AHYfb5g3LH5ci7TM6HCxrgjS9b0NWHocIz2YI/5hi+Moof+d3KAjcP0D
        Y7GcJx0I/gntpKKktIXtRA==
X-Received: by 10.99.161.9 with SMTP id b9mr9687298pgf.144.1503094856455;
        Fri, 18 Aug 2017 15:20:56 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:55 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 10/23] pack: move install_packed_git()
Date:   Fri, 18 Aug 2017 15:20:25 -0700
Message-Id: <e6d35ba0c847f4526ae727bbb306b5976bff526a.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 -
 packfile.c  | 11 ++++++++++-
 packfile.h  |  2 ++
 sha1_file.c |  9 ---------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 3625509f9..c4d8bee52 100644
--- a/cache.h
+++ b/cache.h
@@ -1619,7 +1619,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
diff --git a/packfile.c b/packfile.c
index d1433d8c7..9a65aa4f6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -28,7 +28,7 @@ static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
 static unsigned int pack_open_windows;
-unsigned int pack_open_fds;
+static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
@@ -658,3 +658,12 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		hashclr(p->sha1);
 	return p;
 }
+
+void install_packed_git(struct packed_git *pack)
+{
+	if (pack->pack_fd != -1)
+		pack_open_fds++;
+
+	pack->next = packed_git;
+	packed_git = pack;
+}
diff --git a/packfile.h b/packfile.h
index 1e932a49e..a18029184 100644
--- a/packfile.h
+++ b/packfile.h
@@ -28,6 +28,8 @@ extern unsigned int pack_open_fds;
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
+extern void install_packed_git(struct packed_git *pack);
+
 extern void pack_report(void);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index 0929fc10e..b77e7e3c3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -718,15 +718,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void install_packed_git(struct packed_git *pack)
-{
-	if (pack->pack_fd != -1)
-		pack_open_fds++;
-
-	pack->next = packed_git;
-	packed_git = pack;
-}
-
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
-- 
2.14.1.480.gb18f417b89-goog

