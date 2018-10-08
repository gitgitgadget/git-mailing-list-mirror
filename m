Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814B51F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJIBWW (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:22:22 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38494 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBWW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:22:22 -0400
Received: by mail-pf1-f173.google.com with SMTP id f29-v6so5869623pff.5
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMbBJEIy7CcRrtNLx3aihrhtIKCAy8t6xUB1y+wXPn0=;
        b=VbuM3/U4qPOI/4iL+tYQnyxZ5HCnkanNtf8gjnAfIzFL9cmvuCakuyqdInMzgv0XSv
         5RHZ42yL46dl8N6mpc3wwIgB/PWCDw/wBH1mB6gwjbQmHPeAPySHp798q8CQKl60D2Na
         2SzP/whYBReYkyKvSm/ylBdoDlRbsVpOzmupnbz/faBwgZFkeb6Ik5C04WM/oJyGBhV6
         dtfyT/Q33R8pMu9rINBdxW8+rKSzpW8lidPv8Oze5rXllZNUv1sBic/6ll4IdKAp2IHR
         81CeqqKXHJwCmUgUfv3xyu6YstiGF8czherWs5pLbSXTPeoe2ApPdt2jGUIPVn8Mfjdg
         h8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMbBJEIy7CcRrtNLx3aihrhtIKCAy8t6xUB1y+wXPn0=;
        b=ejlPoEnbWDKlSzzt9EZslCFq22lfCPW+TY1Gb0IZhTFRj76F06NqPj1OLso3m79LCx
         05mMPs9hqN1slpTvkpCkHxpD0Ad4ALR5Ot5yMajke0k1cYlw5ZeQDi+54v+sHLYkSHoX
         siVgcD4UDaF+rCsNsTEs5a47qShwGllmU0MWIkG40e+ZFPsT3grX8lrH96oifcYdYCfe
         dnemqA1i5xWbmPb4uU2eeVGM6yfjUxecTOXSo1zIAtZET7NvDYf5ix03ZVb0N3W/vVgH
         YsCmpyyLJgMokLDJWqmTRh0uPz6n6GFlC3ssAVBbDz6LAcitPJ9PmCaEfZk9EaFMgIvM
         BNxQ==
X-Gm-Message-State: ABuFfoiuR+whCV4fgZybMm3RI2Qe5ViKZ4FuPnfnrmFYr1gjSEKnLfFX
        a++cxd03SUc7YP2mPZQxJBgf3LCdOeA=
X-Google-Smtp-Source: ACcGV60v3HSkUxk4mIHZVGw1y+wY8KOF5moCoR1Z2SEGk8A755HDc2HdWvn9bZgrbMiPa1YT6J5Uzw==
X-Received: by 2002:a62:8708:: with SMTP id i8-v6mr26181317pfe.150.1539022165196;
        Mon, 08 Oct 2018 11:09:25 -0700 (PDT)
Received: from localhost ([205.175.107.112])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24223373pfg.173.2018.10.08.11.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:09:24 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:09:23 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v5 1/4] transport: drop refnames from for_each_alternate_ref
Message-ID: <e4947f557b2eab84047adde62d3a79e657e664d5.1539021825.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1539021825.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539021825.git.me@ttaylorr.com>
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

