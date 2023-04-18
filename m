Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B94C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 07:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDRHZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDRHZh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 03:25:37 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39F59E8
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:25:15 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-18785c2f39fso169865fac.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681802714; x=1684394714;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV+2moyGuuBgipJcxlclsmLVmGe6FzCMmljdFmmL25I=;
        b=smU1295Kjnp4OoeEP/dLRHR+YtBtagdOupLS8Z8xORjWxIcXytxSmvQfONnE6H0mgA
         tSCXnLe4B80YU5g0vK81ZHk7fOABA14P3STeWA8gy9Me4r1xRouYfQltVri5tvhcaufP
         +hebdjWtLWJ87mBsEp5/5g4D9a/neZuJm34TUyEtxDgyMPNnjU/aSxZVu8EQhbluWqBo
         bcudS5VYnYPpf7tEMX6X/3xp6NAcY9ZZ3tHqkZ/QEFE3t1XMFULtA0xOrrrZi9rKOthW
         BPaKUTYf4xDcshlO/k2XDd236OqYcCPc1MRoGaVGAhMe374DT+ywJ+XDjVRqYGJW0uBk
         GwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681802714; x=1684394714;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kV+2moyGuuBgipJcxlclsmLVmGe6FzCMmljdFmmL25I=;
        b=fXz9re+2OSHY9dOPfXJAUEa+UpuJCqxnc5cGpwNXjb0zpoRTkeYlMDVfgHIRa6MNc8
         3/vfMrJw3gbHBfLk0q4KyIwU6z52YlNUs1tb6OQhc/Huu3DOsizeE00inG+zWsVOXSog
         c7USg/s7lfl4NnLDzuXY/7frAINcZuc5lXDpiDv7UwPY51X8YbuEuuLKOJ7zdVulL3w2
         qXXKQuhW4qrv8EenquYpTP30zLCen5KsSvjgdhwcslsnUfXjoRcbk2cWsP0RYohOV5/x
         lSZjXYpMxlseUKDfW56N7ITkWS4sKxwoME/K7MCX6B4xZT7LO6YmcyWhpvS+UnhU6w1T
         fFCA==
X-Gm-Message-State: AAQBX9dB4RFDe+svQWoikN/zlJD6BL6nxTxYhKkWxY+pBUiyocrBkJHu
        AmLjJ3e0btP+O6IlA7H4mAY=
X-Google-Smtp-Source: AKy350bXMHM9IRSbpxOUXCR17WGLfcre5cU6NA7bAhV7AS/U9vHZ3HbNpOZRp/XYSGRHbtPbGiE57A==
X-Received: by 2002:a05:6870:c114:b0:187:baaf:fb24 with SMTP id f20-20020a056870c11400b00187baaffb24mr789478oad.29.1681802714562;
        Tue, 18 Apr 2023 00:25:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q62-20020a4a4b41000000b00541854d066bsm5582097ooa.10.2023.04.18.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:25:14 -0700 (PDT)
Date:   Tue, 18 Apr 2023 01:25:13 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <643e45d9222ae_21b04329432@chronos.notmuch>
In-Reply-To: <20230418044142.GA130759@coredump.intra.peff.net>
References: <20230418011828.47851-1-felipe.contreras@gmail.com>
 <20230418040034.GC60552@coredump.intra.peff.net>
 <20230418044142.GA130759@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: remove custom callouts format
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Apr 18, 2023 at 12:00:34AM -0400, Jeff King wrote:
> 
> > It's probably still worth moving forward with your patch, as I think it
> > takes us in the direction we want long-term (and which builds with
> > asciidoctor are already using). But we may want to pair it with a patch
> > to work around the issue with git-checkout.1 using asciidoc to avoid
> > regressing that section. It may require re-wording or re-organizing to
> > work around the bug.
> 
> Just to clarify my comment on asciidoctor: since our Makefile will put
> its output through docbook, too, it actually is using the xsl you're
> removing here (though I'm unclear on why its output looks good in
> general even before your patch).

It's probably a quirk of the git hack for callouts, but that's specific to
manpages.

Have you looked at the HTML output generated by asciidoc-py? The badly indented
output suggests this issue has nothing to do with my patch.

-- 
Felipe Contreras
