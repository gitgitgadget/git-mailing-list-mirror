Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B262C433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284E523A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbhAHSSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbhAHSSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:08 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14876C06129E
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:17 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id h4so9278519qkk.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GM9loUCar09yegUPLrtLkMMhYCJSKE0JxszIhPtP/ME=;
        b=ckjespQwaH1GlK5qo1BDhN/mSsMgXeK3tufwMcIUNqq+8WmG6iD97L8bSA0A6VDC3L
         h5ZFkXGgaSfQNnRjAXC91eJ3AyyAe9bW28roZ71/Erx0kuLkZjhQ0ZfFS9oOFCiO2NxY
         dUYsCblMVyR8O+rP+iMRNsAAEMWCZpwdrwy8RLEf2HVb39ZcdKI/Hyz3gjuVtz6ztBWH
         F2P6QpZ9LRjYAUHpNSH70bUzEtOSjY5+kFaOJ/pAebT/5WMGxsy2keYrkjKYrangx6WG
         CWDELBKZcSVzOAY2cVx9O+Y4E/QTa5GUQ4y351bOoqHNCZc55U2KVRBGayR+mgH4u1Fj
         6/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GM9loUCar09yegUPLrtLkMMhYCJSKE0JxszIhPtP/ME=;
        b=HQpPCskeaRKuszdoKDlJz4vQNXjWvu9ZtseXl81gF+BprX0hfd5cYLd1SuePAE3XQh
         roCNrm/UbsKp0cDkJuetcrG1jvUw9HEwSMMiaf6HcDKglvEhWiWYASxDDu3vKUxTfKHS
         H6+buLGsfsuYAZGwjwqmbl+FGV60gRm16pbBZTjufTLB+rY1hfKdNc8kkZ7oijRK2Tc8
         FKVbhW9Cu5attZkD2TzEHyVzOstPEIB4+sIEZpKy450x6KhsEudc9gglWH++ITPSf+FO
         wPnzTulrYqP/sikPmMKFhDyn5WvML7fT3tGcoHMOqUMR1aV8/Gy/NA93wSM6Dnc/BB6j
         pJ9g==
X-Gm-Message-State: AOAM533ZEWoIl1BNCjWgvEZIDnsOc52KE38N2Y1hlv+91ljdegP28dIC
        1VHHpk7Cnjr3h/XREMedTTcL1GZZiWCHyw==
X-Google-Smtp-Source: ABdhPJxk7OqJxhBqi8tNSiXWPsJqEGnSZ3zSUE2wYlGajT8MvYDbt9pWuWV3FeJnZ2PKkJ942RI0cg==
X-Received: by 2002:a37:a24a:: with SMTP id l71mr5217325qke.161.1610129835876;
        Fri, 08 Jan 2021 10:17:15 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id d3sm5240381qka.36.2021.01.08.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:15 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 08/20] get_size_by_pos(): convert to new revindex API
Message-ID: <541fe679f3e8e02617c4c9461b85fd310f55ccb6.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove another caller that holds onto a 'struct revindex_entry' by
replacing the direct indexing with calls to 'pack_pos_to_offset()' and
'pack_pos_to_index()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 80c57bde73..422505d7af 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -835,11 +835,11 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 	oi.sizep = &size;
 
 	if (pos < pack->num_objects) {
-		struct revindex_entry *entry = &pack->revindex[pos];
-		if (packed_object_info(the_repository, pack,
-				       entry->offset, &oi) < 0) {
+		off_t ofs = pack_pos_to_offset(pack, pos);
+		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
-			nth_packed_object_id(&oid, pack, entry->nr);
+			nth_packed_object_id(&oid, pack,
+					     pack_pos_to_index(pack, pos));
 			die(_("unable to get size of %s"), oid_to_hex(&oid));
 		}
 	} else {
-- 
2.30.0.138.g6d7191ea01

