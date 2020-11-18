Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB4AC56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038D52168B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCoRoS0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKRSae (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 13:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgKRSad (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 13:30:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86088C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:30:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so3114382wrr.13
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RVmK5NIPLLXSYaqZdPcfl+MAajr8mT15xa1RvA2Ml2I=;
        b=NCoRoS0CFWqdKweAPYM/yWjD3P6KzNlqniVcaL7WtbhtnImXxsC8eA/oTqrYXBZnf/
         frHLQBJ5+AxyK6LlVTsHZsh9dvp4HuZXi/gu4RlK/42LuRznz88lq/byBXcLHolJM1NU
         dhC+NqVi6jn8jYqj2zygOMwHAyUhG164LmR6jbzaobr4WdNrggLViLf62IsZtMHovJ2W
         q0EnW+w7O7PN/mlN0wzAevjpMrgUIRptxo8fDRFnDWln1nQj1Lv54+a3SC5qllvGYApx
         hDgoaopQREkazGWgA7Vs0QpBXs/MvrAp7dzK+3GOAOssNg0Y0Xo/sYcmjZ1j8cysrk9i
         cPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RVmK5NIPLLXSYaqZdPcfl+MAajr8mT15xa1RvA2Ml2I=;
        b=Q/qzrL3yx+SjKP7lPti3pgutlFmme2GNIUfUZwyU1W0cVcq1mvOihtSE3MLdpqOJx9
         mwHoHY9B0bVi78ifKup4FWDOmBx0RC7DfECAMHaZ8h/B0vlL0tTwY+/G4OTDoNkzvdIS
         zTI4HHpDMDKgaSEtWtYzy4YX5gmM0wRqY9OFiVy2H/VeLd1BZB5MJnRG/KuAwS49Va0v
         52sweJqnXhOqza+Y75E8/Gpz01UUyMTk/Aca1Rr7Olh6t7zVHcZHzhvemWjiqqcOYUIX
         QxEne46mXtrE9T7x3hUqEknhiVAesiC0ikxESRXXTKB8JM1O/2HUc0HTfNV50kxOC4Xd
         40vw==
X-Gm-Message-State: AOAM531bZzkiWnLCXMHJzoO4gLlZ38vy72zxUdY/hWw0ViPa8lYkMnV1
        0KYMvoSx7oA0cy/pEWNwCHR5KlorDZA=
X-Google-Smtp-Source: ABdhPJyvZ4PrLYnlCEGAa55f2eVZ9QGrkZCgM4OM+fnzEzN0IjyPs8meaJyNokZ3dHvn68YcBg5NiA==
X-Received: by 2002:a5d:5405:: with SMTP id g5mr6251952wrv.350.1605724232277;
        Wed, 18 Nov 2020 10:30:32 -0800 (PST)
Received: from szeder.dev (78-131-14-45.pool.digikabel.hu. [78.131.14.45])
        by smtp.gmail.com with ESMTPSA id p4sm5798751wmc.46.2020.11.18.10.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 10:30:31 -0800 (PST)
Date:   Wed, 18 Nov 2020 19:30:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
Message-ID: <20201118183022.GA8396@szeder.dev>
References: <20201113215307.20855-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.2011152252520.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2011152252520.18437@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 15, 2020 at 11:08:40PM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Fri, 13 Nov 2020, SZEDER Gábor wrote:
> 
> > In 't5310-pack-bitmaps.sh' two tests make sure that our pack bitmaps
> > are compatible with JGit's bitmaps.  Alas, not even the most recent
> > JGit version (5.9.0.202009080501-r) supports SHA256 yet, so when this
> > test script is run with GIT_TEST_DEFAULT_HASH=sha256 on a setup with
> > JGit installed in PATH, then these two tests fail.
> 
> I wonder whether there is a way to change the `JGIT` prereq in a way
> that automagically will recognize a (future) SHA256-enabled JGit?
> Something like
> 
> test_lazy_prereq JGIT '
> 	jgit --version &&
>         test_have_prereq !SHA1 ||
> 	test "$(git rev-list -n 1 HEAD)" = "$(jgit rev-list -n 1 HEAD)"
> '
> 
> What do you think?

I'm not sure.  It is surely a substantial effort to fully support
SHA256, and I suppose there will be JGit versions with only partial
support.  I'm worried that there will be versions that can already
read SHA256 objects, but can't read/write SHA256 pack bitmaps, or
can't transfer/negotiate SHA256 objects yet (for t5512), so even
though they could fulfill such a prereq test above, the test would
still fail.


