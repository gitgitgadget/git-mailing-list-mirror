Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F401F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030447AbeF2BXv (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:51 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:54268 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030424AbeF2BXr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:47 -0400
Received: by mail-yw0-f201.google.com with SMTP id l72-v6so6416468ywc.20
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=IBDGEusxhlQBPllcXxZ7SdZBLJNYaNKS4VAFv+Iq0Zs=;
        b=p1MH0rNzVMXbC02JvxYSYx+gFt1O8CXd9MOtyztsMnshEixKDcNXROFGCg7Hl/kGPk
         tr4WUgQQqi/h+5+wABQt5gwWO2EC6IHznPJpp3WGLnT2BNCSFoOq5QaVHM03MZ8+AMnF
         xVOpd+UMgVdaRKBB0Hrrm3sMljwO8H4mISyZWHgNe9INC7prPXgOSXdwQPczV/DHOFZ6
         Z3Ld7qjyWkGrZ82G9Y0yyJgEVj9WOAq0D0yG/lXb10/B3cGFcFfyI1ZTjuqwgkWV6uL2
         v4hkpH/ibMq60C7glIHhtLfFBkJ5lRqM8HlmJVdXvb4ACnsdSxmDDtqAf40n2nkkfvJw
         ABhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=IBDGEusxhlQBPllcXxZ7SdZBLJNYaNKS4VAFv+Iq0Zs=;
        b=Ac4OdlUJZ7VxxOTVTgqirHBVXnrR6bbcIFf8kkXSwG4ACJoIu5cBQ4PjRtQzyrxS7w
         4LqFg9vD+kvrrziPhXC/sdhwp+mpwQ2D12g68c9jaVVaT+127bs+hoDwysDCs2NyZ1Gi
         lYQYIUUlbGxHGE/RcStmulsrz5LHfmLUQyJgNlmGQEuSuL9DoU6N/A+mQpHfuU2kGSAR
         M/ce+Zg9LIPb/MF+K6zLk3Q+XCL9mmb7/Qh+yH0bYGMq5YWiS/DzUEfPDW4qXWLNZeBA
         YpDjfTWwp3ZFDV9gzGmjJ5p2ozpkMar6xI1p0UmwM2XeuIFf8XNZJRaw9cSY+9qUR015
         bEkg==
X-Gm-Message-State: APt69E2/he5ylt2pu26rIkH+oZVVXSzlabIGRWkKNQSmtXDIO06vbfNe
        wr9lDl8CT6EzHmZiu4RdJiQP+xzkxfOrnyPGwIvWA2N7tO5s4fsqCkpjvTqGS/RodLcUfYWsiKE
        8CZH99JkH8Mgykh19ndAkKMSsh6k/e/zMvcsbSnNczOCpDeXrQXkt8eSR0YV8
X-Google-Smtp-Source: AAOMgpc3mNN1cEwExVDrWZwqvvUxeOKpuRxIoTPU5U4ve99NGuomJWom+o0isYeSecQEoOax20qNQqintwV+
MIME-Version: 1.0
X-Received: by 2002:a81:6cd2:: with SMTP id h201-v6mr93755ywc.229.1530235426690;
 Thu, 28 Jun 2018 18:23:46 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:22 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-33-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 32/32] commit.c: allow lookup_commit_reference to handle
 arbitrary repositories
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
 commit.c | 4 ++--
 commit.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 08b4602f43f..b88ced5b026 100644
--- a/commit.c
+++ b/commit.c
@@ -36,9 +36,9 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
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
index f1f25957de4..8b2cf9692de 100644
--- a/commit.h
+++ b/commit.h
@@ -64,9 +64,8 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
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
2.18.0.399.gad0ab374a1-goog

