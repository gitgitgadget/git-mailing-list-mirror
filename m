Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2006C38A2A
	for <git@archiver.kernel.org>; Sat,  9 May 2020 01:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB574217BA
	for <git@archiver.kernel.org>; Sat,  9 May 2020 01:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV5JO9mK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgEIBXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 21:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEIBXI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 21:23:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E7C061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 18:23:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so5098139pjh.2
        for <git@vger.kernel.org>; Fri, 08 May 2020 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EP+fa5dulM0SSv2pT1cn6bBZ7feniElRKYKrHK+RrxU=;
        b=QV5JO9mKAqiHHR2dzUTDlk2dAZrYl0StkGdRJxWa78BAd3a2nhj80SMcxmFjdTj0mK
         ZQDVUPbucs1N7H0fn46djAbqghIHvL8TPtaxRfI7yd0YRAxGi3AIgXStbRmp4iXEfq9w
         xC7VFgzVJuvsLPDYYtQUiwWFUyFJLjCHLu51hN3jgZLNbd53RNK4sSo4e1kT8Z9GxMTV
         dLeHuDQT6IRa+m5fzwWvA0NtQfgq62XjwTKjDnEJUnWiiMYJOzvAiJOc3nsKfPXRn/8U
         wvEHP4k1AcgSx1cWVOfK9N+TLWrP5g1amNl+1UUR0fiRagLdE4sHzRW876lmBvLPmMXn
         T2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EP+fa5dulM0SSv2pT1cn6bBZ7feniElRKYKrHK+RrxU=;
        b=nIcqkTjS4bZbMlv/qj74mPBd7Dl7NcNJI2j4gJECica8/fwy9MBHHUUYwWQy/JCgLZ
         M4JA6LJDlG1bu3bEmDt0eto18vfBqRh6SKGAN1aPKLEyo29g9MjxFlSnaftVf+fObOPd
         e0AzhC2KbbzqDEEVP/HNsSSkrqY0DvisNoEEMKBDJnPxVb7VnKinjJReNl6zUzt5fNS3
         2oJf4TrgzwBPaIg2iQi4oczE3/DfV90a7uIT5GrNd7aVGo2mX2iUwyTQwj9bYGP0WCN5
         /1yXVNtbu6z2gw7DyuREXbb09pwODOittJxSOq7q2QhHuvU7pt6RjCdw+mzMBgIVF5xA
         5SZg==
X-Gm-Message-State: AGi0Pua5Oebpd+kwi9fzVBMzjoCqkkqrJkLtHDjE6T7yuYW+hDCmqzud
        tu6e2xgabOpdl/TD7CkW76Y=
X-Google-Smtp-Source: APiQypKEPGtse+XaySXuFDaDVT6R5y0rJNtM8ApwxKS+/Noz4OYZk9+GjOmNtbnL3Ic7fVEacB4oKg==
X-Received: by 2002:a17:90a:fd94:: with SMTP id cx20mr9352144pjb.157.1588987387358;
        Fri, 08 May 2020 18:23:07 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id q11sm2997372pfl.97.2020.05.08.18.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 18:23:06 -0700 (PDT)
Date:   Sat, 9 May 2020 08:23:04 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: allow per-branch config for GitHub Actions
Message-ID: <20200509012304.GB2111@danh.dev>
References: <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200507162011.GA3638906@coredump.intra.peff.net>
 <xmqqwo5n34ka.fsf@gitster.c.googlers.com>
 <20200507204626.GG29683@coredump.intra.peff.net>
 <xmqqo8qz2yrr.fsf@gitster.c.googlers.com>
 <20200508180047.GD637136@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508180047.GD637136@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-08 14:00:47-0400, Jeff King <peff@peff.net> wrote:
> I just noticed this needs a small fix to the sample script, which I gave
> the wrong name:
> 
> diff --git a/ci/config/allow-refs.sample b/ci/config/allow-ref.sample
> similarity index 93%
> rename from ci/config/allow-refs.sample
> rename to ci/config/allow-ref.sample
> index f157f1945a..c9c9aea9ff 100755
> --- a/ci/config/allow-refs.sample
> +++ b/ci/config/allow-ref.sample
> @@ -7,8 +7,8 @@
>  # your repository:
>  #
>  #   git checkout -b ci-config
> -#   cp allow-refs.sample allow-refs
> -#   $EDITOR allow-refs
> +#   cp allow-refs.sample allow-ref

Hi Peff,

The source needs to be changed, too:
---------------8<-------------
diff --git a/ci/config/allow-ref.sample b/ci/config/allow-ref.sample
index c9c9aea9ff..249872425f 100755
--- a/ci/config/allow-ref.sample
+++ b/ci/config/allow-ref.sample
@@ -7,7 +7,7 @@
 # your repository:
 #
 #   git checkout -b ci-config
-#   cp allow-refs.sample allow-ref
+#   cp allow-ref.sample allow-ref
 #   $EDITOR allow-ref
 #   git commit -am "implement my ci preferences"
 #   git push
--------------------8<------------------

-- 
Danh
