Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4898C433E4
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFC92077D
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSwglA7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgGVJSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbgGVJSD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 05:18:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB319C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 02:18:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so1160763wru.6
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n7jsE8IkA0uqZfIbHORgR7Fa860r0FvV6pzHFoRvv+w=;
        b=cSwglA7r7yfp6sSVc+jnJ+IwRKyyOvD1Z8qRRXc5HUBw8L2tRX1v9E971m6nqbIC+0
         jA+bKTnPprW1/EGlvhAGoUpNrIq19SpWmpGQrPaZPhPz0Yd3mN4O3tqKkiy/JZ+5GdiL
         9Fyiw3dsXgrCyI2AJhjYEaQpAuwpj7PXMo3qexgvVj5dfdnpTuNfFwYtj8GNQKfxYmf2
         RH6Ery8B/c1gNs+uSP42FJIanQOCH/370gNFrblBRyDYW6IN8/dtb7EZOouT2tJ/qMtr
         jhh+qAHZyMjjWzb8umncZN4waEj664MaezwkZxa14B8ysxhZg1vCjXc2QKVLnOe8NfEv
         r/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7jsE8IkA0uqZfIbHORgR7Fa860r0FvV6pzHFoRvv+w=;
        b=KmBjotIhDRq/tZNRt0OOB5uSfAoKdNTwl5JC9f4Yi4BpuLjYBIUaBczR9DLVYgKHUK
         nm68+cZRAyI0f+dA2CRMerxSP6zgwgQNOl3LA0o8D8olFu6X2vO9V/DYeudovd8EalG0
         U2Q+JbZvuIgy9LkxVGc6r5oBLPftzlNOr2JpLnSA3wi9egLiz43wPfs0B/pIw1qcKZGY
         hLVH7U3VxDsRFb/iBm9UzahCfgRccNxJT7jGG1nApNK/1GIADYCBXoKnxGa3Tvkyig+I
         R8/2lKeiLAVbsgEscHIMd6ObLL3PUnuCLxTZh8gHiwdWwV4FDbfLBiFKo4g4/2591G0U
         cDEw==
X-Gm-Message-State: AOAM5319+Nk3Ppb2D6C4tT6DkiT304u6YSQsbYEmqbXuT4lOBT4qCFFx
        d/LmQpbuSXu5tc/+9Ac3VE8=
X-Google-Smtp-Source: ABdhPJx/bfCUyH29BoIKRIi5KxIuFIe52a/Z+BuypJtzgvJR0fd1/5QgPTlazMQvVIsJM2CV0HvXkw==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr5162646wrp.355.1595409481733;
        Wed, 22 Jul 2020 02:18:01 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id t202sm6774483wmt.20.2020.07.22.02.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:18:01 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:17:58 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200722091758.GJ11341@szeder.dev>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200715100043.GG11341@szeder.dev>
 <20200715105521.GB3262157@coredump.intra.peff.net>
 <20200720200739.GB91942@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720200739.GB91942@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 20, 2020 at 04:07:39PM -0400, Taylor Blau wrote:
> What I'd rather do is something like:
> 
>   - Introduce this patch series with the 'test_must_fail ok=sigpipe',
>     and no error checking.

die_if_using_banned_filter() shows two error messages: a "fancy" one
is sent to the client in the ERR packet, including which particular
filter is not supported/allowed, and a simple 

  die(_("git upload-pack: banned object filter requested"));

If this die() were to show the same fancy error message as in the ERR
packet, then it would always make it to 'git clone's stderr in the
tests, so the tests could reliably check that 'git upload-pack' died
for the expected reason.

>   - Modify clone to swallow these errors and eat a packet or two.
> 
>   - Then, drop the 'ok=sigpipe' from t5616 after 'git clone' is a little
>     bit smarter here.
> 
> Maybe more steps than is strictly necessary, but I think it keeps the
> scope of the review on this series reasonable, which is a tradeoff that
> I'm willing to make.
> 
> > Probably git-clone should ignore SIGPIPE during the network transfer
> > portion of the process for the same reasons given in 143588949c (fetch:
> > ignore SIGPIPE during network operation, 2019-03-03).
> >
> > -Peff
> 
> Thanks,
> Taylor
