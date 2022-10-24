Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D9FA3740
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiJXU7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiJXU7F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044CEB48AB
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 12:05:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y13so5211936pfp.7
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/65QXB1aoRxcs4Xsc5r9OGnY0ge7BQ1M2LEBHMwsoVk=;
        b=SJcbj01m4TgaBuPEtnV0Zw1qExJ+2msR2EWArvxL3V7N0A90xcT+VmeBUjAxIpCkKA
         0sfR3Hr0NaOCuqRcKp6R3VEkDCqDmaT0YNJiBTeVNGyxwmHyHijTAwL5/snmUSCOxqgv
         /PyI1GGc8/RUkXReGknclnmIPjyGVsmrCNHWJoQhkgNxTBMQSFeunwWP46XGSJQzWZgj
         9VRSNfdqREqZH2w5dGVDk+fjl4EwHTxz8GnDFlfrqWJrK+LXGnPO8HQG/MLAoafAgf6D
         EZKhhP9vANLj5zdPVKWlb4cZn5CV/tgfK1dOQyEtm63HvhsAoylk42fcK7zTm/l202Qb
         arWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/65QXB1aoRxcs4Xsc5r9OGnY0ge7BQ1M2LEBHMwsoVk=;
        b=x38CR0yFR8BZBAqDTDbXOMSUlLOATyjIH0bDtTVk0SMoUWvypkK4LSt8ewlKKyZZDm
         ZDzBF/3wVkKnTeCJpZuBHvBCQeMT6glDF5hPQxHeEbGYi5B0B/Yu/TOLJWHzUVZyCzU2
         d8AR4IAnlzsV3xAM/S/zwegImgL80hlGc2fwiMqhA3QWmFQrU6kLGC5q2beYFbq5o6OV
         aBSPIZkT0IlE+sX4eJZp2wxL9g8wp7kMBBsukg/qARH9gKsKdzuJ2lMa58qRRO2NXAgC
         hclIEM6hhF7q8BES8ozu16N5jtbOppVacvAyti5S7/RWR+k/52OX9Yds2Uj5YyqJx07u
         csUg==
X-Gm-Message-State: ACrzQf2LAo7D3ZRqPJcWcgzcL08g32zvcNcdVPHQF0updRWBrqPbbKhR
        V3am7thKrc2dDKTPVst0a7A86OgVtylypoiZ
X-Google-Smtp-Source: AMsMyM5WRkLqoZ1K/bOt2lHkpcEaYH9v0upV/STzN2P5ug3yTBok4rcnCrH5eA+7e2XnBfjOGB1x+A==
X-Received: by 2002:a05:6e02:2147:b0:300:184b:702f with SMTP id d7-20020a056e02214700b00300184b702fmr2095412ilv.88.1666637745940;
        Mon, 24 Oct 2022 11:55:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k3-20020a0566022a4300b0067c47eb46desm194864iov.47.2022.10.24.11.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:45 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 6/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <6a373815bf5cd92da762c7cf5e40c0cecaa33be5.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
a special case of the new `--group=<format>` mode, where the author mode
is a shorthand for `--group='%aN <%aE>'.

Note that we still need to keep the SHORTLOG_GROUP_AUTHOR enum since it
has a different meaning in `read_from_stdin()`, where it is still used
for a different purpose.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 808bae9baa..f6032c6328 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -253,15 +253,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
-		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%aN <%aE>" : "%aN",
-				      &ident, &ctx);
-		if (!HAS_MULTI_BITS(log->groups) ||
-		    strset_add(&dups, ident.buf))
-			insert_one_record(log, ident.buf, oneline_str);
-	}
 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
 		strbuf_reset(&ident);
 		format_commit_message(commit,
@@ -383,6 +374,10 @@ void shortlog_init(struct shortlog *log)
 
 void shortlog_finish_setup(struct shortlog *log)
 {
+	if (log->groups & SHORTLOG_GROUP_AUTHOR)
+		string_list_append(&log->format,
+				   log->email ? "%aN <%aE>" : "%aN");
+
 	string_list_sort(&log->trailers);
 }
 
-- 
2.38.0.16.g393fd4c6db

