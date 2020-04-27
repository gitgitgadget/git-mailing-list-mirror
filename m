Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AC6C83001
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137732074F
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ACL5AZSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgD0X7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgD0X7j (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 19:59:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FFC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:59:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j7so9420857pgj.13
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TDtsT6kYp4qhfKXcFwhZCgEPW968uS51iXhiL3UeIG4=;
        b=ACL5AZSjHfCLkjqSsI3Y+88BzpVC+xcLdBfxT2FXGo+7qgQ/q2ZjrmKInV3E+037TY
         2Br0jAp/9L1DFH+fzepgg8n9Ts3mqAgIai/8EQcfY4HY+UtQnUdXVB3Mw8cr9g4SqHkm
         QD0nOUEM+a+QvsF2lyFlmy9GJoQ0A57B7vOP+3J7U+wMEfsl65LHE7l1RrTd0JV8Bng7
         cM9gmBfl+YinN7E1CLDTZJ7dhTOwSWS6dabCO1eC4sAdurz5HuA3F1fjOQuQWKhRZR6B
         gzdZn62fWrYLm9g9+Ve437g1PWCEmD8E4FdeObuPMxLVCzBQOhMqs8lFqAeA+9uXxrwS
         UJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDtsT6kYp4qhfKXcFwhZCgEPW968uS51iXhiL3UeIG4=;
        b=Tpg/95iVaDTiKeD6WYQ7iGbnHH/LQx976M+HYzUsZoblOc3WfqYr+6ivDfWKvGe16S
         vqWm5DjCFkKqbVlnFeQzNkaqi/dWiD+fnYIrExfzWBPt4lrOw0fQuCVLGcxD6wAPaAth
         ezwsIn5u/VaffhFpu8mnhvVf0uJfYpkQQ7fh5NGJCXDI5P+xA1CaqCLaVfrwU4+fC7ox
         KIbiqFXEvgURM1bi4+Kyr2VRBHDOj/oHvNXiX2Z7e/9tjOVEsoNa2x+8d1hZVEvZaK6b
         GdHl9JMGM5sdH2wy4JIwFHKmUl59+gd5K7E/jHLGb7Q6xolQYhS6c40X0c+aml4u0oW0
         0IOw==
X-Gm-Message-State: AGi0PuZijA2kQIjfjhSkH7Qy9LjoDOShESRZzISFKbPANf5qXdITIP/l
        obNEP1zKojQgTzUuHOyz6JObhg==
X-Google-Smtp-Source: APiQypLeTRjHDjw9IHks8mog56h1oWAqowFmn59rnuTkXe9xD2krNKPX58Mdhn/1Us+X2cnhd3hPtw==
X-Received: by 2002:a63:2347:: with SMTP id u7mr24509978pgm.183.1588031977568;
        Mon, 27 Apr 2020 16:59:37 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g40sm351316pje.38.2020.04.27.16.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 16:59:36 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:59:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as
 read-only
Message-ID: <20200427235935.GA14984@syl.local>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
 <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
 <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 04:54:09PM -0700, Junio C Hamano wrote:
> This step, queued as 3a5c7d70 (commit-graph.c: write non-split
> graphs as read-only, 2020-04-27), starts failing 5318#9 at least for
> me.  Do we need to loosen umask while running this test to something
> not more strict than 022 or something silly like that?
>
> Here is what I'll use as a workaround for today's pushout.
>
> commit f062d1c028bcc839f961e8904c38c476b9deeec3
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Mon Apr 27 16:50:30 2020 -0700
>
>     SQUASH??? force known umask if you are going to check the resulting mode bits
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index fb0aae61c3..901eb3ecfb 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -12,6 +12,10 @@ test_expect_success 'setup full repo' '
>  	test_oid_init
>  '
>
> +test_expect_success POSIXPERM 'tweak umask for modebit tests' '
> +	umask 022
> +'
> +
>  test_expect_success 'verify graph with no graph file' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph verify

Looks good to me; this is definitely necessary. For what it's worth, it
passes for me, but my system may not have as restrictive a umask as
others.

I'd be happy to re-send this patch, but alternatively if you want to
just squash this in, I'd be just as happy.

Thanks,
Taylor
