Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A81C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 01:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbiFHBVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444494AbiFHBBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 21:01:51 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E939C11B
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:56:12 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id cv1so13165533qvb.5
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VyyGQe+pl8q/XbAEfoRlK27+ViQfikXnKZyy2zXKGC0=;
        b=MCEvFwOYDKBPM+5r8o0lDWmX1kWobMT0N2RxGmcY+GQj7QFFT7doTlC4Hp0vNpgX12
         O0QZ9OK6bD12gBi3g13ZKb/MIMMOsD+GmF5v8BJ6pGdtuGiR/4eNJk4e33XVKjIHYOUg
         OtVw0a61ruQUuiM3R4ZZlJZJDDrtIFGlp0hY+Zv+h7xGlDXzY4OL1C+Q+NKIzaDHtY/z
         W16hKnwhxbvFVt0pBJYU1Kcxka7PKX0e0dwIhunfghV1ofnGhM/yRICg4exWDVzl+VVe
         PtDgTSJU34FWf2BZkmoXkQ/3rf0oLUA/+T1HaiqiYfYI9VwF3y44u/rwgscim81COcyO
         6M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VyyGQe+pl8q/XbAEfoRlK27+ViQfikXnKZyy2zXKGC0=;
        b=jsbh7gaM8Fsquow5Jak/rULS6z0y9/1lpl/rpWsBG6wiaLeZjl6HR3h/4IcHjinHM8
         aUS9d2I58JhRV4zrwttnqNz+GOJVA6QKvbu9IrgBg1Qb8YFNi1fNyob0p+wlzMvIIY25
         Db50FAuXf1lYG7STM8gz9uAtbb3yONH8iq7pirzxPwR9YZg6v/gT8bEL7ojCemi2J01Q
         /z5gCdlyit0CMFLqaRtCrrgXB9wHP1tUNGQpz5zYPq28RYRl0+sGvLReKoCBP43SQM0Z
         Ctj7jjFHbF7cAObNVIJF/cjISFqMdo/u6DKZc4nXFAxIvFPn8P3XBoH8xrjDl5OQePO7
         0/Lw==
X-Gm-Message-State: AOAM531r2TX2WpxUvZdsRuD0Eyu02PuowVAmhvt2ygjC4FIF4/sElvVH
        t0LjfdpiMdc22MdSrKS1NyU4gw==
X-Google-Smtp-Source: ABdhPJw42zRQgb9//5SUAIUzGiF3auO7Kuu5hHtptQXykhVdjb7yNO8yZxRECh3hyCoLBFRTmt16+Q==
X-Received: by 2002:a05:6214:1948:b0:464:4c88:dafa with SMTP id q8-20020a056214194800b004644c88dafamr37954032qvk.12.1654635370451;
        Tue, 07 Jun 2022 13:56:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bq33-20020a05620a46a100b006a649e42962sm15232976qkb.70.2022.06.07.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:56:09 -0700 (PDT)
Date:   Tue, 7 Jun 2022 16:56:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 3/3] bitmap-format.txt: add information for trailing
 checksum
Message-ID: <Yp+7aXdaCX3Fh9SE@nand.local>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
 <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
 <2171d31fb2b783371bdc31ba54856dea8224de65.1654623814.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2171d31fb2b783371bdc31ba54856dea8224de65.1654623814.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 05:43:34PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Bitmap file has a trailing checksum at the end of the file. However
> there is no information in the bitmap-format documentation about it.
>
> Add a trailer section to include the trailing checksum info in the
> `Documentation/technical/bitmap-format.txt` file.
>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/technical/bitmap-format.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> index f22669b5916..a43d2fe2bbf 100644
> --- a/Documentation/technical/bitmap-format.txt
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -125,6 +125,10 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>
>  		** The compressed bitmap itself, see Appendix A.
>
> +	* TRAILER:
> +
> +		Index checksum of the above contents. It is a 20-byte SHA1 checksum.
> +

I assume by "Index checksum" you are referring to a checksum of the
bitmap _index_'s contents. That term is used a little throughout
pack-format.txt, but it's foreign to me. Assuming that's how you meant
it, a more conventional term (I think) would be just "trailing
checksum".

It is also not guaranteed to be a SHA-1 checksum, if the repository
which wrote the bitmap is in SHA-256 mode. So I would suggest that this
addition just read:

    * TRAILER:

      Trailing checksum of the preceding contents.

Thanks,
Taylor
