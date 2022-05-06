Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334AC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 12:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392107AbiEFMrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiEFMrW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 08:47:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C705930D
        for <git@vger.kernel.org>; Fri,  6 May 2022 05:43:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so10703963pjb.5
        for <git@vger.kernel.org>; Fri, 06 May 2022 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFMWC2v5AJKPtsb4BFQ5fMERbNzH7EcGH3E35XYLFe8=;
        b=ovKHyB6U5YCR/+dD/IFhN5MrQAKLZQBKg6gfSvcqmQ6KU7rB4bAowg6LYJOb1M6xhj
         5z/cT5VyGrxGBTKEvhpR7ijTdmVrwXc0jLvyvbI/4Ki5Heo9mR1RXmiyXgKVCTiK5Wbm
         L7MTRV+W5lqWchp0+S3JzFbnt8WV8u9QkIlyWtJS7ulqKxn1r3+M/RVUIS9x3xUo+aYP
         wlsf4FPfWr+zyjmHA6Wewp9zVLkLjo9fHXBwM81JciD9WT1teRcYN5vwWKaw5ggceDTD
         HbfFCIVuRe3AqRj3Igoro9M1tVumwqxdwJ69LQZV+N0A802DWpDa+trX7790S79aPxs0
         n/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFMWC2v5AJKPtsb4BFQ5fMERbNzH7EcGH3E35XYLFe8=;
        b=nVF69A3KMBdOG2KEPNhgBMcfSl0QyD22+OgLKebFGNM5ZoN2Pnj/3dguXgdzvzpGAb
         Ggk9z9mXTqOrZJaD0md6dCceyRxH/xV58/fOqJasJmKbb9Lb6Ge628M/VGFBIgdXUdgC
         UeGzdYcZ0apcG5+muVgmFmzhUJfjOiDQzcvw6o/gZWgB2oJbjoaCjx7uhXK9WAwW/9ER
         iKNu5h0Dcm8VrDFDHLcozDF9KGzP3ntxHpJWKkw+UBHefHu81QfJpd0/FeK3rOktf/tf
         l3bDvNF+VGdlCusacielu2OQ/PGtKcdiAu0p/yi/Qi+KTFUc5Oe95W31c/AlVaSOc1oi
         31wA==
X-Gm-Message-State: AOAM533/m2ZXhZW1Lly+BEFeEG7sqQBPnjWpJvjvQHj3UE8cFXsuMYr3
        wZuTz/j9A/T1ZhHYEUCd/r0=
X-Google-Smtp-Source: ABdhPJz+3IrrXIzVm1EcGiM+lLusfmFT/7J8o1Ts5c6XclBJRDyTNgiDvgp/sjfKE9BERjTXpOOmBg==
X-Received: by 2002:a17:902:eb85:b0:15e:bf29:bd9f with SMTP id q5-20020a170902eb8500b0015ebf29bd9fmr3453658plg.135.1651841018814;
        Fri, 06 May 2022 05:43:38 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id p43-20020a056a0026eb00b0050dc7628184sm3376729pfw.94.2022.05.06.05.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 May 2022 05:43:38 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@jeffhostetler.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 4/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Fri,  6 May 2022 20:43:33 +0800
Message-Id: <20220506124333.58956-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g1a169d7b5e
In-Reply-To: <8005642d-979f-8e48-7a93-07b8a888bdc7@jeffhostetler.com>
References: <8005642d-979f-8e48-7a93-07b8a888bdc7@jeffhostetler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This might just be a style thing, but rather than logging the pathname
> in a separate data_string message, you can use the _printf version of
> region_enter and region_leave to also print the name of the
> path -- like I did in read-cache.c for the "do_read_index"
> calls.
> 
> ... | region_enter | ... | index | label:do_read_index .git/index
> ...
> ... | region_leave | ... | index | label:do_read_index .git/index

Appreciate for the input about the _printf version, we can choose to
let the region_enter and region_leave to print the pathname by moving
the related "midx_bitmap_filename()" and "pack_bitmap_filename" at
front, but it's not enough because both midx and normal bitmap support
multiple opening, so it's likely we keep on the current way using
"trace2_data_string()" in "open_pack_bitmap_1()" and "open_midx_bitmap_1()"
is a simpler solution.

I'm not sure If I totally get the meaning about your suggestion,
so correct me if I understand you wrong.

> As AEvar suggests in another message in this thread, I'm not sure if
> you need the region timing here for reading the bitmap, but all of
> the error and any other data messages will be bounded between the
> region_enter and region_leave events and that might (or might not)
> be helpful.

I think it's needed in my opinion, the bounded between the region is
helpful, especially when we want to know the detailed debug info like
we do in "open_midx_bitmap_1()".  


> Also, I agree with AEvar's statements about using error() and getting
> the trace2 error messages for free and not needing some of the
> trace2_data_string() messages that you have later in this file.
> 
> I wonder if it would be worth adding the pathname of the invalid
> file to those new error messages.  Granted you'll have it in the
> trace2 log, but then you'll also get it on stderr if that would
> be helpful.

I think I will remove the redundant "trace2_data_string()" code when
it will return by "error()".


Thanks.
