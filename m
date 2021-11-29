Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E5C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhK2W34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhK2W3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:29:11 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AFBC096778
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:39 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b187so12437596iof.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kbwJq3Gqc5ASN/8UdLMGbry/z/UwwdC9H75sXPGgTKE=;
        b=mavF+2GEJClw//YaJNI9k8Iuo6b/XUvPOgbLJp5+x4kYG+V417beqnbkSNz5IBI/MS
         3emA5CxGRUxLxeKAt9f9gTxlbH4yx8f3SQx7X5Qtz55oxdJnOLvB9Err1osJJV+2fsTx
         7IPw+S2EUMWO5+fhctqoQ1fazptTYPzDALfy73X1rIcrEMOX0uoGRCQUt3Zj+5PDEUl9
         p3rubsnKbdmbI5qYS/dnLgr3xiUr5rqvgPJUzG2haCcPwt8mBBp8Rb9ZXdBiL4SpSrHU
         1x/MOjeQXmTDeHqcaP8BBVSTov+xURC4L+2VMcLXL5If/7NUHSolQcdbj2zhfY1ryLts
         f6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbwJq3Gqc5ASN/8UdLMGbry/z/UwwdC9H75sXPGgTKE=;
        b=mgLymqS/b6MuHVtbZVSnPCVTbHKyeLzmntyZAPcZ/d0+owggOshpwb8Iit2o69/2PN
         t9Y3jyoel1q7gdF29JyBgUgKI27FUUxC/vsDEjiMsy8ygDSTdObPt6iqWuURZvC6AOns
         dUVmZCKFuHpgEHWy+BaFZKabsFpJ6nNqTgbOAnnfJVs2uBSI7uZhA4ne3lIdBjWUedIj
         8iTjce+9TLDNuQr2DDo2mPy3YIKYptz3k1VkTZTxhGjxF4hI+HcNL7Gz778Mi4AFd46N
         ryFPPdT9CPi2CVkJFBF+Uff+CULXPBLRhoX/jL0U1B+8VQ9c6XJgJ3DziJcZ6eNKUXYE
         J3Ew==
X-Gm-Message-State: AOAM530pE013xClKkHl+bMDA/HGwlD01Ze3pU2tqXSuIUQjHm5ut4TU5
        cKJTiNfIpfYv+f8RHYsziNtgo2WWgo8Fn0vE
X-Google-Smtp-Source: ABdhPJxH73iTMVIz22XLQiqZF/YMP2gnc3bsCz0ONyV7VJ7dTAvh/mGM6zGYQKOn6UnHedh+Islz+g==
X-Received: by 2002:a05:6602:2c85:: with SMTP id i5mr57530097iow.89.1638224738934;
        Mon, 29 Nov 2021 14:25:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm251772ilh.59.2021.11.29.14.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:38 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 14/17] builtin/repack.c: use named flags for existing_packs
Message-ID: <fd50c396577dedee00a513a9ba5a684dd78e5274.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the `util` pointer for items in the `existing_packs` string list
to indicate which packs are going to be deleted. Since that has so far
been the only use of that `util` pointer, we just set it to 0 or 1.

But we're going to add an additional state to this field in the next
patch, so prepare for that by adding a #define for the first bit so we
can more expressively inspect the flags state.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index cefa906344..cd4d789d27 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -22,6 +22,8 @@
 #define LOOSEN_UNREACHABLE 2
 #define PACK_CRUFT 4
 
+#define DELETE_PACK 1
+
 static int pack_everything;
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -559,7 +561,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, existing_nonkept_packs) {
-			if (item->util)
+			if ((uintptr_t)item->util & DELETE_PACK)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
@@ -1002,7 +1004,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			 * was given) and that we will actually delete this pack
 			 * (if `-d` was given).
 			 */
-			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
+			if (!string_list_has_string(&names, sha1))
+				item->util = (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
 		}
 	}
 
@@ -1026,7 +1029,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (delete_redundant) {
 		int opts = 0;
 		for_each_string_list_item(item, &existing_nonkept_packs) {
-			if (!item->util)
+			if (!((uintptr_t)item->util & DELETE_PACK))
 				continue;
 			remove_redundant_pack(packdir, item->string);
 		}
-- 
2.34.1.25.gb3157a20e6

