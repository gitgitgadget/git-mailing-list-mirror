Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA6EC875D
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbjIGWLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjIGWLB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:11:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7161F1BC6
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:10:57 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5925e580f12so14465377b3.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694124656; x=1694729456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGBciT0vSARpZzlOrqiS6YZMN8gw/V8MLeIOfJ0agu8=;
        b=0LqoNC0TZ2Ee99XEbXbYt9epskfnwKsMA01lAUe7x/CtsBamnpJLthCdJ6PyHaouNF
         XiJNTUsQXvbiHRIqKLHG9URBlxx5+DAaE1//LY8nYZUkRPADP86MX7vklGR8mj9eX76z
         mED7Esf7FRk6VsocvZFH1vzzkVy7hMmBcAjtg2wl3N5MhKJy4KEZBDp4S0kSzec6aB4Q
         q7Pjp1lbuwp4TwGTV6FkPAHo6sNi/qCkFSja5vH/B/xg7Lo3x4IW+854cG4b0Jm3tuwQ
         ViKPRHNEyl8yO4L3Lc08ql47NBJ8DYSLjlDqM+Md4fxJxGbaUOFEweyp/Jj9GOD2pzzt
         M3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694124656; x=1694729456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGBciT0vSARpZzlOrqiS6YZMN8gw/V8MLeIOfJ0agu8=;
        b=iR/iBjujaa/XKXdAm2AN9ByWf8GMPYv/QU06MdbJlVwe9+pv9oNzEhhDNn8TQs95XH
         aVeIAEVjQjqpo+xu4zZ/qQUG8Wb+gAK6lO7r0e7JLp0GIGBY9OQDyK3RXacYJL17itZY
         xvE40hBICd7NjpkU8qDkMligO2+ZseFRqNg+PmUG0hgvIfnLJt3X7iMd1gkNdGaFomuQ
         MXVtLeQ7+pZ1YlT4Wrh71DG/NDmYhvq+1TFeyJEESMZU+IKz7f6V+W/cJonAzdGkQs6m
         7EEBe73qrBVNNnUxlMmRFChp+2fOcU4QwJTVNanMpo96OSoLMhQuO5o0G9sa0qLWiEeC
         iMnQ==
X-Gm-Message-State: AOJu0Yy0e9UhguGcLT4Ft2sGyRhaH7R246arfEVHcKnoELSLmmcw/HQ0
        mhGV/987YLsAN18jy/OdP+wvec3sQMhpCjueOBGwaA==
X-Google-Smtp-Source: AGHT+IHHRrn0j/ZIw3PSfarZcXcvoINCesrJ9Re0+3IUuZZO4fbrlWZycxh3Ugmk71+REfr7xVmPbg==
X-Received: by 2002:a0d:c503:0:b0:595:6913:6616 with SMTP id h3-20020a0dc503000000b0059569136616mr1014032ywd.38.1694124655178;
        Thu, 07 Sep 2023 15:10:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y198-20020a0dd6cf000000b005707fb5110bsm104148ywd.58.2023.09.07.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:10:54 -0700 (PDT)
Date:   Thu, 7 Sep 2023 18:10:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/8] builtin/repack.c: extract marking packs for deletion
Message-ID: <ZPpKbKqJhBJcqyl3@nand.local>
References: <cover.1693946195.git.me@ttaylorr.com>
 <313537ef68892b15e772eaad8937a4a8c7ebbe61.1693946195.git.me@ttaylorr.com>
 <20230907075931.GB1260718@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907075931.GB1260718@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2023 at 03:59:31AM -0400, Jeff King wrote:
> There are really two "factor outs" here: we pull the code from
> cmd_repack() into a helper, and then the helper is also just a thin
> wrapper around its "_1" variant. That latter part isn't needed yet, but
> I can guess from your description that we'll eventually have the main
> function dispatch to the "_1" helper for lists.

Yeah... the "_1" variant looks ugly in isolation in this patch, but I
think makes things cleaner in subsequent patches.

Thanks,
Taylor
