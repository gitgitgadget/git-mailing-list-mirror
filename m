Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F084B1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965446AbeF0NZh (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:37 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41142 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965419AbeF0NZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:26 -0400
Received: by mail-qt0-f195.google.com with SMTP id y20-v6so1571369qto.8
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FMEj809btplyZ8ZsIq3DhbRBEL8Biljh1/KBPlKZ5B4=;
        b=cdv9vRK+aW3DNcl2ERxY0gG05k5HHsJwPsOjplNKb+UrGlyCVCoSQMs1M5wjGmAjZk
         8SRphMRuXL3yevkJrkuuUVHGY+fTrWKhGhBcsTZinC7uHEjGqLF1F8KTDc1Hbkeh+mBj
         6n184ffZ/7IWQoE2IAYsi27Xvr74gtamSCbJCz6/p6WGZb6zBa5l7MvswDo4/xm5krP5
         n1N8rQ5ZUDHkUXDLpVwHVI5YLiWnvLBc1JtsdkGsGJHqwYXz3nlqAFGiokIqQLOeypTA
         JxT5A0MOZo7ti358HaxOb2T0z/MK6orU4zdwO+rpxvnPlBps8M/Ld7Fweri8z//OatN/
         wBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FMEj809btplyZ8ZsIq3DhbRBEL8Biljh1/KBPlKZ5B4=;
        b=KT/uluN5HVXpG3Qhtft0fVptUKZJLKxxwq21lJv62iNIMeSxdC+Tr7xBJtdiOIDWCZ
         7gW/V1WR35CxnEq+SEwAFaXRc2TNZRECAwp3gtuj3/GagVfS/b055Bxu8a8/RHHjYRL6
         pAw+DSuyxJsbfAtRnQ5+HGF3cjQgJNk0N5sk0oFzK4Y6bi/CPm3lqjlTwcXCP3uhWQa6
         KK+KA4m0eCukiNqS3epEfbucZyGWSL0sdiHQp1rJn04wrOVO13YDwy2sMFG+in3dJ4jO
         pu3ns/2WpSClEKPBJB+MTowITYscaBjeW8de5qFnG0F03/VxwwmBNnzwFNSNiC3z2EiY
         9EOw==
X-Gm-Message-State: APt69E3Ux+fapjP3MwUJi018dFOGa1//nTlcFQkfQGDamK6pSxKxU99s
        0uJ4Vc6MsZqx7Esy9lq2LthFXshuTHE=
X-Google-Smtp-Source: AAOMgpfroqimc2B/Pe2OVKY3R4aWryVANWZtXrrdcunA/lIG4EfMPwlr1EEYJ/ByJlJR9xPhK47cNA==
X-Received: by 2002:aed:3fc8:: with SMTP id w8-v6mr5330756qth.262.1530105925856;
        Wed, 27 Jun 2018 06:25:25 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:25 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 15/22] commit-graph: verify commit date
Date:   Wed, 27 Jun 2018 09:24:40 -0400
Message-Id: <20180627132447.142473-16-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 6 ++++++
 t/t5318-commit-graph.sh | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index e0f71658da..6d6c6beff9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -986,6 +986,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				     oid_to_hex(&cur_oid),
 				     graph_commit->generation,
 				     max_generation + 1);
+
+		if (graph_commit->date != odb_commit->date)
+			graph_report("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime,
+				     oid_to_hex(&cur_oid),
+				     graph_commit->date,
+				     odb_commit->date);
 	}
 
 	return verify_commit_graph_error;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3128e19aef..2c65e6a95c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -273,6 +273,7 @@ GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
 GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
+GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -377,4 +378,9 @@ test_expect_success 'detect incorrect generation number' '
 		"non-zero generation number"
 '
 
+test_expect_success 'detect incorrect commit date' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
+		"commit date"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

