Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67468C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 21:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbiEKVbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 17:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344673AbiEKVbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 17:31:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC6579AA
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:31:10 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c8so3027215qvh.10
        for <git@vger.kernel.org>; Wed, 11 May 2022 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XP2mUhmZt70oo80brXxkcZiwKjKqYJNq9U6Q5kXHsjo=;
        b=6v6P+gv02cAkkp6u6NTVrBvb5ZtdVLDOBWW+ZOUQAUQbKhh8/C1sg5YKWsARsUTsEF
         qnBo65m3z1ivavKGpv430DV8QRyU0gscwCncyVD/nIccO/v/NA6TDlFWFTwcahxOWv9x
         VsdLQi660UIaX7IdBM3mGUXXoQIVp6YWNqegYTO9eTNOlRo570bkv2/X9fx7wITf2dfP
         mHT4gIo7gHMrxzXTEE3N56rJ8KG+4V2fas0hkcZVqFCybCvZ74jkEY0mc9W5vBhsNtG8
         0hMko5lyY5viWTYWQW2SEovfD8/qd7VOwbQ00EBIzrdl7w8+xmd81SkBuNXsFFu4DmJP
         MH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XP2mUhmZt70oo80brXxkcZiwKjKqYJNq9U6Q5kXHsjo=;
        b=p5xmaq5MzeOcqWAOJst3DuBZR1Mj8u4W1ZoW30XGqWmhHnECje1rTrRI0fHCEoPMne
         wQ7cZZBHPNPoyjUsqzuXuOluYqLYJ7tw77FGZVikugaqiyXtN3gcKhKpZ4QcFpIXIm9V
         w3zYSqU8MrNsGMbHqzkS14lGNF9FRjjkI+rDJX+JVYhnbHkez3atYfooeKTHIQlIeVGJ
         ucSVSDqpdjqccvRX9C+0HHKn0Sm7Ba6tW88ml2NhAuO7k2KNNmFID0tu2BGwoTA5+ZIk
         sNZfBi6ac+JXx9YX+hZUhw67GPh3UjyJG78ZoMbN3ShKrevDDDI0dbI5oYgOEj2SJrjJ
         6UiA==
X-Gm-Message-State: AOAM533q3ervy1el8wyAbzkR2bD/wTmNJMVrjL+4YiqauAKP1AmaZOtQ
        4zqGfEK92ya8johjxzIFntSq5YlUEn8I+skX
X-Google-Smtp-Source: ABdhPJyAEYgAu3ucruwALAK9FCHJOuT1Nt6xc+9Kw1MQCI5ZhzMQY/yF3VWBkw/YnQkxgv9YBw5OdA==
X-Received: by 2002:a05:6214:21af:b0:45b:ab2:6cf7 with SMTP id t15-20020a05621421af00b0045b0ab26cf7mr15585682qvc.0.1652304669995;
        Wed, 11 May 2022 14:31:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 10-20020a05620a078a00b0069fc167df92sm1809207qka.82.2022.05.11.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:31:09 -0700 (PDT)
Date:   Wed, 11 May 2022 17:31:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: Re: [PATCH v2 1/5] pack-bitmap.c: continue looping when first MIDX
 bitmap is found
Message-ID: <YnwrHHPregT5wCH1@nand.local>
References: <cover.1650547400.git.dyroneteng@gmail.com>
 <1bfd2fb6ab01af689fc6495e2f32d3f64c19f4b7.1650547400.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bfd2fb6ab01af689fc6495e2f32d3f64c19f4b7.1650547400.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 09:26:36PM +0800, Teng Long wrote:
> In "open_midx_bitmap()", we do a loop with the MIDX(es) in repo, when
> the first one has been found, then will break out by a "return"
> directly.
>
> But actually, it's better to don't stop the loop until we have visited

s/don't stop/continue

> both the MIDX in our repository, as well as any alternates (along with
> _their_ alternates, recursively).
>
> The discussion link of community:
>
>   https://public-inbox.org/git/YjzCTLLDCby+kJrZ@nand.local/

In the future, it is often worth summarizing the discussion, optionally
linking off to the list archive. In this case, I wouldn't mind a little
more detail beyond "it's better to [continue] the loop until ...".

In particular, you say it's better without saying why that is the case.
The link to <YjzCTLLDCby+kJrZ@nand.local> explains, but this commit
message as-is leaves out some details that are important IMHO.

> ---
>  pack-bitmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

The actual changes look good to me.

Thanks,
Taylor
