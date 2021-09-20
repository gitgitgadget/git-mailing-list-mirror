Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B551EC4332F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920D161278
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347869AbhIUCWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbhIUBuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5996C07E5E0
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:18:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 134so701409iou.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t5bLshPUYMZePHz/Z/qolKwF9hEIrMsfKQrBdnnWDwI=;
        b=ZlgNv9zP7AtCvXLyn37jZte2q5YnOGfOfcmMKa5Dqi/fPFp8V7aXAAfXOImTyiMlR9
         pglrQ/I0daIkOnB1iaKGnkD2ls6+aHQBVgSYcHFZLotATBC4kW+CHKb8u2nZy0OaK8Io
         K3w2n5O4QgakDrRH8ztIvv5tyIoHcpM3b6hTM3XNUBeZHbKKk+c7obsOdr2AxXNH7ZmE
         36gveqNJ5zZjdAFZof8z+A+ZD+rQiZxjPUpe+J5LAOv6RpA0kuXDqvQN0IueYKEproo0
         EwgfB24Q8UMVNDa0kBsevc9nFukXYBoRcCTcYNvErb2ubgojed2sEjDlSf07mfj/7bj7
         lYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t5bLshPUYMZePHz/Z/qolKwF9hEIrMsfKQrBdnnWDwI=;
        b=I9zHc//ji8759t8ClOLcxfiJZCnBQNfefoXYHWvX/gOJ/BPi0YyQWuPy06ZHEJdN/M
         UXncFlTsYtfVQwfofAS6w9lCLbnRTD+pnLThZ9Y87EZdr/x9cM6Ho8eHwF4Zyi9On8h2
         3YnG9gtF/DbhVZjv8tSbQIm61jvqTViMR92LmUWeGDy8wd0igu+TZX6EMwAokWAC//dL
         H1voSNsURYhRjb007rK0MQjLKYzfcOEzYIYv34dyF3zt0//pJXSz23XLxHkyOp6AhZgc
         f0XQLK5U8H/+O77yPVB5DKJaO38CojO+IZFsvW9Tv6zXslSoPa+Upi0d53muwS/EdCmE
         SjkQ==
X-Gm-Message-State: AOAM533XDnZigxAiou1bfTpGFVd9u9s2/W970+calIiWQ+0j+Q6y5Vcc
        OpAKjZ/lJlKp8UP/cjy7mybLvA==
X-Google-Smtp-Source: ABdhPJxkIB9mD6l7SJQcGmBxhr660g7Pq07AP2YxDTsjI9/cVzRJZlyVdWA8F8x7Fomfi/5PC+qJ+Q==
X-Received: by 2002:a05:6638:168a:: with SMTP id f10mr4316166jat.100.1632176338361;
        Mon, 20 Sep 2021 15:18:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s18sm9505156iov.53.2021.09.20.15.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:18:58 -0700 (PDT)
Date:   Mon, 20 Sep 2021 18:18:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/5] repo-settings.c: simplify the setup
Message-ID: <YUkI0XieMJbzqlTT@nand.local>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-4.5-28286a61162-20210919T084703Z-avarab@gmail.com>
 <ddf328f2-30cf-2881-c61f-0698d499ac39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddf328f2-30cf-2881-c61f-0698d499ac39@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 08:42:37AM -0400, Derrick Stolee wrote:
> On 9/19/2021 4:47 AM, Ævar Arnfjörð Bjarmason wrote:
> > Simplify the setup code in repo-settings.c in various ways, making the
> > code shorter, easier to read, and requiring fewer hacks to do the same
> > thing as it did before:
>
> Popping in here to say that I agree this new arrangement is cleaner.

Agreed; I couldn't spot anything in the post-image that wasn't an
improvement in one way or another.

Thanks,
Taylor
