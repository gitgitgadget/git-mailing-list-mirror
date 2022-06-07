Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7806ECCA47C
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 03:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbiFHDDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 23:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358460AbiFHDCG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 23:02:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7262019F
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:51:39 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cv1so13157647qvb.5
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bghxs1SgDQu9Zw06c+FDI/seRn4wv6omJDTzAcBEb5g=;
        b=iUDm/KjCLJZ8l67Oj2gX9GQxgXE7MxX1XT/ZiygHkRmRLACWHai7CYza0jC5RFrOKj
         o8K30JoXcHOsbAQeOsqy6rBf3R92gxjFNWAuugyqBIa9W6+aZijw/X3rYL7divda3nnS
         MSF/9tyQC2h3pKvhZ+Qn0KcAFHtt/xXhfAvKOcFZ0jVieKL3FHCzZ3YIRvUOkikC3+Cf
         VsTwM2Ous1S/N+QkgQ7Pf2mDkv/9RaHo9OmxTe9lIYkfrtdQVqOgWbNDXT7jFnDVriis
         U2qv4LvhItC4Kl6wKVw9ZFRMZq/vl0VdAejVwftG8LXXAAQI5g1Jhcs5ASjKzH96i5hZ
         vtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bghxs1SgDQu9Zw06c+FDI/seRn4wv6omJDTzAcBEb5g=;
        b=oYkruoUkotyPjPKmxN3ApTKl3uHxpwyCGd+JLuitaTBjqWNmNM57nsgaFMfhbM9OuB
         u5AcQYLPso2XkaLvL3OaRf2QmLhuXsmqs7+Gxmee60OaPTJ1LX9nckg9q9WXOusXEm5P
         iIhmsEUdUO2SAH9EH/BaVqeWbNfztWE5h0O0XajByDCDh66ULflG9BfAXyEe5fpRxTIe
         VhSfq1Gsglvj/FOi/T6P6B5fVAysOq890i6Q2GavLFOn9xrDXrBgS7I0jIZc36I3u2Zu
         0JrH0WsspIZ/CeDsTbr0x1+0JOUeCSz1IVe14R24GEBy6bBdQPXIYBZCrsGYgAcXAeKO
         zoIQ==
X-Gm-Message-State: AOAM533cB+kBVxp3msMGaJ7FATxWwn5T0mm6Yv7Hylx+rc3pXUcq9On8
        R1/leHRwc80uWuPuUbfK1xgNtDOCQueVEph3
X-Google-Smtp-Source: ABdhPJyTrzzw4TZW2Hg7pVeuq4se4f+UDkryf0u9pxtVIhpDNWPG4pj4Qh2e/m2lgbT0E+QBxGe1lg==
X-Received: by 2002:ad4:5fcf:0:b0:467:dc87:82ff with SMTP id jq15-20020ad45fcf000000b00467dc8782ffmr19208240qvb.14.1654635098149;
        Tue, 07 Jun 2022 13:51:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86e88000000b00304f55e56e4sm2548042qtv.40.2022.06.07.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:51:37 -0700 (PDT)
Date:   Tue, 7 Jun 2022 16:51:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 2/3] bitmap-format.txt: fix some formatting issues
Message-ID: <Yp+6WU+k2OwHDB1b@nand.local>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
 <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
 <cb919513c14d426b51051ee5c16badec37538032.1654623814.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb919513c14d426b51051ee5c16badec37538032.1654623814.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 05:43:33PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> The asciidoc generated html for `Documentation/technical/bitmap-
> format.txt` is broken. This is mainly because `-` is used for nested
> lists (which is not allowed in asciidoc) instead of `*`.
>
> Fix these and also reformat it (e.g. removing some blank lines) for
> better readability of the html page.

Hmm. When I render the HTML for this page and view it in my browser, the
removed blank lines makes the contents of the section "2-byte flags
(network byte order)" run together, and I think it hurts readability
IMHO.

Is there a way to keep those line breaks without significantly
reformatting the source of this file?

> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/technical/bitmap-format.txt | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> index 04b3ec21785..f22669b5916 100644
> --- a/Documentation/technical/bitmap-format.txt
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -39,7 +39,7 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
>
>  == On-disk format
>
> -	- A header appears at the beginning:
> +	* A header appears at the beginning:
>
>  		4-byte signature: {'B', 'I', 'T', 'M'}

Similarly, everything below the "A header appears at the beginning"
list item appears in a <pre> element, so the rendered HTML looks more
like plaintext to me.

This isn't new from your patch, but I wonder if now is a good
opportunity to make some light use of the formatting options that
ASCIIDoc gives us to make the page read a little bit more easily when
rendered as HTML.

I don't want to compromise too much on the readability of the .txt file,
though, so if there isn't a good way to strike this balance, then I
trust you and think we should leave it as you have modified things here.

Thanks,
Taylor
