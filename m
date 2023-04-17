Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE325C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 22:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDQWwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDQWwl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 18:52:41 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28FF2D79
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:52:35 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n193so5135706ybf.12
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681771955; x=1684363955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPoKoTQsD9snXzILQD0cVbH7l5x0TOf4PAMIYXMjloo=;
        b=SB3A+X8pUXVvh2wgRF4JzB+DL2X8cOpQIgeSAT0CfqRlyL205ku4QYzDGIOfV/d302
         d3FuTY9avM0sAC+rogpnbo/bQTskh7U9u6FJwQyaM+132f/jtozL13tNR3gt/JuZ9Qrq
         /IhovXAxOOgzIzHJY1zE52Z+NiAw/57KU10DxIvBhBlV21708lMKZ/BmR1lkyrIMrB7y
         wsNt1d4kOHkmSbXq6ai61cQIwpJcgvKiRUuLOLV4D5Exz6aao7nj5agHz8Dz3pm9Obtq
         yEWi2I2XeVbupzm1+rbgJ5jU6Je+SoV/QzpV8YZFxLe3k4LV6xnGTt/VXezL4j4rhhrN
         T6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681771955; x=1684363955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPoKoTQsD9snXzILQD0cVbH7l5x0TOf4PAMIYXMjloo=;
        b=VVBCRr6y1s+T341FwaL/gdat41/ekfbcwk+u/PzW39kXZXR0bG8R01rcLneAdmweMi
         m9KMn7XEoVqrvQRDyGay8PlBZN0Yl6OHl81Nhm1YFFSXvWDPP0qk6NhKCp0erWuBl6lX
         0PURKFG6ccTKnB1rbZDy//nFN+sEhsF8lWcp0oOYuXuFP2DSCOGxk+LEV4+0w1m+tDuQ
         7EsHuK1BRVmXxfgilB6jgkFp1WkFfxzcTWQCqAUAWWXZ3zHwLQPPQirPNK/RRu9v0GzR
         5wHzUptSusSkXKVWs1NKsVcE4gPrs3e+pZil8q0q0CFNUg2fNss4hM47tFRllsXpD9Cc
         DlRQ==
X-Gm-Message-State: AAQBX9fqRT9M3TcAHM6qjfmdw8G+BMXliSmg/D8T6sCI2uVSpAF13Cz0
        a+lQJeFxnb1xoddB795iBYAPJw==
X-Google-Smtp-Source: AKy350YjMUuzTclSIycopbn8FGFqGVNGXNWD8KlRxZwffMmvE7NoL9Ctj9gYpsEtAmZAf1bAcbS9wQ==
X-Received: by 2002:a25:dca:0:b0:b8f:1841:8135 with SMTP id 193-20020a250dca000000b00b8f18418135mr14956726ybn.18.1681771954967;
        Mon, 17 Apr 2023 15:52:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j189-20020a25d2c6000000b00b8f871e917fsm2460987ybg.11.2023.04.17.15.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 15:52:34 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:52:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/4] fsck: check rev-index position values
Message-ID: <ZD3NscowbkXizxCv@nand.local>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <adbe9c8ee90e087e864bd9e0c67338974b5dbc8d.1681748502.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adbe9c8ee90e087e864bd9e0c67338974b5dbc8d.1681748502.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:21:40PM +0000, Derrick Stolee via GitGitGadget wrote:
> +	for (size_t i = 0; i < p->num_objects; i++) {
> +		uint32_t nr = p->revindex[i].nr;
> +		uint32_t rev_val = get_be32(p->revindex_data + i);
> +
> +		if (nr != rev_val) {
> +			error(_("invalid rev-index position at %"PRIu64": %"PRIu32" != %"PRIu32""),
> +			      (uint64_t)i, nr, rev_val);
> +			res = -1;
> +		}
> +	}
> +
> +	return res;

Very clever.

I thought about it for a while, and I am pretty confident that this is
the cleanest you can get this loop to be. You could do something like
building the forward index out of inverting the values in the .rev file,
but everything I came up with based on that ended up being circular and
not demonstrating anything interesting at all.

Thanks,
Taylor
