Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84636C7EE23
	for <git@archiver.kernel.org>; Tue, 16 May 2023 00:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbjEPAYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 20:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbjEPAYG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 20:24:06 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B65FD1
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:24:05 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba7a7423cc9so3032346276.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684196644; x=1686788644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GU1Art0oofO98Zh9kdNV3uUV0IkJHI725oXbz/rSilI=;
        b=qhq6fklyzw9xlzKv6b44eAZxwt3XBGgYowAO6S5UxlEJlV039hkeDnBr+fw9hbVrcI
         r/jWjE+K2/0nBL7IcMGqwsyLG+/SXH/5jwUI3kGQz+KpMProG9zKWVrY0UhVxt1tvFVY
         vnWSWsGs0wE7XP3FxuJ+Z+U/Xg4tHL7Nqh8RNXfA5+S/PivIjp2PvZcoyAkH3XrDm7JC
         cvJc0CWtdfHtXlENlvNa7KG7Xa8R6oYC7z8gMQsZQxgGFzhkLnbvCd30nEDLAjGaZNyR
         +xTWjWUEG05UcCr7M/haxRUSN5Dpzbvh5U/WYAdzjS1mVLVp75owHlPq6i1I6edcb8bS
         NBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196644; x=1686788644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU1Art0oofO98Zh9kdNV3uUV0IkJHI725oXbz/rSilI=;
        b=GmrmqnQT2vnsV7Piwg4FCdmRzzmH8A73nDEXIdNIlB87XrP0fDqlPGfAn1KMt5GlXu
         H5iW4M3tj2hbRfy1C6kmbMdY+Pz0EG7ZQEsUp3m9H4uryY3M+ND0W7VZaqBDCzVgIC31
         uVgum5Xnin7zxeb8c+YaA7iIvz8BL2oVNkK6vSK8Uf5hiUo/HEVn6wTeSTrRXm/d892A
         oHdUx21oh9JtDXfea6WeqGw7wZfzA0O98NLHhUa4uPKHbONtijOCNohnNpmLeOHqdJW5
         cT3BATu/IpGekIr9ciQ4sr3y04+nY22h2DqPF7W0avDTBUyuWauGWIYIBMalj3WzTVyd
         PchQ==
X-Gm-Message-State: AC+VfDyUeG3b5B3qc0L+8RDe1DkrnmXz3S9y6nN8UdokXYXNF4BeHaL1
        Bf/gZcfEpFD+R2FnIygurlywG5tvr9U5aX8EEt+VDA==
X-Google-Smtp-Source: ACHHUZ66DYx2yatUcuO1ZKmSRvKX30dTy6+1NF2iJ3L9PSsldhMn5BxBb+4HpDDiFmKvp89BdZSNAw==
X-Received: by 2002:a81:4f08:0:b0:55a:8037:84ca with SMTP id d8-20020a814f08000000b0055a803784camr35989939ywb.46.1684196644511;
        Mon, 15 May 2023 17:24:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o64-20020a0dfe43000000b0055a382ae26fsm198394ywf.49.2023.05.15.17.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 17:24:04 -0700 (PDT)
Date:   Mon, 15 May 2023 20:24:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v4 1/2] reachable.c: extract `obj_is_recent()`
Message-ID: <9c1b59c8cf34f6f17cd3f1fdf851434abf3d6f0a.1684196634.git.me@ttaylorr.com>
References: <cover.1683847221.git.me@ttaylorr.com>
 <cover.1684196634.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684196634.git.me@ttaylorr.com>
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
2.40.1.558.g18e50d2517

