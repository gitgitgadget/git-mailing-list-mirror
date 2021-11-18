Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F98C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE95610FC
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhKRWIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKRWIr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:08:47 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303DC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:05:47 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id k21so10135810ioh.4
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VpGGAIp2jFI9nloJctqw0U3zahQfw2ecvFl8IZA8azU=;
        b=K0Era33ZJ1XxV4P+i1ofrF+PF60USLz8L0iTJddPrD4DYAr3rSSynHrJaA9TY/W+9n
         TLmMK/XBZSEXlZoh8Ys5yHurjJUdlxhQt6A89ALm7nOtUjk+OTzXVB9GhDCL8BYe8AWn
         vt50p0kKtwmrnbJ/4U4pOQyyk7Mi6oUljJuxzRZu8tIptjsI6EeShbvMjLT3zad0YKF/
         gGZqKnj6KfTlRlUjtcYPCEEmb7AHy1IR69cqwS4CiKz3YF8TFIZKUtwAWSUQN9sk5VRT
         KFkkj5cKA0P+dTAHt21rb4uBW0NWBM9FpnrGl1psxr/jKCoDP/i3dKzHl6XP6vEQMwOV
         N9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VpGGAIp2jFI9nloJctqw0U3zahQfw2ecvFl8IZA8azU=;
        b=ut+fu/xrYiVBjUvMXv1DfTjhmYgWpdYe/CRJSJ5iBpp81fLHHlUMX/HOVAw/ivhHeF
         D96owyWNMoDCauIUnD+aZJBMjrqod1LpuRLcNncH/z7L62GUwyRkXvCdJTYLUa7LHBLF
         iYslZMgGVtlR1iN5ETEZ8joHl4eCe2nihkEkwqY9rihzMewL01I8UFX+nKm5qwDN36z7
         1s7vor4RxBQZ/Tou2pG/OugxYkcHYiN8LNdQEbw6W32/faLZsqc1GM5kvFIam3/1NAVr
         68FeH3445ohpraVxOadnI36oL0kgdYpWQaWPvtQGq6yKNFqcGAD5yAnJlfBE0z3l40qx
         oZaQ==
X-Gm-Message-State: AOAM532HSH2CLhIZUUVDMLz/XZ7VDPY/kygtm7ECB8qayFas3Rnl3b11
        hYRY5X9Cub8Ma7LB7o3NAH1Cog==
X-Google-Smtp-Source: ABdhPJzhGI//5RYYXhtl9E3mECfa5ScbXtfYn6sW330kbfkNYYCqQr4BPDIhtlD2ztU8LhgYeIx70A==
X-Received: by 2002:a05:6638:240e:: with SMTP id z14mr23312482jat.65.1637273146524;
        Thu, 18 Nov 2021 14:05:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d4sm574929ilq.76.2021.11.18.14.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:05:46 -0800 (PST)
Date:   Thu, 18 Nov 2021 17:05:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jan Kara <jack@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/27] bisect: Fixup bisect-porcelain/17
Message-ID: <YZbOKgoYmeM/yLAs@nand.local>
References: <20211118164940.8818-1-jack@suse.cz>
 <20211118164940.8818-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118164940.8818-3-jack@suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 05:49:15PM +0100, Jan Kara wrote:

> Test 17 from t6030-bisect-porcelain.sh assumes that bisection algorithm
> suggests first HASH3 where HASH2 and HASH3 are equivalent choices. Make
> sure test correctly handles both choices, add test variant to properly
> test commit skipping in the second case.

OK, makes sense-ish: at least in the context of preparing for the
bisection algorithm to change. The subject line leaves a bit to be
desired, though. Perhaps:

  t6030: handle equivalent bisection points gracefully

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 1be85d064e76..f8cfdd3c36d2 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -197,11 +197,27 @@ test_expect_success 'bisect skip: successful result' '
>  	test_when_finished git bisect reset &&
>  	git bisect reset &&
>  	git bisect start $HASH4 $HASH1 &&
> -	git bisect skip &&
> +	if [ $(git rev-parse HEAD) == $HASH3 ]; then

This is somewhat uncommon style for Git's test suite. It might be more
appropriate to write instead:

    if test "$HASH3" = "$(git rev-parse HEAD)"
    then
      git bisect skip
    fi &&
    # ...

> +# $HASH1 is good, $HASH4 is bad, we skip $HASH2
> +# but $HASH3 is good,

It looks like this comment should have gone above the start of the test
in the previous hunk.

But it looks like you accidentally duplicated this test in its entirety
(with the addition of the misplaced comment) below instead.

Thanks,
Taylor
