Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48675C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKOTS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKOTS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:18:27 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB500640F
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:18:26 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id 7so7905680ilg.11
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aErkji30euYUt0/I2WCnXZ24+hNrHdDIdmKgIlWWeC8=;
        b=iyOJ/qmMk0BcuLtDdA4wVUfY6SIaLSGbI1AegIryj5L4IpLI6MMt9hdYDuMIJTfmv6
         JPfTxryJpbu7v9162NifrxmOxAaVhED+CkT8m8VDnOKBXfR0GZ48549f3LOT80wCb+/P
         UDxezBAkkLFlnJqMmho5ocJvvd6Vuh9OmAcv1vPFU0w5l4EjQR6UQZpTNwCwC0GpBnc7
         rjI5qg094QHJ0aZk5VN6v07swPz7YfDL1ZQs0nTnHAPQbIVqlTDSseWZKgntNZwGKsOT
         k8BZtz9yAitjUuQ6rEe0iJK+LhGg4Ayspdo0N5aomcFkyv0+kPLB640Zgx6bW/eSmxUv
         5Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aErkji30euYUt0/I2WCnXZ24+hNrHdDIdmKgIlWWeC8=;
        b=wFSz2I2mrTywzoTez14dmeAHNGqantWKpuw8MrfiyZAfiqMwJkEDHfCNE4qmZzHLCA
         F1xeQRu2e32fvY6+icwv4o3FlGCXdeU89Q2ZDihloiw5p3vHBPHj+2ecV2Fp0mUN5JgL
         5hiBctTM4hz50qAfJgEjoW5CzOwA6DJyDBYX4tjClOpc0XVw3r5bM75VqcipJ6FUU6St
         Xs1tO9bblcP5Hlu3+r1u+9dQ4geSOG0F3NdUVgRZsf8OV7aY6BJlSG5rYjFjF4Xg58ca
         JnA2kD6COdE8roDAxuV1+U2z3Ar0fSUgE8iS/A6tSvW+e9io+jfU+0jsiYuijkqNBZ2s
         sEfw==
X-Gm-Message-State: ANoB5pmGuYeKBe+y4m4P5j4MyBHJYIYpBs6dj4eTQ66ajRGEOJ+Ttztx
        ile/5wF88gH0aNCvc5oFIpVrCw==
X-Google-Smtp-Source: AA0mqf5zNfXsMH+0HgBEXPPXnpg9ItbwbWtFJsTbY+vWv7tpV9XkBKTFs0FnihLp79debs17/YdvaQ==
X-Received: by 2002:a92:b0a:0:b0:2f6:9e8c:586d with SMTP id b10-20020a920b0a000000b002f69e8c586dmr8790147ilf.84.1668539906049;
        Tue, 15 Nov 2022 11:18:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e73-20020a02864f000000b003760795e371sm3319523jai.56.2022.11.15.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:18:25 -0800 (PST)
Date:   Tue, 15 Nov 2022 14:18:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/11] Turn git-bisect to be builtin
Message-ID: <Y3PmAP24GPAhXPOm@nand.local>
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
 <Y27Hrkruh6++7NkO@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y27Hrkruh6++7NkO@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 05:07:42PM -0500, Taylor Blau wrote:
> On Thu, Nov 10, 2022 at 11:36:35PM +0700, Đoàn Trần Công Danh wrote:
> > This series finish the git-bisect porting from shell script into a C builtin.
> >
> > This series can't be applied cleaned on master, it needs to be applied on top
> > of the series posted at:
> > https://lore.kernel.org/git/cover.1668097286.git.congdanhqx@gmail.com/
> > AND the series rs/no-more-run-command-v, which has been integrated to next.
>
> Thanks, having both was helpful. Note that 'rs/no-more-run-command-v' was
> merged into 'master' via be4ac3b197 (Merge branch
> 'rs/no-more-run-command-v', 2022-11-08), so picking up these new patches
> only needed a merge of the other series.
>
> > Johannes Schindelin (2):
> >   bisect--helper: handle states directly
> >   Turn `git bisect` into a full built-in
> >
> > Ævar Arnfjörð Bjarmason (4):
> >   bisect tests: test for v2.30.0 "bisect run" regressions
> >   bisect: refactor bisect_run() to match CodingGuidelines
> >   bisect test: test exit codes on bad usage
> >   bisect--helper: emit usage for "git bisect"
> >
> > Đoàn Trần Công Danh (5):
> >   bisect: fix output regressions in v2.30.0
> >   bisect run: keep some of the post-v2.30.0 output
> >   bisect-run: verify_good: account for non-negative exit status
> >   bisect--helper: identify as bisect when report error
> >   bisect--helper: log: allow arbitrary number of arguments
>
> Looking good to me. Is everybody happy to start merging these two down?

Hmm. Looks like there is a small breakage in the last commit "Turn `git
bisect` into a full built-in":

    $ make check-builtins
    ./check-builtins.sh
    bisect is builtin but git-bisect.sh still exists
    make: *** [Makefile:3561: check-builtins] Error 1

Seeing that this is on 'next', it would be nice to see a fix in the near
future, certainly before we graduate this down to 'master'. Am I correct
in assuming that there is no reason to keep git-bisect.sh around after
that commit?

Thanks,
Taylor
