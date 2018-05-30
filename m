Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B161F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968590AbeE3Atb (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:31 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:41600 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968089AbeE3AtM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:12 -0400
Received: by mail-pl0-f42.google.com with SMTP id az12-v6so9958079plb.8
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g8jHiywSNDE5gTcOrcsO9wTd6oqG/tam5+TFbkVmil4=;
        b=r400fXDGHRsvE7c5HOC4yvckMSoMy1ZrNaETQWkAQ5RrAWh2VsM0pxYaQt57dJ5oDh
         x3TY5zi9RkVupIbpU6BTBLU6EtMnnuzNBHYlZu84NwDuFzaca1lCDKEaILbuUmd0y4/5
         UNc3FR3CRK+fdRlHf/zGlGq+rwXB0lhbQmNU2WKl1p/2i+32aR6Tts0ByK0kfAJ+6du7
         YmF4Kc+z8HQVG5SDLw4ADuuvHSWV0g/lHuoxSbq0pZ8iwspjOB/749I7Yko0EmWVS5gv
         7B2NEd6CySoIVS86zwFDp0kaHvjnBQzJxzjkaqLqC6GJqEcPjVqiE5WfTDwmu8keZhgE
         sJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g8jHiywSNDE5gTcOrcsO9wTd6oqG/tam5+TFbkVmil4=;
        b=FNjo+vFTrubb/XdCc+T2PVzodFKksZuPCL3r/c1VOlZQbxVDAwLelmIGISX3mlhQYq
         rxF9CkyNIlr6wuc09F6Ohx4hIZJUIF1hNR5liNrNPop2lsUEa9kUVPrIh1c4ScehbxTX
         5AQsKDnRx1Zaq1YEnBsTON0HLTmZddFOgrYCvF99H9p5MRFiYybS9ZNYAnqwR8wW7XfC
         07s7FIgY2fobx3rzNZ43grHw1ew1AbTr8EtYiqDdQz6mYdPhMLy0IIJLzsVbCWC6DXLM
         HSYloMjWwfE2We8grSKp0Z4YMCkSVZoqlWyrAzIcTQltPr9i/z9p/BCGIzLg2hO+WHEp
         Q+5Q==
X-Gm-Message-State: ALKqPwfPnMghpPDkBVKTc6RfvlmV6c7mdA4gVKwzW80E6TgqPhgT0p4k
        kdFVBPMpF+BzITQnm//bBtmzuuBehB0=
X-Google-Smtp-Source: ADUXVKIjxwf3Y21m8IEA5yrEc3aGehFF9J/yjQpraS/qRGH57/8h9RsFrm8cdcgjaIGrJJvZtL23YQ==
X-Received: by 2002:a17:902:780a:: with SMTP id p10-v6mr607652pll.281.1527641351488;
        Tue, 29 May 2018 17:49:11 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r20-v6sm62054463pff.152.2018.05.29.17.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 35/35] commit.c: allow lookup_commit_reference to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:10 -0700
Message-Id: <20180530004810.30076-36-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 4 ++--
 commit.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index f1bea3d1612..b54aed12170 100644
--- a/commit.c
+++ b/commit.c
@@ -35,9 +35,9 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
 	return object_as_type(r, obj, OBJ_COMMIT, quiet);
 }
 
-struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
+struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)
 {
-	return lookup_commit_reference_gently(the_repository, oid, 0);
+	return lookup_commit_reference_gently(r, oid, 0);
 }
 
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name)
diff --git a/commit.h b/commit.h
index 1fc55900fb5..12736c5fbb3 100644
--- a/commit.h
+++ b/commit.h
@@ -54,9 +54,8 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
-#define lookup_commit_reference(r, o) \
-		lookup_commit_reference_##r(o)
-struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
+struct commit *lookup_commit_reference(struct repository *r,
+				       const struct object_id *oid);
 struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
-- 
2.17.0.582.gccdcbd54c44.dirty

