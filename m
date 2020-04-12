Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A3BC352BE
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B23C206B8
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL4rK50Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDLNae (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:30:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38080 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgDLNad (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 09:30:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id p8so3331968pgi.5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=GL4rK50QJJdV4OGcFokz1dUnAqW9uBlvYsuj8/fCRYjmKlgE8sqJ1jarYqKN7ziqqV
         jFfOl4XPJ6XJ3g7HjiCLWHYYPx1s+Kien1M8tkCzMrUJJ3+LAkL9Im7/nIyYx/zd4eT1
         tmE+0eLK6xCzfZz1RhaRRRmBQgl+9Rs9x5OagyJe18rcR4zovmFLAVcUSn4yYJBjdCXJ
         rT3tUaZV2SOdQtXTp0rkd6aJRdJNK20OkxMQpbs0bTEtfPe7pAx0fH+D30sqZOK2bcK3
         +Sa7dGqLcCQoV13rdvD6uplHw4cDEuel8U1HIfBQPaRY4vUShmK5RqCkEPnwP46B9xtl
         SAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=D4Zu4laChCtEA3xZDg/KZLcFeyjLOIKiK6R0YwUu8zZOLfXuhYjv5mhoJLZmas5pER
         +AQc2EBzeSbztiUeHNXqSiVhPND1Q+j6aBO1na5GuGs/+fOMpAu84QXF5z6sbhP+DYOE
         ShxE7Z8enngjsDQBP4IKKQP7guYJnpoAwzgGRT9gDDa99PPXTb+WudCWSvgezqwPkwG2
         LaYpVhy+iD55OgzFb1vqcZTiWq/JqQx37ZZ5lxsekCgH1/u+ncyxmUv2jNFRqXl+koq1
         67nUnBkET2MiBvJ7ATDvubsNC6rNAZdOiCCDqPEfU1qfnHluDiPQJJ7sqWwBxUsML7Jj
         VMrw==
X-Gm-Message-State: AGi0PuZDnNxhDgzjBovb3Nz3D6UvbSqWIMaFei8if5+WrsbcBt4NgGAy
        nAXSOY6tnDaGX9SVwETqW/M=
X-Google-Smtp-Source: APiQypKv8gi1+zgsrQsmgenQ4iUPW48NW1pfyhu9kIBDVNNRDU5KT3yPum5yYLwJOJ8aV1NNCYHKtg==
X-Received: by 2002:a63:4b16:: with SMTP id y22mr10640053pga.251.1586698232767;
        Sun, 12 Apr 2020 06:30:32 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 139sm6093363pfv.0.2020.04.12.06.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 06:30:32 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 5/8] connect: export parse_feature_value()
Date:   Sun, 12 Apr 2020 09:30:19 -0400
Message-Id: <20200412133022.17590-6-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200407120813.25025-1-worldhello.net@gmail.com>
References: <20200407120813.25025-1-worldhello.net@gmail.com>
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

