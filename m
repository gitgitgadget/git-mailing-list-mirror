Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F337AC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCFC613C7
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhE0A0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhE0A0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:26:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED07C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:24:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so1287474pjp.4
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VhpMfoyyyfBOsqnmU2QVrRMvPj+XPH5sVOwC5IpaU6s=;
        b=cTRAivKHb/DhlaKxj+4n+n44hWTyxXHbKu4VQv3ToktMZXp6AOXHatavjbOw8aIUgc
         iScLt2hO1qp3G1TtIFYllPgMisS1mNJI3vudNasy7YJ+1lnm+lI+r5TJbiqhhXJPBpEG
         knr9k28OgJtT22CYPjUCw3pYVpDY6OholGkoz4oKmT2B7PJ1kFWZwn8f4w3Rn6qOI1Ng
         H/Hxpd1GuNVtMbl6p4DYfCclMqaFF6NX8nLSaUDxEIs2EGirU17ZyIBWVXaS4TUaE1go
         693KyY7cfAcbR2aPhU1r1/CIEKsiDEPff+QRiL1e4LEi0kYxojicOr5WwjTYrrTVTB08
         4daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VhpMfoyyyfBOsqnmU2QVrRMvPj+XPH5sVOwC5IpaU6s=;
        b=HvcWJejAMMsSJvJ/U3MHAfqdMOLoyRG7pm5TueyUMYVCXmiBlSqYzQObup1JKv+dKz
         NJjRa8JcI47sRlJOl0jROHEjwyyxpS3xhszOKOZxmehn/MINp+/E2E0X8Km9ZlIr+4I0
         f6AjZ0voYcq8LGo4rcImXdRfVuj326r4OzajBbBrcSOHaDDLSEt051RbpJ7r9uUBQ7ic
         q79ZL38AGlTW0L+eeGqgPGyN8IOo44pnNGUbhR8P9ys8jtaF5cE7eDKHEG2O+29Ah5Is
         UmSWTgC07GxvlmFXyRo+6XIlynkV0uqcLSCtZRkEmbp/h/4n5rv6995Enaa923C5KdmY
         5gAA==
X-Gm-Message-State: AOAM531o8XC9Q8xX3Zl2518cmBZ74WTObD6+NDS3+q98OSEx6jUSJXBT
        rkyRb1dCYHCEZib66RSQSyV3A+7MA3Gtyw==
X-Google-Smtp-Source: ABdhPJw95rSng2hSLOkp/0NFCz6bzzoXERK/LCUjP6nilaZYHZIvI4eEfye1jsb+lJ2UYt4RGRG3Bw==
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr821533pjb.65.1622075087982;
        Wed, 26 May 2021 17:24:47 -0700 (PDT)
Received: from localhost ([2402:800:63b8:812a:adcf:8995:bb0b:8236])
        by smtp.gmail.com with ESMTPSA id i14sm292203pfk.130.2021.05.26.17.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 17:24:47 -0700 (PDT)
Date:   Thu, 27 May 2021 07:24:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <YK7mzXItolJqvjNr@danh.dev>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <60a7fe0b2dd8d_558062087@natae.notmuch>
 <875yz5m5hd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yz5m5hd.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-27 01:35:21+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Fri, May 21 2021, Felipe Contreras wrote:
> 
> > Jeff King wrote:
> >> Of course there's value in coordinating. Everybody _can_ hang out on
> >> their favorite venues and eventually talk to each other, but it's much
> >> easier if everybody agrees where to go. :)
> >
> > I don't think it works that way.
> >
> > I "everybody" agrees to move to Discord, many old-timers won't. Same
> > with Gitter. And if most people were on IRC, many youngsters wouldn't
> > come.
> >
> > There's a limit to how many chat applications you are willing juggle,
> > and adding one more just to chat with git developers is something many
> > people won't do.
> 
> In the case of IRC though there's many IRC-to-X gateways that allow you
> to somewhat have your cake and eat it too, e.g. there's one for
> discord[1].
> 
> I haven't tried it, but I use another channel that has an
> irc-to-Telegram (the app) gateway[2]. It works quite well. Aside from
> the Freenode v.s. Librechat question I wonder if there'd be interest in
> having such a thing running for #git or #git-devel.

FWIW, Matrix also runs a bridge for IRC. There're existing bridges
for freenode and OFTC. And, a new bridge for libera is WIP.

> 
> 1. https://github.com/reactiflux/discord-irc
> 2. https://github.com/FruitieX/teleirc

-- 
Danh
