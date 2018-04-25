Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADE51F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756312AbeDYSVd (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:21:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38200 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755673AbeDYSVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id n9so1120431pgq.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KjtnlRvrrCURarWx02VSL0j9MVtNYAKueHelua6q8ls=;
        b=ml+3IQAW7dCTVUSiDZPLaZoiDnRCAbA6tnl6pvhHydaorHYyhlgL/p/yQu/Wu1JzZk
         eYNf4PLfGBMXIZRiL8r/2V90FyxlYObM9MMQZ9cas/KhrPU1vYGGPMomwhfNf/c++s/6
         SABcmdaef6pt38Dn4Z44TWj7sA1K76c4pR719SB8jqanrTX+PJe88bmKIWNDudjPZ3hi
         uyBG7CR2GY+XQTsTgbO9mSZGacC+cRjvHoHMVEEeqTz6G7VlA6F2kyVWCSBbnJ6r/mgR
         dOFYDYihUnYwliOi6mNWQjCAGgEUDeOPjeQmuEQYdshJrX5nXKBOmDsoUtfjoylP8Kz/
         fbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KjtnlRvrrCURarWx02VSL0j9MVtNYAKueHelua6q8ls=;
        b=UX0vTpdTa3abOiXkjPXa1c019GMS4Rnk0QIWqY5eAwauJHXbHnbuTD49dAkNs64Yg9
         YaHhsTP+RwLlDlrpv0ZiJc8GPH3GOTi0fWWN4uKrry9jQcF6doXVs9734TE7rTffYfro
         LY1XsivxEUkNAZMd1aiMCBx9WKlag62JNsz2Iq9V3TrRQmUHcE4w2Dui5KiOyOVljRiC
         Xs6lalsCRlQw4ev/kU1OUe1CzWXP5VIOwT1Lo5IhjFMZlu3m77/Hv/kewVt5wMUxXra/
         a12h+BaeGzmwOBe14/RTv3+71o9w2azqllzE+qCY/1dloN1q57BiF16cl5GYaWYhYUd+
         gQ8g==
X-Gm-Message-State: ALQs6tAzw2jbyW8N73+1WT5/6V4dYvVUUkIh7uYMz+Js1MxoOh3tZtur
        ZYclNq0rOgXD7P74JVohgSs6uQ==
X-Google-Smtp-Source: AB8JxZoRsQuun5utf77aMuNHFkmZE2rVyj8/Bds47Q5myXwgat3YjojbsjwHUUotL3GFxzkt4HKTVg==
X-Received: by 2002:a17:902:5402:: with SMTP id d2-v6mr8986517pli.386.1524680479373;
        Wed, 25 Apr 2018 11:21:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p5sm3873850pgv.90.2018.04.25.11.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net
Subject: [PATCHv3 6/9] packfile: add repository argument to read_object
Date:   Wed, 25 Apr 2018 11:21:03 -0700
Message-Id: <20180425182106.162972-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of read_object
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 5fa7d27d3b..2876e04bb1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1469,8 +1469,10 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
 
-static void *read_object(const struct object_id *oid, enum object_type *type,
-			 unsigned long *size)
+#define read_object(r, o, t, s) read_object_##r(o, t, s)
+static void *read_object_the_repository(const struct object_id *oid,
+					enum object_type *type,
+					unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1614,7 +1616,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_oid.hash);
-				base = read_object(&base_oid, &type, &base_size);
+				base = read_object(the_repository, &base_oid, &type, &base_size);
 				external_base = base;
 			}
 		}
-- 
2.17.0.441.gb46fe60e1d-goog

