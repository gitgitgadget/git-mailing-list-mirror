Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F42E1FD4F
	for <e@80x24.org>; Wed, 30 May 2018 00:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968597AbeE3Atw (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36902 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968565AbeE3AtE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so29804plc.4
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CK7G+oCcBPsY6NluMsBjjvpFARPlGHkFoNPg9mnnaNs=;
        b=jYSpl/mCcyfxp3ZNrlankd54KPMNwIDE7RlyB7+G0rQmoWbxNgzaNm9armiVkugfWK
         dPSmnJYeEaoaRmcO/0T8a2Tuqvj4GiduSAfmg9VVbU8ExC33xsQNbzaUxhF7yIcjSlYu
         5a03+aW5CLNrr83YwrNbgcLXtJs473H7/9q0P6r2uI69MrNafXm2K6L5QfFyjGOlAoNd
         wMU2T9p7gZ9YbPDdYNYBLLvlG5GK34d3jzd/jljZ2qFSB42mummTuzrTVOPl2murDGp5
         NL20+gYsGrlSFwvuDPkXhLos58oyy7Pz6oD7kA+zNXkVn5E9xqbu33hOCrgSWMuGdrY4
         09Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CK7G+oCcBPsY6NluMsBjjvpFARPlGHkFoNPg9mnnaNs=;
        b=K16ZMOYohMgBTlGvbtyW7m2RIVZjwXxsZpbv6fL1T/kdlNGSgUmxXukBmr9tXvlwNE
         0YcwcyYxrKVW+KtatZQr9/lSDGS4MB9JprGpIQTOBjbvoZ9eEgPT24vc68X1rfsgHOQI
         NxZMEww+HT0QLlS5B2QanjD7YGifLF9512spgHKVlITGIxaasiFs7fEUrPJFGPTSPK9Z
         DxPoXHKQ9sYrazo+LEMLbcyr+gnYvQE8PTZ6gif6D75lE/hVsqt3BIBFCmyi9oY2ESni
         FsZFxgOe9IKFOpbAqnDCjEY1otXtIG1GeEnn1IQPz4RvfkKQVt7EYBrM+I+7AICraSwH
         KRAA==
X-Gm-Message-State: ALKqPwdk6hXJy+z/r1+ymaB21C+Dg4AorAwxLgyMoEeGqXUZmNyJJF8P
        wEXDIHj/+Zrvp86WGCTAlc9QgKpMZLA=
X-Google-Smtp-Source: ADUXVKK/8N5SIHGO2jMRmEIpPoZOlzDmqM7M6shvVmDB1skDWLBCW1Z6UvXw+L+cVvAoE/wVb9kOkA==
X-Received: by 2002:a17:902:848b:: with SMTP id c11-v6mr644531plo.132.1527641343261;
        Tue, 29 May 2018 17:49:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 14-v6sm15968207pgc.63.2018.05.29.17.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 29/35] commit.c: allow set_commit_buffer to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:04 -0700
Message-Id: <20180530004810.30076-30-sbeller@google.com>
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
 commit.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 45dbf6f1453..b824e69186e 100644
--- a/commit.c
+++ b/commit.c
@@ -262,10 +262,10 @@ void free_commit_buffer_slab(struct buffer_slab *bs)
 	free(bs);
 }
 
-void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer, unsigned long size)
 {
 	struct commit_buffer *v = buffer_slab_at(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	v->buffer = buffer;
 	v->size = size;
 }
diff --git a/commit.h b/commit.h
index df199498bfb..ec1733ed86d 100644
--- a/commit.h
+++ b/commit.h
@@ -87,8 +87,7 @@ void free_commit_buffer_slab(struct buffer_slab *bs);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-#define set_commit_buffer(r, c, b, s) set_commit_buffer_##r(c, b, s)
-void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned long size);
+void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
-- 
2.17.0.582.gccdcbd54c44.dirty

