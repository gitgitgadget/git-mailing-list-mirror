Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC94C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 22:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKDWMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKDWL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 18:11:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43324BFE
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 15:11:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r81so4891841iod.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJiXRarPjpvq9ZaGnBvMOPYPz61wpju694xTIlX1Kq4=;
        b=MsA/SRH1rpglzROp0vy1VuILiT0RdoO/uhXT8JSaace5xE5uqFDL5HGxNOdIqSMcvc
         ZGzHzY1lsXh7JFaUCnbhzbwr2HHd99FN6evUJGo2BDFvAH3R3jRVcy/nnhJKNRkXE7C1
         h6O5EXCgEsSITtupFneU3KJEFpQYhoZNNd+WFqJPrZEg/xIMObC7HnziHvp9KeSgPLrG
         KdAVyBW7RJt22kfJ2Ulu13vABDhpVXT/CTAfm3wcmTo6EtjMiupc1Dgcg4tyge1CaMdu
         8MDr8Lek+gJD/N69wnCfOq1V2wCOGuLmx3i4j1ls7I4PlfP1h+KKWYk31DPzpLgxIxEd
         IuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJiXRarPjpvq9ZaGnBvMOPYPz61wpju694xTIlX1Kq4=;
        b=vwlCrcP0CxWPjmchP+V5OnbutWd51NizvYO2U4SI3TVYExHBRvAQyot5XfuEoux5Lp
         F8jMHEO36ZnUAKG8CH/Wdt7Ny33TcoR/XGlrtpngtkZ3yYjTUv8lOt6LSzim3dvXUJZz
         B5njBFxZ56Il8EGRWzNNOYOJW6rso7TD2t/MFnP4kB4PL5AmHArrppuZblPFPWuh92ZF
         Lr9YnMlpTGZS4u9wglu6R0KPlpEMLKizOzg8ghDLMHhse+0/eGcS7M90QBmShGLV3lYP
         afs16p2T3WRwdW7qFWjSlmCwYkwKW+0QtpdjhY+4k9dy5uRLgwQyVC6ctA3fkJ9UoAF8
         44HQ==
X-Gm-Message-State: ACrzQf1/aP/ObUbHYj6SbLzdzFIJx3TFND44BPl7D24jpo/dlTtH7Kqw
        mNCGvyO/M7K+AFlVVMoYlWHBPw==
X-Google-Smtp-Source: AMsMyM4IILkCl/ne3dfUS38kRRmQSkeIIzcSbzJZVuGtWKez0ItFSrIaLMLASDGltZjm4FivoQK5xQ==
X-Received: by 2002:a05:6638:42c5:b0:375:620d:4306 with SMTP id bm5-20020a05663842c500b00375620d4306mr16796822jab.104.1667599917475;
        Fri, 04 Nov 2022 15:11:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a928e01000000b002ffcac9d1cbsm251157ild.3.2022.11.04.15.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:11:57 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:11:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, XingXin <moweng.xx@antgroup.com>
Subject: Re: [PATCH v3 1/2] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y2WOLMC2381ktwgg@nand.local>
References: <cover.1667470481.git.dyroneteng@gmail.com>
 <de941f58f9eb7d0287fa1f7a5ffd343a22e5e46c.1667470481.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de941f58f9eb7d0287fa1f7a5ffd343a22e5e46c.1667470481.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 11:17:09AM +0800, Teng Long wrote:
> @@ -354,8 +354,9 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	if (bitmap_git->pack || bitmap_git->midx) {
>  		struct strbuf buf = STRBUF_INIT;
>  		get_midx_filename(&buf, midx->object_dir);
> -		/* ignore extra bitmap file; we can only handle one */
> -		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
> +		/* ignore extra midx bitmap files; we can only handle one */
> +		trace2_data_string("bitmap", the_repository,
> +				   "ignoring extra midx bitmap file", buf.buf);

This is looking good, though I think we *could* drop the comment here.
It's as redundant in the new version as it was in the old (i.e., we say
that we ignore extra bitmap files in a comment, and then issue a warning
with basically the same message).

But I don't feel strongly about it, so I think this patch is fine with
or without that comment.

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 6d693eef82..0b422c8a63 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -428,8 +428,9 @@ test_bitmap_cases () {
>  			test_line_count = 2 packs &&
>  			test_line_count = 2 bitmaps &&
>
> -			git rev-list --use-bitmap-index HEAD 2>err &&
> -			grep "ignoring extra bitmap file" err
> +			GIT_TRACE2_PERF=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&

Do we need to clean up an existing trace2.txt here? Looks like not, so
OK. Is there a reason we need GIT_TRACE2_PERF and not GIT_TRACE2_EVENT
like the rest of the tests in t5310?

> +			grep "opened bitmap" trace2.txt &&
> +			grep "ignoring extra bitmap" trace2.txt

These two look good.

Thanks,
Taylor
