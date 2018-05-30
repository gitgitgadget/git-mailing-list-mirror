Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224681F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968593AbeE3Atn (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:43 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:38197 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968572AbeE3AtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:09 -0400
Received: by mail-pf0-f178.google.com with SMTP id b74-v6so4646312pfl.5
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nwxO2pgScPqw094Pepa5PUCv8W87FCoxp50jhjJ8ShE=;
        b=OjhxsR1JvDtwTx877Ea8x6LJhkccZ3XOHKQCUF6uhmxnFxolRNfLULvuw3N5Vz6bh9
         w81uKw7cWwshwMqnSWCL1/kjFw/lOcDwlq/s1L/rYOxRUC6dnll066ygeZndExMkF0BQ
         D37UbShx4KCKK0K0ZMgcR/j1/FL9KkiCEQHO5uTLbwmPkfO3EVP/Xq+Nx0by9g2Ocjaw
         dexOojmEmrayfIwMnk/y3MvvQ2V4DCJH6cFGPJsYZfhSjEqyV1O2YY2vnwuenUVbxFqh
         b4v3d9BgcQAkaKrRY9XBp5CyODE8+NtEzowaRDYh5mpe9AlTaweRuJiBSb580MkcKxl8
         KuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nwxO2pgScPqw094Pepa5PUCv8W87FCoxp50jhjJ8ShE=;
        b=AUCoBtMljosGg/TAAVIICxjmoeieZObleYnFAsWQppDLzBz3TxfuIJqRxzsF/ZDQU2
         IuRjQPmgJs2dJIcHBqVp4XtogIdCpMIUbQkPL4XOD9ojCqqrhMIC4Rbxfhl7OPqBTtXn
         +lTbIEl2uZWBkDjhhTNiQME4P6xuJVG3ggKu3KwlwP9aaaWr1dvThpfSPGXGVbRB3F13
         ExMmWKmqsi4qwIAwK7iMt+Wr5Orva0PaB/BiJWw7aI356iuVUXWsGYOYFTjkhdqkk5OT
         Zsub6ObcT/4OCbhjHGQgaVk3q7qSkQl+zGR+aidD/33jSqXaffNlYcl2/pm1Tm1J3OLW
         RhxA==
X-Gm-Message-State: ALKqPwdNFO20RmvWvYROWkSOCQHPxuXT7OoDJUpBYMzAQkpgaBm92xCP
        f+iuv1U36xEbD7lsPSgVBVljTEN8Uvk=
X-Google-Smtp-Source: ADUXVKLsg9SPH9fBa+ChzPo9qWEMVbNn1+d9FutSteqsNi/ngbfUSKsdsUpkgVAaP/mnx04cj6MFBA==
X-Received: by 2002:a65:5946:: with SMTP id g6-v6mr452033pgu.391.1527641348838;
        Tue, 29 May 2018 17:49:08 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id h27-v6sm16057907pfk.160.2018.05.29.17.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 33/35] tag.c: allow deref_tag to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:08 -0700
Message-Id: <20180530004810.30076-34-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 5 ++---
 tag.h | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tag.c b/tag.c
index 682e7793059..94a89b21cb5 100644
--- a/tag.c
+++ b/tag.c
@@ -64,12 +64,11 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	return ret;
 }
 
-struct object *deref_tag_the_repository(struct object *o, const char *warn, int warnlen)
+struct object *deref_tag(struct repository *r, struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
 		if (((struct tag *)o)->tagged)
-			o = parse_object(the_repository,
-					 &((struct tag *)o)->tagged->oid);
+			o = parse_object(r, &((struct tag *)o)->tagged->oid);
 		else
 			o = NULL;
 	if (!o && warn) {
diff --git a/tag.h b/tag.h
index efd4c7da67c..e669c3e497a 100644
--- a/tag.h
+++ b/tag.h
@@ -15,8 +15,7 @@ extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
-#define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
-extern struct object *deref_tag_the_repository(struct object *, const char *, int);
+extern struct object *deref_tag(struct repository *r, struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
 extern int gpg_verify_tag(const struct object_id *oid,
 		const char *name_to_report, unsigned flags);
-- 
2.17.0.582.gccdcbd54c44.dirty

