Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8284C41513
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 18:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjHBSM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjHBSM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 14:12:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE71724
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 11:12:27 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58688a0adbbso393257b3.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690999946; x=1691604746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGLbAPR1Ctl00gU01GIMo1zeriPBpUk9wVVLr3TREJs=;
        b=UUuHgJVmfAFQexFXoQwIFMZdMnH8DvjTwdYR5lD4d4mx2nMEneabSwgbaopLbamPo+
         8rlWn4FPyHc2955tJFITwtd0RWUz8bY/SA+fC0TCIUdZvCtmfErgQDj+sbHTfjV5DbZy
         +XiLZZCHnU/xPGUMAQqVld3VcCoXI7up/tehoJhcY4hNcqQsQ/Wd8oGMldzci4oHrGmT
         1NqNvAYkxYbbC13so6xwYZLmRFUkBhZPFw7q6L1fHw1Gvwum4lwVXgwBPXE9iKSBYMht
         Omr7fw5UylPhji2qo5P/A9SrPjaJbkPASYNADIrBnETZtG7ACUx58u5sK8n2dQVBd/II
         uDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999946; x=1691604746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGLbAPR1Ctl00gU01GIMo1zeriPBpUk9wVVLr3TREJs=;
        b=aym48KJHM1rFclL5OEi90E/t5fWQ40Q59oi1+BbAxYwm2la0vKgXMM2tPaGQR+qBJt
         sKvpDow7BgsSDjBLx+6m7NGddN5NHk12dqRLeFNwGhJwuCNNku9oaaO+G7Rhy5mHfjML
         zt7ylET/PB2kve/clPrL02kitFVrev+2ElxHgE/ZldIfynRNLtOH+pMCqVf144wCf6Yo
         OMMrCWh6X9gDjAUqCDttYBAZrRFlWBJ6xJC6oV8LAk2N8IChLctbYdNMQtKyg+wrwVtI
         POYdC/Ql/qN4+C2y11N610iLx3Wy1/Jja2oZKrY9gw1Oi3LCYUyoLx218ix7a8uh/2OV
         T4Aw==
X-Gm-Message-State: ABy/qLZAhk49ws1Uvtp8GD0bj+6glBtESGqO2UkGRaPOjfBpVxXllg0z
        +/H/HYksiT5ymdEsszvBfzeARYS7P7AhQeUaXXHpbg==
X-Google-Smtp-Source: APBJJlGROXoP9Hac4mmy+nHOPqWVasSq+GVY9vZjP4WmNz/0zdpTAuuWihGlCZYRq65YXD84gLN+gQ==
X-Received: by 2002:a81:7487:0:b0:586:563:e616 with SMTP id p129-20020a817487000000b005860563e616mr12391521ywc.40.1690999946469;
        Wed, 02 Aug 2023 11:12:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b00583b40d907esm4809264ywe.16.2023.08.02.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 11:12:26 -0700 (PDT)
Date:   Wed, 2 Aug 2023 14:12:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Yucheng Zhou <zhouyucheng98@outlook.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature request for shorter relative date format in log
Message-ID: <ZMqciat7tdbYGob8@nand.local>
References: <ME3P282MB2274D11DC15DF1FDBBC36C3DBE0BA@ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ME3P282MB2274D11DC15DF1FDBBC36C3DBE0BA@ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2023 at 02:07:16PM +0800, Yucheng Zhou wrote:
> Hello there,
>
> I usually use --date=relative in git log, but I find it can be shorter
> to save more space and be more efficient.
>
> First, the trailing “ago” can be removed, because it seems every
> relative date has a trailing ago.  Second, the seconds, minutes,
> hours, days, weeks, months, and years can be shorten to a single
> letter (e.g., s, m, h, d, w, M, Y), and the suffix “s” for plural can
> also be removed in this case.  Maybe it will be better to give us a
> way to customize it, or create a new to config like
> --date=relative-short.

I can't think of a way that this is possible to do currently.

You can customize the format of absolute dates by using
`--date=format:xyz' where xyz is passed as an argument to the system's
strftime() implementation.

But we don't have a way for users to provide custom over relative dates.
Perhaps we should?

Thanks,
Taylor
