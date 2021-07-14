Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20437C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23BA613C9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhGNWXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGNWXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:23:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07789C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:20:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d9so4081858ioo.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+WGWdzafuY7rL5vO/i4ScypCQ7hNvz3xjK4UUqjn90=;
        b=j3/g5qNg9HX7N8SZT/9u0LW/0WRDAmCYp/cnaMF79Fknc0zCACWweVQULe/y7eSgXl
         E/2AvhxKoYDPUqY0jubPtiybkF2/aYVubM6SkbPdx/joGczTyMXsR84bXTWVv3t5yuKc
         7WfYU/QPkNvxt/P5lg1QaoKQY1hLXvtH1ALh/fzKEbIoi83o96k1jf4Sk1WR2Vk//aQj
         /t2FNCVYHWM5QF/hClkDu9u6nc3WOKGTATFuynY2kdA31PopBIpdMcAvbFsIGcFcpxQW
         FzmaPJ22bURlm/Ezqln4vHhLznbyNojz6SHXMZxcrThHTEppqa107/l6gYgx2q9n8LPu
         vrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+WGWdzafuY7rL5vO/i4ScypCQ7hNvz3xjK4UUqjn90=;
        b=tnrvX18dOPxTdckWw2r5t+y784UGoFj9hShDk4ZfpkMy1OI1EdM5EKWWh1d5kzEj+w
         8UZTZSTb6NLnCwssVqK8G5xtH/gv7UcMNIre7OEDUJaOHGQVZVb3fApsUxd/bWWGll/e
         JM0Mj8yEVe/YltjZoHuonvjO7j9kCDr8boqs/UnzIMiprHVp4b+HZUaQK3T/EhMa14ap
         WD+IOQlK6RmxpMDKCgIcZXy00svHJO4l/1UoVBh/ExtQ6T5tCJQGlgqMcHZAXKBTv9PM
         /nbaW7+6CV1wcE6qwpdoFD7UHuZUPuo3n7mEiVVcAx6dDi7jqlMUD8ioBAV4RkkyMH0s
         6UOw==
X-Gm-Message-State: AOAM531h7e1mDz0qiqc9R1cjfVrB6XJ9CpK/vPATXrKFK4RiegZP+A9A
        o1HukQpsOfhtp7FfCfcrknbhcw==
X-Google-Smtp-Source: ABdhPJzrDZHJOmWnokNof6REYca8oAvSdjOHOikwevLPw8tXnplX0Z1bgSeP0PHtLU/OJRqFpBEkdw==
X-Received: by 2002:a5d:8198:: with SMTP id u24mr260452ion.81.1626301231413;
        Wed, 14 Jul 2021 15:20:31 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id o12sm1949006ilg.10.2021.07.14.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:20:31 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:20:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] doc/git-config: explain --file instead of referring
 to GIT_CONFIG
Message-ID: <YO9jLvGlIVj3aI/m@nand.local>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
 <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 05:37:29PM -0400, Jeff King wrote:
>  -f config-file::
>  --file config-file::
> -	Use the given config file instead of the one specified by GIT_CONFIG.
> +	For writing options: write to the specified file rather than the
> +	repository `.git/config`.

I wonder whether or not we should write "rather than the repository
`$GIT_DIR/config`" instead of `.git/config`. The former is true for bare
repositories, too, but may in fact be more confusing than what you have
writen so clearly.

Perhaps `.git/config` is clear enough; I definitely don't feel strongly
about it.

Thanks,
Taylor
