Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72720C54FD2
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395E621D6C
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UszcH9Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgDRQD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbgDRQDv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 12:03:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F9BC061A10
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d1so2687383pfh.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=UszcH9Zp/LMa8oyQlesStklPlWp2STHXzseR9U2vzpdWamvDXoXD8T+EXWcULRheIW
         Yo8FFUr+7POdZVHQfV7wMv7mBq5kRvA+iBC0yxyLA0+Vb55pPcwYlstevBMztuKhaEUp
         WvR/prGB1SgHdQgiDeWjwE1I+Ug67ywFPMfHmGUVnhBXq2rEHl1jEHEBBP1IJ/CSThpg
         kay8xqTosApzZgthy3o1JtwRKYb+8QC6Euz0mFl8bzbcVfwbEFBDqoZQPAZHc+ZtdyNS
         NChnsYCDq07g7wbjJl1JSKr4ktieq+vgK0gqk428YB7U6ztScTBmZmTZufUcfKMKwhsq
         vVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=sqauKuG2KGxj8MDOBGkuvtmHzD0mApE7xNLudfsf81kaVeeoBkDMH1HFOGV+3chENK
         6/iGNOu3a+dFhn8sFE4gKVa2GEFsBXKxPbwnuf+bciMeezQdUO4VQjsrM4SsKmLkpFjC
         GqnMaYXIMxJVEbA/4d2TUazeAoYU8dD0GD6nNfUQOpjnTSIa0bCQppBPHzGVF8y4ZS9P
         L57mC8i2A40iuYW3AdgzJjXDO8+5e0ArRDPYH6OEEiUfs35f9UB7Mfeu8EFRYNTbcqKG
         tgUIExaFxFmiJXp4mFjJbG2sZQXdY6adHWTohkYBX9L8rIsbE7ztJdv0d+T/iqLMDvOQ
         USTQ==
X-Gm-Message-State: AGi0Puase9ibN1+RVp6xsMvMpOjV1kGuRmjBnrbsDIdXTqmPCJZ5Nqg3
        WStbaQAAy6RPqK9HSuvn3RE=
X-Google-Smtp-Source: APiQypKXacIyvssO2k9CPPSlCOoj+cc2BO+PsksnMN5sV8h8NHN3QU32ChFqCxOhLSE56yCeiYazIA==
X-Received: by 2002:a63:7159:: with SMTP id b25mr8175205pgn.72.1587225829900;
        Sat, 18 Apr 2020 09:03:49 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i187sm22461649pfg.33.2020.04.18.09.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:03:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 2/8] connect: export parse_feature_value()
Date:   Sat, 18 Apr 2020 12:03:28 -0400
Message-Id: <20200418160334.15631-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200414123257.27449-1-worldhello.net@gmail.com>
References: <20200414123257.27449-1-worldhello.net@gmail.com>
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

