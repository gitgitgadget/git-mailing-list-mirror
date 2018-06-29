Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE011F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030451AbeF2BX5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:57 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:53242 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030241AbeF2BXf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:35 -0400
Received: by mail-yw0-f202.google.com with SMTP id i77-v6so4015711ywe.19
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5kXKxb5C+cdfNIaanFP7Ud1zAYtikiQQbEz4XPPBhCY=;
        b=jMeGP0m3TuyEJax/ftepdxb3eFEm+NbJ2SviOUaHB2AaK3HC8bfEUZUrWhs10HucaD
         KShGzM9KDy+S2ph3Rix/J/H1lU7Z7mWqU7keONz5dproh4tg1XoLOGgUMsbQfpGdkVh8
         SH666XjCST5u83HenV9AfpdbpIihA2iI5qBDrV6wbx0EWUOWwqEoPj+kbS0VZxQAcRVw
         hqhKw+qEU99uRPTHYaThbklDY+mltL7BnWd7jLIe4S/6m6W6ANMA6vKoSKgjBKKtFakz
         veZDGq2kF+de2lenPM10LZ4UhjgW/F6Pzz+b/+3ayWFdzDQfwhs+9d6R7tg0PsSJ4D5c
         GOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5kXKxb5C+cdfNIaanFP7Ud1zAYtikiQQbEz4XPPBhCY=;
        b=HmP69gK0owYprRTl3uynaLQCJdVaPx6sCcmscPP3TWqXnn2GdlBzQw978zCub7OxN7
         oIVLcXl3G39VKurygIMulrpNSJsEej0wy8k42qfyjqmYAX8vRWFxcHsRwtbyESI23F8p
         pOwlRZajE2nPqVkSjmqBkRt9nrSvxixN/SLo6/djsdi/9VykRdw/Fl+GHgfe6RMCUxKL
         9CZLv+RlHNC/eQ/FF/D6g5rxQzr24fk2hVN01MZ9oBKWSb05+LJJPnJGUMD1AJQrdUaV
         3jXs6HSmoiL+7lsQmTjGEecB42VPdCrHFPy8x3SolXV2mqRCi8bJGkCWavKBYqjPEhhI
         9kJg==
X-Gm-Message-State: APt69E3c/WyB9mNaxHcpMQo/4CfB9G4EfADuEaUUWX9Sa4YfESFITFTm
        lGWdefzEVacn4KID/GiHnm37aaZYtrHzc8l7HcrkLiPPzl5OBYRQemaDA8WQWTbOzxJc9huDsmy
        5XqKdZy4twKMx9Y6/2eAv5ggVPtUoMK7OZUXbZw0k1Ck0b/Kp6a5fJ8BLVmEN
X-Google-Smtp-Source: AAOMgpdtGpAlQO71cxFkB0B1H0s7dGny8Bk8IHyn1G/JXMvrxP3v4Y8Aqad6oDVXR4owrF/PSu9aAntBuJqb
MIME-Version: 1.0
X-Received: by 2002:a81:2d54:: with SMTP id t81-v6mr3272592ywt.171.1530235414752;
 Thu, 28 Jun 2018 18:23:34 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:17 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-28-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 27/32] commit.c: allow get_cached_commit_buffer to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index dd8c9c15b14..15b044331a1 100644
--- a/commit.c
+++ b/commit.c
@@ -283,10 +283,10 @@ void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer(struct repository *r, const struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(
-		the_repository->parsed_objects->buffer_slab, commit);
+		r->parsed_objects->buffer_slab, commit);
 	if (!v) {
 		if (sizep)
 			*sizep = 0;
diff --git a/commit.h b/commit.h
index 7297af467b9..d61585df5bc 100644
--- a/commit.h
+++ b/commit.h
@@ -103,8 +103,7 @@ void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsi
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
-const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
+const void *get_cached_commit_buffer(struct repository *, const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
-- 
2.18.0.399.gad0ab374a1-goog

