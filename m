Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B289CD6E7C
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjJKO4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjJKO4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 10:56:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD290
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:56:30 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-774141bb415so409001485a.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697036189; x=1697640989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WaAhRF6L6fxch3Q9PW24clG1sF9LkdDeso0Ei2ymmAQ=;
        b=OcQzaBxbF4uph+2utaCWW36lb1yQV4cwiSSr8mMzJa4R9T4/JVM6ihkDl81MIUFC9D
         hyu7IeDF/7NZISoEsUonwMHTIzfEw+hZF8OjhKtDb+g2B4s4lvd5vSn7d2mn1sT+jTdu
         BvQ/kgxfWyzSVcq0ezMHS8FhgAYyxxshPLSVNaDeFC2Jr+LRYAK5Winzr18TkyMMc3NR
         1th/5nzrrLVyoVlYQ+HUReAESCz3sLx3crgri9uROV3N4J4Nt2SEY8VvQcFstKQX8E88
         NmLqPMP7DlU99yeSyY4kIK8AYO4p7/aYjI1qJNBji6afVQJ4CAKvUQymjPY6yf/hYV7j
         St+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036189; x=1697640989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaAhRF6L6fxch3Q9PW24clG1sF9LkdDeso0Ei2ymmAQ=;
        b=T2Sx/asLUtwXauAugq9jeGKpuudvwJOFO51TBS/HcpB+ceuPJ8QSZmvOkbXnpfY8YX
         +FPDvFQMOtYLCstjHo1f1pHYkrnxvSwURplBTSHrlYPIO6Z2T+ggfo5kWqzSqijGcHCk
         d2qHE6lAGVx4AbH6U9rPoT3+yuEmZAjlgNBuKlJ2GZmrD++jcvU+wl4yqeyaj6LBbjit
         dxVMDQRLifwOB8xRbgJwdia+nmNv8t9H9ZkXEpkDn1DfrJUTJCBOOB2uJhEyx6zvtmBm
         SdSG244gak6n+PCvWTe45ki4EzKDHBqm76oJNDnwTvTQLyXm6+QTOpZRJayV+U2bKB+K
         GHLA==
X-Gm-Message-State: AOJu0YyWiSkBVHdgdRdqBEqnsZIbWd0co+jsvaSa0fEsb7rRLgZ0S0SR
        9PvtuPMwol2A8HiI3Am1tXw+mA==
X-Google-Smtp-Source: AGHT+IFmee+u+AkPcXZFNe7VybgaXZm/MJKAdiYLSfVPzwZK0UlkzRkjN1fMQKn5W0xnNpPnqbipNg==
X-Received: by 2002:a05:620a:4483:b0:776:f8b5:c47 with SMTP id x3-20020a05620a448300b00776f8b50c47mr14684945qkp.19.1697036189346;
        Wed, 11 Oct 2023 07:56:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s14-20020ae9f70e000000b0076d74da4481sm5262244qkg.23.2023.10.11.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:56:28 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:56:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/20] midx: enforce chunk alignment on reading
Message-ID: <ZSa3m7yyf/BVNKxb@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210523.GH3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210523.GH3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:23PM -0400, Jeff King wrote:
> ---
>  chunk-format.c              |  8 +++++++-
>  chunk-format.h              |  3 ++-
>  commit-graph.c              |  2 +-
>  midx.c                      |  3 ++-
>  t/t5319-multi-pack-index.sh | 14 ++++++++++++++
>  5 files changed, 26 insertions(+), 4 deletions(-)

Very nicely written and explained. I agree that the choice you made here
(to validate the alignment in the chunk-format API itself when reading
the table of contents) feels more sensible and places less burden on the
callers.

LGTM, let's keep reading...

Thanks,
Taylor
