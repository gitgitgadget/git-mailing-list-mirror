Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF36C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhL1Qd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhL1Qd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:33:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B17C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:33:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so13044111wmj.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9RxTl2Q7vMrxHVgHez4EHNO84n09i1iu/yRoQumyxb0=;
        b=RcK2Os2PnKm9VSptADO8xtAkk2t4RzIZENtGh3K9Le+dCYIR5OfBa4tcjYq7q5Fi/E
         m/qW+fJnsKuu2KSXCDgC5mCL/5T0TA02TrkPAipLIo7l/nT+abyksWhmulm0lrg8J/Y4
         M1b7k9l12B6Fb0eV0Vw167j3rAej0k3mRTjHtL+/mDVTM2/iEwAy803tZMoLYztaxaIm
         4SOqNhRhEsYbMCD48DwhD34o/q05ZMoEZ2nKmfNu8YOWaBZ5+utwVVXYv/MRFuUjdnU/
         oDM9WQmAfznLnul2blMnXkExsXoVD5UoaATN4NdozX+4h2pTkbB4jNXgPm+s5he7X2in
         kD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9RxTl2Q7vMrxHVgHez4EHNO84n09i1iu/yRoQumyxb0=;
        b=0G3xTM1o069VxEiUfNhE02uvIlG8XEAvOX6DLoQHal9henTI8sA3mbV6NMTL4WQ35R
         qANelrqIaOe1B035JO4Pz4beVU7tOSCWxAGh6HfIWVxHO45AXxXQ3KTo2AWGiFm8aoqX
         M7+7pc2lfjVZ60por/oh+8W2W+x8dAcWOhfRWRhiTU2X7M+rxJ4zVUzIf9K7Ph8KBgWH
         2ywGcHmuudWtR0fdtzhp+2q4MWhA6sNJOHThJsoyHaf0LiU4miEr7FhiDpIF+l5FsJMC
         AIy9VQ6DqRcuxGEKantbYz5FPgU/PrJpvVMmS/sY6fqHjo+pm3ugUWyW49mAg2TMK4Aw
         QOqw==
X-Gm-Message-State: AOAM531mSIUueLpGUiv6Mf0EqSuThLbtF/qAcKQgqM7T14yUlhpBsegh
        CDhUfjvJ82xoBAzI1PpY9j0nQUjjCWK+Dw==
X-Google-Smtp-Source: ABdhPJycNGuyrUn2Bsn9+iduuTNmPxCj5AxLymnmciowQrhYLgscd0KVpKR0xCtX11Sd26GJ77jjkw==
X-Received: by 2002:a1c:20c2:: with SMTP id g185mr17982223wmg.115.1640709207077;
        Tue, 28 Dec 2021 08:33:27 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id k19sm21123527wmo.29.2021.12.28.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:33:26 -0800 (PST)
Date:   Tue, 28 Dec 2021 17:33:24 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v8 4/7] progress.c tests: test some invalid usage
Message-ID: <20211228163324.xolh4lbsxuv4k54x@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
 <patch-v8-4.7-7c1b8b287c5-20211228T150728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v8-4.7-7c1b8b287c5-20211228T150728Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 04:19:00PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Test what happens when we "stop" without a "start", omit the "stop"
> after a "start", or try to start two concurrent progress bars. This

I think there is still no test for the two concurrent progress bars,
but you mention it here, and also in the previous patch's message,
which is misleading.
