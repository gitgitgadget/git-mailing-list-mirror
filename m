Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939E3C43462
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718986100C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbhERPFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbhERPFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 11:05:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDE4C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:03:52 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t30so7201091pgl.8
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nI424pw4wyWEqUsowBl4sv/G5ycm/MBb2NdfJca347k=;
        b=RpJZsAgyfvztvUqFoUtbJNDn6VAVIg/heuSEfinvJl5j2gACAbG6vobAalUAftoc7R
         Zv8ROmYf4uPZUj53dxIkeaVNqzXuMJpfpGj2sulaUf7S4jHsrtiIQ7M13HqF+5AMIsbj
         idG+2sLjbeNFpJvRorecvZc7k+a1ijFui7Tn0ciRRfg79eECWtDiiZz4J/VPqZpwVB2E
         8P2zBO+114vNb6giBhHWHrWxYnoozKCWQUKjnUlPZxWk+A8z+UF4ebiUzm6Hq/wKSRkQ
         2uRpQAKvdGFb7lLT7GooqvFEtaUDXcCjH6mG4RW2qH74zXrTOKvxPYBRdmOoNzZqx/bf
         XEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nI424pw4wyWEqUsowBl4sv/G5ycm/MBb2NdfJca347k=;
        b=MohjxA6S4qu+RjT4lbX/JU7oU7WVx8xMGiDJSI7gk0DW1Wn1Ty3hcmQRkW5m/6s1+C
         sAQIiZYSLmTyOvcWefwoSZVqaotKeqPz3UTpeoBc755ijUkZX32ek+XfdIOBEaieNVWK
         8j7tZ9G7Y+svFjNLTzFUfbVRcjB40FHX/THqrmLhu5k/KV1V8uPtXDAVc2BrWITWBMUz
         Jeq3z+2dyJ8x23yYuq5YAtdwiZInMof8ecrNKNMg6UIlMZ7QROWDrS0TtGxL9zbq7Nzr
         KN40RWk3g3SR3CswQ8osiX/yjni3o8UXFt+ch0R1z+HeJjfUVPpVvxZnd/cITWALPqk8
         s0eg==
X-Gm-Message-State: AOAM531npBiMDskTOakxftUSWo2pnQ6br+oLn1Dup0tAR5DU1W1nwxgd
        jpZWPUYtBe3zFt6XbX3QCbEaImyXLyA=
X-Google-Smtp-Source: ABdhPJxLrERgJcOBJ4O2j3HRJU/hanLlJST2xYqVIrcuFuR8UdeNVpKEoNKbK6oDJ+0Zm6PSyAiRAw==
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr5461546pgk.433.1621350231103;
        Tue, 18 May 2021 08:03:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ea96:bdac:27b4:8cdc])
        by smtp.gmail.com with ESMTPSA id u6sm11936457pfi.44.2021.05.18.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:03:50 -0700 (PDT)
Date:   Tue, 18 May 2021 08:03:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] xsize_t: avoid implementation defined behavior when len < 0
Message-ID: <YKPXVMchtGbwDuue@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xsize_t helper aims to safely convert an off_t to a size_t,
erroring out when a file offset is too large to fit into a memory
address.  It does this by using two casts:

	size_t size = (size_t) len;
	if (len != (off_t) size)
		... error out ...

On a platform with sizeof(size_t) < sizeof(off_t), this check is safe
and correct.  The first cast truncates to a size_t by finding the
remainder modulo SIZE_MAX+1 (see C99 section 6.3.1.3 Signed and
unsigned integers) and the second promotes to an off_t, meaning the
result is true if and only if len is representable as a size_t.

On other platforms, this two-casts strategy still works well (always
succeeds) for len >= 0.  But for len < 0, when the first cast succeeds
and produces SIZE_MAX + 1 + len, the resulting value is too large to
be represented as an off_t, so the second cast produces implementation
defined behavior.  In practice, it is likely to produce a result of
true despite len not being representable as size_t.

Simplify by replacing with a more straightforward check: compare len
to the relevant bounds and then cast it.

In practice, this is not likely to come up since typical callers use
nonnegative len.  Still, it's helpful to handle this case to make the
behavior easy to reason about.

Historical note: the original bounds-checking in 46be82dfd0 (xsize_t:
check whether we lose bits, 2010-07-28) did not produce this
implementation-defined behavior, though it still did not handle
negative offsets.  It was not until 73560c793a (git-compat-util.h:
xsize_t() - avoid -Wsign-compare warnings, 2017-09-21) introduced the
double cast that the implementation-defined behavior was triggered.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

This is *not* -rc material; it's just something I noticed and figured
I would send it before I forget (among other benefits, this helps us
kick the tires on the release candidate by having patches to work
with).

Thoughts welcome, as always.

Jonathan

 git-compat-util.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a3..20318a0aac 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -986,11 +986,9 @@ static inline char *xstrdup_or_null(const char *str)
 
 static inline size_t xsize_t(off_t len)
 {
-	size_t size = (size_t) len;
-
-	if (len != (off_t) size)
+	if (len < 0 || len > SIZE_MAX)
 		die("Cannot handle files this big");
-	return size;
+	return (size_t) len;
 }
 
 __attribute__((format (printf, 3, 4)))
-- 
2.31.1.818.g46aad6cb9e

