Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8789DC761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 23:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjCaXtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 19:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCaXtI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 19:49:08 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA701BF52
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 16:49:06 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-545cb3c9898so369074287b3.7
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680306545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fufowuCFsu0CjEHx6YCFElYGeWTnBV4lbQfj2ePc7jE=;
        b=I/nhSnn30hWohUisrpiMkFhCOjQtrBQq69MYcRBdoNVyOzxCgaD/FXF2VcgyaMxdJb
         8nxIxMphSI1hQ9FDHe1WHpcJjhJ3e1kORVAhlxS/WsA5yPRh6Tu48k7D4Bkw+g9vCxMI
         oXNK/x37Gf3HOTvBzXsewQXKMgGY21CCu4eoKy3KtCNO1t5no4BduMx72/JBX9+O2kpI
         i9XR0F8NlTkuKBy+5leFr7OW7p8C9z+rkYWZ+el9JUg+nlpbLuV4WDaOW1Mh07UBzygB
         0mCX4dQFvSDjr8PrqNSOpATcNmmGrdVv0P/TdiWqIYYPlJWcxGRkFwXdrNSg7o43RAtS
         kP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680306545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fufowuCFsu0CjEHx6YCFElYGeWTnBV4lbQfj2ePc7jE=;
        b=pLHjG0O98+lvQ6391X6rhhpbiruQBX5BVJpqJjbRoBTCQOtn6HagCY8noCiMmsSod5
         xFPG2lffUDpkn5W+v/BkoAmAHYzW2UMmFqrom586weOa1EtxJfw4aNAi2THeLZmjK+qa
         ben23/yD9eYA/zXduKyPARez2THWB8s8KaHDgN+eQJaBlWy/kNRsfZTlc4ofVERiWUX5
         d3lLj07Neb49NIy7fJaCO+sNUQmtEj6UHc5fwhEXwqkxI1sHnBOkn1Am4WneLGA5Bbd9
         QhNBhFEizSCYDv21YBS0TAHedbptuBVQgAbbqdMdXTxzwQFyszr6bXH/u6c3Ff7du1vt
         knwg==
X-Gm-Message-State: AAQBX9dgy3jsVxQUcdAdYUkp3nZ45jI51v2a6iuPdPskvCuZ13/42cO1
        yrZ4HLIddlOJyoxH/hGQ9SA8lg==
X-Google-Smtp-Source: AKy350Z5iwvNOJBX+Ne31Zz0N1SD1Cbr6fPt2PHBmU03i7J4o9kwtT6jHDK+lZ9ukkLWVld5NiNGsw==
X-Received: by 2002:a0d:d9ca:0:b0:542:931e:2c56 with SMTP id b193-20020a0dd9ca000000b00542931e2c56mr27888451ywe.39.1680306545461;
        Fri, 31 Mar 2023 16:49:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 206-20020a8117d7000000b00545a0818491sm844980ywx.33.2023.03.31.16.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 16:49:05 -0700 (PDT)
Date:   Fri, 31 Mar 2023 19:49:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: How do we review changes made with coccinelle?
Message-ID: <ZCdxcKr2mQ5cBQ8u@nand.local>
References: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqtty2hx30.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtty2hx30.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 12:13:07PM -0700, Junio C Hamano wrote:
> Glen Choo <chooglen@google.com> writes:
>
> > - Is it okay to give Reviewed-By on the basis of _just_ the in-tree
> >   changes and ignore the .cocci patch?
>
> If they were made in separate steps, sure.  If not, not really.  But
> we can still say "I've checked the changes the author made to the
> code and they looked good."  But we haven't reviewed the patch in
> its entirety in such a case to give a Reviewed-by, I would thihk.

I think that while none of us would probably call ourselves "Coccinelle
experts", we are probably reasonably capable of reviewing *.cocci files
and their impact on the tree.

What I meant when we were talking about this off-list was that I don't
consider myself an expert at writing idiomatic Coccinelle rules. But I
feel competent enough that I could review Ævar's patches by roughly
grokking the *.cocci changes, and then checking that the resulting tree
state matched my understanding of those changes.

> > - Do we care about new patches slowing down coccicheck?

I was the one who asked this question off-list, and I did so in a
leading way that implied that the answer was "no".

> Surely.

But I agree with Junio that we *do* care about slowing down the
performance of 'make coccicheck'. When I originally asked, I was under
the (false) impression that we didn't run 'make coccicheck' in CI. But
we do (see ci/run-static-analysis.sh), so we do care about the
performance there since we don't want to unnecessarily slow down CI.

Thanks,
Taylor
