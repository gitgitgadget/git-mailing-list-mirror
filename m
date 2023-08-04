Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F42FC001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 19:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjHDTDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHDTDN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 15:03:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F22524C
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 12:03:11 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-585fd99ed8bso50652167b3.1
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691175790; x=1691780590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4AVRJG6ZvV5JPeqCQLB7iDUArPmAwYvo9giwSkw0YU=;
        b=r8iUu7y6elhI/10PMXJR2zQT2C5eBNnItflIcGEGWgjOvVijpFtCvVT8R6xpjWwfxB
         qXT0cpYmXK21W3RElXNywVDn7sOP/tiItbhOd8oB6E2eYVrt8o6wH5D+XZ73YLi3m37g
         4MR32cGbOLc/z9gw4lC099S6cSGraEHwVIE0UUBWOnmKpJB7Xby/B2Z29qYFYzQppUgD
         4EuH0Wm9G/6/kOZguu5ppc/xy3Zh2d3yVH8JCH0zY+b96Ok4Vl7DHGSKWhoUV6+oLpJI
         IRkVcyPreXJvr1OfnQgIG7VEIsbu5A6BEEy6NUzg377NMm+zgaGl45dyDKFOJ+OT45cJ
         NCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691175790; x=1691780590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4AVRJG6ZvV5JPeqCQLB7iDUArPmAwYvo9giwSkw0YU=;
        b=ck8oMsglADmB29NA+5gQKr+h2y0ED4+OLIE2Px6HA9II+Rsut+Vdu0FdZNGbEepfcm
         fXsvtUEZKFOWO7WiIoPsnUqoS4iE4f/RO/pnNqMH0Sqnj1PWR58OQizk3k5KGmdpV514
         u+Bxv5nzsefnK/3ZSi1FOF/oT/gRY8/WEcXIcrcmQzoeuz8iZl6laEE/TGd7cKl3xMn+
         BHmeeKuaCr1bX0hQPuPbHrgBfTvDeWfHjP9Ruo7XrxLyft+1w8Px2vm84etmX/9IGOln
         MfsphcbMLc0zemd1Vi4ODnZXNWzicOoHRPrezGHnef0JIGiTxbghF+HbMTxy3+ukZbpd
         gzCw==
X-Gm-Message-State: AOJu0YyCa5BP/m7d9QG7FlgxPgDGvZzZ8dyctYNybui0IZ+jEphDQPYK
        atwW5GBQEnk+Q/EDswsCH+og5zOQcx9w1+rABf2qsQ==
X-Google-Smtp-Source: AGHT+IHZU1lF6kHEaZmNGEv84uTpd3qU2J+XnBFsWAjRxUWSLYcutfalm5fCpNjLlwJc9OtoXu/1yA==
X-Received: by 2002:a0d:e84a:0:b0:579:e6e4:a165 with SMTP id r71-20020a0de84a000000b00579e6e4a165mr707111ywe.10.1691175790706;
        Fri, 04 Aug 2023 12:03:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m13-20020a819c0d000000b005839a780c29sm884477ywa.102.2023.08.04.12.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:03:10 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:03:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] unresolve removal
Message-ID: <ZM1LbVp74cqpqQ0A@nand.local>
References: <20230731224409.4181277-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731224409.4181277-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 03:44:02PM -0700, Junio C Hamano wrote:
>  Documentation/git-checkout.txt |   9 ++-
>  Documentation/git-restore.txt  |   4 ++
>  builtin/checkout.c             |  15 +++--
>  builtin/update-index.c         |  98 ++++----------------------------
>  rerere.c                       |   2 +-
>  resolve-undo.c                 | 101 ++++++++++++---------------------
>  resolve-undo.h                 |   5 +-
>  t/t2030-unresolve-info.sh      |  45 +++++++++++++--
>  t/t2070-restore.sh             |  71 ++++++++++++++++++++++-
>  t/t7201-co.sh                  |  47 +++++++++++++++
>  10 files changed, 230 insertions(+), 167 deletions(-)

I am not so familiar with this area, so take my review with a healthy
grain of salt, but this all LGTM.

Thanks,
Taylor
