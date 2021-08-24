Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469E8C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288D561212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhHXQQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhHXQQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:48 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345EC0613CF
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:03 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j15so21070488ila.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f9cTScN3cBtgvr8gRBwQzXJ86fIQCcArXDoohUDQAZI=;
        b=ml0yvjLjoEP9vLJhpEJ6UMK2YVJGdfvJKg4W4e5t8nYxQgH5C1VUvxX2+fD8OQ4yOQ
         33z1icn/L7d8wuM9mP6iNez8xF2dfM4reU4HP6qVej4B6NbifhbZXeb6q7sC2o36Pp68
         dkSMv/pxu1hGmtrUgYjFsu9Lmsol2ZZ278m+Zx43wj0Rup8xWxe/L3MuwY9gWPBbNlo4
         3FfamFDm85E5/1YSyMS2EQ14t5carxhX/M1g7ekxKTp0k4c1cVZzBXjuZJjkjQnDqZ3n
         6QCIKWkR+p8V6QpojlUzz+pCZaR+cv4wgDWEgYW6q29KKJl2Pk+blLX5poW6b8Mgizxd
         qKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f9cTScN3cBtgvr8gRBwQzXJ86fIQCcArXDoohUDQAZI=;
        b=HCRBJuw3CwLDH8nE1gHg3T9oMXHurazAyGat3gKecN6pT8e7Fmy9auwpUWWnEEQr44
         J3bmRgV0KwBQZt9jCV3UOTU60DJQhf2v2yAb/0KJ6pVTmPZ/Dy4RBy99NglSWqOV+Ymj
         7mDY/5svA5GODmv6XhsGr6M+A6NLaEm5x3YFjmRDuYHMBLHgn1v8vpJbpF80wSWgTfzJ
         lcQYffACLv99qJYQq4qLff3uVWw9BmEPabnExiyUKePh8MR0ZGOkfqSP72Gq1SBG5tfJ
         F8RSoW2TGFr+fwDnYkjMw4XixZWJ4Z2PoPQ1q+nd89Q/ASXI1dyxbf95n+zd8lHWE7fi
         vioQ==
X-Gm-Message-State: AOAM533GuregOD3Pg3OAuxDPgwiKzoKV2xjIjhvfTF7JwQmNPJ8pPU1E
        bPuGzh2hHeh353isl439dRH8kjcGefpissLt
X-Google-Smtp-Source: ABdhPJz4Q/1bq3qahsU83a+aeJenUiiPfcjk07SCsU0VQqttxuRVTflx1yERxAUWx1FczpTvcExHcw==
X-Received: by 2002:a92:c646:: with SMTP id 6mr25788407ill.78.1629821763114;
        Tue, 24 Aug 2021 09:16:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p19sm10321486ilj.58.2021.08.24.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:02 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the MIDX
Message-ID: <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new multi-pack index, write_midx_internal() attempts to
clean up any auxiliary files (currently just the MIDX's `.rev` file, but
soon to include a `.bitmap`, too) corresponding to the MIDX it's
replacing.

This step should happen after the new MIDX is written into place, since
doing so beforehand means that the old MIDX could be read without its
corresponding .rev file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 321c6fdd2f..73b199ca49 100644
--- a/midx.c
+++ b/midx.c
@@ -1086,10 +1086,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
-	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+
 cleanup:
 	for (i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
-- 
2.31.1.163.ga65ce7f831

