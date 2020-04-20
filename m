Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C0C54FD2
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA56D206A1
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7CPyyux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDTTym (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgDTTym (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 15:54:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA090C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 12:54:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n17so8977323ejh.7
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aiaWr5+0tFrYWEJO0Mr98cYtnJ3xipFOuXGsNpbmUdM=;
        b=u7CPyyuxAd8ipRj6vjJAVy3hZp3P8nxvLRW5RVZ2NRJXnRbsAtVyxN+/5x2zmK4vVE
         g5+BvH3LpuU6ngG0CDLmpMw61sGibRd5ctAXoOWBtKkgVrL0yYUoxpdNhP+44RGP4lbu
         ZWl7oXD5wOXii2XGc5F9w1f8h003ttu5oMqBbJrtYOxjcgQM4suC5LjAZmsXVIo/2uUX
         vJHwo7oTHA4TwMk2xWqMaDeDF0eu3wUtosH0HL23/Jk+uDl6HlZPOPNtZtjki44sGWXg
         UHZn9FMkUfK/51T97bkYpNQcXxZlujnHniu7SgfhQlwnu1/k03JCVaF5UhMaeJ6QY+1z
         kvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aiaWr5+0tFrYWEJO0Mr98cYtnJ3xipFOuXGsNpbmUdM=;
        b=KX/EXmMuuOB1meB4JybBhyj+XbtXRZ4hQ6br1IgZQtVxFzBkB08dzhXcH7YSmVYKiZ
         zvJLhTTcp447MMFYnUdNQXX30k2R4aHmKwLow8U/JUVNBYeOb1lIiJpo6dlNalmS0TvB
         bT/oP24dmOhEMXBqx80xziqYosuu7MuCsTgiZIHmjnwsGhRxs1TroReMr7nqR9yFYyn6
         wg10XAGN9fBCLjYZohz1AqzkjhUAKv71dMWbvJuwG071Tl16TY9YeURt4yBDgk+3EFzR
         DJwiKdACwLInReMq2QxAdgZFgfgrtGwjUfBx+YcEC5+cKmYHWEUBFAOhKADo/PyQykZ6
         zS7g==
X-Gm-Message-State: AGi0PuawQTzNclHsDtUzfzD0aQivJ4tXiAarlGKqSS9rvTF6uXPYDO0B
        0XzU20O9a/NM00fiQD+lXAYD3iGK
X-Google-Smtp-Source: APiQypIbpC78q2LCuQrua1OBK7DcAK8pmvapJ0ifMlgZuswXOMeH5mlSvByzV6KbEjJh/iGASYsO9A==
X-Received: by 2002:a17:906:88c:: with SMTP id n12mr18277052eje.92.1587412480122;
        Mon, 20 Apr 2020 12:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm28602ejl.37.2020.04.20.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:54:39 -0700 (PDT)
Message-Id: <82f7473d3b8225771bbf09023ad2b5b787261dd0.1587412477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.606.git.1587412477.gitgitgadget@gmail.com>
References: <pull.606.git.1587412477.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 19:54:37 +0000
Subject: [PATCH 2/2] index-pack: remove fetch_if_missing=0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Commit 6462d5e ("fetch: remove fetch_if_missing=0", 2019-11-08)
strove to remove the need for fetch_if_missing=0 from the fetching
mechanism, so it is plausible to attempt removing fetch_if_missing=0
from index-pack as well.

Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 builtin/index-pack.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d967d188a30..9847baaf3f4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -782,7 +782,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (startup_info->have_repository) {
 		read_lock();
 		collision_test_needed =
-			has_object_file_with_flags(oid, OBJECT_INFO_QUICK);
+			has_object_file_with_flags(oid, OBJECT_INFO_QUICK | 
+									OBJECT_INFO_SKIP_FETCH_OBJECT);
 		read_unlock();
 	}
 
@@ -1673,14 +1674,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
 
-	/*
-	 * index-pack never needs to fetch missing objects except when
-	 * REF_DELTA bases are missing (which are explicitly handled). It only
-	 * accesses the repo to do hash collision checks and to check which
-	 * REF_DELTA bases need to be fetched.
-	 */
-	fetch_if_missing = 0;
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
-- 
gitgitgadget
