Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6267C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 00:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKEAN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKEANZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 20:13:25 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514845FF6
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 17:13:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id m15so3392191ilq.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3prfzC9wYzh/OTtFaqrhz6+IoQ+Dh2GhJ0wh1zIg4E=;
        b=BCDK3YGceENT2yNWmxl21iwZjjAFgUlbnZEsdCmDx/BlXG7wqkUS19NnvB6EiuXjmW
         Icwmqa02amzNlX19m1UWhJrvZSQle8lQ0Pcnq+/v7gNUrFHko3dWaQrEr5epcMJcf88U
         bgUbR6K3vDrm/VvJv/fF/c06GqTL3PhaP/CXnqyi9lKB0WubaYp4yNjY5peRbmjGjxTW
         uSyeidTRGbiNIeEF+76Oi46DTccZJ5koqhhL19FyrQRFkZWQ50mHP5VP0jN1khhqJiZ3
         NUcsEy5y+KkHHrnMGjg+oLswe281mfKmTiTGa5eafBKi+LA2Hlj4DvWjUij/BsWvhARi
         5GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3prfzC9wYzh/OTtFaqrhz6+IoQ+Dh2GhJ0wh1zIg4E=;
        b=qS781421QrxQgS60W0zj/Ia1FYe42YVITGg9WK047WS/BDb1Ke+lVFhExht6ya0yGi
         eyCJRsxGHHPraDbdZAOx/eUFzZ1DLSh3+2u1inO/8rhGlvQA44aB4FtcPzPXoCWkK0cI
         cUGPTD3iXbJM8w0s2a+ydnDutB0ejzjBQ/6j2wey88i1E+bt3sFSMj8/7ATtNNDlmNnx
         UFlODQVydmgqahNntqsBc4xicbTSbh+zYLPyqDt5U5PSEDVzrH/7cjkMM/Rii2hqpvHN
         AKk7gOMZj5tCgdRJEMvhbu+9lqK+FzhtOMmD1OuHAimgOf0BQ6Pt2VXv9Bxp/+C5WjDS
         lMhA==
X-Gm-Message-State: ACrzQf1abe5qiVEUfrnjJdLot/ItuCXn+cXGsa5KU/xxCOK47BrIQH9Y
        urzfTika1/2XJA6KQl2ks+lc0Q==
X-Google-Smtp-Source: AMsMyM5fMzZwOzrVVPHZDzWjx1d8ans1hxmVj+/S5VPrj1nocfA2sIxVQtKCVKuTHweuF+UkIHYIag==
X-Received: by 2002:a05:6e02:12b4:b0:2ff:ee24:4468 with SMTP id f20-20020a056e0212b400b002ffee244468mr21851900ilr.199.1667607203644;
        Fri, 04 Nov 2022 17:13:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u7-20020a92da87000000b003007aba03c0sm309388iln.66.2022.11.04.17.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:13:22 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:13:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/13] bisect: v2.30.0 "run" regressions + make it
 built-in
Message-ID: <Y2WqoQ4opWoMHTiu@nand.local>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 02:22:37PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This fixes the regression Lukáš Doktor reported in [1], and also gets
> us the full way to a builtin/bisect.c and "git rm git-bisect.sh".

Can you and Đoàn work together to find a way that your two series can
work together? Reading both, this is definitely a "one or the other"
situation currently, and I would much rather pick up a more targeted fix
in the short-term.

Thanks,
Taylor
