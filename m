Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79F81F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965066AbeF0NZF (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36416 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934033AbeF0NZD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:03 -0400
Received: by mail-qt0-f195.google.com with SMTP id o9-v6so1584056qtp.3
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWTr3zFA/tFAk6Gid54+sYGZNfmCZq8ks3V/PyRTOpM=;
        b=Zc4JqO+tG4beEtts4oByxWWb7ZwJ5yQTz4ufCJ79Gz84HK4ZGgV647cxtvl8R/eO0y
         mxHlUAAtSSdYHpllp6a7C1jcBXJ+zB/gEkm5jQ+Mv6tdpXyDC9wEpNa70OaPQRcM1zX+
         Ati8ay7O9LThDk07ta372jeBu8BM2mO0jScQMVs/02RuOKuBKewXr2XP2U6RaN5lHOza
         NPHyoyBQ/I+limypz+GtZRIsPyqKIv4xna5qiGWDI+UylUSovIdS87yMfBzKiR1KQrf5
         oojVJ/ktg54+f8l4IsqnvDsssAZg4Jj5bDsB0YyAOTeykubWT1hsmkqOnJo8Piet5Ca8
         N5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWTr3zFA/tFAk6Gid54+sYGZNfmCZq8ks3V/PyRTOpM=;
        b=aLPH3/XKgM5cAAQqpSBq4k3Bcqra/ZhXx/jIJT+dMt9QnJJgrCY8mI6mssYssXbrH8
         RaHXz7ePKIM1PXS/g+NuwDp9nR3ih80qi0hR0haYgyUmZsk3CPI+jBj/RIDAmWO5giLS
         oTsSULi06XtJEGuDtTL0Y/SIJ3LVRDdovsECpSrhYpKj4XBF2WUr/M9BAb5qfCZGClL2
         e1iM8V+lLgA9ZM9BKiP+xl7TLfKQ8JpaoZHyXj6egOqH53WohUsp5MpEwNzYjPytn6sd
         w9bSfspwCuucW6qOv4XtPxOQbKMj+QSpjLqf+fiLp/bgwEBUB/OjqzIsUtJizLqgati1
         eDBQ==
X-Gm-Message-State: APt69E0bRldd+N4V5fAaf4JUE6jBkigcy0v7dVi497vybs/k8D1sE1fl
        dbCZjerDfKF8NiIFC0h1/115gupzhxg=
X-Google-Smtp-Source: AAOMgpfsRxqnZzzE/XO1zL9hirdYinqjX8EQ4dSLmfSAtSmzKJakshjGYoRpCQ7UqO/yQXmihlXT7A==
X-Received: by 2002:aed:3ba3:: with SMTP id r32-v6mr5377750qte.362.1530105902792;
        Wed, 27 Jun 2018 06:25:02 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:02 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 03/22] commit-graph: fix GRAPH_MIN_SIZE
Date:   Wed, 27 Jun 2018 09:24:28 -0400
Message-Id: <20180627132447.142473-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GRAPH_MIN_SIZE macro should be the smallest size of a parsable
commit-graph file. However, the minimum number of chunks was wrong.
It is possible to write a commit-graph file with zero commits, and
that violates this macro's value.

Rewrite the macro, and use extra macros to better explain the magic
constants.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b63a1fc85e..f83f6d2373 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -35,10 +35,11 @@
 
 #define GRAPH_LAST_EDGE 0x80000000
 
+#define GRAPH_HEADER_SIZE 8
 #define GRAPH_FANOUT_SIZE (4 * 256)
 #define GRAPH_CHUNKLOOKUP_WIDTH 12
-#define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + \
-			GRAPH_OID_LEN + 8)
+#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
+			+ GRAPH_FANOUT_SIZE + GRAPH_OID_LEN)
 
 char *get_commit_graph_filename(const char *obj_dir)
 {
-- 
2.18.0.24.g1b579a2ee9

