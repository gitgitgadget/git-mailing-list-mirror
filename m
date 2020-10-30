Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056DEC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7476720756
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=powertools-tech.com header.i=@powertools-tech.com header.b="KuHyZ0Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgJ3LWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3LWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 07:22:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F68C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:22:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i16so638109wrv.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=powertools-tech.com; s=gsuite;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4mNxrQmwoEbA2xguQMhtAGcPvKMdogX0ezPVgFlFlSE=;
        b=KuHyZ0Zd1k0JzogrnwWfrnYQVXjFTeNF2sPBqZdTzdlwRiQRe8uUSnA2gHu67bkJdN
         SwtDRW5vLijM+0zgWOvLYO6pvneS35rCXY3WyhtexjgzLCjOsxB39ZkNJIJGZtBAbhcR
         yX74OW+n+HbTQ2/SNc+d8auwKECipy5o03SEEvdeFVHNYw2qKX8IcJ1I5X8Xb/HOsyWH
         TkLkap006tZ9vQ4AXYkuUHDyS61hwdzxd/KVlQQF+bGlvNWzJNlLFBgbD7TecPKcV2If
         hyVTsY5igLQgT8du+mTrD2kIoi35aGgBMjo4nEEjtCHrOfLLSTzxjBKmNxagtlF70/LH
         ETTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4mNxrQmwoEbA2xguQMhtAGcPvKMdogX0ezPVgFlFlSE=;
        b=L9O8dK/C+rxocmV+RSVoFq4uWRnpwigJJUzzhpCQgbTkrXT/XRHZerVnVd+AAspgr1
         VYF1970jFn76KVhzOMBY4NT//mFDEuIQY3vypu58RWKDG0LGeqG+WFq8XSomVaLxkzs5
         5woB5tDNocJuedsTSTU9zOb1uaJ81HFMsSdQRAqUjfsLTThtjHb1CjoJHQ6GfWcletqm
         VyEKYtdfV+ZqnRlO2Xc1rZSr1Hslzqyp+Pedn+Uckr6PD8TiWUAk1C6vJoLq7smAlRyZ
         s9Egd5z43DaorN3F4GgTaJ/bsnDC3NjaaRuXrOVYTM5PZeXfjUVdXLtVNhVp0RJkQ28w
         PQXA==
X-Gm-Message-State: AOAM533bED37JZDr52yD0PcIekiUske2SI/W7Mq/0+D+pQ6MW7JekC1x
        mr2OBEqA4sW5vUwplUTDoNqMJQ==
X-Google-Smtp-Source: ABdhPJxK4xJpUzOITiJl9hzMK+kUrN9UOYUoP5ZskWnPralEFUBZ7wqvs4wHpAlv2gJmuKcJoZMXlA==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr2491584wrn.52.1604056951562;
        Fri, 30 Oct 2020 04:22:31 -0700 (PDT)
Received: from localhost ([2001:470:1f21:ea::ffff:dda4])
        by smtp.gmail.com with ESMTPSA id d142sm4232408wmd.11.2020.10.30.04.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:22:30 -0700 (PDT)
Date:   Fri, 30 Oct 2020 11:22:29 +0000
From:   =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Credential Store: Don't acquire lock when only reading the file
Message-ID: <20201030112229.3rcyylkuyrlrhn7g@safonso-t430>
References: <20201029192020.mcri76ylbdure2o7@safonso-t430>
 <20201030055541.GA3264588@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030055541.GA3264588@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff, thanks for the fast reply.

On 2020-10-30 01:55:41, Jeff King wrote:
> I agree that "get" should not be taking a lock. And looking at the code,
> I don't think that it is.
> 
> However, after successfully using a password, Git will then trigger each
> helper with a "store" command. So likely what you are seeing is each
> fetch telling credential-store to store the successful password.

Ah, the plot thickens. That sounds more like it.

On 2020-10-30 01:55:41, Jeff King wrote:
> There are a few options here:
> 
>   - we could have Git not do that. And indeed, I wrote a patch for that
>     long ago:
> 
>       https://lore.kernel.org/git/20120407033417.GA13914@sigill.intra.peff.net/
> 
>     but it turns out that some people rely on it. There were some
>     options discussed there for moving it forward, but nothing ever
>     happened.
> 
>     Another option that we didn't discuss there: we could remember which
>     helper gave us the credential and not feed it back to itself. That
>     would let simple cases work without the extra request, but would let
>     more complex ones (feeding the result of one helper to another)
>     continue to work the same.

Right, I did not imagine you could chain credential helpers, but that
makes sense.

On 2020-10-30 01:55:41, Jeff King wrote:
> Interested in trying a patch for any of those?

Sounds good to me, I should be able to handle it if you CC/BCC me
(subscribing to the firehose is a bit too much).

For reference, I'm using:

> $ git --version
> git version 2.29.1
