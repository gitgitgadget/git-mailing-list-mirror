Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17342C43331
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B8B235F8
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbhANCFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbhAMW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:27:01 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C4C061795
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:14 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 143so4408693qke.10
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygOOxZvwT4fpebBNERIgQabv33pbsiBcH0bco8d1HdE=;
        b=ZhJE/VlsScZDMtQ1zZ+V38BYhnG2aXL9tykAAM627F6cGxMEnrxRejw0bELlti8B+R
         /2JI9nWHzmMMTRBKZVaa/BtvJYSoedKpdwNW5xR7fyiUpuwznbDzl5A7ywGl1NMz6l9u
         EC2fgXhUH9IoX7qku7h2WOC6WWyDQInonkSjej/liQOSb/cXmuK+UNkvmLBiZH1GkbCt
         rmRcW2VpDboAjLmX3Kv0uqDafAgMRzhaYS+Ubmg1pZ5by1VXVQvMnTfFBIjKz6kzSmaH
         Wvrmd2RHGwJ6bYl5pNSaF+cGKQ2aYaGBTdoe5RaXvPzREtlQk2HbpUNTDmWMv6dbipYt
         KbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygOOxZvwT4fpebBNERIgQabv33pbsiBcH0bco8d1HdE=;
        b=eU0dECqcFm3Pw5VTgGpk4/8+OyKkip5FvN9SNW/Ce2PAby+CVRfcFYamXcsCi8kjjI
         GDmeTr8ic/2FInlrknwnut9stNOUYg42L7oSfdykx9p56tdivz2Hx89HqYC4mj1lyYBK
         V4kdez3metjTzybaLt7wUkGDi22wpe0j/JnpwTvzSTZg0M5ftwmlfYLvv+1rN0XujDRW
         tljKI2rE18+YDBEED4/KWrOHOOq1L/UnPQVXSt1OkdBxVtw5GIKiLVpRWx4p+hKwOV/V
         W0FmIK76xRji2Ape3Cj+9ncT+L2+cLGFZPp+U/w+6R+HWLWlbLpRqMjjDpHQBqCKRzam
         pV5g==
X-Gm-Message-State: AOAM531Zw4gXPQeUAAflMZMdOVGe+WadNFnqGJcNYynPyMR/MQZXJc/F
        t+LlBVwwBobevdLTmZ1PGwYSCWGxYGJhjw==
X-Google-Smtp-Source: ABdhPJyjHtGtzmonZEVi0zIIYmI/fd7tqg8E1R3EtoiMJilMfuX9KLEeL16/aPGNmYui68Vn6pFYsA==
X-Received: by 2002:a37:b083:: with SMTP id z125mr4329061qke.246.1610576713182;
        Wed, 13 Jan 2021 14:25:13 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id o201sm1984703qke.60.2021.01.13.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:25:12 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:25:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 20/20] pack-revindex.c: avoid direct revindex access in
 'offset_to_pack_pos()'
Message-ID: <8400ff6c9615b4c999b198c46b2e673ec0f2b14f.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for on-disk reverse indexes, remove a spot in
'offset_to_pack_pos()' that looks at the 'revindex' array in 'struct
packed_git'.

Even though this use of the revindex pointer is within pack-revindex.c,
this clean up is still worth doing. Since the 'revindex' pointer will be
NULL when reading from an on-disk reverse index (instead the
'revindex_data' pointer will be mmaped to the 'pack-*.rev' file), this
call-site would have to include a conditional to lookup the offset for
position 'mi' each iteration through the search.

So instead of open-coding 'pack_pos_to_offset()', call it directly from
within 'offset_to_pack_pos()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index a508d5f0a4..5e69bc7372 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -177,21 +177,21 @@ int load_pack_revindex(struct packed_git *p)
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	unsigned lo, hi;
-	const struct revindex_entry *revindex;
 
 	if (load_pack_revindex(p) < 0)
 		return -1;
 
 	lo = 0;
 	hi = p->num_objects + 1;
-	revindex = p->revindex;
 
 	do {
 		const unsigned mi = lo + (hi - lo) / 2;
-		if (revindex[mi].offset == ofs) {
+		off_t got = pack_pos_to_offset(p, mi);
+
+		if (got == ofs) {
 			*pos = mi;
 			return 0;
-		} else if (ofs < revindex[mi].offset)
+		} else if (ofs < got)
 			hi = mi;
 		else
 			lo = mi + 1;
-- 
2.30.0.138.g6d7191ea01
