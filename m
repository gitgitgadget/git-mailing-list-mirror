Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99EC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9879F64E34
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhBOSyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhBOSx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:53:58 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF73C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:53:17 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 2so3605571qvd.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l3Eg/WzYvyo8HkkaTepyrjKm3/+Cz8mHEIvXWZf59ic=;
        b=2R00P91zmiy7E2XYtOXYJPBUK0Sb5SXP2bHVEc6mxWoZurS3AVScrfFjCY9umEbhoN
         MFheT00EXGto2l7NHyVa2pY28KGJI47DMnX+FHOjIN3UfeG+BukKq5VC3nphQza3hgiC
         GOYP1Y1Dar/u5uVkfIa1VDrVoBmgU5wANfbgfI4PFb3ngFZlQyBumZOd/2Ht8+GnbPgC
         pz3OY0FhIvAlxakDXZH6tTDGe/Sgv2utz/TMOfbpzXbpLuA9J/h/MOW6SoPVZSmovx13
         KfVtXeKT4VldhHWT9aSQja9wpn+Ts1rk5TKtrMj+SYyRJKBwhqvEeCiG9EZasQlgVCP+
         8r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l3Eg/WzYvyo8HkkaTepyrjKm3/+Cz8mHEIvXWZf59ic=;
        b=TBUaylOkoddHRfiaYHIZs3WH+yUpZQqD/lF/4xKOrE1ARbm86240L6yDvMRY9IGq8V
         ItfLtJnOq97avfWoTQcFUYgR7YYoKLUj2Fm5x6/w+4JQUSXlFKIfboPK/P/J4q0h81/r
         HLlBrvaMf/Lch+WMmikoAI2Euy48vLXI4HRzidDfhoipp0R+ld68LWgwD+qY5gjrbNGW
         KS7org5/AsnCLsoXjg4dMISDIH1YrwgJctT+0Omm98FEf/KaOkvLWr5HVEELNU31OK1H
         zXhHylWxyMM+6msRw33npLBaZmVxYy3AQ5PoK8FjRbdoOMtJWdMc5tKmcGn2Kf8zihiN
         Eaew==
X-Gm-Message-State: AOAM531RkB61wLwAllXhyhGUeJItv+qmZ39v/U1JKzDzKY7QUibiG7IF
        wmuXndSdCUBk7a3mtYjEdDvGDQ==
X-Google-Smtp-Source: ABdhPJxVcV0I9G1kmSEpJyADDMXkKKc8QZAXuXT/UzSKXR9MnT6I/eKIx94FOOsE7DKqU5MJV3C5DQ==
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr9796058qvb.50.1613415196792;
        Mon, 15 Feb 2021 10:53:16 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id l7sm11656577qtu.13.2021.02.15.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:53:16 -0800 (PST)
Date:   Mon, 15 Feb 2021 13:53:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH 4/5] commit-graph: refactor dispatch loop for style
Message-ID: <YCrDGhIq7kU57p1s@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210215184118.11306-5-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 07:41:17PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I think it's more readable to have one if/elsif/else chain here than
> the code this replaces.

FWIW, I find the pre-image more readable than what you are proposing
replacing it with here.

Of course, I have no doubts about the obvious correctness of this patch;
I'm merely suggesting that I wouldn't be sad to see us apply the first
three patches, and the fifth patch, but drop this one.

Thanks,
Taylor
