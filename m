Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3671F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeDWXnp (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:43:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34866 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbeDWXnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:43:40 -0400
Received: by mail-pg0-f68.google.com with SMTP id j11so9459785pgf.2
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pDU3w8XB0cqvS4BPCesnrtD0BbZczRoykPYSi9ZHv+U=;
        b=rhRFR8FyYN4l9U2ov0l2tCef3vhFuOlDSBBaol+o9HDRKYVm/VMJ1IktXqkSv5+Ric
         icOHSttsRG7xFgPqAviwyF7ecpdgAJNwyx6dwBXW3mvFrdQi7AOelp/2de89PUrrC2Ce
         OMJ9tzz0+Ug/pBIPbgGUGAAASC18Ud/lkPd3EvE/BNGV84lrda3NFhbLz2gi0V6qvPy6
         eyGUsYFytuLS/BpG4rOciN1TIjpsOij8Lm1qdlSUSSAk/A431ZZyGoVWL3MNk5YqVyG5
         tsrhkBSI1w0Woeor5yybJ8wXkE+WHX6VR2cqqXjuhkFMq3cGDPY75NQxjAaiXEN4iUoQ
         gkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pDU3w8XB0cqvS4BPCesnrtD0BbZczRoykPYSi9ZHv+U=;
        b=uaNt3mBFZhtAighh+I4vhleYQu27nUUa2A3eXAp631ib/NuKE0bcRW8U/dgdgqsYZk
         qK0dDrgT15Hkpa0fmatj2rDiQNUEdHrmiVktjX+hxklZUr3emTjfYViZgr5naKUDKJHn
         ulzCij9/5KYARKsRJvf3lda9JVf2hXoOVK1/vw1D5BqgS3rIO5Qb2buDuH/Wf0bX3zaF
         YLvBGsVB02hk8BV+naJAA44SOLdu1PW51fCXvD9N+t8+AcVg01SOt8WrRFXbF7dK+ane
         3Hn2z8favx9UJ7skzx8seokAjxXtvKiUH3Kz6isZMYxzVLubiIWmTpPW+2YQcUlpdula
         D7ZA==
X-Gm-Message-State: ALQs6tAu7OxAq+RMBrWGdHEXH23vO/LQwBBGSz/sX0CKDinm9tgt/RVq
        V0iGZJN92o5rGIMzJxz8PkEujA24S/w=
X-Google-Smtp-Source: AIpwx499o+b1pQ7yVcmY4iqUZxx/v+JhWnfK9j1ZJImgf+22H/zMXg2oeo28wgllVMRVzLJkvWMQsg==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1-v6mr22032929plb.283.1524527019515;
        Mon, 23 Apr 2018 16:43:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y13sm18852102pge.34.2018.04.23.16.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:43:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/9] packfile: add repository argument to read_object
Date:   Mon, 23 Apr 2018 16:43:24 -0700
Message-Id: <20180423234327.250484-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180423234327.250484-1-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
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
2.17.0.484.g0c8726318c-goog

