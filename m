Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0528A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeG3VYX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:24:23 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:35956 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3VYW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:24:22 -0400
Received: by mail-it0-f74.google.com with SMTP id m185-v6so522937itm.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kWxa0pX3/pXT4+nz/YEvZ7VypesQL11RmxsMPdtBJQ0=;
        b=TFaHItkkM3jv/fM9yZlZEmlAvaSjOSYBhBrCXQt5RWpWYyckJ8SL3ba2LG7imjQf6z
         NCMWQIv+ZOAVGPV/SlHEioP0e85U/wZnnOCcqGFRNjXr0LCsec5KUGW9kWatrw61ApHB
         s+uhBDTlINLxyNvK1Zq2geDQzzWPNLW+WZ5nOuzatgn2ik2CSaSDMuqYVU54GsN8nRMd
         Z9LfxquostgYgn4mgFl0gmNtpmQCJMuRUmJlnM6dIiW8S8bBVGM534bJIyRDl4mXPC0e
         rrCZWZ78oiXD6AeFQj8u0xr+MtKaaSeLdm6o8U2HPi8o2W3naes8Daw91RzWT41nj7oq
         DK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kWxa0pX3/pXT4+nz/YEvZ7VypesQL11RmxsMPdtBJQ0=;
        b=s6BE7kIgqVzsPVH0gfaToukk0UaiPt6LONs2+YCi9mPm0v/4OogJG2/pWg24eJ/RjJ
         7BpfM8wcEsN2l31sUM48JAPHw0I2bgMNQp/oVlX8lcL1KYdMb2suONFtN2/yl5+DpO2/
         f17vgQZLeZh3LEZaq02ZPU0ExC50/jyu7ohLysp33UF3SExTbrlGGfznbySAFLC7LU8G
         +oRWJdX9Uh8xFB89yzW8//DzRNm3ZGi+QSE0WqA+HD01IjAwz9ucclWcE5CWyQkA5b1I
         TP/lXAAc5DwoNJG+et+JSor22ZcXeogzn+i/t5lJ6yo9Utnz8HeUm8Z7e+mOh9EAaijx
         bcSg==
X-Gm-Message-State: AOUpUlH6KA77WsenO7aWlp+fPvoO3dX6fijvvNSUJPaOb0ZFIvjdADlY
        G7kA9JS48NwRT+squt0PmJoF7VmYgy5L
X-Google-Smtp-Source: AAOMgpcMySNWfF+2KmFtz7ZMB8IZVhmrnaprGMcoQT+tnd1ISCAeKgsW0Lfx5rDflJgiC87SVZmItSo8h7Yo
MIME-Version: 1.0
X-Received: by 2002:a24:328e:: with SMTP id j136-v6mr307293ita.26.1532980069783;
 Mon, 30 Jul 2018 12:47:49 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:47:30 -0700
In-Reply-To: <20180730194731.220191-1-sbeller@google.com>
Message-Id: <20180730194731.220191-2-sbeller@google.com>
References: <CACsJy8Cx7u5YtK6sPJ=HbAOUBXCrP7VOgMyoQ58SB6q_s4N7Gg@mail.gmail.com>
 <20180730194731.220191-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 1/2] replace-objects: use arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, mhagger@alum.mit.edu,
        sbeller@google.com, stolee@gmail.com, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is the smallest possible change that makes prepare_replace_objects
work properly with arbitrary repositories. By supplying the repository
as the cb_data, we do not need to modify any code in the ref iterator
logic. We will likely want to do a full replacement of the ref iterator
logic to provide a repository struct as a concrete parameter.

[sb: original commit message left as-is. I disagree with it.
We want to keep the ref store API clean and focussed on struct
ref_store. There is no need to treat a repository any special
for pass-through by the callback cookie. So instead let's just
pass the repository as a cb cookie and cleanup the API in follow
up patches]

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 801b5c16789..e99fcd1ff6e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -14,6 +14,7 @@ static int register_replace_ref(const char *refname,
 	const char *slash = strrchr(refname, '/');
 	const char *hash = slash ? slash + 1 : refname;
 	struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
+	struct repository *r = (struct repository *)cb_data;
 
 	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
@@ -25,7 +26,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
+	if (oidmap_put(r->objects->replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
@@ -40,7 +41,7 @@ static void prepare_replace_object(struct repository *r)
 		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
-	for_each_replace_ref(r, register_replace_ref, NULL);
+	for_each_replace_ref(r, register_replace_ref, r);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.18.0.132.g195c49a2227

