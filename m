Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECED1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbeBMBXY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:24 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32846 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeBMBXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:19 -0500
Received: by mail-pl0-f67.google.com with SMTP id t4so5872808plo.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6It2K4MSmTz6UVUKOz1wfa/VhEIeB88003+JG7sFt+Y=;
        b=gtzLE2WnZhRn47jGyWbFJ8epCidGZcZYg0mgTM4HNrBKJGJyOnchDnO9TjE/VPIgAt
         kUhA0l4UhKTFNOONeojD9lClE1T0eOcHWLRCli3zEDS8pXEC/4fIquBy6LxyDkt4OXyI
         LrZ0iajLwuzYF/Dk6sdm9p/jsIFCtcd0KCrQZ7DhdNfjK9hDVe9hfYSWzhBYfGDgm7cW
         w5qK+N5GzCH++82E7AOiMH33Oq3D1HpHlErqsZEjJebRxee8S2ajTvou27zimceSyxrO
         /T9PX+UiDz6m89uX2IdShto94O6EGnXqyi5f31f/w0HqySAnVZO6ZuVFTd8BtF/94jdf
         Cd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6It2K4MSmTz6UVUKOz1wfa/VhEIeB88003+JG7sFt+Y=;
        b=IaksFASjvU1NBbF1ZuWXHatDZtVhVBJkz/ifmDF+gbHpYQU9tK36IB8SvhogvTe3bK
         ncqHJh6Vr+cifPzKGD2tS3XnCL8Um6c9ODOrnGGrWrpp25hAMPFReqr3Wzfx2aj4OzZd
         FGacgBRYVfu3BcJqeTx78s+BRJ4AUNZ69C8o0i1Wn7M2O1AH42MMH+apvMtl5vhf90JU
         pIXtZqEwda8pTkQC4GNnfCmDxohLcofoq3ey935Og3lKiPlH3YfnYl0tSv/DXMM2FsBw
         EANhUNLzSmxGOEt9Mgp/RcKiP7K85txNH9hbDovYo7ppOXrS4SWSX5eH+0iYRiQTapJv
         mpJg==
X-Gm-Message-State: APf1xPB5q6aUtkLEZN7joxgYFsuam7GxrFRn/EHsyo3nGiyX4JI9RX9O
        kJ/4JIhAxiMcA6LZyG7VlN/HOQ==
X-Google-Smtp-Source: AH8x2266LECnGsjT5Zo7k9fmeyRihRnRFij9RRUk6aTgiq2ZcCZzYDi3UeIY21bxZE/9NgmNA+0I7Q==
X-Received: by 2002:a17:902:8607:: with SMTP id f7-v6mr12417685plo.273.1518484998959;
        Mon, 12 Feb 2018 17:23:18 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z25sm26781138pfe.0.2018.02.12.17.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/26] sha1_file: add repository argument to sha1_loose_object_info
Date:   Mon, 12 Feb 2018 17:22:35 -0800
Message-Id: <20180213012241.187007-21-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the sha1_loose_object_info caller
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1ce4058644..d0bc09a089 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1151,9 +1151,10 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi,
-				  int flags)
+#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
+static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
+						 struct object_info *oi,
+						 int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1266,7 +1267,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(the_repository, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-- 
2.16.1.73.ga2c3e9663f.dirty

