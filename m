Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D14C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiCDKoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiCDKoE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F51AC297
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cx5so7044320pjb.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tlU96CYeTuyTtdpREYGgx8VcGfsmQiSu7UvBT/Rsxs=;
        b=FrocB5pPqVzMdDue8168keI7ZY73reAjN+be+XtXeNKctkBap+hY/ICaj1GxpqWeEz
         Mp8zU0Zied+Tbh/IQ6+VuQimI0uLL6IRW7RNDLR92Ayv9EDPqf5vKf/ac5IFFHEdAcmn
         yWQs8VCWYzkTgxA8FRlhfsJmU3V2jq3jI/ufGTyOzG432l8hdl/O9wm3yrgWSxO6YD/P
         KdaLaqlSvsLvZSoeefOY6bnirRVkkoP0KqELAvnilNlx8p0abXggB699Gq6uzAEuWKm1
         3E8jJD3YQ815uREZi5JbF1J6RF1o50b78Lt4Yz7P84Cx7bMT2l6BlqNSmZ9yDzEa2ESO
         J9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tlU96CYeTuyTtdpREYGgx8VcGfsmQiSu7UvBT/Rsxs=;
        b=CO6MrPeHPC4z3u5QTLYrUHIzBpc8V8rET6rawe89vhnxZqO3e6tjHvQiHG5nPzDGlx
         DW/ns8cMRiJ+KUTslo2SRIMQFsvYHAlymM2E8AQiLkwrOrBWFrAKcqdu2RQVY4GR5//R
         gsUZCAeQqL7Onp+bgMFtxP4J+V2V5VAzhNGja0eL9TrLygT0ltDjd6R2PiTXnbhG19iY
         AoZaK6/oB9nadO1fH4kza5bT6Cy8NHwVQON5R4kaBYklxHCkmDp+6nY/TWlo8A5mJ/OV
         wES8uH1xRik0d5IXYrWa7c19mICeMWpxnFT7Q6lH2eTRnpdT2BFL1M9i1bcWxuefE6xS
         JVQw==
X-Gm-Message-State: AOAM531/BvbKwEgdV5XGyGcyuT43DzKzkbPqfsGD4CQEtAN5Y4vhS+EJ
        dc2jLUhyphwQaiRg8BFzjvI=
X-Google-Smtp-Source: ABdhPJz+eAHLDLICF3FCVzsB+mm+Ol/ht/H6XxcBBgqZT9m4yAyEjLXwr9+guOIfl9NHt3QfW+ZEvA==
X-Received: by 2002:a17:90b:1c8c:b0:1b8:5adb:fd84 with SMTP id oo12-20020a17090b1c8c00b001b85adbfd84mr10037156pjb.238.1646390596361;
        Fri, 04 Mar 2022 02:43:16 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:16 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 05/12] ls-tree: rename "retval" to "recurse" in "show_tree()"
Date:   Fri,  4 Mar 2022 18:42:31 +0800
Message-Id: <99e6d47108308b0bbaf406b439170de04e375c56.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable which "show_tree()" return is named "retval", a name that's
a little hard to understand. The commit rename "retval" to "recurse"
which is a more meaningful name than before in the context. We do not
need to take a look at "read_tree_at()" in "tree.c" to make sure what
does "retval" mean.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d5..ef8c414f61 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -64,7 +64,7 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
-	int retval = 0;
+	int recurse = 0;
 	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
@@ -72,9 +72,9 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
+			recurse = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
+				return recurse;
 		}
 		type = OBJ_TREE;
 	}
@@ -109,7 +109,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				   chomp_prefix ? ls_tree_prefix : NULL,
 				   stdout, line_termination);
 	strbuf_setlen(base, baselen);
-	return retval;
+	return recurse;
 }
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
-- 
2.34.1.402.gef0f5bd184

