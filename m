Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C881ACE79A7
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 23:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjIYXGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjIYXGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 19:06:30 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1011C
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 16:06:22 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c215f2f4aso96338687b3.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695683182; x=1696287982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FI3XPLd+1qesqOMgwHxYLTEHUZs0E7lLSwW+Gb/eGFE=;
        b=EjHQEz4UPGuOpkQtt9S1Ld++JSAh5zCA2ceFDHahQNw6bhkn7JB8Zold6gAP5o0Isi
         P+Va2kJ8+zd4E8GQNd+I8IPY1d3DUcbg5nN0IDtOma6AEFQyfxS0i7Cb1CsJq6QolOC2
         an43HivTg8ARrGcbm735qKD8QXsdwWNALXqZqi6hQxgP6h4c4B4k3QgT+d1OQVjrka9X
         a5CascDXU7hj27GVUCt2EzwCCcgajWDvVWMC5BHcou84x9gKtLRm9yvt3Jx4bQTe1nOQ
         4IGpCa+eaT7q0CyzlPdWuvqLyu6/TjKYjZSPeFdNoKT2bKll5dEsLgYasM/BnII/Nax9
         bxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695683182; x=1696287982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FI3XPLd+1qesqOMgwHxYLTEHUZs0E7lLSwW+Gb/eGFE=;
        b=hw1z689Unj963HE3lZrPoue1IccvpT8xhC5x+iWhRayRcPJVJh0XRAMSEPAFTJ942s
         7dj221LbjsdQyS5TjO074u29rQM3mmyTXIkj/EtUKtzjCiQ2x2S7o0TVp+A6Vdw6vtad
         W0fiH4oWqHDhYuIv4ikdZXELA0sJCJdYp/04ghnqJunV2S7iNRjyp5a2s0igzPCcLfye
         JDqWYkuN3rFoSnV1uEwdnOpMAqohfezEg/lZret7FlGYo1sgFpxlg19q4OJJUgp0VQSE
         qX5jo6dvhS+Ld0v5a1IreVr9qf35YhUR/Zg2GybKBPZuAOn/h0nuidpwVX4iMkYy6Gbo
         gxtg==
X-Gm-Message-State: AOJu0YytgoSRyHAyS2OJc5quYtB1ah0N73Ps9iiM2oRKkzLc6L4UA+bO
        2oWdG/As6G2wJ7DTMYflBixF9dKfJWD5cI1HR81H9g==
X-Google-Smtp-Source: AGHT+IHlwSBNI/zUN1vu7cqImfYOY6ytzfr2hNK5XG6/GPuWjM5MKYjtNCCtXQqldV3I8Qd1w8eosA==
X-Received: by 2002:a25:6b01:0:b0:d71:69ff:ba74 with SMTP id g1-20020a256b01000000b00d7169ffba74mr7021026ybc.23.1695683182176;
        Mon, 25 Sep 2023 16:06:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l26-20020a25b31a000000b00d7745e2bb19sm2431680ybj.29.2023.09.25.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 16:06:21 -0700 (PDT)
Date:   Mon, 25 Sep 2023 19:06:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2023, #05; Fri, 15)
Message-ID: <ZRISbdyy1OhcOKgj@nand.local>
References: <xmqqmsxmdhdw.fsf@gitster.g>
 <ZQnpIBR4hEbOLCwP@nand.local>
 <20230924195900.GA1156862@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230924195900.GA1156862@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 24, 2023 at 09:59:00PM +0200, SZEDER Gábor wrote:
> Besides the issue of not reading Bloom filter for root commits, that
> message of mine also includes a test demonstrating that handling split
> commit graph with layers containing different versions of Bloom
> filters is broken.  That test still fails with the current version of
> this patch series, i.e. what is currently in seen.  Jonathan provided
> a patch that makes that test pass, and also noted that that test did
> pass with his original design:
>
>   https://public-inbox.org/git/20230901205616.3572722-1-jonathantanmy@google.com/

I am not sure whether you are pointing out an existing breakage which
remains unfixed, or pointing out a new bug introduced by this series. I
think that it is the former, but I wrote up some of my confusion in:

  https://lore.kernel.org/git/ZRIRtlbsYadg7EUx@nand.local/

> I maintain that without test cases thoroughly covering the interaction
> of different Bloom filter versions with split commit graphs this
> series should not be merged.

Agreed. We should wait for the discussion in the linked thread to settle
before merging this down.

Thanks,
Taylor
