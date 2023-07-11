Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73939EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGKR3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKR3X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:29:23 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D392
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:29:22 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5704fce0f23so71366527b3.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689096562; x=1691688562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kW35tbqiFXCHZ5Xy+YIUqcoao2kyLxperutbD+IXvU=;
        b=gCApLa2zLHAteVp03XY9CtKC6eBGMcP1aHPPbSH2v+UcgOk/WPLMrAGvLmvjq7IBfI
         CbTe4NqCpHEHKRk51WImUOhE/YH+B72xElThfy92tqrA3HBOPIEGFzR2OH1lvBqIXmSr
         fhmxzYl48AKHEaFazRPSEan0mrGz5CtrXo7Z/F6etos5+XtTqJ8zJz91vfJyY92+4CwB
         V5T4qOdRWckI4zTiP3bHaZXcLt5vjwHVnkujMIDgxz6DBKacI49xaFR3CVlzkyR/v/rq
         d0dAm6HtwWJfxaW1MMwNkd0xuoiqqTNE42D94Gvb+2B40K/1wWrqIkguXdMWzATjdtFk
         5/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096562; x=1691688562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kW35tbqiFXCHZ5Xy+YIUqcoao2kyLxperutbD+IXvU=;
        b=X0fDotL9UWRRSfTbNYUgscUZLzLVMjOClMNj4RalO+T4/+s4m2pa7mYmfoUg2gt15i
         iD3WafL6JEvRACa1f+tZNmDHy4jLgmAbNxAmvakVM4Sl/GRgVqu521PyJXYhyl4bsVCa
         mxUNpDGlfr4CLJu3jw5xromvfN8zjh78G2DNLloLq7Ke7zbrca0Ofl47QmxotAxBXVWw
         L9tj7NZQY0KuNMlp4Vl0rdZBG3T3glh7t341AFAvzIMZ8ZjsxjKLMAc0PD1FeCBgPlta
         HvXPrgEx0pl7oKn3dwzsnd37pzBAFbUNgVd9rIjdRD6+fx8/Yi9VB2FUMUa0WBr5NYmo
         AnOw==
X-Gm-Message-State: ABy/qLZjMW0g8XePTwIL5IoSCmNyXDLsaSzS3jFUW+thd5M5ntc72RFY
        nHozRIultcmZ/RexKchPlZfR4Q==
X-Google-Smtp-Source: APBJJlFlINErBPI8a1QzcqdtXpYc1FTENOVD2w3654peaRli7hmoG3XxaJFXuZ19L1k5pKAhlDYuaA==
X-Received: by 2002:a81:bf50:0:b0:577:2f3f:c712 with SMTP id s16-20020a81bf50000000b005772f3fc712mr15089553ywk.40.1689096561958;
        Tue, 11 Jul 2023 10:29:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w125-20020a816283000000b0057a6e41aad1sm676491ywb.67.2023.07.11.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:29:21 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:29:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] builtin/repack.c: avoid dir traversal in
 `collect_pack_filenames()`
Message-ID: <ZK2RcGet9dgybwwX@nand.local>
References: <cover.1689017830.git.me@ttaylorr.com>
 <b3d0d9308ef1a0aab8dd5a65354044568c65388b.1689017830.git.me@ttaylorr.com>
 <xmqqa5w34fhk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5w34fhk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2023 at 02:35:19PM -0700, Junio C Hamano wrote:
> Does this "fix" anything, or just makes the resulting code clearer
> and protects it from future breakage?  I think it is the latter and
> not having any test is justified.

Nope, this doesn't change any existing behavior, and there is nothing
broken with the original. So this is more about clarity and hardening
this function against future breakage.

Thanks,
Taylor
