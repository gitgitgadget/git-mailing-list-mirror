Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D1C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbhLHTdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhLHTdx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:33:53 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF935C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:30:20 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 7so5408908oip.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xRks1Xi2xZdngYhLlzBtDlyu1HcAcaSrhID/v7kAZy4=;
        b=KsoTZlkb7viU2zkjMDqL2oYsjdzI9cnCmr4aUFVaoIAoMNQ0Sm9tpEA5X/VeDyVFD0
         viv7ET93UQR1agF2DSYyqoqINaZwySwJc3hCII9S8KSCQquZz7XKBT1adnqIjGJwWnra
         p/aCYZrT9v60P4gvuB8hNjq+AZE+X5h/gNp9SP2pL5CngoE1HFkFp579yGOkqV2cREsM
         6zv4sRIKn6ojQBOGuK4zYFvGF9tfvZWbq+MGqMqlUabjPHg/8XYSuO+3CNtyBDSDj6PQ
         68RgepPJ1935k/f/kO6TMptAfDXLaoiIhsion8BqZPOgmrHbvLFPWtO3zsvDy8kjqhTm
         zFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xRks1Xi2xZdngYhLlzBtDlyu1HcAcaSrhID/v7kAZy4=;
        b=vfBRbqrBgibeQ2bmncTsFnLjh/bcmQXixxYE8ra1ZSNcvmyIX4lZYMsrdkP/tO0ZF9
         rqqCBxXig6VmLhA5It6Ryw2xH5/a+FrsTCMSkDnycDQdj9mSHblfa9VVjjpX+10yO+4y
         MfT4wZODrYzd3+o31tjMzquTzT4l3KKL+rZWrCWa1SgexaZcHL3/Co/Gy9VuR4usBvAs
         tGFBKVgYmy/zpHz71NT/bsmAThFUl+YXHnPW6YVSB4t0HWN8hSCYCBYvLUFoFyzy6N6v
         Ggl5ExMZCihn7TksURbX2j+eqJkoo6GpGZz06CefS/QnSm4Pd0WgZFX3HP6SbIP68oOf
         xiKQ==
X-Gm-Message-State: AOAM5323s5wQMCgZlwSfW0k3vxF+vvzWLLUDbEM3G1UlSeWhjYZdZ503
        sjM3Tyh1H8+SVKrvPlyjoyWLIJqBdM4=
X-Google-Smtp-Source: ABdhPJy1yTgWE/ZXzNwID0AVdi15Ja+KafRnn2AdE+e7c8h+nwYBtnWudTXVLSk8FTKfXagBmyxwtQ==
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr1476252oig.5.1638991820123;
        Wed, 08 Dec 2021 11:30:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id q10sm884118oiw.17.2021.12.08.11.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 11:30:19 -0800 (PST)
Message-ID: <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
Date:   Wed, 8 Dec 2021 14:30:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack
 order
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <cover.1638991570.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1638991570.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2021 2:26 PM, Taylor Blau wrote:
> This series demonstrates and fixes a problem (which has existed since the
> inception of MIDX bitmaps) which made it possible to reliably introduce bitmap
> corruption into a repository.
> 
> The recipe (which is explained in detail in the first patch) roughly looks like
> creating a MIDX with some packs. Then re-generating the MIDX and its bitmap but
> under a different object order (e.g., by changing the `--preferred-pack`).
> 
> Because we used to link the new .rev file into place, and because the object
> order is not encoded into the MIDX itself, we would inadvertently generate a
> .rev file with the same name as the existing one that contains different
> contents, and then fail to move it into place. That causes us to read the
> .bitmap under the old object order, producing incorrect results.
> 
> This series applies a minimal fix (in the second patch), which is to include the
> pack ordering in the MIDX itself. Some small thoughts here:
> 
>   - We could alternatively have included the entire .rev file's contents in the
>     MIDX. But this ends up being kind of awkward (and is also discussed in the
>     second patch).
> 
>   - We could cache the identity of the preferred pack (which we currently
>     discover by looking up the pack for the object in the 0th position of the
>     MIDX's pseudo-pack order) by just reading the first value of the new
>     optional chunk.
> 
> I'm certainly interested in pursuing the latter, but in a different series,
> since I'd like to keep this fix as minimal as possible.
> 
> Taylor Blau (2):
>   t5326: demonstrate bitmap corruption after permutation
>   midx.c: make changing the preferred pack safe

Just chiming in to say that I reviewed an earlier version of this series
and the version in this submission looks good to me.

Thanks,
-Stolee
