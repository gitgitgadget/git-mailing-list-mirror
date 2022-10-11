Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A015AC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJKBOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJKBOt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:14:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E81582E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:14:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z197so4823653iof.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ6xnVGVFdmMHYG0g8bCkZjUCROJ5nnWmfAHnRmspKE=;
        b=id2s/hGc8oB9mnVmu2y39gPRST9SEPA/fX65fR74j+MWbUq3UCXHogi+AxC0XLgKp6
         q/+Wp0hF6GMv75GEq0M8Gl7DorlNLO12T2UwzO1NBUdZevGT5lq0IoVKL9+f5Ymso7ej
         7gZZd8Vc1VckSJOs6QJZEvAiM4nIusFG/701mNRrNvJtWiBtbFeguaq7zaCUxDD2KAW5
         lZw7DTgkayxjv7V2ilU/YVHdZOgY+Tju9kV5K+98FqkUSx+hFnn4liyHVIA3TJkpSe/x
         oXCU+rjXID2tQgvNKwILvViL+/AjsC6T+SnvHxiY4KhrRcrSDh50DeNKx8exlsy+Dh46
         rKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ6xnVGVFdmMHYG0g8bCkZjUCROJ5nnWmfAHnRmspKE=;
        b=k1suNwwH3A7LsJ7IrlCrdGyrRHdi4cjmf7h/F2aEk4DsrgWP66MZTbb6G4EfdcCIzL
         uBPH4LR+9+wPXUT8ZYUvEcLYrqNv7vsKb7a4bnesCaO+dE+jE92iR4BJLLGj90vH3Pru
         ZPr6JeBInEOeyuMzCXdWQ0FprN3GlARtQdNNOEHhsxXPZB7x6QkIZmWYUlEc9vv+UU4e
         8843WzW6FfNtVqfj6yv89boLuq1qfAGeqbvbOeLLM8xMaSV4nDrCxykeLVvdjzRHuFiS
         v37yNcKWxeGek450JPUePBnMKWsxk92idg+IMINNRdo7XUji1mPFcFUelednACL/JhPA
         T2Rg==
X-Gm-Message-State: ACrzQf2xCpZu08nayONvLAD3zzLq5k0ydk/jp391zH/MdiGd2Fh0t4ti
        R9JtGmG8wpwVYXGn+fddCFjGZA==
X-Google-Smtp-Source: AMsMyM6VCiM9xdJJbzRhEHoh3zKRrUlkZ6Jpk1/2yPsATAS41XiRK+B7rc69YW9Ty1kK+sswcPY8Pg==
X-Received: by 2002:a05:6638:134a:b0:363:a76b:5afb with SMTP id u10-20020a056638134a00b00363a76b5afbmr7238785jad.23.1665450886344;
        Mon, 10 Oct 2022 18:14:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u3-20020a92da83000000b002dd0bfd2467sm4440832iln.11.2022.10.10.18.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:14:45 -0700 (PDT)
Date:   Mon, 10 Oct 2022 21:14:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 2/7] shortlog: accept `--date`-related options
Message-ID: <Y0TDhP8O3xZsC/vv@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <b587b8ea4ab593806b9fb6d1db8751591991455b.1665448437.git.me@ttaylorr.com>
 <Y0S9cZBiLL3GuWm0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0S9cZBiLL3GuWm0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:48:49PM -0400, Jeff King wrote:
>   - it's arguably a bug-fix, and can be tested in isolation like:
>
>        git shortlog --format='%ad %s' --date=short
>
>     which currently ignores the --date option entirely.

Good call-out, and I agree with this reasoning. I updated the patch
accordingly, thanks!

Thanks,
Taylor
