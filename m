Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4241CC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 16:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiKPQpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbiKPQp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 11:45:26 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C159FE3
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 08:41:00 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o13so17161069pgu.7
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JI0/5sdVq1dFbHi2UunveBNPZzyycwttGxeasTeVYMQ=;
        b=i7vVPfMUn/3+EtwFFK5aoZ1FrvxIaulINMXS9l4zCZ+FAkm+o2soUFY+oERGhNYK/q
         Jn4rAByj0RYV8+muskUvGcFQ8JibB5RtEkzk0okSEAzRz2USDUlXY+QQEl/SVjdJwj3q
         OOYM2cr0m/xSgXFCry1KHGbkmew77zOhf1pCO8zrNYuAOngjQMBGeNkLFn66rFltqYKw
         B1JBUPCBe2Z5WMED/MkJtF4G1Sv1q7J677oNe3ovY/iWWeUzFJS7SaeoDwGr2v3m+F1F
         oIiTQHgfMY9TuNiBbsN9lnFsikslnRQygn7Vl36/iYQX+HrQkH6vxL6KMpGqYbuExlhz
         0frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JI0/5sdVq1dFbHi2UunveBNPZzyycwttGxeasTeVYMQ=;
        b=RfGGl883eZnK1M2r6d2Gtm8DtAFQCpIjBKVSVlzDCp83z8kjBNcLvJSsSYWSmuvf3n
         JnovJ/dip2ewJ/wsFIABBmJjIjnQEBTq4OWXfbkyXjkHc3pTqCvdsb1oXznThzIvd2wo
         +jW274ALSElMee6pwalk4YdzYM1kbE6HOpgIf/PY5mPGOBKVBrHPoqU8gYFdrFckmD5H
         q1TAOCYE4p4VXeQd+GFgnJe9mzVn9l9YnYeBtWpceRIMVGuJsJM1+UyMZc0qRVEhprJy
         kCt0BfQK+pSwhu5w4unsT6+xFEK9iKGwSxV2NOCkr76bic+u6x4MDJ/HmxY1UD3q0WXU
         fXkQ==
X-Gm-Message-State: ANoB5plV8/6F4/F8GnW4hDxwXvHh8OG86Dn4g3rr0KW8f9MeMJSAG0r1
        YA0IhR4pfu4O5wLc9fQMdTaUQuPjmKA=
X-Google-Smtp-Source: AA0mqf4iRn4fKpIPPsDyxpExusDHq1f71c2/eJar+gfSVRjLzZeXDrka8+K9vIBFT3vAK5UWgIK1+w==
X-Received: by 2002:a63:d94b:0:b0:43c:6412:994f with SMTP id e11-20020a63d94b000000b0043c6412994fmr20811019pgj.421.1668616859056;
        Wed, 16 Nov 2022 08:40:59 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.47])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b00178b9c997e5sm12502609plh.138.2022.11.16.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:40:58 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>
Subject: [RFC][PATCH] object.c: use has_object() instead of repo_has_object_file()
Date:   Wed, 16 Nov 2022 22:09:56 +0530
Message-Id: <20221116163956.1039137-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is mentioned in object-store.h that the function
repo_has_object_file() is deprecated. One possible alternative for this
function is has_object() (or atleast that is how I understood it).

The file object-store.h also mentions that repo_has_object_file() and
its fellow functions and macros can be removed once the migrations take
place. This patch therefore is an attempt to reduce the usage of these
functions and macros.

I request for comments as I'm not really sure about the "flags" argument
of the has_object() function and its usage in this patch.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 8a74eb85e9..0a9516137a 100644
--- a/object.c
+++ b/object.c
@@ -286,8 +286,8 @@ struct object *parse_object_with_flags(struct repository *r,
 			return &commit->object;
 	}
 
-	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
-	    (!obj && repo_has_object_file(r, oid) &&
+	if ((obj && obj->type == OBJ_BLOB && has_object(r, oid, 0)) ||
+	    (!obj && has_object(r, oid, 0) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
-- 
2.25.1

