Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44109208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750851AbdH3G6G (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:58:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37666 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdH3G6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:58:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id a2so3793931pfj.4
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b2+cn/wuFBp68K9gpV3jVz3ir3/qxGyq4TwFgaYq9og=;
        b=Ydr3qx213BRsdtolaiYM0CwJdGdZ1YSXV/USqVF+Kty//lIlFOrMd1MNM8WG+1FyBx
         Jr7BDvq+cV555epJiX9DU/8LLWH4SvhgtkKgKtvxHgSpO7SrWj/9lAy8HALZqOw10vIs
         vfhWpGDY7ORGTLOieLEUHgG7XeSuztlyzOm2RQMFt7ek3RnAf+OFZiA++nMvuIWF+Knw
         Gs3jJ8IJeoWeGLD4rNfPrULfbAqqC7AavGtXE9MjsjfelaDC9RRClZ92mJr6wPv4ykFF
         VPpt4JBvXmbDRq+fCjathHBI2G6X0azAHPM+nWtOHpOeTX75rYnk0HNeJX90jS4I0gP6
         eStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b2+cn/wuFBp68K9gpV3jVz3ir3/qxGyq4TwFgaYq9og=;
        b=Jm+1J2TuayT5BaT1gvd3LQRAzCDxvJJSDnGe5m5Hy/bz1vwpf1N51fYSDl+YS43DS+
         5XuZeCxh1LXXVqbR3dfQYlb8Rg8x85rA7/HasjqU4jI7OVVh9bcEK1jshUPV2uf+LAdi
         dulxviHEiZiM5vQohHifLPWSuPgESY0c53ZKpuGGKJhvjTu3hC5pC7mda7xgat+4f97x
         6+u1NLHvU6FhVVzdd8Vf0ka1dbPYDmnsA/VqRFSWkHBomcYEI+Nx3WglrCoOCSQXPvNh
         MkArkTQfqFVVk9pJRhtbwDXE+yl4D2cRdoZ/jH3jE2Uv3Zk14fDAaR2CVwxRsOewwm4w
         3Itg==
X-Gm-Message-State: AHYfb5goKeOkdH/DzM8SxvqqolO7Qg7H11v8TZgKJ/L+KMnVv/AFzbGo
        m6ekdtaxbUZru9QiKq8=
X-Received: by 10.99.140.78 with SMTP id q14mr596920pgn.213.1504076284907;
        Tue, 29 Aug 2017 23:58:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id w184sm7714749pgb.29.2017.08.29.23.58.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:58:04 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:58:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 09/39] sha1_file: add repository argument to
 read_info_alternates
Message-ID: <20170830065802.GJ153983@aiede.mtv.corp.google.com>
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

Add a repository argument to allow the read_info_alternates caller to
be more specific about which repository to read from. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commit, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c63b52f6fa..29cead6d2c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,7 +323,9 @@ static int alt_odb_usable_the_repository(struct strbuf *path,
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static void read_info_alternates(const char * relative_base, int depth);
+#define read_info_alternates(r, rb, d) read_info_alternates_##r(rb, d)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth);
 #define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
 static int link_alt_odb_entry_the_repository(const char *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
@@ -364,7 +366,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(pathbuf.buf, depth + 1);
+	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -427,7 +429,8 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth)
 {
 	char *map;
 	size_t mapsz;
@@ -624,7 +627,7 @@ void prepare_alt_odb(void)
 			&the_repository->objects.alt_odb_list;
 	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(the_repository, get_object_directory(), 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.14.1.581.gf28d330327

