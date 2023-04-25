Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224CC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjDYSsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjDYSsv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:48:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F316F27
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:48:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54f9e41dfa7so45244777b3.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682448530; x=1685040530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBfUE6VUrSzdaDdF2GSfMYvUUsUde3tb/ie7gqDhWcQ=;
        b=N4VuX0hUOk/ZIu7gmbFOQjmHOPkVQYNO1AhLS3oVYnE0AltHg+gehtbeJbo2muzWei
         Y6bjwlW2yqBNSIWz8XfJ7Np6qN3zIVismDAj4ztdHsu2pFFmv9e1Gn/ad1J9AwfumyOA
         TBiaJL8P5QNuwktcJoTjZP26lvRx6tINHJN0g3jKBwSjWeEBaipC83DDm9R5CFiEal71
         ie2v403+onZhuKPQYw+GeRPbFvtVC1QjRjVewcIdWxeO2Wblvjl/uGi5IYt7uCqz/jtQ
         ardfq13Z0Gkp/4d0swowcNyCVt0FZSQYRRU7QjWvuFNulqg4Wk0xQ6coTNRaOqRiSJCe
         U/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448530; x=1685040530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBfUE6VUrSzdaDdF2GSfMYvUUsUde3tb/ie7gqDhWcQ=;
        b=D+mtGkbRP/AxPBL59hlozol/YsbEoKH2jQZ8sDhjbkuDCkKX+F3Z2O4mEIiOk+RnO2
         MANgdQzEUdIWl5C37xvNzWM0fEUquCA/Df0iIgMO7XkxDB0LtxM9WOpwt9zU6c3TuINH
         FakWP/DpE9lZEsAdQ7lm1HWObm3m8xo7vHNTXejq7th2CbLDAyXovkOSm3m42BgH6L8y
         26vGz2eWxlptVBLoZ+ty679eqRBR012CNyJ954m99T3X1KSiY83N1RnQBwzMjL1I4YIQ
         Jh2Mp7hpGWXmcMKn8qmWhEAxtxj+wg99HB2+/OgzGkS2kUDSRt9syVFNBZjqv5VDxI4e
         3hAw==
X-Gm-Message-State: AAQBX9cTvK7XWe8AhjcNxE57zE85j220G9z0hNDLvyi1XA0ComDGkZqm
        9TmHUkphhmArBE0h/pVhWrSsww==
X-Google-Smtp-Source: AKy350YGpvhZuKb6uuaM3UN2gQZwAekS+6Jg7DE699Tgf8fqMNr9RjyXzJj/5b9kxkdsiSdvzG4jkw==
X-Received: by 2002:a0d:cad5:0:b0:552:9ec8:eb3f with SMTP id m204-20020a0dcad5000000b005529ec8eb3fmr12384110ywd.7.1682448529949;
        Tue, 25 Apr 2023 11:48:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t190-20020a8183c7000000b0054c26b34e8bsm3673936ywf.144.2023.04.25.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:48:49 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:48:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
Message-ID: <ZEggkPQRCvZ7FcJP@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
 <xmqqsfcnzuse.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfcnzuse.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 11:22:25AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> Or am I wrong to understand that the idea is to collect all
> UNINTERESTING commits?

The idea is to collect UNINTERESTING commits between the tips and their
commit boundary. This field should probably be renamed to indicate that.

Thanks,
Taylor
