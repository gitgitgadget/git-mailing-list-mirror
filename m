Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D7FC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CF661178
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbhIID0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbhIID0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24DC0613C1
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:25:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e26so300162wmk.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0GH/X5HCgQtgghJYJJMgKfzAuaoeMDV0lg7f3kpEJZI=;
        b=0vkigo6Ch1eSll1m/5RLZ3LxqyhfCMM+RII/bDBoBiZYrvsEmRByPV2St4Xz/DYaw6
         YViOGVvoEF11ENhEzEFidkoYnaK2u4K3SfdQMPnvz/jRyu7gmdMIZYlFUb0tvNXgQD7j
         gshyyLwzvuWYxYElHITC+491p391qhRhwunZ0LSTgvrGFJTYnppnAeGexu9iG+/8qgE1
         FVaWU1eh39eoxVaFlRVRODca/NafnAJ8GA1p8hdykpax6xxARTv9ejVy8YHSKyAY+wzg
         F1+6E349WkGateyqo+E4/aWAvQGWjV5eyzTLtfAmeT4GrI0hHaIyGv2g2XfMaqOXQHcy
         ovqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0GH/X5HCgQtgghJYJJMgKfzAuaoeMDV0lg7f3kpEJZI=;
        b=sZQUB+hnJVj4+Gxf6zjwAytTV8kccoDUb1pOxhAS36LcmpIgjudNqYqaK5Tnjih7Td
         yFzMCIC7zBOWCgr3jeg6GllLbb7ln8fPLhOXBuop12XpL9e2bUEkdjLWDP9GZwwQ86v8
         DbPvjRLiw8K9a+AefYonrQDUzM+dA+jgy85JVOMAIkHsfiu5WLOqzjg9FsLELVMQCTmo
         rHGeT1axR72epap9dMtNl6fu3TmOnSX0c4xUpVklEzQOuWKZJ6JrefgsNdDDwQ4s34Ra
         msSqLzlyoQrkpgsTlJc+vG276VV1DFCmD7DUUFAZ5rCNHijAcQyxWHQuLGX5QWlUZYNG
         h/dg==
X-Gm-Message-State: AOAM533xm9Rf9eXoRg096RqOBwwfOP8i2ILZqcq0qOlFZmIIzOHm0XeI
        uFpI3zvP/P/o8cff7GzkF+snwbxQPf+x9Rog
X-Google-Smtp-Source: ABdhPJzr30/L7Di1TY3h7gj4TJFVCDH9kZGtJvrhAh+CMLZqbeCTBjqcFHtiEP9lgYvGLg4L9152RQ==
X-Received: by 2002:a1c:cc16:: with SMTP id h22mr549996wmb.117.1631157901616;
        Wed, 08 Sep 2021 20:25:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n5sm332670wmd.29.2021.09.08.20.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:25:01 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:24:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 4/9] pack-write.c: rename `.idx` files after `*.rev`
Message-ID: <0fb2c25f5ad8bfdccd653f760b1c4beeb05273e7.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
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
index 95b063be94..077710090e 100644
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

