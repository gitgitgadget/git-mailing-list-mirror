Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C12A1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeBXAsT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:19 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38065 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbeBXAsN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:13 -0500
Received: by mail-pl0-f67.google.com with SMTP id d4so5848276pll.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=am/JCIUsdblzT6fv5cPrgG4p0WBWlP5Jk3pguNjLa7g=;
        b=VxirqX86y/ozp/4MDgjKyq9KcozXzz9cJJaBFfIHcKrMh1SBgm1z64XriAiBWCoyhQ
         iL8D7uahFlGBUtviwvYZQhxH60ncL1PliGU36lnnOIN0aHjsguUgl4b/7PSxHuuFwJyq
         FmKCqzvtuLFbKwaaztwm5GieZJcltoKK46svdDStWBVnxACOzj7f69uNwlJoboqixTjk
         oXT0hnbqGvGjD6VmojJrsy8U2hq1w/AFxy1Q3h9BNO8SJsJ69eVFkMLgFK8fPnC+xZCv
         XSSAVgmL4jKM3If4jCWJjG6nMEXecyo/R9qWqaRKIQM/dvazoJvXO2TwNTbg1by5rehx
         RxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=am/JCIUsdblzT6fv5cPrgG4p0WBWlP5Jk3pguNjLa7g=;
        b=I7tQy2SedJjnFSO3Xrb6bH3MHYk8LCSurdILCDaER2/WYjMkaSMIVyjGnDhkIJw9HP
         3M+yPWuBg/SwXTzuN/HpZ942PvGAdEHi4/RPgK32FXH9W/4K5FwR48i1L9FK+TaN9tmL
         3sFCY1ZIvZmKR7xjSCCLQYYcHMKTdBMh+BP9MhCSi0uM0fUWbbIaOA2ovb0llNpSyc21
         G8WKzuSTO+Kf3eehMnWZWbjGx9k6Xcu5fGNAHtjZYUq7YEfXlNcenafJTb6A65SGbq1q
         ZdtFWbfQq4Do9KkCzDhAA6BxIY3PJ359DCyAgjKKGxQZjMQRHj72j9sqArH1tm48v/Z/
         0XLw==
X-Gm-Message-State: APf1xPBA+BpX+h+D6n/I3fHUdD1uWwhZR4BTYySEdpUMRcQrT1jSXYfv
        eExuZE4JGdJjp/kfnVHw3skvNxswhJ8=
X-Google-Smtp-Source: AH8x226hSY7kvEKyUexAz+oQ6qx1dhvFS4+qpFIcsOcgzL3OG9RKTmavAn17nU0oCTjSfuG0GD2Y6w==
X-Received: by 2002:a17:902:8f95:: with SMTP id z21-v6mr3367164plo.132.1519433292641;
        Fri, 23 Feb 2018 16:48:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c185sm6939105pfb.146.2018.02.23.16.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 10/27] sha1_file: add repository argument to link_alt_odb_entry
Date:   Fri, 23 Feb 2018 16:47:37 -0800
Message-Id: <20180224004754.129721-11-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the link_alt_odb_entry caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Since the implementation does not yet work with other repositories,
use a wrapper macro to enforce that the caller passes in
the_repository as the first argument. It would be more appealing to
use BUILD_ASSERT_OR_ZERO to enforce this, but that doesn't work
because it requires a compile-time constant and common compilers like
gcc 4.8.4 do not consider "r == the_repository" a compile-time
constant.

This and the following three patches add repository arguments to
link_alt_odb_entry, read_info_alternates, link_alt_odb_entries
and prepare_alt_odb. Three out of the four functions are found
in a recursive call chain, calling each other, and one of them
accesses the repositories `objectdir` (which was migrated; it
was an obvious choice) and `ignore_env` (which we need to keep in
the repository struct for clarify); hence we will pass through the
repository unlike just the object store object + the ignore_env flag.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8e6f213f9d9..e5fe0aa04ef 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -388,8 +388,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * terminating NUL.
  */
 static void read_info_alternates(const char * relative_base, int depth);
-static int link_alt_odb_entry(const char *entry, const char *relative_base,
-	int depth, const char *normalized_objdir)
+#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
+static int link_alt_odb_entry_the_repository(const char *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -486,7 +487,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(the_repository, entry.buf,
+				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
-- 
2.16.1.291.g4437f3f132-goog

