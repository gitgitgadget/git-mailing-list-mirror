Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E12EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 13:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFVNHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFVNHo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 09:07:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A751FF1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 06:07:37 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b5a1f873c4so2121566a34.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687439256; x=1690031256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IO3i1gUmQoXvT3f532qJgePIAqqLIK+/iTXY64AJio=;
        b=BwFDzH0FntcVIxHQkf75bK9IfzcfWenBnDRiH7Z0kLRmIEnJVH+6hkk/O7GAXxsKu8
         e1s53YxGyczVHhZo/K5LoUofqfQyExU5kn0qRS/uB8yFK80TikNZ8PR1CYgXvBmUVT6Q
         Rx1A5WH1PZ8R5Kh3utv+21VPER8NCfw+/YT8eLvHz2RASHX6xgvlhTTNhRde6G0pkFnl
         aFN0fJKNmWhPoJEVQbucXaKqTbTw2/B65CTBi81Pk6cy2YdyGJI1LP02Ewg2IeWdKKYe
         z7aNsybuBzGA5Ztm0ICP5pg/cv6PXFSLjm7sqZlpvbYwBqQKXdGHapNlnMHbhwrFQu26
         Zx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439256; x=1690031256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IO3i1gUmQoXvT3f532qJgePIAqqLIK+/iTXY64AJio=;
        b=B7T92r6Azfilfp0WIAC93RaC2c25OCWnL8kLV5V2ml88VLRWHpL5QRIGEfVsGyrj6D
         4UDwP8emAexTJjQRcl4Ee3zJ9WlNr0H1UU5rYvNChmipDtSYyr8YFEYxJSDLaIbll5jq
         rGBhFwUpv/2j2ulZE0UQUI5EFedUsN9jjobTFVNbOZVDIM4qJv8455zAFBCGanPrrUDP
         v559NsCmx2ctK3Q9nPP2cw2HRlDyEHofKL7JaxCeAt5rSoCCH1JRf4BUzPFRp89LBjD3
         JBrleiPCV/lxtxieFw/Vym6s+VVE4u90/AMyQPB5fQeuYN+hJ0RKh55I1Fh3A0Yj2LH3
         CNXQ==
X-Gm-Message-State: AC+VfDyzvvsO5fNqtsASXhtXe6ms5Vb9HucPhrX1WGyZdnVA+to93/Tn
        kbxBrm7QRksRrJH3mXpeaduidg==
X-Google-Smtp-Source: ACHHUZ6V7LYRGl4aHjLahlXqtenvyFZEAzXpVtF4bd/Fqu1G2bo6r1eMJL79UHGEFKzCIXobD40MIA==
X-Received: by 2002:a05:6358:e97:b0:12f:2030:1c77 with SMTP id 23-20020a0563580e9700b0012f20301c77mr3684743rwg.31.1687439256147;
        Thu, 22 Jun 2023 06:07:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 130-20020a250888000000b00bcb4ac1fbc6sm1536452ybi.30.2023.06.22.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:07:35 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:07:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Sergei Golubchik <vuvova@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug: submodule update fails to fetch
Message-ID: <ZJRHlJvE4BMue1/Z@nand.local>
References: <ZJQr0_aC-NlLXDgj@pweza>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJQr0_aC-NlLXDgj@pweza>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 01:09:07PM +0200, Sergei Golubchik wrote:
> Hi,
>
> Sometimes (my local repository has lots of branches) after switching
> branches
>
>   git submodule update --init --recursive
>
> fails with something like
>
>   fatal: transport 'file' not allowed
>   fatal: Fetched in submodule path 'wsrep-lib', but it did not contain e238c0d240c2557229b0523a4a032f3cf8b41639. Direct fetching of that commit failed.
>
> the submodule transport is not 'file' (it's https) and the direct
> fetching of the commit actually works:
>
>   cd wsrep-lib
>   git fetch origin e238c0d240c2557229b0523a4a032f3cf8b41639
>   git checkout e238c0d240c2557229b0523a4a032f3cf8b41639
>   cd ..
>
> after that
>
>   git submodule update --init --recursive
>
> succeeds. This happens deterministically, but depends on the old and new
> commits in the last checkout. As a workaround we've had to change our CI to do

It makes sense that after manually fetching the desired tip that the
submodule update goes through OK, because there is nothing to do (the
checked-out state matches what's in .gitmodules), so we don't have to
use any transport mechanism.

I recently changed the submodule update rules to disallow file-based
submodules when not directly executed by the user. See a1d4f67c12
(transport: make `protocol.file.allow` be "user" by default, 2022-07-29)
for more of the details there.

So in the short term, you should able to work around what you're seeing
by setting `protocol.file.allow` to "always" with something like

    $ git config --global protocol.file.allow always

But in the short-term, I am curious why we are complaining about needing
to use the file transport when you claim that the submodule actually
needs the HTTPS transport.

Are you able to share a copy of your repository, and/or its .gitmodules
file, and your repository-local .gitconfig, as well? Do you have some
`url.<base>.insteadOf` value configured elsewhere that would be
rewriting those paths for you?

Thanks,
Taylor
