Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7755FC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJUWZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJUWZq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:25:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD7A1918A0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o65so3510792iof.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpsOH8MNNjaXe8PFoD/jp7TaZ7ac3hJ14pF51hYOfwY=;
        b=Xf4fLqcICpCCaMruU0saND2MLU5sDuyKEHKDGGMhTv/sPuIhKNnOw7DY019vqlMCqG
         404XW5XPiAgRPoY/+QS/QZvsPUdN/Mzo/3SgSBJ/Di/0/ys5QXAknyqJI/Na5Bt3mK6b
         4so3vGQRWNdkTua5+mE0O5nPPAxnsda0M4SxFmPcwZKGjMqdsfS543czpsLeOPH/kbay
         LOzHquPOmha/2PNHzCx30x+18INpHkX8rIu480VHiANEWbEnUM+8addIrgwKPyqd+7KD
         qmdlho9c718d0+TqMKayoQxuvhS2jcruai1kyDkxk5Sw2kgW2wITp3U6RqvQmzb8f2Yx
         sS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpsOH8MNNjaXe8PFoD/jp7TaZ7ac3hJ14pF51hYOfwY=;
        b=0mU+qCIyGpIltpG2x2oGaQYf8UR+5mJhlZGQqLxbj0Q6FgzAx173ACY9PsugHzPTHP
         1z9YkFragi8+gu2Or+izSAxrUCnVc8uDACDwU+eBo7uPJCg20UCiIrg9Z+40AgauW2tM
         VfSpAKAaSdCtC7MRJaPOmz59UmVFq/svUNphUTugc2D3vOxY2QVoqynEDdcBWl8FbssL
         cKI0FjVknjdo3dr8XeKVOmKPSqfmRg5AcOEsUaqBdyOkTMkDQaN0o8UckN07CHmA77le
         AYi8CAQQCTDkuck3AsZOPEUCyU+Z9E0H7d5ZRkWzMRq2bvZx5dMPEygIVjOKc3KbvSL+
         xudw==
X-Gm-Message-State: ACrzQf002nzIOxsJzLIw3hGqlX0ibeD99Zyh0LxnJy4E0LuTIXLxUaO+
        WVb6kijPKsepJG2C9lU14fCo5X/1BJt/r0q9
X-Google-Smtp-Source: AMsMyM4H4hLYMLvNoQCisJznPzhdmJr6OCkIkl7OT2tMfS2Wnthkp09b/Yr8HZnaFdhSz4dpEf9knA==
X-Received: by 2002:a02:6385:0:b0:36e:ba59:5ded with SMTP id j127-20020a026385000000b0036eba595dedmr354116jac.247.1666391144641;
        Fri, 21 Oct 2022 15:25:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q9-20020a05663810c900b0034272baf43esm4612776jad.168.2022.10.21.15.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:44 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 2/7] shortlog: make trailer insertion a noop when
 appropriate
Message-ID: <25cdc28215973b2bcefb1c14d5415e7a6f163352.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there are no trailers to insert, it is natural that
insert_records_from_trailers() should return without having done any
work.

But instead we guard this call unnecessarily by first checking whether
`log->groups` has the `SHORTLOG_GROUP_TRAILER` bit set.

Prepare to match a similar pattern in the future where a function which
inserts records of a certain type does no work when no specifiers
matching that type are given.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 53c379a51d..18f0800c82 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -170,6 +170,9 @@ static void insert_records_from_trailers(struct shortlog *log,
 	const char *commit_buffer, *body;
 	struct strbuf ident = STRBUF_INIT;
 
+	if (!log->trailers.nr)
+		return;
+
 	/*
 	 * Using format_commit_message("%B") would be simpler here, but
 	 * this saves us copying the message.
@@ -240,9 +243,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
-	if (log->groups & SHORTLOG_GROUP_TRAILER) {
-		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
-	}
+	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
 	strbuf_release(&ident);
-- 
2.38.0.16.g393fd4c6db

