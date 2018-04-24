Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962901F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeDXV7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44733 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeDXV7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:24 -0400
Received: by mail-pg0-f67.google.com with SMTP id 82so1992401pge.11
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KjtnlRvrrCURarWx02VSL0j9MVtNYAKueHelua6q8ls=;
        b=Bvy/A02bKfbap1z5/U4a4oBFFC3d0v/lOlEHAsI/A1+NKip+kkmg1UMkZFMxpaRDuc
         4fAPc6Nq3vIsWfF3ceHubXhpcm6L2jwYe19UnNHIrEbGLZrIcGxVHoBIXPTsQQZZbrOX
         Pd91O6XYK5kFkMBiyX+98OVR81oFphpcXhKlL07nDGKOqcoCGZHYWSGHKjRyS7lc124R
         EAnuuhkPYeftyIQ78GwNdIDLxL8M6K7Ys5dz236SpDmzLLJE7vqB55EXPnjMpG8Q73gX
         hVJh6T7l7s7kirWY+w4tefIY2qL/Nk/vYPnlT/JUrz1lB3L5PEoZczE+vOu0ctg+QgsN
         cTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KjtnlRvrrCURarWx02VSL0j9MVtNYAKueHelua6q8ls=;
        b=P58WOnYtg8qSJTWRQHDk5t62dQngd5Ozs6mvrapK5xCfl9UOACuebJ8Nd7dPaUG+7C
         a6lpw59KZggvZZMlfgPTx8G+Y5iLphnUFmNc4HbhQ3GlaSXKiwyLp1ruLdf0Q/AljzDt
         jw3Ond9t3ov8hqaqwHQ5fmdgOmEpbVhUS7XyRqgd4EMbbYRACXqYFbOJsqazy61AZ00M
         W8Y3A0Dl9crYS/f0JreCJ/VqxlBoc79XANbyvAYA0ynCKt6RIx1lY4cFBwWZyn12EgpX
         pLeMCO/GFK3i3wmRWUa5UhAUS8Bgn8p7XpQvL+D03Q3OrwMvoXYp3ZNhCIMQg+6Xfrl6
         RjYw==
X-Gm-Message-State: ALQs6tCxodh8cewb20yu2c+o3pVWDYypCAZGsvCRQbTrWiF4FsfNrRZV
        LhsttZKxyEnPKymFO3r5MN0psj8PSOs=
X-Google-Smtp-Source: AIpwx4/0tlkd0Hxx6FkBsV4eIEjJSLOtsukp+5b716Z0thewEz2ItMCE+2lMxYckroSQ4Rz401eI+Q==
X-Received: by 10.99.125.86 with SMTP id m22mr22270010pgn.257.1524607163170;
        Tue, 24 Apr 2018 14:59:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v15sm36546646pfa.116.2018.04.24.14.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 6/9] packfile: add repository argument to read_object
Date:   Tue, 24 Apr 2018 14:59:06 -0700
Message-Id: <20180424215910.22201-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
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

