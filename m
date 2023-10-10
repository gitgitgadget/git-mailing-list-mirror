Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20485CD98CC
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 23:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbjJJXre (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 19:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbjJJXrd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 19:47:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C7699
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 16:47:29 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-774141bb415so364736785a.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696981648; x=1697586448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNIVXO5aebChSrblw5Y/UQzSUhA91tpIDO3llp7x60g=;
        b=NDefbC5oW3aQ44n2dZ9fRV/DvAHUuDnqzxBdrUdUuWl+iiY3tBf34r6YCaqa8L7fdX
         U4AxmPojM4X/nNhiOMeLmas+WZ9RvYKVYIGPZnyw0ITc6xk/iN5sV1xpqlSKEgOTtrsz
         /FGlm9uWVWQCnlny48QUB9ZmjUA6dCXFfFtKJ4JVZfpswBMZnE5AYufqlG6IvXucsNx7
         jjMOxD9YTuacrCWcV81W0eu1xvfuvsDyYna/bP+7YhwbtrOSUukVdn1uGFTIJ8ZjwxQl
         GGJoYKABSsRUcp1a31y02vQVnhpHccQoYOZUx6Ljype3ysBsXnmzlJap7xOMDkQ1RmH0
         epoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696981648; x=1697586448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNIVXO5aebChSrblw5Y/UQzSUhA91tpIDO3llp7x60g=;
        b=IyP4eLRCVWlWq2aSFB7ijfENC9S02aXpeYL4wVgkRNVgUIsMDrJug/b7od7KRMOOGT
         s/2Qc+gySMRIcqI7EuimC8zVSFSNCPNN5C7YW/pfLntDbF9U8UECfLn+bLRGQoFEkqnz
         MOOkYIlRzDDUIkCu29hWXHGDEqqEZ74l9bU03XgIiJauyObZ/v31aIsCe/zO5qx3uALK
         qgMbNiH8l8KcMdwlZ4tAb0JMqjqTne/8gTIuV76fhpE6ANYUhJ4cx0LVTwrwRvgzRu2G
         9M2asSdHZfAMcARAmIsJbVVX9OZvn8B2tVvMlEj+/8V3JH6eIIecX1+di1aMz9FLBRFE
         2hRA==
X-Gm-Message-State: AOJu0YzDflXHUdEct3PwFxs+FzOXaM73UZ/UlCHFOKSqaUtLr4MQ6IER
        1d1vdvo/4GCftOmmSqWwYyE2N91vXGovml+A61SX1g==
X-Google-Smtp-Source: AGHT+IFlRO1FAlOW8mGvg/posvKzkwXKcGHtlglmS2NFZFBxa6mU87+fl023LJzfIpPzjbd6WwMGsw==
X-Received: by 2002:a05:620a:1a86:b0:773:ae67:4b96 with SMTP id bl6-20020a05620a1a8600b00773ae674b96mr22726827qkb.53.1696981648324;
        Tue, 10 Oct 2023 16:47:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id vv11-20020a05620a562b00b0076ceb5eb309sm4741290qkn.74.2023.10.10.16.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:47:27 -0700 (PDT)
Date:   Tue, 10 Oct 2023 19:47:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/20] t: add library for munging chunk-format files
Message-ID: <ZSXijWNVCyO7FelP@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205838.GB3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205838.GB3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 04:58:38PM -0400, Jeff King wrote:
> ---
>  t/lib-chunk.sh                    | 17 ++++++++
>  t/lib-chunk/corrupt-chunk-file.pl | 66 +++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 t/lib-chunk.sh
>  create mode 100644 t/lib-chunk/corrupt-chunk-file.pl

I can't claim to be a competent reviewer for the Perl portions of this
patch. But I agree with the goal and am glad to see us getting away from
the brittle implementation that we have been living with in the test
suite.

Thanks,
Taylor
