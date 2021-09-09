Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7850C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C750160F92
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbhIID1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350162AbhIID0e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F5AC0617A8
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:25:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q3so532108iot.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ajkVj0Qyvw/bQUPoafTQ+yX+kdQZvrArM4W/UBNO2dA=;
        b=JBrhKeDy4v6ffTEu+qUTtJzbiM4Osaqg+AjCUUdvacinuTDek07LXl54U1y0Roj87Z
         S9Ekzah7VguNkzIg+S39dd1CM665/BKu53X33TyDEMHGiFWulVsi3H1vD6xiaJI3QQOX
         1adIxiMdpoMj7WtKQy1toGSr9OWOt0Qi5QaWFukYLofeunw9yy8TT9g4/dtpfHK61EYP
         DIPkZHY9C76iyMwRtjUr3e+9JT+kF2jMRVyWMQ+CCll4VAIuNIJlNmdUbYLJZufRy2+b
         SRS+RvQAHgUbYtHf6MVj/Sb43/Bxeo1EPJPa6eYpG1HRlNLGZ/OmAfgpk0MHomjigLmp
         GVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ajkVj0Qyvw/bQUPoafTQ+yX+kdQZvrArM4W/UBNO2dA=;
        b=4FGR3oYganQbtXrYLN77EmNGbQ3H6RQbtdeZLx0W+uiVZ27oPP2dqFns3duvd6GFe+
         tIGfA/W/Yruo1tHS59gbVZ2ggF6OfYVPmIYWSOPXyg+Az4DBsN+RYIrAAtVqj/zU1DLI
         pAFNVyMLA+Z3BkeRb3rXDMx/o8uGdFnm682SXYrHIwkaDoxI8m9WDMU4XBWbSMBw5ZKu
         9IGXrBrZmqpAG/oCOYphtLQdYxHU/qn65z6ZpSpdQhBdSZfc9d/TZT2D77HNm58TMa1y
         gSAcvMrcfXI5m2DVeHx3iE/djIhsvxMBOQReo8AYFoUVwfpS/pZekscdF0Eygmv03fQG
         ppvQ==
X-Gm-Message-State: AOAM5308StSNIzE3J+28GTp7P+K+0gGdJTlEDxiT7c6EIJEXUodnX5iV
        S5DRHkKP+m4GJKLX0u55gRVU8a23j6rVdrQQ
X-Google-Smtp-Source: ABdhPJxljJWfWK3JJf855VsjTXfP/BZ5yiAnKnCESCpzj0zCXP9S9znflWmKE1Pw1F/tJ/n+mXufRA==
X-Received: by 2002:a5e:9901:: with SMTP id t1mr792240ioj.92.1631157923522;
        Wed, 08 Sep 2021 20:25:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o15sm296187ilo.73.2021.09.08.20.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:25:23 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:25:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 9/9] pack-objects: rename .idx files into place after .bitmap
 files
Message-ID: <d8286cf1075dc85231128145c5abb0db3881032b.1631157880.git.me@ttaylorr.com>
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

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

In preceding commits the race of renaming .idx files in place before
.rev files and other auxiliary files was fixed in pack-write.c's
finish_tmp_packfile(), builtin/repack.c's "struct exts", and
builtin/index-pack.c's final(). As noted in the change to pack-write.c
we left in place the issue of writing *.bitmap files after the *.idx,
let's fix that issue.

See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21)
for commentary at the time when *.bitmap was implemented about how
those files are written out, nothing in that commit contradicts what's
being done here.

Note that this commit and preceding ones only close any race condition
with *.idx files being written before their auxiliary files if we're
optimistic about our lack of fsync()-ing in this are not tripping us
over. See the thread at [1] for a rabbit hole of various discussions
about filesystem races in the face of doing and not doing fsync() (and
if doing fsync(), not doing it properly).

In particular, in this case of writing to ".git/objects/pack" we only
write and fsync() the individual files, but if we wanted to guarantee
that the metadata update was seen in that way by concurrent processes
we'd need to fsync() on the "fd" of the containing directory. That
concern is probably more theoretical than not, modern OS's tend to be
more on the forgiving side than the overly pedantic side of
implementing POSIX FS semantics.

1. https://lore.kernel.org/git/8735qgkvv1.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 944134b6f2..a01767a384 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1250,7 +1250,6 @@ static void write_pack_file(void)
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, hash, &idx_tmp_name);
-			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				size_t tmpname_len = tmpname.len;
@@ -1267,6 +1266,8 @@ static void write_pack_file(void)
 				strbuf_setlen(&tmpname, tmpname_len);
 			}
 
+			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
+
 			free(idx_tmp_name);
 			strbuf_release(&tmpname);
 			free(pack_tmp_name);
-- 
2.33.0.96.g73915697e6
