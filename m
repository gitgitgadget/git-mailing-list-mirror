Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612A21F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933227AbeBMBXJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:09 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40157 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933195AbeBMBXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:00 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so8741575pgn.7
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNkndn0MwId8ZY2asApu4/5pA6V/Ol+btX9btRkbd78=;
        b=H/wBr9JX6a5MScFixmimOtGCl/WhRfqK0dG7spfp+aohgvWqM5sY8gd2WBnFBFbbS+
         yTuaKnfAvuUCiQwFCZG4YjTOcokW2bENB/49ln/+nnT8/GDvdR2ZxNvxWvsdjFNKZaKv
         VMle9rthcCin9joO45+62iJszuWsd5TxyM7+8Q5WcZ3DBOt8JT/Wcfbj8Rij/6aZcElK
         hHW4K5MnPdnTlZTATzkHrU4q9rFUCfn4NlQhZs8EELq3kT1OgriYXGkakp4C2u6MFhdn
         D3dv2YKxB7e9hMrvOM6/ALbuATbIfcJSE0u2EJHELTwKFnQ35zEgHbdpbKZM8ZgEY2y7
         cWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNkndn0MwId8ZY2asApu4/5pA6V/Ol+btX9btRkbd78=;
        b=RD2K1kovr1lHd5tqgy1YUec68vFz5WfOOidJvEVzEgGC1ADjfP5wCGhQ0Yz/IwqiS2
         pheHo7TcaNdJT8xhRx1B8lOln/g+9wM/GtW10hNfYPvIAGMJD0kj/grVcGqJMqszkjfF
         oQt98oydLdb2PwZ93eACVJ3psakI2IHdD6FzsIOZ70QiMNs+HgrD63iAVSAPxkctV07f
         JGNdmQ29L+GbLlK9zJUFU7t+2Bfwc/F8frN7Hul5oHybMD5vc1QBBNjV8N0HxcXoo+as
         npEhILj9cPTA4/zpmELj8k6xR68SK/N0P3BmvcCaO2f8WM+aYBbF9Kz1MQcTkc8wKrun
         99BQ==
X-Gm-Message-State: APf1xPAzMkV1GAL0wjpLWURW0q3p7odVohZIHhc7az1C8wfAkffAChCM
        XZTMBtvdNuwn/kNJaZtVnvGTXw==
X-Google-Smtp-Source: AH8x224kDZOHBpPeMQdJmNnW9jGs0bembJp775u3fX1iXdVxHUl4P2UAJbSPyrKUxCBdR9K4aad1YA==
X-Received: by 10.98.198.1 with SMTP id m1mr13180620pfg.90.1518484979996;
        Mon, 12 Feb 2018 17:22:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e12sm26970891pgu.48.2018.02.12.17.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/26] sha1_file: add repository argument to link_alt_odb_entry
Date:   Mon, 12 Feb 2018 17:22:24 -0800
Message-Id: <20180213012241.187007-10-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
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
index d25b68a8fb..7dc5f690e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -394,8 +394,9 @@ static int alt_odb_usable(struct raw_object_store *o,
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
@@ -492,7 +493,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
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
2.16.1.73.ga2c3e9663f.dirty

