Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54092C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DD20774
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zL/WcTg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgC0PSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:18:33 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56000 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0PSd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 11:18:33 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so3994035pjb.5
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TKmGPQyZW0YQJ39wfsRhqoLIySjgw/yeMLQ2VtbEYro=;
        b=zL/WcTg0UKkhmc/n93RhCyxr11JvcUMWs7bOT31KfvDms6r4K+omrKAhk28d7fHtvh
         ueUADZX4XO4WYS/7G9l1xUvXn25G6g3R1YBLxBum/ui1IT7IJMVxu2RBEFPg2x/g75vE
         rGQPSOaKiDstFRqOY+9NUIO/ujd1NYPRtH6s2D5GIAwY3wBL97BMeg+frVfOHQsLYUxf
         cl8BRKeS20AuqLng/IAhl3XXiM2EOUFy7vfc7dfOjFCu8/P9OtcfNvFJlWSgihdA+6nf
         yo9HYfBkQTtFCTFJkUh3Vdw8ZfOSjLPPz5m6fng7FjsWRhAs7ptoFiBDB16VwzSuh6mh
         9CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TKmGPQyZW0YQJ39wfsRhqoLIySjgw/yeMLQ2VtbEYro=;
        b=hVA9uXbOmTjdiJFydwJWbFwpzpZFUOwpu0iB1MH8PJV6yckDA2xNBUjYL5w003wosI
         8pb0dXAKbKwJqABLbf0WzCTngeVgub/Lxjy2OoOQl3SByeI/XzbaiTWN1Kuk9eIBPyF1
         hDgqP6K7hqR5Ggegiv0R4ztX1X6rMI65NPDZzXsmJLAQZFxX5kaKZ+xIMSJAP89Gy69A
         PUFjKMzNGx/lGBL7tV21LC+bzs4XPvXEnviWCn/5BuxvSuELE2djPp9xNYuHe14Nexik
         tJwVqkt/afFlJXLPS4OU+gpXwq4LKxRZDv9bfQ5+ey/DFVSmGwJil9lPqevLpvefulFd
         n9tA==
X-Gm-Message-State: ANhLgQ0uE3JuZvvFr0ysLHf6zlu1rNeiRcHlpBtC+coomF8AVW+bXsZ/
        DRnoCPrHCQ/BX15E4ykHVWWL0g==
X-Google-Smtp-Source: ADFU+vu70/LqqgduZtICgq8KVZrprabZbkech1DYqzTcAucqlc+UNfleqBGC38rqTqdc/KKH++DMKg==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr6508973pjq.107.1585322310336;
        Fri, 27 Mar 2020 08:18:30 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d84sm4390476pfd.197.2020.03.27.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:18:29 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:18:29 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] upload-pack: handle unexpected v2 delim packets
Message-ID: <20200327151829.GA30577@syl.local>
References: <20200327080210.GA604725@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327080210.GA604725@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, Mar 27, 2020 at 04:02:10AM -0400, Jeff King wrote:
> We saw an upload-pack segfault in the wild today at GitHub. It's caused
> by a client sending bogus v2 protocol lines (a "delim" packet instead of
> a "flush"). So the client is broken and our only option is to break the
> network connection, but we shouldn't segfault while doing so. :)
>
> I don't think the broken client was Git. It didn't send an "agent"
> capability at all, which makes me suspect it was somebody generating the
> request manually (nor was there anything interesting in the transport
> layer agent; it was just an openssh client).
>
> The fix was simple enough, and is in the second patch. The first one is
> just a small cleanup / refactor in preparation.
>
>   [1/2]: test-lib-functions: make packetize() more efficient
>   [2/2]: upload-pack: handle unexpected delim packets
>
>  ls-refs.c                              |  5 +++-
>  t/t5562-http-backend-content-length.sh | 19 +++++++++------
>  t/t5704-protocol-violations.sh         | 33 ++++++++++++++++++++++++++
>  t/test-lib-functions.sh                | 23 ++++++++++++------
>  upload-pack.c                          |  5 +++-
>  5 files changed, 69 insertions(+), 16 deletions(-)
>  create mode 100755 t/t5704-protocol-violations.sh

Thanks. This series looks good to me, and is certainly improving things.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> -Peff

Thanks,
Taylor
