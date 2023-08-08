Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948DC41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 21:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjHHVSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbjHHVRq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 17:17:46 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A27EC3
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:13:15 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58451ecf223so65922237b3.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691525595; x=1692130395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c7kFgaX2KsLjgUbDu56DVlCNXTbxoR1icm3hpw1IibI=;
        b=B6WvBNzb/ixdhuV8wr9X/mtlRgpTHoXBT27h8G7a2i8jsbl1oFhg6RqaDzIJLrVz1X
         dmEtnEV76myj1fY9tiMPeQEPQm1H3PksMyRZMfMZsaQ0WgpTfl+EWZzl4JEbTyFv2o+p
         uJbEmxkzDJGIPFgGahm5EUO09R8nlJ6QRKh8ISRQ/Z5wRz10u6Soru7pUlBNSTTLMAa+
         PMur5rg2PMDdnHHCvbD14Ry2jxgpmqn85clXNJBudvwwrlt7XJt780y5mNeQWLZwtWFK
         2VW0W0aa9rGIaXeXsRGRnOR1KiJG27bat1NZmJ506HjIBEMsQnLoUyC71WQzGZwM1+tg
         ddPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525595; x=1692130395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7kFgaX2KsLjgUbDu56DVlCNXTbxoR1icm3hpw1IibI=;
        b=WwnL/8yXCAfnvHq4XRjpe1ZkzIG/7cWB8kztMuG4fpUHI9g98aoej4lKCrOD244G7u
         sf7Xmj2yT75K7x0krjEaru69KmaTle3isD0N4b1XW6jLxi3e6xTOWh9EN/pGa1f3A1Vh
         JxlxcJiwO3G5iNwssFm20cV0yyOQEPs/LU7gcIs7vyOOI8Fge7kYyHCtSDt7xUF2+G+e
         yEy3nnTIMa8SHooCnYnKLRrKMrdJTA1sBY8rJ3szQazW2JxjeOH2gpxCJQKN+eAxU44Y
         CwdMtjlePjbDETu7iw5qBlfeb8+E/oAKRbYETipYHiCHLaf/Ox2xhjnWhGNrSi8pnZ8K
         7g3w==
X-Gm-Message-State: AOJu0YxglubWff0k3vPTSYPDk1PyVmab+O4IWqQ/88LECPm3bvOLc1vo
        vtfDlkOyeE2ilfCI8/Eway0iTQ==
X-Google-Smtp-Source: AGHT+IHsvBWsWLISuCv1cgWjslAkWx/8jj30b1cSVPTw9UgbYCuLx3cp/wvltQ5On/d/bHRjYYNNaA==
X-Received: by 2002:a81:9283:0:b0:56d:2ad0:cb45 with SMTP id j125-20020a819283000000b0056d2ad0cb45mr800682ywg.1.1691525595119;
        Tue, 08 Aug 2023 13:13:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z133-20020a81658b000000b005772e9388cdsm3533423ywb.62.2023.08.08.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:13:14 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:13:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] send-email: drop FakeTerm hack
Message-ID: <ZNKh2lzaRUjeU9AF@nand.local>
References: <20230808180935.GA2096901@coredump.intra.peff.net>
 <20230808181436.GA2097200@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808181436.GA2097200@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 02:14:36PM -0400, Jeff King wrote:
> The smaller change is to implement:
>
>   sub IN { return undef }
>
> for FakeTerm, which would then behave according to 5906f54e47's "no tty"
> behavior. But after reading through the relevant history, I'm fairly
> convinced that just dropping it is the right path. If it were actually
> kicking in ever, people would be complaining about the obscure
> "$term->IN is not defined" error message from perl.

All makes sense. Thanks for the detailed commit message, as always :-).

Thanks,
Taylor
