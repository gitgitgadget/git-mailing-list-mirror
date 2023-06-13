Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B00EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 22:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjFMWhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjFMWhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 18:37:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1692D127
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:37:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-651e298be3fso6410966b3a.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686695825; x=1689287825;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFuVLInm3UXvTBQ5q+09ZvCsGJy+iI4ZqT6JxUtj8LY=;
        b=L8ABHRQV/SSEe8FIgfViAbCtyvL2c/gccxaWBwtn3gIrsoVCIeObQgdxPXiBGDTc2q
         gjst61g7+EFmH2rIWca95a8SyVaV6D2iMCizh0ACqHGinPVJgpLDrqic2eeD/4MbjFBA
         4uSS38mXAdiz/6cL4hxtve/9NLCxBoLauij9i4ADvgmv/9EuHdLTqJgOgspVBcDUuYI7
         0a16vn1KBBmuMdenCnHIBC4dx4FcEa8Vvgw6BIQrk+6TQmudly5c01fVXBqWfFLsT4u4
         Rnd6t4pwhD40AtmJRgO9xqHT9ewZjuVxduea9le3aJz0Vfxd5HfdAEJ3jtahXqdCCS85
         S82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686695825; x=1689287825;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YFuVLInm3UXvTBQ5q+09ZvCsGJy+iI4ZqT6JxUtj8LY=;
        b=hRS2InFp5YButN0/zovk/YS41I6WGUa19i1lxh3no4Hw491zuVhwg6Cesw+4t1RLBK
         1eQCnvI7PM7dSr1406VJTtuMKgtrdoxdTvT+5YTsuSp4nUN+OIB07i3betz7JhCHX3Mi
         bGRuaCL6XFKGNDrfaUdxXz3gDda3B0vVx23PDeX8mlHX5lezJrtdM3zVp0WjSVTfhomt
         Dx2hGvdVkzCXvOlEhVGCE1G3O2rZowooY0aZiOkSPyfBbwSSfOXJHpHc6iAHpBrPM63N
         vq26FzARSB/QPMDbpsU74paAelZfv9xuItDMO3R2OCwJ56GZsjbvyQLVjzOUA/6oUEmf
         OzUg==
X-Gm-Message-State: AC+VfDx/9MIRXLAmJmKAGZpd3yid9yDPoioICa/M5W6nlGW+rZJpM11O
        dys56mgy9afFeFWwO5QzIpc=
X-Google-Smtp-Source: ACHHUZ4kOPts1ufFs/UXlNoz2IMjxzMncXVfhCl5rGhAj7/n+sA8q3H5Gto7Mb7zkAlA1BOUlUvnUA==
X-Received: by 2002:a05:6a00:b56:b0:662:56b4:c2f2 with SMTP id p22-20020a056a000b5600b0066256b4c2f2mr189990pfo.25.1686695825422;
        Tue, 13 Jun 2023 15:37:05 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id a10-20020aa7864a000000b00646ebc77b1fsm9138432pfo.75.2023.06.13.15.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 15:37:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 05/16] ref-filter.c: parameterize match functions
 over patterns
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
        <1988ca4c0a79065a1893259da8abe63919e05cf3.1686134440.git.me@ttaylorr.com>
Date:   Tue, 13 Jun 2023 15:37:04 -0700
In-Reply-To: <1988ca4c0a79065a1893259da8abe63919e05cf3.1686134440.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 7 Jun 2023 06:41:13 -0400")
Message-ID: <xmqq352v3s6n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Once we start passing either in, `match_pattern()` will have little to
> do with a particular `struct ref_filter *` instance. To clarify this,
> drop it from the argument list, and replace it with the only bit of the
> `ref_filter` that we care about (`filter->ignore_case`).

Makes sense.
