Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C2C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 13:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBJNWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 08:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjBJNWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 08:22:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC87C60B9A
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:22:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gr7so15799285ejb.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4tqjLXCH5StpCn4iAKyw2Q7Yzy5W+lexVDsePTCXLs=;
        b=X9BYNYWjqxm3ee7H0rZVFHe2AkWo42emnlRHmT24V2q4JdYp/7gsGUeX/wi8Db2ehJ
         D6tKzD+xl2o33OX5nhYgmSOa+gGMa0F49jbCvNuVEEhCEcUMoWZdo91O2I+1fp4k6j0d
         YOdwc6dydZYPvCXomPvPODPgy4tYVPHr5Gd1AbrHNxVuLXkWtJNw+8hx+e+XEYZ8F2yV
         lGSeY5ESGW2VC/AoejOuRZ6IDTx8p68W3A4NRLPkt3iecBFcKzXn12kSOgwTOPA+gr5p
         WiTv+mLNwL93kFZGtgpgbRUbpG1j524l/GNb3e1duME3aYAClv5HQzJY+bD05JOusHu7
         5BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4tqjLXCH5StpCn4iAKyw2Q7Yzy5W+lexVDsePTCXLs=;
        b=0KFB8atAvmBPrAbEQ46mRrheZQ3J9dWYgxQxGy3dsu8PF/Na4vZlHRbLdPtGEewunu
         YvqoBhCcYoMCDB6asEW7VEtB1EleOUZXaYo172jI+yCkVOlFT1BMpr/6+YjP6spxo7TJ
         iuMouygMQ90jGaX1RgRYBsqMd0qCuiik6fD+NB4HfNsi1+P9yknbdGqERWRFYPi9EclN
         GLYJtLnGVz01UxQnI5ltAVrx9vEPYcqRtfuAnItEqkRy3JFpHYMbqPHG+tcUTTqckWmP
         4KBLTFe2ySfi4fmp4CtWYCXm966vYNoGkkrmr6vVBTAkMkcs60AGbJyDHfTJu8CqW2si
         6ASg==
X-Gm-Message-State: AO0yUKXGXFS1MZ69awBrhT/lSbDlbnoMFC3FBcgjjxD3aUUf5WHF7MAF
        FuKtSS3IwuuV7ahz51c3EZI=
X-Google-Smtp-Source: AK7set+W92J/RsyM4Lz9mb0YGHwv7a/v0cSPmvcN31WBTwLxBgkU4OxXEkKmN719WkItceQEkhNsAQ==
X-Received: by 2002:a17:907:a804:b0:8a6:5720:9101 with SMTP id vo4-20020a170907a80400b008a657209101mr17910003ejc.4.1676035330540;
        Fri, 10 Feb 2023 05:22:10 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906135800b00872a726783dsm2328618ejb.217.2023.02.10.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:22:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQTLt-001vpR-1Y;
        Fri, 10 Feb 2023 14:22:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Rienstra <mrienstra@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Markdown release notes
Date:   Fri, 10 Feb 2023 14:20:46 +0100
References: <CABBAUF+acoMScQfHFQGooPx9eng2FBeb-Z2619DsnCt5QmhQPQ@mail.gmail.com>
 <Y+V0Mu/v/FO5318/@tapette.crustytoothpaste.net>
 <CABBAUFKv64xhJtwRk9kMWBov=nV_QzvR-jJqhJxKQyej3pcYCQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CABBAUFKv64xhJtwRk9kMWBov=nV_QzvR-jJqhJxKQyej3pcYCQ@mail.gmail.com>
Message-ID: <230210.86wn4pveny.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Michael Rienstra wrote:

> Unless I'm mistaken: Right now, release notes are only in the
> `git/git` repo, which is what git-scm.com links to. They are not
> stored in the `git/git-scm` repo.

Yes, but when we deploy git-scm.com we pull in git.git.

> Sounds like you're suggesting either (A) migrating them to the
> `git/git-scm` repo, 

Definitely not this.

> (B) having them in both repos, or 

Not this

> (C) displaying
> them on git-scm.com, but the underlying files would be retrieved from
> the `git/git` repo as part of the build pipeline for git-scm.com (so
> to speak). "C" sounds like the cleanest path forward, as it wouldn't
> involve any duplication or breakage.

Yeah, and most of that pipeline is set up already. I think it would be
valuable to render these release notes on that site. Thanks for working
on this.
