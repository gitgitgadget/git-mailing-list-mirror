Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691911F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeDIWqT (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:19 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42530 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeDIWqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:46:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id t20-v6so3248545ply.9
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=drrSJMjEKhktVBXymTc31AeRL5hNvpFWTVkRSqYzTvM=;
        b=dbGO8Mu6N+MQCf/kNS9OLMYEnKuGvySJwti/ew4Z5wXx9wTQiE/OBzcFBZW0Ft6rRG
         z6bAUiqpm9b0izOkfUBrSbSciVmq45tUQ2ePiXC1LSeqjPfcgbGymyKHZm9zDWisv1nE
         5m3v3tYAIXWOoVMFsJJg6Y4kX/hHg8dfxLNIp8C76wYwHgZbd3SIZE5B7sC+QGdWt1Nv
         VZlPR4bp/F+78E5gU+fq+15KDXr4MNG1fSCPr8Foop2SuAkgj+rHrf+FUEQzqUha2hMz
         GUqD9/TaISchsXNdG0sNj6p0BdVnJ9h1SF2nYD2qen6g/evfL9m9ohEZsFIJpFmUMc40
         1XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=drrSJMjEKhktVBXymTc31AeRL5hNvpFWTVkRSqYzTvM=;
        b=N3NMx0EeOPQ987WYGO2NjR4X4pzaHvXi/AMTYrde/+R0Ms9uBslpJxjNXfy1fEsFd2
         jE+T2XfXy+UXrAHcjCVniFQ12ETeUWDCBBj5xFwi9HcdR4Uq+ZpsW4VGkqFWLDBqVqLd
         ftYitKuazFNJxgrlNQT5egXCgWDIR1fjVVJYBJrMhcKhqxsUfXC2wKDH9QWaT0QkEzjV
         qb/8keo07mUe+upiEYenb/aLBdHixu2X0IWn6VtLc6K/bdxsLm/FEzdsYWuDbAvAvsif
         EJfS7zY0EtQjkdeDdA0O6TCQC/gp73G/fawMx7rnh5+KEb+9Xu9Jw7uA5icpH5n5/RO1
         eYGQ==
X-Gm-Message-State: AElRT7GUkzsV+kGmisBf3Ds70EtLf79wvFF6pOxfjyEKOlfepHwORwdK
        bCuAc/SouL1KEi2pgouAUQaIKQ==
X-Google-Smtp-Source: AIpwx48+J9/KS8LXl/2h1Z4aiZxvedkmJlts1bcvmmseRtgH/GgXk1tLXgBukZwx3upQvmarl8bVOw==
X-Received: by 2002:a17:902:5204:: with SMTP id z4-v6mr40533316plh.385.1523313961472;
        Mon, 09 Apr 2018 15:46:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 76sm1953940pge.5.2018.04.09.15.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:46:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: [PATCH 16/16] replace-object: allow lookup_replace_object to handle arbitrary repositories
Date:   Mon,  9 Apr 2018 15:45:33 -0700
Message-Id: <20180409224533.17764-17-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/replace-object.h b/replace-object.h
index 3520fd7ff7..9f607a929b 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -23,14 +23,14 @@ extern const struct object_id *do_lookup_replace_object(struct repository *r,
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-#define lookup_replace_object(r, s) lookup_replace_object_##r(s)
-static inline const struct object_id *lookup_replace_object_the_repository(const struct object_id *oid)
+static inline const struct object_id *lookup_replace_object(struct repository *r,
+							    const struct object_id *oid)
 {
 	if (!check_replace_refs ||
-	    (the_repository->objects->replace_map &&
-	     the_repository->objects->replace_map->map.tablesize == 0))
+	    (r->objects->replace_map &&
+	     r->objects->replace_map->map.tablesize == 0))
 		return oid;
-	return do_lookup_replace_object(the_repository, oid);
+	return do_lookup_replace_object(r, oid);
 }
 
 #endif /* REPLACE_OBJECT_H */
-- 
2.17.0.484.g0c8726318c-goog

