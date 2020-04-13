Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36203C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A77206E9
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4wv2NR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbgDMQsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731775AbgDMQsi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 12:48:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B446C0A3BE2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so4684074pgg.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=V4wv2NR3EHJQNKIuXmJ+Sy9M1zUuschHp9FsEcHiQtlAhq7+Lr/71VTbJjRiL2T4Xw
         FBabxejgKVPGk9Yv0QINdWzWw72yPQyi3rnt/cJmQFPzP6lXnhfDa9SwqCrm39Cx2ysP
         c6wDqPY/bcXU3XRkno7beZQ3RNlW/tvusbsHtE+nOvlNKSTgzs2drbC5688RwMPtzOZV
         y1bKV3zBhaVTflwLKver6XJP9X9H+JkPqu8H4puPNZsIMampFSM4MQdEc05uXjGDmgap
         sZni6x1SjFM3ex0l/2YYuCEsU8LMV7AUlKls4FuUgeNmpSCol8wu/zxk5xANKuNcoZNB
         fRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=RBwI07XGDqh+SqsPytSvOBqRYfftHbHpCyCICi5tC14A1Y/ZLSEVFuI2UQMLX1vmuq
         ylKBwb5Uc4EYtva0CjyVN5Cn0+bRg2ha69Dzm1EQXckWc5MaGi2agoPqSq8RKr77CZQi
         aBoDdaPxzjt8NxMNjsBYl1CKc2mZZE9OHc/IyvCajz7lPXnXf9McvqJ4QSfSoN+uP54R
         4ImIHpnVych/wEIJlrQXYgmy9ttNRl4YKSeLfnnvD457wG/BgfrBllVDjbUhXFZd79iB
         h9nnT/sffzF6RzWyYDv2pwm8NrPv8Try+1aFt9Zzhy330wqx2gSQnSbRNnyH2xhI596Q
         AvMw==
X-Gm-Message-State: AGi0PuaOHqSS5XbMuTKBOEox4NMZdnX4quk8Y3R0/adNL/GUKk+CQanV
        9WAepDBjUp2RB1zM0t4risk=
X-Google-Smtp-Source: APiQypIXr7ZNOz3sYgFGulGD2dCxAWnZCU8TyQOObB3FYeEmo/icP/uvkbF6ikw4NwQQ/94bAusVcw==
X-Received: by 2002:a63:d10f:: with SMTP id k15mr16751704pgg.73.1586796516832;
        Mon, 13 Apr 2020 09:48:36 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e11sm9254885pfh.117.2020.04.13.09.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:48:36 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v11 2/7] connect: export parse_feature_value()
Date:   Mon, 13 Apr 2020 12:48:22 -0400
Message-Id: <20200413164828.23260-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200412133022.17590-1-worldhello.net@gmail.com>
References: <20200412133022.17590-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Export `parse_feature_value()` to parse extended status of report for
"proc-receive" and "receive-pack".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 connect.c | 3 +--
 connect.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index b6451ab5e8..08e0616726 100644
--- a/connect.c
+++ b/connect.c
@@ -18,7 +18,6 @@
 
 static char *server_capabilities_v1;
 static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
-static const char *parse_feature_value(const char *, const char *, int *);
 
 static int check_ref(const char *name, unsigned int flags)
 {
@@ -447,7 +446,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	return list;
 }
 
-static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
+const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
 {
 	int len;
 
diff --git a/connect.h b/connect.h
index 5f2382e018..17b3252cbc 100644
--- a/connect.h
+++ b/connect.h
@@ -12,6 +12,7 @@ int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
 int parse_feature_request(const char *features, const char *feature);
+const char *parse_feature_value(const char *feature_list, const char *feature, int *len_ret);
 const char *server_feature_value(const char *feature, int *len_ret);
 int url_is_local_not_ssh(const char *url);
 
-- 
2.24.1.15.g448c31058d.agit.4.5

