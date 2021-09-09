Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DBBC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3231E610C9
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349612AbhIIXZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349759AbhIIXZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:25:53 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFEDC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:24:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h29so112996ila.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wLMUPGNiWOFGKyR1RJpDMuyvM/DALCGBKEAxDmj/rwA=;
        b=lM9IBDwcWbNBdcqdJh8bOZEWH4v4GTigHAPZOsqayCN2HVcE/ghff+XpA815mXA9KW
         1NV65qz/ds/hBnnub58cZo06w/6/8yuB2+MAcl3kYYbSVBGhhLlpik0yzdXbZOktYpOv
         hhclUCidYdoIhnAaWEIA1jb7uaSeqMJjk7cqGiIrus7gXRI9RUWlzh0gG6RMm6aK/ar9
         b5kv7okbzfxk521USS/aSuz9I/vOo80nNNCDD7+7SyZV33CbXfPM0EKCBbBOoVXnc/17
         aqm98PbDq7c80HgrVJa+uE/DU3TGaqH+Lgg/mLbh4f8RAFVj3OJF8Nf7w6hJKCfgem2/
         oH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wLMUPGNiWOFGKyR1RJpDMuyvM/DALCGBKEAxDmj/rwA=;
        b=U1k6Y4B0/tNQ8Dm4RXV9mmNV4XAFjcnfJNs31R++F00HPoH9jO2WXMtBNH3tJYG0Pb
         8PpMunmBdZ3irJ2xlG83aoTZ15sXy5LmVOX4bQZ1t2WwRk3wMVB757z6tuUOh42297qK
         STjqwG8v2Udn8FsOgJWa7pCo3jNlLtXuvw2zgI96LAbEbBdluxzWMnowt9vEWj3ORDuk
         g8/hzbtFmn/EbbPe1FBhwHrR5iQ+tO8kQ5I0kHlVg5Lkayz/H1UvWZKvEtyOpMlalMR5
         y09697tPBgPQDNhCk7+EnJL96zKj2ifAHre74Q8EfTd1YkAoeJelsplncIVpICvyYbel
         TDtw==
X-Gm-Message-State: AOAM530+hQnOxPGuRb8ve23QDeu/ZF9vL4oIuSIeXM9uN/NyYRRpuWKM
        8owHNxFu1fhnV0aVpAgAV+jXuvjeUO4oVlwx
X-Google-Smtp-Source: ABdhPJz3RHJXLlHjFtxNyK/qRJ7Yz3OS2q7/lavpMktEzDNbmk1GtEm3Vj8FegmS3spq8g29TGijkQ==
X-Received: by 2002:a92:6a02:: with SMTP id f2mr4314615ilc.19.1631229882531;
        Thu, 09 Sep 2021 16:24:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m26sm1572734ioj.54.2021.09.09.16.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:24:42 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:24:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 4/9] pack-write.c: rename `.idx` files after `*.rev`
Message-ID: <41d34b1f180350c466243ed5aa7f6a48a2ff2aeb.1631228928.git.me@ttaylorr.com>
References: <cover.1631157880.git.me@ttaylorr.com>
 <cover.1631228928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We treat the presence of an `.idx` file as the indicator of whether or
not it's safe to use a packfile. But `finish_tmp_packfile()` (which is
responsible for writing the pack and moving the temporary versions of
all of its auxiliary files into place) is inconsistent about the write
order.

Specifically, it moves the `.rev` file into place after the `.idx`,
leaving open the possibility to open a pack which looks "ready" (because
the `.idx` file exists and is readable) but appears momentarily to not
have a `.rev` file. This causes Git to fall back to generating the
pack's reverse index in memory.

Though racy, this amounts to an unnecessary slow-down at worst, and
doesn't affect the correctness of the resulting reverse index.

Close this race by moving the .rev file into place before moving the
.idx file into place.

This still leaves the issue of `.idx` files being renamed into place
before the auxiliary `.bitmap` file is renamed when in pack-object.c's
write_pack_file() "write_bitmap_index" is true. That race will be
addressed in subsequent commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-write.c b/pack-write.c
index 58bc5fbcdf..b9f9cd5c14 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -491,9 +491,9 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 				      pack_idx_opts->flags);
 
 	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
-	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
 	if (rev_tmp_name)
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
+	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
 
 	free((void *)idx_tmp_name);
 }
-- 
2.33.0.96.g73915697e6

