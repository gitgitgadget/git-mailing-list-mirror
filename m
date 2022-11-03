Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FFBC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKCA02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKCA01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:26:27 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484DB1C7
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:26:27 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h206so155878iof.10
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NxK0fhn1RaWDLamRX+Vl8jBdRVUzO3OLrOyva+NDkA=;
        b=I+p36iXGTuZgUNPMTl0BfmlmCWGLTLiAm9vNHaG1OH23wZ3eREy4R8zZcgBpHbTERB
         Q/2n7z6b3GWfkweLN+h+LQdDcw311G8Ym3mi+RELjpjiueGcGD3NoN5xgzVkjm99Mikj
         2bdtAkMOaWQBaIVX+g2oJd5y1XivevBb3y8pvSVD9unQHIegJKpi5eWBHg0aT02cn8Ja
         jcOOwZ28mZWu88ONuFJYwbaZrPU8MOQ68Y96tFvDCzGKzxX/s5sE2LnOUZGr/laN0PHv
         gnoYoGZIV3Pv86LOf8fmrv5E1LsdocZOP3ElkB5c+87xI/CMW1kJIgyAmq58DRSUVguA
         KbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NxK0fhn1RaWDLamRX+Vl8jBdRVUzO3OLrOyva+NDkA=;
        b=5DLT5II7M7TiES4gREGixhIln7Ue8IwBLgF7pSPDwIsTouEqle6VP0TdbLZhDbHKJW
         Ongd7ID02iBzmhjVm67Dht4G2SnkfE72I2cPbNWbvSk+lL44TbtyUmE9AhFJkKN0LfCP
         P7j8Q4ClvnG7TV+UB/evSLGgl1VuR+YUgLtKLHKSijPAoylpiA1uF8XgE90N9ca+6h2o
         UxevpRUYo1AgU1NGS8eQkT3t80gozVUjlXfwJwTtqfZYWi7uo+svNuiuYaZqxJ64i6rJ
         WYxcUOyBGnH1JIJTmdjPT5MGVNSC4SVLh7H1qVlu4pSOZXuAkclQ1dKnQdIsXx427Z3L
         W2XQ==
X-Gm-Message-State: ACrzQf3Bb7dMT90ZuAdZ7e3wk5qYxej6zDq1u/XoK6b0DYO8EtKGsa+X
        +dX3Pow3XeVBCfB8p3i1SEzPzg==
X-Google-Smtp-Source: AMsMyM6ElI/8qcYHWNyhS8hsyYlfEK5pCOXti18GTv+kWq2TQqFpEwGbXfx8yLIx7VCzjXFX4BIO9w==
X-Received: by 2002:a02:ad11:0:b0:375:767f:e53f with SMTP id s17-20020a02ad11000000b00375767fe53fmr6438818jan.318.1667435185349;
        Wed, 02 Nov 2022 17:26:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a24-20020a027a18000000b0036348f096acsm5388961jac.6.2022.11.02.17.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:26:24 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:26:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "L. E. Segovia" <amy@amyspark.me>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [BUG] git format-patch incorrectly follows the mailmap when used
 with --cover-letter
Message-ID: <Y2MKr2Yga/o1sjun@nand.local>
References: <cb90779b-edb0-1911-c8bd-a6c56203a201@amyspark.me>
 <Y2MGyM3O7ljEZ4Hm@nand.local>
 <527f8050-7955-50b1-304c-617703cf99e6@amyspark.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <527f8050-7955-50b1-304c-617703cf99e6@amyspark.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 09:21:12PM -0300, L. E. Segovia wrote:
> Hey,
>
> The shortlog in the cover letter follows the active mailmap (incorrectly).

You say "incorrectly", but this is subjective, no?

I imagine that most (?) users of format-patch do want to respect the
mailmap when generating a shortlog. In fact, the 'git shortlog' builtin
doesn't even have a `--[no-]mailmap` option, either.

> The letter itself (From: header), as well as the patches, are attributed
> correctly.

OK.

Thanks,
Taylor
