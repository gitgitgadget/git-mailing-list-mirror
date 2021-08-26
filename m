Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A5C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD96610CD
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 03:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhHZDY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 23:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHZDY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 23:24:27 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839BC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:23:41 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g9so1886084ioq.11
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Zgxe4TisVyAVHEuvbJ97zCdrRyoA7u/UrkD+gv0tXwk=;
        b=YZAL81gYJIKVGR8iA05UVfDyweXVzw3ekBZ1N78PWkOyom9qhXEmaTm4aup+oN06+2
         c585Xf9Qe6LoO18wzfmbdDO0wqgcZ8kCZV172ZjRks+FGfk6/JwxcJZGmcy90TWwn7+F
         U3z2JYrtPV+nZUjOINEnB1RPO4yyZPnwFrYcFYhZZz+3EcZta+xBUJMBEeqFUxNqDfLs
         +03Vm8BwctN+hExpHWPuRGmcD72zQvCultD0GQvlsOnahehCq7rkrNQOwp/fYSABRHuW
         fxK8CRCauaHZ9zlkPrepm5uYNruWG5iF+Rs/oFGnoRLB/UQKVNQg6fy3bW0htFVoKVf+
         w1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zgxe4TisVyAVHEuvbJ97zCdrRyoA7u/UrkD+gv0tXwk=;
        b=cWtGlea/VNVYA5D2PUnmke0AxA6inwRd4OlPoq+IVNOHgOMIH5jfl7qVH3jOah4xg+
         GopKU6ZmNg+K8uV1HSg1pX3TBOAn9Xelqd/e5/tUFF88cBc1kzArvuaQ3V1Y3yIkcm2L
         9eXfDWmLqJJJ96xFy5bEJ+bnXV1OcrmcwSkz6zfPJvKFLBycHTjDswiPLxWH47R5adU5
         Nke8+xuTZXFo3vwCqZtBdvyWgauxsF6C/6TcQfS4wMYfVOVJ4rrafCsqgDQao7gjox8X
         tjwIof7zFbxNSwfAroDOCajbtrccBp05sHDfCAwcWlPWGWJ3SVIFQ68Vq9SSS1lLkgKS
         7mVg==
X-Gm-Message-State: AOAM532fYluh+Yctt4ZO3j4rJF5uqQeHDTOBSvtba5Ldrn+QlgGQyWdR
        xKCaDhYtJTnYQrwKZer2PaP+Uepv2tL53VWb
X-Google-Smtp-Source: ABdhPJyra5NBw1Esz/boJ5enuN9fP6r4f62OeBYiQ4JL+ChnpUGM962z9UQlOpTSryujQtbvvnSt2w==
X-Received: by 2002:a5d:850f:: with SMTP id q15mr1389790ion.118.1629948220891;
        Wed, 25 Aug 2021 20:23:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c8sm1025850ilk.64.2021.08.25.20.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 20:23:40 -0700 (PDT)
Date:   Wed, 25 Aug 2021 23:23:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 5/6] tr2: do compiler enum check in
 trace2_collect_process_info()
Message-ID: <YScJO9SY+H4KbHFV@nand.local>
References: <87o8agp29o.fsf@evledraar.gmail.com>
 <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
 <patch-5.6-4e378da2cce-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-4e378da2cce-20210825T231400Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 01:19:23AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change code added in 2f732bf15e6 (tr2: log parent process name,
> 2021-07-21) to use a switch statement without a "default" branch to
> have the compiler error if this code ever drifts out of sync with the
> members of the "enum trace2_process_info_reason".

OK... arguably this code should have been written with a switch
statement to begin with, but this looks like unnecessary churn to me.
Maybe the next patch adds a new value of this enum? Let's see.

Thanks,
Taylor
