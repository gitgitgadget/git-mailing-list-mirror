Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B241F453
	for <e@80x24.org>; Fri, 28 Sep 2018 04:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeI1Kr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 06:47:26 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:47073 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1KrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 06:47:25 -0400
Received: by mail-pf1-f174.google.com with SMTP id d8-v6so3367400pfo.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWCjesQs45uIiTepfNif0G/RoktAJa+Gp4iLqGAH/pw=;
        b=pPR4+1w9bodvWCYoM70zvYfxsdH7XEdHUjL26rpCZtsDLAME6AwqgzQWvQFwpakZil
         XZdjm4CO0I6LmmWqF5Xvte/Y1cf8mB+aYY7cUCQCDGWsaDyHo7JrWO7V39wb6w2LQYSX
         IOsvxBmBaRsODTDMmoZCKL/s5aAtbeQ0+xH6oaDS8zCX/dWeNVL3iVfJVcqjBM0YTnQs
         k1M7/P9VdDtwbFPej4OUBCyWSyjrhgT8iM4gXe7zbN58/t64ral4bTJwTkgXAX5E9/Ks
         v9RUWJai/JmPduyDeLX5i8BWiIONqsA8NTGZ61Fwtnu2Jsh1kY0WZAbYOfB/6UZqFX4k
         vKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWCjesQs45uIiTepfNif0G/RoktAJa+Gp4iLqGAH/pw=;
        b=P1Z6asfD94Brtecxl2l0ZsLfkojE0rnAyVDDJ2v/3PjxYPHE0URZYeAHJXhbv3iJuL
         Iu+Fz6xELyOCj7boVgk/r2c5Xv8AxZwHT6Dudvgkv6AGnyz5dlWU75CbK8e9QNGQ/3ts
         k4gUuxSCP0J9sIKulMtQdKegAoD5d5Tp+CMvxAa/9BTsheuF+0Dw/Yg5W/4bKJVXWlDu
         NlTHaDAto18sT/XhhDveELRort1rBiWbQ8FR76w/9xHqpFbAPY/+Cnwbg+I9KUuag54n
         +3qhCv6GGGv8FHCorw68ihRxbs8vsHhS68aBzSdoxIgR0JjnWuvbcXlhR0moiscaeRqD
         uW8A==
X-Gm-Message-State: ABuFfoijOApmmivOv1su83F9R+sWcmob+jcxvmYjnfNly0prLSAthWJh
        2bDIDoyIAeGr+wbhDMCuoVGxyFy0xEHSqg==
X-Google-Smtp-Source: ACcGV62fG0Ux+4D2qy/M6wy9dy/xiyuf11jd5GZNIdS7uXzwME4IpQiGRNr+tGEdmWU7ZDFANmKUfw==
X-Received: by 2002:a63:ef10:: with SMTP id u16-v6mr13132152pgh.269.1538108739179;
        Thu, 27 Sep 2018 21:25:39 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:1924:afac:8279:2210])
        by smtp.gmail.com with ESMTPSA id i65-v6sm5995635pfk.43.2018.09.27.21.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 21:25:37 -0700 (PDT)
From:   Jeff King <me@ttaylorr.com>
X-Google-Original-From: Jeff King <peff@peff.net>
Date:   Thu, 27 Sep 2018 21:25:37 -0700
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: [PATCH v3 1/4] transport: drop refnames from for_each_alternate_ref
Message-ID: <037273dab0f861e5f10241de1e32cddaabeab0cc.1538108385.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538108385.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

