Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDEFC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CFC233EA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgLPOwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgLPOwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:52:16 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF3C061285
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:16 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id s6so11417892qvn.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UM8E71D5hsgpPDsL4/mS1QuAqEZ2fo6QhgV2151KP+4=;
        b=a9Yj3zfAAMu0vxloDvv/ylEgd/oLlEbMzugEQNMA4nm2jJ24P59AoT84YWwknlHks0
         dmhcrEcZ8Vg2HryU5KIQpeev6Ty4mUgQE4l95JiuoKKBuUApEnWkwIXKjGehIDc8GKdL
         SWTyB49rwmZIBC59F5l3Wgayixc0K9bjh1ukWguYza3Nq4qAZQilKs/Nlo9h9ldXaDDF
         ahUxDloQxyVBpohlt/CRqMOhQ8hNQA5LTFpFwSHnjRVHWHqEDRqzHuppgnly8XKf8h6A
         9WQvcxskOgnzYf0aRovWFLQfCisdGrYZJv1Z/dECkSZ1KE0dA4ut8P+9tPgRW4+sZ96G
         RjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UM8E71D5hsgpPDsL4/mS1QuAqEZ2fo6QhgV2151KP+4=;
        b=jgG0W0AIbR1e4dPD00F/LHZmXrMoCOSN9F213LDMHDpg/ICradJ/xhsRsHx5yYJtDV
         by/EBphfbFGFsf6IoovaHKxNT0spyvLGLJBJngXBAFcZfONnnsdIKkE2wwGCh8woXO1b
         +vBuN/AbpF0bDOdo7CalCeZA2P7VV//HuDDvUzPBpHhpsFJaWKraw3e8pEdWXY7cFF5P
         6wHFDvnAiWMPdqkfvcudR8dxb0zPrws770GFEg8VvJVcT7JdlOc7xfgx3543I1u9F3Uz
         xENhv8CT/JYLjz3ToDua4BixCKhgk62n8xcK/s4PtuBuiq9R+TUSYPp5YVmfB4EhoT+K
         moEQ==
X-Gm-Message-State: AOAM533dTUJKNbEZp70rCgTksBZUUe3mp43ckHIVABWW1A+fRjfQL5+f
        JMQqdm96CNaY8tWmtYP351NUiIdzjeR5GQ==
X-Google-Smtp-Source: ABdhPJxG3O9A1WBpofpCtOR/PPiMHLMZD0d0H35ICHIj96vo9lVD96w6gdMxloywZiyj31JmqZGW2Q==
X-Received: by 2002:a0c:b8ae:: with SMTP id y46mr44071479qvf.51.1608130275267;
        Wed, 16 Dec 2020 06:51:15 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:14 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
Subject: [PATCH v5 6/9] entry: make fstat_output() and read_blob_entry() public
Date:   Wed, 16 Dec 2020 11:50:35 -0300
Message-Id: <da6d1d762472ad0fdbe3d6145384078741d6516b.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two functions will be used by the parallel checkout code, so let's
make them public. Note: fstat_output() is renamed to
fstat_checkout_output(), now that it has become public, seeking to avoid
future name collisions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 8 ++++----
 entry.h | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index b0b8099699..b36071a610 100644
--- a/entry.c
+++ b/entry.c
@@ -84,7 +84,7 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
+void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
 	void *blob_data = read_object_file(&ce->oid, &type, size);
@@ -109,7 +109,7 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
 	}
 }
 
-static int fstat_output(int fd, const struct checkout *state, struct stat *st)
+int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
 {
 	/* use fstat() only when path == ce->name */
 	if (fstat_is_reliable() &&
@@ -132,7 +132,7 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 		return -1;
 
 	result |= stream_blob_to_fd(fd, &ce->oid, filter, 1);
-	*fstat_done = fstat_output(fd, state, statbuf);
+	*fstat_done = fstat_checkout_output(fd, state, statbuf);
 	result |= close(fd);
 
 	if (result)
@@ -346,7 +346,7 @@ static int write_entry(struct cache_entry *ce,
 
 		wrote = write_in_full(fd, new_blob, size);
 		if (!to_tempfile)
-			fstat_done = fstat_output(fd, state, &st);
+			fstat_done = fstat_checkout_output(fd, state, &st);
 		close(fd);
 		free(new_blob);
 		if (wrote < 0)
diff --git a/entry.h b/entry.h
index acbbb90220..60df93ca78 100644
--- a/entry.h
+++ b/entry.h
@@ -39,4 +39,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
  */
 void unlink_entry(const struct cache_entry *ce);
 
+void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
+int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
+
 #endif /* ENTRY_H */
-- 
2.29.2

