Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A40C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbjEKXUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbjEKXUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:20:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4E4658C
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:20:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba6fa8be5f7so415189276.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683847236; x=1686439236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibSEJcUeEVXaEh6PhptEBKGBCSaWHbcUYdd7LpKdWnw=;
        b=Mi/ADYpxpFewoGKCpt6gX3VPdVl7qBKhmrTlW/QZ2pBfRBD9OBEjT7tmxQ2xHLUlVT
         /ztAgbU0eXz2j3pfxjuJjdODGvfpRVhJbe2cm0s/9XwKzxp2ewAZb3riAKaFnZxOUY53
         XnSCB2E5MuArsMjwdnQfAjWGQ5QJqXPqKFfj3KiQ9MzNI6iPy7QatKmM3nNJ8/UFF08j
         VWogCuOSp3Uv8TzLqHD/Ue8/Ip6Buf5hqjWQxGWwyBlHtDxxsvlgNiL6q9fij+hCD2/x
         RMdye33KsnVJsLOD06qF8Yb6wf1yR7WvkkM76WaQ5UlNmz/HGssxPJwK44jLs0hf2Rx9
         Y/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683847236; x=1686439236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibSEJcUeEVXaEh6PhptEBKGBCSaWHbcUYdd7LpKdWnw=;
        b=hw+Yn5BRpb4ht+83JFHG4FH9GB1Ak9kaNoDCK+lIxrl8ubgQ5rbXJZn3uLemk48UjL
         F8d1V0M7+KcFvzV5B1g7gADqaXr4Qw/LdmxFxA55uANoai+qpXG34J1pgrFHWgo/O6HV
         LFXRWsFCQcVLCeFiO8vPBdYs/JEyvQr/BSL5+GBgUrV64FscWocZ8FHLkKnnBkNyxcH5
         h7C7rWRG9qPdWoDbDdNYy1hgU5KsyxIAM1hV7vxmQ+X7hSq1ojvFvkISyAPyeaOiYW6E
         2nulYPXN6ke6GR7BsHsLCfK0zmdlwDEA7svs8h0XeqLU8sSnrv15OxqOrnia9U8ncJhB
         eAFA==
X-Gm-Message-State: AC+VfDz3bkspREBzo0y0w4S8ikOHAn7Zh456jASOIo49A5X/qo6f8ZiL
        O47IeD/zfyIymfO8bT1szr/uszOxp2J0BMkV291gIg==
X-Google-Smtp-Source: ACHHUZ5NU20wxvT8HWj2dHucgwYodU0f8JSgndpbPIfzIPaYosG6OC4jRmBJ0V+sahl2Rihe4MPOMA==
X-Received: by 2002:a25:3795:0:b0:ba6:fd35:e994 with SMTP id e143-20020a253795000000b00ba6fd35e994mr556333yba.34.1683847236007;
        Thu, 11 May 2023 16:20:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j1-20020a25d201000000b00b9550fcb12fsm271666ybg.64.2023.05.11.16.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:20:35 -0700 (PDT)
Date:   Thu, 11 May 2023 19:20:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] reachable.c: extract `obj_is_recent()`
Message-ID: <f5f3b0f334f6c26ba2f9252723a9b539371375e3.1683847221.git.me@ttaylorr.com>
References: <cover.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683847221.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When enumerating objects in order to add recent ones (i.e. those whose
mtime is strictly newer than the cutoff) as tips of a reachability
traversal, `add_recent_object()` discards objects which do not meet the
recency criteria.

The subsequent commit will make checking whether or not an object is
recent also consult the list of hooks in `pack.recentHook`. Isolate this
check in its own function to keep the additional complexity outside of
`add_recent_object()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 reachable.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/reachable.c b/reachable.c
index 55bb114353..7a42da5d39 100644
--- a/reachable.c
+++ b/reachable.c
@@ -69,6 +69,12 @@ struct recent_data {
 	int ignore_in_core_kept_packs;
 };
 
+static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
+			 struct recent_data *data)
+{
+	return mtime > data->timestamp;
+}
+
 static void add_recent_object(const struct object_id *oid,
 			      struct packed_git *pack,
 			      off_t offset,
@@ -78,7 +84,7 @@ static void add_recent_object(const struct object_id *oid,
 	struct object *obj;
 	enum object_type type;
 
-	if (mtime <= data->timestamp)
+	if (!obj_is_recent(oid, mtime, data))
 		return;
 
 	/*
-- 
2.40.1.554.g2ce8a79fa4

