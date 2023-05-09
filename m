Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A0C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjEIU3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIU3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:29:47 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900F40E4
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:29:46 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9dea9d0360so8401257276.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683664186; x=1686256186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chrwqOCyveQraEn11exT7WS/wtG/liKDWK/sMmbUwGk=;
        b=cdDxwprj1vvXm6wJWNcVQp4EE4ebb0vjnKXALAyGixgyIkfQg1AqONl11gFcYhn/aW
         PUhlRuixgmtgYTFIUypy2T8iqoSFWdu7DYB+itLBI56BqoHqllnJBhV4yYwurqO2Cnxe
         daqn0s6OUD/Sp0q40gvrCgXGBtwfOa3COlRSdwnl64B85ASMGsPAbHteHHSvyxlQdskK
         5/ZlFA8epV5LiQhznPMwgIYZbcclAIEfCiWTrM/Nn4kszCB6+cY2MkD+WC1E5jrzFMNC
         BeNdLYw8hMVK/6iENjTOSLU2gwwOTTC56ZDF/vlIgdLhk/0+esHu4k+iqICFw8s9XMrz
         D7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683664186; x=1686256186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chrwqOCyveQraEn11exT7WS/wtG/liKDWK/sMmbUwGk=;
        b=TBDg6hhlXxmIT00QTjTO8ALmTWZwj7GymhCnxlJP8eab8DI0qHc8T+4FXczJW8L5+J
         XgcgTJW6Rc/f9mXkMz3IjtLHYnOOz9Aw+wjL8yedxvCnCsxhxBpR9cU4fYUGqUNRO2BK
         WophGSjoXZClfF2rpi+NtMWkoXdWAglBgRau+YTtSbJWZIKhxBZnndHoefJ5IQnVMIup
         8iauXKUe6pfwYWhVb9vP0FpU0J2XZlBB2utSqG5r3p2CLHjbhDAe8xAxiJmj+uM4MWXx
         OzOodBKBZRUgUR8Uf4Eok9gMD6gyOLtrXxVc4chu4cFYVOc90tVtK/NvGf2ht4QXnqFi
         s/6g==
X-Gm-Message-State: AC+VfDyajspkPYmbPIpX3S6QWIU86dP1HHFSX/N2vjxIIDWTyyIiwFxG
        LELP+VtU1CQwpsHfnQRUQ8OUTg==
X-Google-Smtp-Source: ACHHUZ6mvlClkHZiriZEEa6XgiltgJ2PIZzw4iYlhnlGgvs80VvtCslbNo1eAQOr4dMxz+T/kFp7hA==
X-Received: by 2002:a25:3255:0:b0:b9e:849b:31e6 with SMTP id y82-20020a253255000000b00b9e849b31e6mr16632257yby.43.1683664185946;
        Tue, 09 May 2023 13:29:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f184-20020a2551c1000000b00ba07622e023sm3261392ybb.14.2023.05.09.13.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:29:45 -0700 (PDT)
Date:   Tue, 9 May 2023 16:29:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 08/15] refs/packed-backend.c: refactor
 `find_reference_location()`
Message-ID: <ZFqtOPO5MMrG60S3@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <836a5665b7df065811edc678cb8e70004f7b7c49.1683581621.git.me@ttaylorr.com>
 <xmqq5y924bt2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y924bt2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 04:56:41PM -0700, Junio C Hamano wrote:
> So, yes I can agree that this does not introduce any new bug, it is
> a mysterious no-op, and why we want to pass different values in "start"
> in future steps in order to achieve what is not explained and leaves
> the readers frustrated.

Re-reading this patch again with your review in mind, I agree that the
split is poorly placed.

I modified this patch to just extract the core routine behind a helper
function and avoided adding the "start" parameter here.

Thanks,
Taylor
