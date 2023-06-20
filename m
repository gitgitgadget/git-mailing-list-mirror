Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C738EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 12:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjFTMS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFTMS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 08:18:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981C7C6
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:18:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56fff21c2ebso50203147b3.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687263506; x=1689855506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmVJG6oyeX7cJhF9vW+oHSJ/HaMsYBGEwPC3k1Omg3Q=;
        b=2ufne8d0Ta72hJmEyFt9GC7nYoIwos7U2l/fmLZxNJUKEToGH8hT2oDtZzXDZykhLi
         u4bhCSw49xfi2UIFwYkXnA5iBdt5U+6oe50j3Z0ML2YtWKu660wanz5gHOWPkdUMfmBF
         QctcXFMFYSTXuh50TYSZ3LEPf3Ex8sQ9xmE4UBAEd67ycUwPlDqOixi+CBwSL4VuOw4/
         QU2GJF/H9yURpOj9t63wV8TnDHI/4C2LzQWXKU5iaIKKw48jjQMAzWVFUowQeDT2hZT7
         N35vFtZq/jFGnMMUYky164P/6uxk9VuMDT137Q2IiQjlIw6GMVClwr2WzMIUrvH7qb0E
         JDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263506; x=1689855506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmVJG6oyeX7cJhF9vW+oHSJ/HaMsYBGEwPC3k1Omg3Q=;
        b=PnJdsWIJJQfWbwj9tjmcg0DoeE7Xb7XyM+rzWMTujH/VSvo1XEV3Z7o+oZGs4fxZTx
         xEnZ7ioYnDVriqzOvbFvr+zfydfn4B+l+fAuJzQPxcHQm51adcQbhvNW1LyZYIeMe240
         nSvKOGRSf5GRlIBibAcqQIQKALWzGE8XCNHDK889PccS5C4Hu4+dUlXhacFkyNOHylgU
         BYaG9WSoYVvD+y0GgkyjALzwJsVsd0P0zOXuDu4NrudXbZsaFcWEyfe0dRBPFWtaYtkE
         /SLi1W3DDnOZr6phz6sDsRBMPEkW9wk+f8AqFhIGiSkzLnpSsig02BOZ9cZJLls2pF/u
         Axrw==
X-Gm-Message-State: AC+VfDwAhO3uw+2NkTkctwe1QUGRpiTtluAISURB+P65svd7XJWZUlAN
        KkD63pLhqX0nMXzqxozN4mLEzw==
X-Google-Smtp-Source: ACHHUZ59fTnEHZH4fPNFlA9N06uJLGsiCBYF/PbbJVJJO/V3gs6tCKWF5KQ6sYdJEyE3gIpoQWdu5g==
X-Received: by 2002:a81:7bd5:0:b0:56d:4f5a:bb25 with SMTP id w204-20020a817bd5000000b0056d4f5abb25mr15779347ywc.22.1687263505782;
        Tue, 20 Jun 2023 05:18:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g83-20020a815256000000b0055db91a6ddfsm463186ywb.73.2023.06.20.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:18:25 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:18:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/16] refs.h: let `for_each_namespaced_ref()` take
 excluded patterns
Message-ID: <ZJGZDthfQTGsCDh/@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
 <50e7df7dc0932a53682664a6334791d8f1ff31bb.1684178576.git.me@ttaylorr.com>
 <ZH7ZsIq5vQIstjAG@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH7ZsIq5vQIstjAG@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2023 at 09:01:04AM +0200, Patrick Steinhardt wrote:
> On Mon, May 15, 2023 at 03:23:45PM -0400, Taylor Blau wrote:
> > The following commit will want to call `for_each_namespaced_ref()` with
> > a list of excluded patterns.
>
> This statement isn't quite true as the following commit touches
> git-receive-pack(1), which doesn't use `for_each_namespaced_ref_()`.

Oops, well spotted. This was true when I wrote the series, but of course
I decided to swap the order of patches 14 and 15 with one another,
making this statement false. Good eyes ;-).

Thanks,
Taylor
