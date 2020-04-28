Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F7C83002
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DED2070B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxeVtWQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgD1Ayf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbgD1Aye (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 20:54:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92508C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:54:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j7so9476295pgj.13
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hvtDEAXba/45spe++QdCT9L5+GSTnbuaUBoE9BM7jw8=;
        b=sxeVtWQ+/Tnd3/z4xTb+kynA5LKolJd4XZuPRso+OMapUIU+/yW5P0BlDfEQn1ZhMI
         WT2KAX28fw0Pkq+/YTAr7zLdi87IzHxsfYPBjfHvmUFbu2rOV9y8xLnF/nICbdlh6aYz
         UxIRhnzLq6q5/VlMcAM3R+NG6t2R5HlJDz4KT9CACpY5v6mdatUCgjCTUkXBsTmdUMYh
         Epr5OewX5xiwpiZ7h41XmwD3U8O4J1Ik996MFBNk71fmYJKKWPM1LGa8uUZhvbCo4HQx
         +K8DMA3JuaniR0Uu8ks9tuqS3LEyE/BGGSVwG7aDKC0w/o04j07BSGLNqDHd5cgfJUBN
         sC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hvtDEAXba/45spe++QdCT9L5+GSTnbuaUBoE9BM7jw8=;
        b=mWYdkDeCpxFPbSQzAmFXfHcGj+9Y75tocrpxx2pFh3NWdjY5RwCR+wzz0UEzufT1nA
         40FmiugXAVxDUaWJH5+Tqhw3SCNNUHEUHqrbZVJF6+spWSLGbnBsc46hxITOY6uFwLlr
         tNtBXwKi+cb5eF9HCr5tBYUZH65oHsFgNDxmUj/WwKnF07PnrbXemCnx05p8NpKkkdiU
         ZbCuN7biuWxN4+NfatApcGbF9VjKZW251/0MQmZzeO9UKTu785242q14HRSTpcXMhwC4
         /282MgX/LyktiJW0rq4OoVILkq5N0TV89jMaVrG43XDxTXM3maOx07Tsa4wHjjxWvhYp
         0lFQ==
X-Gm-Message-State: AGi0PuYIO3WyLT87mfpDHoSMTTQvkhLbiCtZb3wmmmNqgrUnQwK3Nilz
        EELEgTI7OMsqiUcrSv4iNUVJHMoR
X-Google-Smtp-Source: APiQypKLTA7OALMR/hKZWN/9HwriB26SynUbXS7T5nNLiMboj/bHpsKoszO0oQ/7tvXGrTbEgtFgRA==
X-Received: by 2002:a63:3687:: with SMTP id d129mr25007914pga.67.1588035274098;
        Mon, 27 Apr 2020 17:54:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id p189sm13845392pfp.135.2020.04.27.17.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 17:54:33 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:54:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/3] fetch-pack: in protocol v2, in_vain only after ACK
Message-ID: <20200428005431.GF36078@google.com>
References: <cover.1587775989.git.jonathantanmy@google.com>
 <cover.1588031728.git.jonathantanmy@google.com>
 <eb18faea2d00d9b09d3fcc79646cc7556023c258.1588031728.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb18faea2d00d9b09d3fcc79646cc7556023c258.1588031728.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c          | 13 +++++++++----
>  t/t5500-fetch-pack.sh | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
