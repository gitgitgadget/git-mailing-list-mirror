Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411731F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965403AbeF0NZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35426 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbeF0NZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so1583923qti.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=50x5+/T/9r2R4F1rJMUd6ON/IEE9colBOpIRnvxTLL4=;
        b=tDs2u4vABe5ALo2n3NpVJWxenZsgWdavp4ruEz+8myoYf6bJxvsI86aQrSBbv9L5gH
         L23dvWBpBTLbvZ9WoUQgfKaHXhKCwbuMC4KVkJnU3344i8iyiQ4p6NI5mcVTbOhSMkwL
         X/AC0Oes+i8W/w8pSvYMBj5GO32gWlm6bTkqvCqdJPt2IpcrRwv1LU8yERj35aOVsXTS
         UHSdCnabl0uWZ+1RwNRkhmmMwW+UAPRjDiSODfk3tLvuAq0gmVDTdCsZuvVpwqPXRmQo
         Wr2dUZwE6uCmzFVI4Z+7RrVRg5WWfPgXSMYWh7gnpw3uwD4XfhHLeAhhMjLcwMf421ee
         s1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=50x5+/T/9r2R4F1rJMUd6ON/IEE9colBOpIRnvxTLL4=;
        b=HocP+Y25Ylm87coBdy3dN6ZxfDMsT5NsqwfvPZkv3jsME094T+ive+uICHlPvvwDSt
         jvybWTHoEKpGKD9NLPiPWifyiStTMzH258yBzuydEHtkwOZqa47xuKwgIiAM3cKHrQoU
         7ToEv6mMX/Was+7BsO+VmRW/fUzpuitMuJVTvKWSeJg44AYR+uU/QomBukr//4WK3nlU
         /CGmANDZ+hkRx+iq4gGYvzh9TFoj43o0oCZOGwbQebb0ZeNNDWQh7QFpwGGMJKCmHyrO
         WF8fRV2qft9rLXHH4UUmeP1cHhUQBTfBd/gcLT7rH8GA3zHnTrAotHo/32kOXHTatqo4
         82zw==
X-Gm-Message-State: APt69E1GSZaX0tUNJ2UPlmz/gSl1qpgoOqlho89SQNVGNuW3DixQ5eWx
        WJVTAU4UhIRYBnf5uUalYiRB5ObI9hY=
X-Google-Smtp-Source: AAOMgpd34cxAcExXDlBOv/77kzY/aJdIlSmc24iAtxSuoJjWaW9x5oF7zfx7VZcfh5Ze55BOhTMc4Q==
X-Received: by 2002:ac8:2506:: with SMTP id 6-v6mr5537547qtm.9.1530105906319;
        Wed, 27 Jun 2018 06:25:06 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:05 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 05/22] commit: force commit to parse from object database
Date:   Wed, 27 Jun 2018 09:24:30 -0400
Message-Id: <20180627132447.142473-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of verifying commit-graph file contents against the
object database, create parse_commit_internal() to allow side-stepping
the commit-graph file and parse directly from the object database.

Due to the use of generation numbers, this method should not be called
unless the intention is explicit in avoiding commits from the
commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 10 ++++++++--
 commit.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 0c3b75aeff..598cf21cee 100644
--- a/commit.c
+++ b/commit.c
@@ -418,7 +418,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	return 0;
 }
 
-int parse_commit_gently(struct commit *item, int quiet_on_missing)
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph)
 {
 	enum object_type type;
 	void *buffer;
@@ -429,7 +429,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (parse_commit_in_graph(item))
+	if (use_commit_graph && parse_commit_in_graph(item))
 		return 0;
 	buffer = read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
@@ -441,6 +441,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return error("Object %s not a commit",
 			     oid_to_hex(&item->object.oid));
 	}
+
 	ret = parse_commit_buffer(item, buffer, size, 0);
 	if (save_commit_buffer && !ret) {
 		set_commit_buffer(item, buffer, size);
@@ -450,6 +451,11 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 	return ret;
 }
 
+int parse_commit_gently(struct commit *item, int quiet_on_missing)
+{
+	return parse_commit_internal(item, quiet_on_missing, 1);
+}
+
 void parse_commit_or_die(struct commit *item)
 {
 	if (parse_commit(item))
diff --git a/commit.h b/commit.h
index 3ad07c2e3d..7e0f273720 100644
--- a/commit.h
+++ b/commit.h
@@ -77,6 +77,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
+int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
-- 
2.18.0.24.g1b579a2ee9

