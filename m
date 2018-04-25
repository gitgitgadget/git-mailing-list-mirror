Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA24B1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756326AbeDYSV0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:21:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46993 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755758AbeDYSVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id h69so15928919pfe.13
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFxyQ3atK3wVBnz9I6srBSM7mcyc6imJff8CUmEtndw=;
        b=BB50QPZXje3ZiVDZPhXMkDBFxReASSHI8VtwvZPHDX4+Rhgs5O496BWaobJ9W7dh5Q
         /TEqTHethzr3dIgyLjE11mW/XHYPFNKNVHCX6KyexbOBBSDb+Cp8q6X3MFs694H0THUJ
         yY6Qq27eLESBAYRN9s/5S3X3XpCyqXGP9A0bIybIb3dAgGCZyPTIBKqTPqAJUE5uauJ6
         oxFDJaCd8H6DQ+dgsJMmCs1UoYNqgawsxLU4SJuYoRGkQF+WT5kxoB+GWqw+VdC/M0+v
         BYtoLSvmha7s/pYPQ8Ef6avElJP8tJNY0BVVelhyvwGkyWb6CJ56fQ4lU4uKdTmjzrRI
         2Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFxyQ3atK3wVBnz9I6srBSM7mcyc6imJff8CUmEtndw=;
        b=Mhm2QHG0/y9TzFovk7u12kKtPh+lSM38JJAt9HUzsb3PK/tpEgm8Q/avnxH1h+x3cd
         kNgg09Afsn2bThhdz4jZO/SFrtmcsEKR3oylPCbYjgAHJMQ0mGa68yzgQdmZy09ClHeo
         kWg6sl5U/WuGUMoHf7IR7BoHTygvcXy9Gav5n7tNzNbpxi/uWt6KV39IGFj893VfyOf9
         JW6uMe3++aKx8k257S6zRgJmiFJXOGqg/dtrzfhOLbtooWdC8bXLpM1f/UBlyoOtcE1l
         AJqGrWLi9LKeqpt7kSdOl6hyFZL+tnRap3CXah7sXqatbrlfG8XscTYkqTHn6QbSFXub
         9WWQ==
X-Gm-Message-State: ALQs6tA2pj9SmQyv+zTiOO3FwReMfY0nt+495V1yWkZEfZKmkR9LYdo1
        l4L6jTJ5Hqy/Aiy1GUrLLLw0KA==
X-Google-Smtp-Source: AB8JxZoRpPHhk/nmiSrHvg+KA8Kc2uOSfoXfNr36X04w+6xaMvd/bYMD73QOuGJeZZlvbe9IynU7Wg==
X-Received: by 10.98.65.93 with SMTP id o90mr2378170pfa.140.1524680475963;
        Wed, 25 Apr 2018 11:21:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v8sm16474604pfn.136.2018.04.25.11.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv3 4/9] packfile: add repository argument to packed_to_object_type
Date:   Wed, 25 Apr 2018 11:21:01 -0700
Message-Id: <20180425182106.162972-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of packed_to_object_type
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index d2b3f3503b..3ecfba66af 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1124,11 +1124,13 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 
 #define POI_STACK_PREALLOC 64
 
-static enum object_type packed_to_object_type(struct packed_git *p,
-					      off_t obj_offset,
-					      enum object_type type,
-					      struct pack_window **w_curs,
-					      off_t curpos)
+#define packed_to_object_type(r, p, o, t, w, c) \
+	packed_to_object_type_##r(p, o, t, w, c)
+static enum object_type packed_to_object_type_the_repository(struct packed_git *p,
+							     off_t obj_offset,
+							     enum object_type type,
+							     struct pack_window **w_curs,
+							     off_t curpos)
 {
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
@@ -1378,8 +1380,8 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 
 	if (oi->typep || oi->type_name) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
-					     curpos);
+		ptot = packed_to_object_type(the_repository, p, obj_offset,
+					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (oi->type_name) {
-- 
2.17.0.441.gb46fe60e1d-goog

