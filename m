Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52970C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249A72075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EyQBDBKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDXQ6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQ6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 12:58:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D50C09B046
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:58:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so4117644pjb.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=saV1Ko7yFxhNaZS7UNKOt2BBTfLJbgZYYTHFdoR1p3E=;
        b=EyQBDBKE8VAT8oidFjBoAybNfvyC0Pk0Bp+9JCxIPjSrj0k7ld4sEEsiEECou/omND
         62suxXtdyNYnusO5Y2fju/q74f5cRhfN4YKhuf4K1d5qkOPe6TwDI8W4hsXh8LJbFI8J
         vDLOs0SRT91aetnO8mjVL4/SKPcN62W3LZl/wLTWKivU+1aTDn6VDpRdhKTJab3LYYAz
         26W33XPBJD5IAQPH0shlKDCres5x3ZpYgn6f+I+olbtO+lj37PJlqkPDMKxfB9juj6vd
         TQtCM6NCGiJhFA57PJcmTsD5HMe6kl3lGvRl+BpP2inte7WiUAj8aViwBue8FX5x+2b0
         TI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=saV1Ko7yFxhNaZS7UNKOt2BBTfLJbgZYYTHFdoR1p3E=;
        b=mlWUF4JQhmQkSDKHupGpAyAqpJz60mAx08wq+8yyGgmcEPD+7G1VEeFpwMjkk7ZbFB
         FPn/zm/rEovuZ6pDjrQa6G2n+yViyrhR+lYts5V4c9+DgaFk0378bB1uxuOme9aHpFbj
         c3KfPWiMIT6mjKnanWLhx+4TWV3YvuZ///tPLfi38vrYeIMZmlOnoDJx1Lr6ar1vZAem
         Sq+t79a98K5QYzqLZC/sjp8tQ+1NIJJcKI+A0LDLtw2FDTnO2nQ0b4McndCOWXRKYBio
         lPoye77QOli6PMdv4pD5Oi/3j7KlXoO3kR6UegSMVTwwh08L3cTCkT/OuJ1sZtW43fkN
         gmtA==
X-Gm-Message-State: AGi0PuaQlfkIkWQBt75YkbLtOGk7LtzJrZt4GPEv5FgEYZ7M0ROj8Cqg
        G29TBK98WfkT9EAZNDPcR942xg==
X-Google-Smtp-Source: APiQypJm/9ppcbuTUp8a3GwzXFOklBHgTkkZ6KKc8KB5WJk3IfhUpHJ1aJ3AHkBB9TbkKGypJBGy3Q==
X-Received: by 2002:a17:90a:db91:: with SMTP id h17mr7500691pjv.10.1587747488000;
        Fri, 24 Apr 2020 09:58:08 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id go21sm5338835pjb.45.2020.04.24.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:58:07 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:58:05 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] minor fixups for gs/commit-graph-path-filter
Message-ID: <20200424165805.GC58621@syl.local>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
 <dde036bb-303c-a9d1-6bf2-880428cfb7c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dde036bb-303c-a9d1-6bf2-880428cfb7c0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 06:14:36PM -0400, Garima Singh wrote:
>
> On 4/23/2020 4:58 PM, Jeff King wrote:
> > These are just a few bits I noticed in the test-tool helper when the
> > topic hit next (my -Wunused-parameter patch complained that we never
> > looked at argc).
> >
> >   [1/2]: test-bloom: fix some whitespace issues
> >   [2/2]: test-bloom: check that we have expected arguments
> >
> >  t/helper/test-bloom.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > -Peff
> >
>
> Thank you for doing this!
> Both patches look good to me.
> I also don't care about the brace/no-brace thing that
> Taylor brought up for 1/2.

To be clear, I don't care about them either ;). Maybe it's time that we
relax that rule (if it seems that a good number of us don't mind it
either way)..?

> Cheers!
> Garima Singh

Thanks,
Taylor
