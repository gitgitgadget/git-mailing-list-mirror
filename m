Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C9C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDLWUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjDLWUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA334C32
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j10so3288028ybj.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681338019; x=1683930019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwy4KBmIx/l8Hxrn2NtHez0hMpYyvVY/Y94tNLdEaZA=;
        b=qz2FCpknAEl2C+dwlO28iAFgmOhpV3wBTtxurSGzf4up19/aagUkyJZFvp1VFL5b7H
         soXgQweYesnIZokpzQPxNcmtBcYA6zASFfW+BmeFE7mRrL4ZHa7Bvm9tDlXVhUX44MT4
         jF3vQIlSxasKb3o84ONocqldo65bvNg1vqP74J3PWOKjxC0njOCzx3x3ke7wyglGdIFr
         9O7/Rl4quytan2ohF+6G/MMbNvjmDFDxh5RST2wgnR44JntLcPBBBqds1MOYMGY3iURz
         WVzIUoxJISIyxnleXZshTc3knQMdTH0pa7heMZIKpjpuUe/gVcL5Y6zmnCKl20hNX7Aj
         44Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338019; x=1683930019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwy4KBmIx/l8Hxrn2NtHez0hMpYyvVY/Y94tNLdEaZA=;
        b=Q72vIBGFFOsXVC8xrLLoVha+JNP4MvyiBbgg4PCKNa6rkoG6PGzuYrstAqEf5h8pkz
         zrXGmyR/LJoE29HH/McTV8qtNfPrQLaPBFU/MWxOb016IMJdJ8SUhAzeu2lDO9RuijpX
         0ZAbDaoO4B6NYvSdRhXMFW365inJN/bfauX8OpA63nEb/IWrTb6xtDeiNhf8xTA4Psm2
         qAaq+HWhsm6UEV+L8FsRPcAc2/6AvnyYkThQZDC/i5xbO/DMde/NGp9uVUUxGYwW6wXe
         RIVOrBf3F7lNAdGWCG76UX0Io1JNMtgLc0MFYZxnfXfQGIkm+ePQfMaoShOLX9uEx4rb
         eHMw==
X-Gm-Message-State: AAQBX9dIBnwzZhemXhnX2lzIyFcJG2b3Gm61inanpnVSM2ieYWZ+1Ypu
        dgDSgrzMW+wQEmCIiVoFn7FhEuNG0012Nir3h7z+ww==
X-Google-Smtp-Source: AKy350Y7//F8pyBX/OHnQL74FdlNYTjz7oL0yliGwwWG5cB1vQ+5cwME/uUtQVd26aloEEn4Tlj3/w==
X-Received: by 2002:a25:b11e:0:b0:b8e:df9b:b2d4 with SMTP id g30-20020a25b11e000000b00b8edf9bb2d4mr111627ybj.11.1681338019168;
        Wed, 12 Apr 2023 15:20:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bw26-20020a056902161a00b00b8c08669033sm4134232ybb.40.2023.04.12.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:20:18 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:20:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] pack-write.c: plug a leak in stage_tmp_packfiles()
Message-ID: <18be29c3988295cd58521f8cc4a729897df074c8.1681338013.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <cover.1681338013.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681338013.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `stage_tmp_packfiles()` generates a filename to use for
staging the contents of what will become the pack's ".rev" file.

The name is generated in `write_rev_file_order()` (via its caller
`write_rev_file()`) in a string buffer, and the result is returned back
to `stage_tmp_packfiles()` which uses it to rename the temporary file
into place via `rename_tmp_packfiles()`.

That name is not visible outside of `stage_tmp_packfiles()`, so it can
(and should) be `free()`'d at the end of that function. We can't free it
in `rename_tmp_packfile()` since not all of its `source` arguments are
unreachable after calling it.

Instead, simply free() `rev_tmp_name` at the end of
`stage_tmp_packfiles()`.

(Note that the same leak exists for `mtimes_tmp_name`, but we do not
address it in this commit).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index f1714054951..f27c1f7f281 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -568,6 +568,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
 	if (mtimes_tmp_name)
 		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
+
+	free((char *)rev_tmp_name);
 }
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
-- 
2.40.0.323.gedff6a80c63

