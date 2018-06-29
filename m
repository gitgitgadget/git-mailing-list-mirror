Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76DC1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030436AbeF2BXp (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:45 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:50073 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030424AbeF2BXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:42 -0400
Received: by mail-qt0-f201.google.com with SMTP id c4-v6so7633501qtp.16
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sLxj2h2yg4uxggJvhZSqbeCLtIZkACOIakWjUhAMhC4=;
        b=PQs3qm4wYdcZErML/FYdDGQcQ44aid0+iOkLJxGJEA7B+gxQCQttkJDzhxo+UQdrN0
         qweIuYT2Db9P4uuc6XHHfDTZvYU0nh8tXBWRE6+vdwmRAAyRWKf7PM389cKufCXcSKRu
         Nh7eSxQZxAFgxQy/8uBJIDTjsN6L1GvniTcp/4xtzIgX2ETDMtXiNhZzYafxXvYjmzWk
         kMfKrKNPQTkaKZz+cPKugO7vFgdjl+sYJZyoiIHD93/7VUU/ijB8Dvul9iLAtzxO7H+L
         2G+SKRTybiJUS6Dam0XsRBoRwAkDQCtaE9ROTAVDqnL1RA8/ExSCF4+52Wel1L2XG6OH
         aCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sLxj2h2yg4uxggJvhZSqbeCLtIZkACOIakWjUhAMhC4=;
        b=K31B+fn2dqe+rVpCrUkVWxhnXjDb8SaGJ4o0eX28T0Vp1TPcjetsfpYhH69qVNKwAH
         cfcTmJOtJMovv1Yy048ZxrKPaj9gl1DDdepRTmoHwF3cNIchAtHKjuhPCHHg5jjD7Frj
         t/u4UOsyPY7kNIP9KA8GfjqNggmjAXrCcDYpEtO0SZyaZWc6nAa/bLwkqPDbndjNz8Et
         EOGU0MFxNRlr6bd5DeGiqCLTQDMWeDi/Fkdtz5I1G3SdagstWFDId/DVnYyacNxAc+/H
         wYZH/hRBiLRlUKCnxmyWFScEr5EqojggPMO+J/wg3eLrtTzXxZhgnKs1CPvoy0SBXP+7
         CvOg==
X-Gm-Message-State: APt69E2jwbCg3NFj4n0/1RV9fZRxwrNAd9Rib3yetfVD16S8KCsDdPON
        nIaWnROlu/TYxJwB0XXGNUhP52VJqIIAuTooBZMBqPI6GDdNSrDy5EpYFUuNTLsx2N1eKov6oWc
        7noO2osnHwJwPx7Jq6ohmURN78pOCuCEGJoww/Oy9Y0Kx+Fnc5nD+wAS0/4vr
X-Google-Smtp-Source: AAOMgpeLpc/6t+8x+9yFEy8pqV0XJQi/V3vVZiotkbsTY4LXJvhhGArQUKX7lpZSpvXxMoRQQj0JRK+Hd1wk
MIME-Version: 1.0
X-Received: by 2002:a0c:facd:: with SMTP id p13-v6mr6714488qvo.10.1530235421518;
 Thu, 28 Jun 2018 18:23:41 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:20 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-31-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 30/32] tag.c: allow deref_tag to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
2.18.0.399.gad0ab374a1-goog

