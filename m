Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CE11F453
	for <e@80x24.org>; Tue,  2 Oct 2018 02:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJBJEr (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 05:04:47 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:43714 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBJEq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 05:04:46 -0400
Received: by mail-io1-f41.google.com with SMTP id y10-v6so535631ioa.10
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMbBJEIy7CcRrtNLx3aihrhtIKCAy8t6xUB1y+wXPn0=;
        b=OQgT2c6ua6oyG5TiuGqSbckjjne7kiPH4R3WOoqUMwNh3vZygilfyfK7trr6CnzP6M
         u3EJzN11DSiMcJdwN8+z0ftMnqGlrFTnjuWPb3t22U3+DpDuOI/HJ+JCEiSzMDn3cYdE
         k2BFAh5neTV7391ZykK5oOUu3160r1tvbuYWP3dnUt8DWTRRb1QGdN0t0xyegWHy//OY
         8YF3FOqFXqOZx5VtEyIPIGpyC8Kbszasf/+RZ8di7dwE/egvIiQ9D3cB8ouQOEsgAkKX
         KKJY0McA6mnvmxnlTGaHbuRNS2HvT2u36gUirE4g08/FHpcvKj9PSUe7+NqaJSt6DqrF
         /MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMbBJEIy7CcRrtNLx3aihrhtIKCAy8t6xUB1y+wXPn0=;
        b=pCFumSNUl37GE10kHz8UQFLcNYQUVVl8AzXN3f9o5Szkuo6Yx1hnCT2S8KEpM/FDkk
         46s8R5pRkAenlWMjPhSMSDjKOMUKH5l0jdwXZOQgJjyLyJ1qdirB7DdfilmlvgtwYxWb
         /+7MzjFXiNzmH7tQ6shzw7XB/I8+4EV3a7ovEQs+7kUL9DIUaYtsjxyAyxzPs/0+KlXQ
         Zbvh5OUtrLA4jPabLV0L+ZVn71udcUYJXIHztri9dCjVqzlF52t7xuSRFWqIHtwq2CJU
         WhLkQ+a4X7X5LWWfI1lyFK35a6UP93W7ort87jW+hvyf2L3uua6+aVLJmVVdsyx+ugQF
         0aDg==
X-Gm-Message-State: ABuFfoi2qpWdIAeVXUpDI5shaWRmDf2M9GR7SZbtXNO4aP/rv/LeiKXG
        nBUbmkXpgbAw2d/UZIu8mGNIgQNUPBkXeg==
X-Google-Smtp-Source: ACcGV60goZ5ATRcubdXNEQ9N+GPgL3zjixl4UCoqqyyogwSne8UAmmH1+AnrXP+MP1vacxsn1ruWpg==
X-Received: by 2002:a62:c8c3:: with SMTP id i64-v6mr14324649pfk.183.1538447035664;
        Mon, 01 Oct 2018 19:23:55 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id g62-v6sm23846036pgc.22.2018.10.01.19.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 19:23:54 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:23:53 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v4 1/4] transport: drop refnames from for_each_alternate_ref
Message-ID: <491f258f5080465c6f4feb9958487595368d286e.1538446826.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538446826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538446826.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

None of the current callers use the refname parameter we pass to their
callbacks. In theory somebody _could_ do so, but it's actually quite
weird if you think about it: it's a ref in somebody else's repository.
So the name has no meaning locally, and in fact there may be duplicates
if there are multiple alternates.

The users of this interface really only care about seeing some ref tips,
since that promises that the alternate has the full commit graph
reachable from there. So let's keep the information we pass back to the
bare minimum.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c | 3 +--
 fetch-pack.c           | 3 +--
 transport.c            | 6 +++---
 transport.h            | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4d30001950..6792291f5e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -281,8 +281,7 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	return 0;
 }
 
-static void show_one_alternate_ref(const char *refname,
-				   const struct object_id *oid,
+static void show_one_alternate_ref(const struct object_id *oid,
 				   void *data)
 {
 	struct oidset *seen = data;
diff --git a/fetch-pack.c b/fetch-pack.c
index 75047a4b2a..b643de143b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -76,8 +76,7 @@ struct alternate_object_cache {
 	size_t nr, alloc;
 };
 
-static void cache_one_alternate(const char *refname,
-				const struct object_id *oid,
+static void cache_one_alternate(const struct object_id *oid,
 				void *vcache)
 {
 	struct alternate_object_cache *cache = vcache;
diff --git a/transport.c b/transport.c
index 1c76d64aba..2e0bc414d0 100644
--- a/transport.c
+++ b/transport.c
@@ -1336,7 +1336,7 @@ static void read_alternate_refs(const char *path,
 	cmd.git_cmd = 1;
 	argv_array_pushf(&cmd.args, "--git-dir=%s", path);
 	argv_array_push(&cmd.args, "for-each-ref");
-	argv_array_push(&cmd.args, "--format=%(objectname) %(refname)");
+	argv_array_push(&cmd.args, "--format=%(objectname)");
 	cmd.env = local_repo_env;
 	cmd.out = -1;
 
@@ -1348,13 +1348,13 @@ static void read_alternate_refs(const char *path,
 		struct object_id oid;
 
 		if (get_oid_hex(line.buf, &oid) ||
-		    line.buf[GIT_SHA1_HEXSZ] != ' ') {
+		    line.buf[GIT_SHA1_HEXSZ]) {
 			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
 		}
 
-		cb(line.buf + GIT_SHA1_HEXSZ + 1, &oid, data);
+		cb(&oid, data);
 	}
 
 	fclose(fh);
diff --git a/transport.h b/transport.h
index 01e717c29e..9baeca2d7a 100644
--- a/transport.h
+++ b/transport.h
@@ -261,6 +261,6 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, unsigned int *reject_reasons);
 
-typedef void alternate_ref_fn(const char *refname, const struct object_id *oid, void *);
+typedef void alternate_ref_fn(const struct object_id *oid, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
 #endif
-- 
2.19.0.221.g150f307af

