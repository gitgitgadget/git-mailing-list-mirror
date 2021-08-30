Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA2C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CAD61004
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhH3SFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhH3SFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:05:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D96DC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 11:04:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c8so20388662lfi.3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKj6wxPhDwSiMqcE/p/2D9BEskxsCy1Q1GslfnclMII=;
        b=0XDSZFbe+kixdckyyyLddwu6AZWEejDyT3YB4FtdUweqj7byjEJmWyUBdfnazr0hZ5
         gBaIh2OPb2PEOUPvoi+w2/dS4N4ETBFJ7JX6qc26iX8/HhPQsaUD9EUIIyw3/xZ54oJd
         nkRvm20+Jp6DBjnANl0N84JQg5xDrJp5TK2QgU86VnikLWDAmNoc4UlpueDhU76I5fe+
         m69hfYeZmjs+5pD04i+JJ7TopVn7H0lABUiYy71eA3PSULwRt+gw+jKlrpxrIW1Rd6ME
         Q9eRakLgsFyuqz96M+MeST+nNV0zqZOvxzYnYhfau+GVsrhr/b+crEmavmsPnIVUdw0x
         hLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKj6wxPhDwSiMqcE/p/2D9BEskxsCy1Q1GslfnclMII=;
        b=pkUEn6v6i/TaPfblqaHeul/EmaFdaeUhPfkVekMT/RaxHvhtPQiMFD1fh4fJ/HwSt1
         F7EkBE5zRq2Bpp4pTg33neuZ7KZcMazXGGRDHDheJ7kGXV9Po91wKQHVhcKF8/SSTohv
         HUIPHT7wJf1Zz8QN/j3dRWqYMwhy0liSAK5lXIfbR5Vg7QK30uEr+Cz6av0DWgxdFO1Z
         K+JD/+C9jgBseRynu2qAfA7PFWPv7GzdsGWnNFMdup2NwMU7yC0SHtuMAac4OpvoL+Zg
         VIjdcwuKr5mGItdfUyY2L3ZJWT8IS+i6qWcUdTeb9EVGNIrkm/yUcXCWmo75UVrW+S5n
         +4IA==
X-Gm-Message-State: AOAM533l/Zo4tzWbtiQWVXzGczLuJlwlQ4JWlK+tXQyqJKOIsithVGYo
        /GtKeizGuXMi8lOWhh8gM0mnAw==
X-Google-Smtp-Source: ABdhPJxlaSoJmdXm/R1+QzPbqE611A7w6oom6x8txDC+CRYOMKA50VUhlX2Z1yBSyy2QeJXU8AI/Hw==
X-Received: by 2002:a19:c107:: with SMTP id r7mr18306241lff.29.1630346674687;
        Mon, 30 Aug 2021 11:04:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v124sm1061884lfa.205.2021.08.30.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 11:04:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6A468102EF9; Mon, 30 Aug 2021 21:04:33 +0300 (+03)
Date:   Mon, 30 Aug 2021 21:04:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg Pflaum <greg.pflaum@pnp-hcl.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <20210830180433.5rqqh7zsakbrfmrp@box>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 07:11:50PM +0300, Kirill A. Shutemov wrote:
> Hi folks,
> 
> I've stepped on a problem after upgrading git to v2.33.0. git fetch-pack
> fails with an error:
> 
>         fetch-pack: unexpected disconnect while reading sideband packet
> 
> It only happens when I access git.kernel.org over git:// (github over
> git:// works fine) and if there's a gitproxy configured.
> 
> For test I used a dummy gitproxy:
> 
>         #!/bin/sh -efu
>         socat - "TCP:$1:$2"
> 
> It is enough to trigger the issue.
> 
> I'm not sure if it's kernel.org problem or git problem.
> 
> Has anybody else stepped on the issue? Any clues?

I've bisected the issue to commit

	ae1a7eefffe6 ("fetch-pack: signal v2 server that we are done making requests")

-- 
 Kirill A. Shutemov
