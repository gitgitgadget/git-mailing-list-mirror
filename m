Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109391F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBFAU3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:20:29 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47051 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbeBFAUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:20:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id s9so146732pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JlLtBkKVKBMi+3lcKg5tM6QX72Xo9rhucdw5vt6rcro=;
        b=NMgvBpnkzPvQoy52V2Sgk+ID6Yvb8c9pRbsw/ly+Ncb46nW/Ifa+zX5ha/+Lz9Yj9/
         90M2xypSLodJGl+WhTPyeN9g36GtaqB0Xp+6iUYdVXhNJeQ4cgvhS6QahrCDDKje6emA
         Fx5DxqhdF0b2jGAx14t687VONIREk7zVSsbyCAUpzVg3XJkX2l8Vdp8+CxW19CRyYXBo
         hugU/Q+fPFyBMpCAoosz8RuMVHUDhpQ1UGHn21Hs7LVlp0P9ol0Xdaidk1qIGc3dO4qU
         Ri0TjR2QV6rqXM4sAqQN84S8WoyzVFX3RUYjEEPa6kQsUJq5/E45XRu1mtvoMVfFqRAN
         o5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JlLtBkKVKBMi+3lcKg5tM6QX72Xo9rhucdw5vt6rcro=;
        b=sq4fjExuYdZQ1bWoopcmRXADsBRfbltoUlo7/LYVigiHS8nhdPjQOs9EKd/sgPH095
         BAsyVRQt9hMEM7jKQNUl680wZsLo3hoPO3plk9IMLNRR1/2Lh/yE9n5zjyZ5AHmRj5kX
         6BDnK5Ya2KwmoQUntyeXfuWjkQOddWNDlMeUyMFM+cxfzdxZT9+IGirgfEP0eYpRCTAH
         DC8BzxC64P2W5ned1RoS8gxZEuz1tPcB1n1TfJ76003Ahr8w0I4UI5bFrjRVnX1mYENM
         kQ7Q+5wYwXY+m84yImVoV4SsA4bLdwIm+xDH1hMElYrD18UgBIL+LHZ3MOGzAx8PT67w
         L/UQ==
X-Gm-Message-State: APf1xPD7KsgKoRe0/lusWUe6mxr7s1YxKd/lhEm+yEgm4fW7d3YdM/U0
        1WenJFqcKKf0o78WLTpM0VlsKtrtx8o=
X-Google-Smtp-Source: AH8x227FVRcqd83MJVTVZXpvVbpbze1GxvzVnkFIrtmk8X4kLPSxUZ99W2PTUqEl3YRuDmgiKbPQ0w==
X-Received: by 10.99.163.92 with SMTP id v28mr427928pgn.432.1517876424945;
        Mon, 05 Feb 2018 16:20:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n64sm9604123pfk.184.2018.02.05.16.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:20:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 116/194] packfile: allow has_packed_and_bad to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:31 -0800
Message-Id: <20180206001749.218943-18-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 4 ++--
 packfile.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 28453739b2..21ca15b1ce 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1004,12 +1004,12 @@ void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
 	p->num_bad_objects++;
 }
 
-const struct packed_git *has_packed_and_bad_the_repository(const unsigned char *sha1)
+const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1)
 {
 	struct packed_git *p;
 	unsigned i;
 
-	for (p = the_repository->objects.packed_git; p; p = p->next)
+	for (p = r->objects.packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
 			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
 				return p;
diff --git a/packfile.h b/packfile.h
index b5122d455e..42593940b0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -141,8 +141,7 @@ extern int packed_object_info(struct repository *r,
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 
-#define has_packed_and_bad(r, s) has_packed_and_bad_##r(s)
-extern const struct packed_git *has_packed_and_bad_the_repository(const unsigned char *sha1);
+extern const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
 extern int find_pack_entry(struct repository *r,
 			   const unsigned char *sha1,
-- 
2.15.1.433.g936d1b9894.dirty

