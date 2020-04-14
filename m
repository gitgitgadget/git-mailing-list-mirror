Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DBC2BBC7
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6CB20787
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baprReuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502001AbgDNMdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501989AbgDNMdG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 08:33:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9F8C061A10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o1so4301256pjs.4
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=baprReuyd11NPwQnKNzbcJp35I5hzsG+FwrAHLc19eu+7noXih+vQ9nuGT35vgIPnQ
         AeXEg4NrU1sHcq5JjCAvUo1ZlFZMpQ8pEC5tZiOEkv0MQFzGUnJ5sNLJnjfgaQwpcsQl
         e3D3TDgo7/6jb4aZ0pKxmwNDohP7wyox2yrik64AuD3tOM7oQkCdLu9c6rkzM7yW7Lxl
         tUBaJk79BwymhyzU+zahhyAu7gxVer8wLoX8K2JlEwTBnk2D7lBuDBt5hx3EBupGAOTo
         uomPK1yzR8zj/r1CyET9sK6xdedxwiBuQXylNc2KW/CrzI3oHbDrtOxdhusl9LhAW0Y7
         rcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPo3QpRJR2XiWos3b8MvTn8o0c2HhyHfcUhONqkjpZY=;
        b=XdU2iVoJaC5F9RqJOgyaSsmO8XVh6rykqaSanQnVam7HrdQrPY73w7IhS03LZarpwu
         JJ0PFouQOlwGsnOIV56ths+61h7U1fz92kZbjZOc5hVpV+oeZ8KFH4tPGnmncLNiV2Sh
         UU7TnnvScfdPzbvJBttrqteidYEuQDPC4JR4+GFThHCsZ1CwwkuwLklZzJMUUNwOU9Wn
         dIrAcIBX+0B+GLWU+ZTpCBbXItCRP9RYLnWUep4cafX4iPxbhT6KEAyLvyOfrG9jVxmw
         wTAMLtceP7IaQpPXe7gBCFaSZ/sOGmExEKqPEmAIkUJ9S0WiiLvhLWRMAwBVeYmVWidt
         zt5A==
X-Gm-Message-State: AGi0PuZNBzU0FgHbS0+DSY8PDDijTC6A4/5u0ukD0t7eJBCQ8tDMinie
        PXbeQrS+oargQfso44lrsU0=
X-Google-Smtp-Source: APiQypJxqflMt0DxsGYzjCnn9pEdrAWdZS4FxaVBMB405rcKYfm2omyerz6o0dfEEIyUkqgkdD+r1A==
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr21177878pln.94.1586867586054;
        Tue, 14 Apr 2020 05:33:06 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c9sm996177pfp.53.2020.04.14.05.33.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:33:05 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v12 2/7] connect: export parse_feature_value()
Date:   Tue, 14 Apr 2020 08:32:52 -0400
Message-Id: <20200414123257.27449-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqq3697cax0.fsf@gitster.c.googlers.com>
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
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

