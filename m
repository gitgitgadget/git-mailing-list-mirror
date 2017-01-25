Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02301F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbdAYWDW (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:22 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33257 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdAYWDT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:19 -0500
Received: by mail-pg0-f49.google.com with SMTP id 204so67748565pge.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MeBOx2Ke8I6nQyWgA7hMKn4nXbX0FeO+J0rYXNMMJZI=;
        b=lMlBn4+vFTLIunA6tbe575N1f/eTMug4X2qFF154OEAEl/eEn3Tn47UQbNdxniOF+I
         n2QL32R8Rnv9EKCre0s5cAarljpg3LisyyDZWCJPV0g03WnIx1c3uzsDg8boQp6/jcOp
         EcDoDGaCPeqRqDv66sJN4Mrr7o7yKeXdcENYMD3TX8ptqTrYkMThT8j6h782UWGtbupO
         vM9C8HlJCwZgdsNN2z9rwnj2tpVxe/Xly6szpJnXVea20/f+mUA4q2CfDhI/Mzto9Pch
         cJ+cbkBnv7fZoAl5mYrr2qr66GCwELy6GuKQBu5Z/BbkWBqmmL2l77O7E9/Q+EMrV5DU
         lPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MeBOx2Ke8I6nQyWgA7hMKn4nXbX0FeO+J0rYXNMMJZI=;
        b=K8A7FYn/hiK8+e8IdHq6SfdC+x2Vp94xqBpeooT18invpwuH5mtCqgoIfWMKek/8vV
         XlsrcosEEtAUrJyrNmvI3/JXWMLoY38WpHfUG4bZwDXTXk0s3OQvxRGmFt1aeFDRoqsn
         3AsrKOsuKjF/kP2+DpAClIoB3xgG8F6RSltY+2EgpiIaZAe/Ft3cD6H+mn7LNkcz8SUo
         SfcjswBnBWArl3CNp4WLnfFICu6mGpakH1McKgnD2ETGOJrObTV/+5UTvjrCf3Ujj7pL
         pKb0tuVcTU+yzwpVUBwVwLxr9TqNIVhiB5O+LyU3k8f5Uw0erowPkSRB9d+W+senvFYl
         gUqQ==
X-Gm-Message-State: AIkVDXLMDX3Uvjwlrn0l6+gaFbAU7V1f93bjArfhJLy2Wf23tSa0VLJv6sxyMVFPkwXxUtOW
X-Received: by 10.98.7.150 with SMTP id 22mr49412049pfh.69.1485381799028;
        Wed, 25 Jan 2017 14:03:19 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:18 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 01/14] upload-pack: move parsing of "want" line
Date:   Wed, 25 Jan 2017 14:02:54 -0800
Message-Id: <be83ed22dbea03511bf8f8fe830ca0a365128c05.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor to parse "want" lines when the prefix is found. This makes it
easier to add support for another prefix, which will be done in a
subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 upload-pack.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 7597ba340..15c60a204 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -793,8 +793,20 @@ static void receive_needs(void)
 			deepen_rev_list = 1;
 			continue;
 		}
-		if (!skip_prefix(line, "want ", &arg) ||
-		    get_sha1_hex(arg, sha1_buf))
+		if (skip_prefix(line, "want ", &arg) &&
+		    !get_sha1_hex(arg, sha1_buf)) {
+			o = parse_object(sha1_buf);
+			if (!o)
+				die("git upload-pack: not our ref %s",
+				    sha1_to_hex(sha1_buf));
+			if (!(o->flags & WANTED)) {
+				o->flags |= WANTED;
+				if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
+				      || is_our_ref(o)))
+					has_non_tip = 1;
+				add_object_array(o, NULL, &want_obj);
+			}
+		} else
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
 
@@ -820,18 +832,6 @@ static void receive_needs(void)
 			no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;
-
-		o = parse_object(sha1_buf);
-		if (!o)
-			die("git upload-pack: not our ref %s",
-			    sha1_to_hex(sha1_buf));
-		if (!(o->flags & WANTED)) {
-			o->flags |= WANTED;
-			if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
-			      || is_our_ref(o)))
-				has_non_tip = 1;
-			add_object_array(o, NULL, &want_obj);
-		}
 	}
 
 	/*
-- 
2.11.0.483.g087da7b7c-goog

