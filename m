Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6CDC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8932084D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="f45/uLgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgAPCkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:40:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44969 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgAPCkg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:40:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so17775110qkb.11
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fWAmaFn5K7Cpfz95nO1TxACvul7649Ek3I9CA229Oc=;
        b=f45/uLgvV/PM47BycHqk2kwMNnP8gofeW+AcJ6JWyfMjZLVthnIkixPYpgp26td/PQ
         PvlfPHvCWnhvxWtKvblzX8Ytobbp2+y3ZNdG4P3nmaZrL1CZFHCeNv/YTmJwcBQlD46v
         IbvB9TWdG02d9eC/UKcQZy8iSRW/3qpOyd18M7eiwtwhxxLzFoEcZASl8A1AsRtmzEyC
         7IcIIc2qOMXDLwvwim+1HmxSQC/N+YQ5NS8A1iw9JzdBg82RZ1SVncoHddVEb2Ol4YkF
         4DDzlquWTNdE3ysFpcAdcFzzVV0KXa4Jxyefxwjh/CxpkPON+z/bxoOJpmAvx3ahyTmT
         U/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fWAmaFn5K7Cpfz95nO1TxACvul7649Ek3I9CA229Oc=;
        b=G7aFQkUgvVfZOIWXwukRU0sp+Im1M0fDUeuqui9yyWAixlRqV1k/zFcBShxUr9FvPD
         Cw8u9vner2cIiPjypjBl1ZBHBv9mWk8jzjApQT3+rum7lGf+QMVetaZNVJLB/AAt3qfw
         YePg8vKFuyJWGcHBe2luwbiYfXYKEQm2avDnXPynjwdPQge9KFhqA3IprZcVSb5iya30
         UxsV1BqslpJ87WosAgc/s+0HY645t+r56xjEdGjbWw2t6OSyjHjE2K0QFQzDLShJ4nH1
         i3VNTrSfGAieMMvxhtFmxqEgnRU7kwNa5z5V5KYc0x0S3DAccDrB72F3TXVTvhRBbCyL
         5z9w==
X-Gm-Message-State: APjAAAUGyORzBYcteEfALZW4sXDUhzwXKxpWzAwsxZFCUSJGpDcnS1Za
        uNLryG6YJIdezcRmNcrgnShdY+cBrLo=
X-Google-Smtp-Source: APXvYqyGpvC/6zekmRW549IuRlkmcUEV60RdBUPC4eIiVWwRsD7JsGbjPjhqbSDNayMvJIt7VkkH1A==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr26141627qke.308.1579142434963;
        Wed, 15 Jan 2020 18:40:34 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:40:34 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v3 01/12] grep: fix race conditions on userdiff calls
Date:   Wed, 15 Jan 2020 23:39:49 -0300
Message-Id: <e2f3d377f5408d3d9365b8ac1b785d6d3f0437a9.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep uses an internal grep_read_mutex to protect object reading
operations. Similarly, there's a grep_attr_mutex to protect calls to the
gitattributes machinery. However, two of the three functions protected
by the last mutex may also perform object reading, as seen below:

- userdiff_get_textconv() > notes_cache_init() >
  notes_cache_match_validity() > lookup_commit_reference_gently() >
  parse_object() > repo_has_object_file() >
  repo_has_object_file_with_flags() > oid_object_info_extended()

- userdiff_find_by_path() > git_check_attr() > collect_some_attrs() >
  prepare_attr_stack() > read_attr() > read_attr_from_index() >
  read_blob_data_from_index() > read_object_file()

As these calls are not protected by grep_read_mutex, there might be race
conditions with other threads performing object reading (e.g. threads
calling fill_textconv() at grep.c:fill_textconv_grep()). To prevent
that, let's make sure to acquire the lock before both of these calls.

Note: this patch might slow down the threaded grep in worktree, for the
sake of thread-safeness. However, in the following patches, we should
regain performance by replacing grep_read_mutex for an internal object
reading lock and allowing parallel inflation during object reading.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 grep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 0552b127c1..c028f70aba 100644
--- a/grep.c
+++ b/grep.c
@@ -1816,7 +1816,9 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		 * is not thread-safe.
 		 */
 		grep_attr_lock();
+		grep_read_lock();
 		textconv = userdiff_get_textconv(opt->repo, gs->driver);
+		grep_read_unlock();
 		grep_attr_unlock();
 	}
 
@@ -2184,8 +2186,11 @@ void grep_source_load_driver(struct grep_source *gs,
 		return;
 
 	grep_attr_lock();
-	if (gs->path)
+	if (gs->path) {
+		grep_read_lock();
 		gs->driver = userdiff_find_by_path(istate, gs->path);
+		grep_read_unlock();
+	}
 	if (!gs->driver)
 		gs->driver = userdiff_find_by_name("default");
 	grep_attr_unlock();
-- 
2.24.1

