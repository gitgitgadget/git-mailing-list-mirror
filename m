Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ECFF1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968600AbeE3AuA (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:50:00 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:38177 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968490AbeE3Asu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:50 -0400
Received: by mail-pf0-f171.google.com with SMTP id b74-v6so4645953pfl.5
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tT3o2/nabfV2uyxQIw9BTmCG8UAkkbmr//NVLOB6/vU=;
        b=iR73tkxQb0u/6sXHU3pYhz8wQBfXQSysV6beWF31C4HikAl6I9g1qpzX6bjY1sTVjB
         hvJ70m1dz9THKQTZz/Inrlx75TOtHuCUCnxPPL4DsjVRnIkBZ4jiRrIjZ30rAmM/v8xr
         pS6JsmbP8TKgL8si7gkL/BFS+HeW6DQZak3IeV6ExPXW8iv1u1atZVjoUSxNndjJ4tw2
         Sqlfg7P8xLrO00R/doxXA0dkO4joydmT4ZDDK3d9usFMLjaJ6FBYNQ+PD6MNIdQs7HSA
         wBth5VTSytGuBu0EQQrdjb5bz28UahlEG/x0gk5Ox8vSafQA14wBBToowDSQpyVx1PQb
         loOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tT3o2/nabfV2uyxQIw9BTmCG8UAkkbmr//NVLOB6/vU=;
        b=oawVJlmD/3vCaAnFaZqBk4+IB/3yxFsnijAOzJHRxIGeD7vlf8YpcGu8rBCWXtt/Kd
         zgHT4LA+XVZpxRD8EXr+aMsAW0mk5KkNduNSGnL6eGhTwxSddTcYBGFHhNxFfRaqts2T
         X0wJ3i6mM4TkzmuCI32BqkUugp6B8lhc8sTpQnO7SNhSPP3fTGXHmaANHdv9dsjDOmFT
         aMCYFPJobcowH/M4YkbXewR9rno8qAaj8h61fzQ3zZVG1Ur5bEzQgzG6RPg18OVF1Db1
         vdnOh9I9FCSalNqxSuU6FX3NVDdxuMzhz8w/7zR6o71Nt0S3vM3ZB5Y8SYpid+MKdLp1
         zyCQ==
X-Gm-Message-State: ALKqPwf1fhw4ii3o1cfibEpCsUTApB2iCYPctLa+7s9M8Pq4goL4LlAS
        yqu2r6JVzN/vP2zUw3f4Mytoy7MPEvE=
X-Google-Smtp-Source: ADUXVKJIPRceHoI7SpFXsD4XJdDW2GOtLvmEPj5mSJzigxJYjujInsopckezWLLeuvaxYiigQPKwyg==
X-Received: by 2002:a63:788b:: with SMTP id t133-v6mr500791pgc.20.1527641329338;
        Tue, 29 May 2018 17:48:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m17-v6sm24991705pgd.52.2018.05.29.17.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/35] object: allow object_as_type to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:47:54 -0700
Message-Id: <20180530004810.30076-20-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 4 ++--
 object.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index eb35e82a4a9..fabd3ea2134 100644
--- a/object.c
+++ b/object.c
@@ -158,13 +158,13 @@ void *create_object(struct repository *r, const unsigned char *sha1, void *o)
 	return obj;
 }
 
-void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet)
+void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
 		return obj;
 	else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
-			((struct commit *)obj)->index = alloc_commit_index(the_repository);
+			((struct commit *)obj)->index = alloc_commit_index(r);
 		obj->type = type;
 		return obj;
 	}
diff --git a/object.h b/object.h
index f2afe7cc66f..ad5f3b2826a 100644
--- a/object.h
+++ b/object.h
@@ -115,8 +115,7 @@ struct object *lookup_object_the_repository(const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-#define object_as_type(r, o, t, q) object_as_type_##r(o, t, q)
-void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet);
+void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet);
 
 /*
  * Returns the object, having parsed it to find out what it is.
-- 
2.17.0.582.gccdcbd54c44.dirty

