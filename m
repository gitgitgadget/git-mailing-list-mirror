Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66EA208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdH3G6p (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:58:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36284 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdH3G6o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:58:44 -0400
Received: by mail-pg0-f65.google.com with SMTP id 83so4468801pgb.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZtrLVjl7ks/kFWjsw7KXoOH6vqVSfo9q5rY9EIcJTmo=;
        b=DDmdp/fp3K77DoItIEnKp7aQsXp1vfVpDUcLIoJwu10LXM51YwRB9GhwBKd+fq8mdG
         /DkK2X7D01KH9egz/mIRDyGJ+pytuuE1WoQ6JNXmwGU0BB3DeekS74QsUmjGrctWTxK4
         vtxFayI0aXT4SuR/yEck1NnYz2AcLUcPIxoseGCGBE9ojkmFYiv3tIrHBwdCY22w6AA6
         RZwN2kfRmr98xq4L/p83xcddutNNuL0yYNFzSb+lnsnY5CeodvqTU/OKVKbX7GnF9dFS
         47L3iHAmijTr3BYlYy8F3DpHhwuUt+v/oUnr5GRetc8EyXMIJ3veYBFO7P2vo600ETKC
         nw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZtrLVjl7ks/kFWjsw7KXoOH6vqVSfo9q5rY9EIcJTmo=;
        b=fSLLBa9x39wmbwvmA/odnhvDCBUnQJjhSCc840vZlBtCAIXgARninDJB7Gq5PFjsae
         efgag4dS/zV0MYV9lESq6phL5rzHmxQy7j95MVfOaq9RlBbQ2s/ql3oFgOOV+bSZAwPY
         Pxp0dVM7El21OREixzH1gHiA00YPaMgX+xY/xbOkpiagJve49oRF2VQ1Uux0fdl1B7KD
         5518SEqsFvEgeORN5LMSiEqQEyE6eULMtOJt+qZlgqUD6pDNEaiTrAh6B2zOM0qGdZEJ
         IhSEJg/uSg+wWf1hqlyvZELBJ/puhGdviG9e0Uap2nE8B+4KwF+lBQ+r9MBCLvZPhjjG
         eOhg==
X-Gm-Message-State: AHYfb5iD38YlB+iujR7qCtANSTt7woXFX4OCSVe6keS1Wy3DQYMjP9yv
        J5IlmSap5TiBKqXgkFU=
X-Received: by 10.99.114.76 with SMTP id c12mr571014pgn.67.1504076323438;
        Tue, 29 Aug 2017 23:58:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id 188sm7338819pgd.20.2017.08.29.23.58.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:58:42 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:58:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 10/39] sha1_file: add repository argument to
 link_alt_odb_entries
Message-ID: <20170830065841.GK153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the link_alt_odb_entries caller to
be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 29cead6d2c..7938bd2a6f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -401,8 +401,12 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int len, int sep,
-				 const char *relative_base, int depth)
+#define link_alt_odb_entries(r, a, l, s, rb, d) \
+	link_alt_odb_entries_##r(a, l, s, rb, d)
+static void link_alt_odb_entries_the_repository(const char *alt, int len,
+						int sep,
+						const char *relative_base,
+						int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -451,7 +455,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	link_alt_odb_entries(map, mapsz, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, map, mapsz, '\n', relative_base, depth);
 
 	munmap(map, mapsz);
 }
@@ -508,7 +512,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects.alt_odb_tail)
-			link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+			link_alt_odb_entries(the_repository, reference,
+					     strlen(reference), '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -521,7 +526,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference, strlen(reference),
+			     '\n', NULL, 0);
 }
 
 /*
@@ -625,7 +631,8 @@ void prepare_alt_odb(void)
 
 	the_repository->objects.alt_odb_tail =
 			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository, alt, strlen(alt),
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(the_repository, get_object_directory(), 0);
 }
-- 
2.14.1.581.gf28d330327

