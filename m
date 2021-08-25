Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E57C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B94B61026
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhHYQkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:40:00 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:56154 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242148AbhHYQj5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 12:39:57 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 12:39:56 EDT
Received: from myt6-d4eda2ca0046.qloud-c.yandex.net (myt6-d4eda2ca0046.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4e0f:0:640:d4ed:a2ca])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 517E510A9B2F;
        Wed, 25 Aug 2021 19:32:25 +0300 (MSK)
Received: from myt3-07a4bd8655f2.qloud-c.yandex.net (myt3-07a4bd8655f2.qloud-c.yandex.net [2a02:6b8:c12:693:0:640:7a4:bd86])
        by myt6-d4eda2ca0046.qloud-c.yandex.net (mxback/Yandex) with ESMTP id IKbWZ4H0Hz-WPHmKlOQ;
        Wed, 25 Aug 2021 19:32:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1629909145;
        bh=awLJcM8VWBMyy4p+fiDoodF4dGW/9sK6GESNZbRgCfk=;
        h=In-Reply-To:References:Date:To:From:Subject:Message-ID:Cc;
        b=dPdKFaSzCWZRX8I4v4s9IxpucXwLmpJVWK6iKiZix2xs794MbP9eYKnUGXdSryPWR
         AqDK6nVVDNp1nn+GnPxmpS2kTegmEry/ov2Ify1qBXrVVIBsC3tGaZNioyeswyV+F2
         NM6y6yd65D2O4qVX0eH/OOduGnSM3G6YycEw2AN8=
Authentication-Results: myt6-d4eda2ca0046.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-07a4bd8655f2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id AgGAM83b3l-WOZuZb13;
        Wed, 25 Aug 2021 19:32:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <b1c62f6aa1eb06b64ee095dff23709a42d25cb16.camel@yandex.ru>
Subject: Re: How to interactively rebase-and-reword nth commit?
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Wed, 25 Aug 2021 19:32:24 +0300
In-Reply-To: <CAN0heSoxE8zjzbYqRY6zvva=GEXEWx1k8FGhJMCf6N=pEcpZFw@mail.gmail.com>
References: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
         <CAN0heSoxE8zjzbYqRY6zvva=GEXEWx1k8FGhJMCf6N=pEcpZFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amazing, thank you, simple replacing EDITOR with GIT_SEQUENCE_EDITOR worked for
me!

On Wed, 2021-08-25 at 17:54 +0200, Martin Ågren wrote:
> Hi Konstantin,
> 
> On Wed, 25 Aug 2021 at 16:07, Konstantin Kharlamov <hi-angel@yandex.ru> wrote:
> > I'm almost happy with `rebase-at`, except I don't know of any way to make it
> > work
> > with `reword` git action. You see, "rewording a commit" requires to run
> > EDITOR twice:
> > first to substitute `pick` with `reword`, and then to actually edit the
> > commit
> > message. But since EDITOR was substituted with sed, the 2nd run won't give
> > you an
> > actual editor to change the commit message.
> 
> I think GIT_SEQUENCE_EDITOR is for pretty much exactly such a use-case:
> 
>   This environment variable overrides the configured Git editor when
>   editing the todo list of an interactive rebase. See also git-
>   rebase(1) and the sequence.editor option in git-config(1).
> 
> Does that help, by not stomping on EDITOR/GIT_EDITOR?
> 
> Martin


