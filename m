Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6440CC4727F
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D13023119
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiQHGU/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWK1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIWK1S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 06:27:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C495C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:27:18 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 16so22240440qkf.4
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UvGNCOmDKOvZ5vaK+jNWRc45APOiKZvmOE4SF7DqeYg=;
        b=tiQHGU/cF8T++VS/3e3MQ4hTX1Crb757ImXfMjGze/V57Uh2Was+3WWVCI7AuyVkHi
         urVUOZlmbzGsbPZRaXN2Kf5Xldk40Y99PDxPnioy0hsFpd/jINRJh5SneZvaWYtt1FiS
         Mkf6VB+IMYQC+i3SmH1JrE/sCvC7PLXBbXHl4dglW6NC585pb/eJiYaevNcaCzHRjun9
         XPfMePSfyDplEn3i7gyFvyK75E6zcJJMHT6hZwiDChxadubIDoc5/cezU6ymW7XQFMSP
         J+CaJQk1LtHfAUf8JpCYMwkNj1HFn0P23TmIBij820vYEu03icwbwJuljbmhbyk9VPa8
         OrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvGNCOmDKOvZ5vaK+jNWRc45APOiKZvmOE4SF7DqeYg=;
        b=qV2OZsDD+U/WRKhLUZKblimPu9K1Doi2h4+nZ2EjpPbyNFQPrHsJhTgu6Wq8P/+rD8
         BoxOrz4+ZwOvFcEbYgFa1tv6TprT6vBJtKWqsDpnus2jL+ZMP3gwsyFhXyRAne0ui7WU
         zeZvmbV2yNlNkeKnu/nZkuQFDdwNaFmvvdbRRMdZMIGQyhH6nBoYdxTN64PCarPGPvru
         kl3D8yYPzo8/CWEDR/Bp11l1NrFSAlPvFAGIlRjlM5CCpOgKxnH/lA9OZaAeULsO3xCm
         vyNkw21god4iuzZ5lD6Due3uhh13nNfZM3WkPeilPKnGESVZRnpZ82SJovvOqlFcMAlg
         zgbA==
X-Gm-Message-State: AOAM5339b8ZLlOOBJAZrW1D/bloOt36bs08ZsEmzGNlgEkj7vE2SAYCW
        5mwR1UwCO/VtyFSBF+sv/jnhRY22ch87h1Yt70M=
X-Google-Smtp-Source: ABdhPJw7jguWBBj8ggk2PBuIo7+2VK80FzYeGp0lhDToOs97sLnECuYay4Y2xkNJFvn8829PHuX9ug==
X-Received: by 2002:a05:620a:2006:: with SMTP id c6mr8508235qka.240.1600856837371;
        Wed, 23 Sep 2020 03:27:17 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.107.121])
        by smtp.gmail.com with ESMTPSA id y73sm13237560qkb.23.2020.09.23.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:27:16 -0700 (PDT)
Date:   Wed, 23 Sep 2020 15:57:11 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20200923102711.GB70669@mail.clickyotomy.dev>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
 <xmqqft7djzz0.fsf@gitster.c.googlers.com>
 <f6bb2b1f-0f1b-f196-59f1-893580430cf2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bb2b1f-0f1b-f196-59f1-893580430cf2@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 09/21/2020 14:19, Phillip Wood wrote:
> As I said before[1] I think we should also be checking the reflog dates so
> that we do not look at any local reflog entries that are older than the most
> recent reflog entry for the remote tracking branch. This protects against a
> background fetch when the remote has been rewound and it would also reduce
> the number of calls to in_merge_bases().

Thanks for suggesting this; I must have missed it earlier (sorry).
The latest patch [1], has been updated to take timestamps into
account which helps reduce the number of reflog iterations.

[1]: https://public-inbox.org/git/20200923073022.61293-1-shrinidhi.kaushik@gmail.com/

Thanks.
--
Srinidhi Kaushik
