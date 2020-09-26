Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F3CC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0D9238E2
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 10:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZZ3yoJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIZKVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZKVX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 06:21:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B2C0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 03:21:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bb1so675921plb.2
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=diIrGpyi+NfaUaaTpHDyxKMNMokd3C37rnBjC36JARE=;
        b=oZZ3yoJkgcb6sACREvMv8rv5IUAt5FanCOOBiL985UGuQebdUr9DTOFg+BsS1vujdX
         aLID2GQ2YUR0wo4hWUExMio1i/9WlXv+xh08nd50ZQqBhAfliPYa8YUbVMO0+PuCnuIh
         Z+1yMJxOdDK8Rqyct7/FXTTSDFtpqrQl3zQCWL9LGA8fc1nZIOocBhdq1S9PT5BxrlXh
         vQtecOIDhF0ySuDoyAaQaPXe+SlboYqGFoWWa35VHAVPiC7mcORgWIrvNLSPZJwg4Gs+
         7MWpbXc0W2xVVR3ne7rhgYNsE8zI34rwiTAa71PcHlnbv25E33+tjZsDsmfzt3pdu8uf
         uJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=diIrGpyi+NfaUaaTpHDyxKMNMokd3C37rnBjC36JARE=;
        b=BHRqOCWSm5IIu7uM7JzDZpJ8toDkaZTuQsQH4zLPbfVH/biBnxuJckudIfdTuR9jha
         ++muiLWCKB/VeaxszzwLEpeX3jTN5/OaPScFiUHJi1fELdwdLTDUpa6C+eJkYB9wb1da
         t05qVfD2PX3oKUbUvpPPN3ngLShIfJDuXpg8s6RIklKhtzZof281IXt9Vlng/lGS8InE
         xrPgRCIf5todIzE4jlampN89jFqNyXVmCL4vyO0/XJKZBj4MfxWSugz+TGJ0HAAKZ3zT
         RYnqIoyhei/OIBEFkpBbiwJL23A+Ql5ZvOh2TPn707jdJUIojjxYg6BEB/roQ6brv7h3
         x68g==
X-Gm-Message-State: AOAM530YHrDUkH30Dr5Hi/sLYCMtaHkvDS2aPA+UMN+/Drz55y7Ive7a
        FZfuyCOHy1SbeOAlgP5RQD+wpfGvoKCistq7
X-Google-Smtp-Source: ABdhPJwFGfcbuHxpqqOrDi2mcf6ocVbZMN8nMkg2ca8peaKKT8Pm3JVH8S5ds2Tl815tkplbfyrOmg==
X-Received: by 2002:a17:90b:3884:: with SMTP id mu4mr1536402pjb.29.1601115682473;
        Sat, 26 Sep 2020 03:21:22 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.106.26])
        by smtp.gmail.com with ESMTPSA id y4sm4473022pgl.67.2020.09.26.03.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 03:21:21 -0700 (PDT)
Date:   Sat, 26 Sep 2020 15:51:16 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 0/3]  push: add "--[no-]force-if-includes"
Message-ID: <20200926102116.GA76247@mail.clickyotomy.dev>
References: <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
 <20200926101324.73457-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926101324.73457-1-shrinidhi.kaushik@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
Please disregard this patch series. It does not compile with the
latest commit on "master" (9bc233ae1cf19a49e51842c7959d80a675dbd1c0).
I will fix those errors and retest in v7.

Apologies for the noise.

Thanks.
-- 
Srinidhi Kaushik
