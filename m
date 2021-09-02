Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2FC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 10:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F80610A2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 10:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbhIBKn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbhIBKnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 06:43:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC7C061760
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 03:42:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so2157715wrn.5
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JXLauDeVfOK/RFSMD1oz37DsWRJDY71l20Iu5aSVC1I=;
        b=Z2Y+lUaUKn7wNYkFiue2Pc7LUK+THfcm4/u11Zu19THZtq+5Pz0KEXPRRuewT2VgKd
         jZnXBAvQhO5fvQGG6PJfteSyi5HM9fNZJtYk93WLradtwZA4Npf7dYUKS8+dS5+cuCrK
         rYrwX046P1AEGaIt1703T8chKfoYYIBdU23+Gmg6VXO7I81nKX0GzO0N1Bby6Ql5iaoz
         8NDRXvaRqCz2fPPkkxvQK7KX0jSjxI+NWO1FIserGczN74NpwYLDd+8xuRtoCvi2QCdy
         TUO9lEHPhtx8Zk+WXf6KJfvfflRCgTHLfAT6vNhKx5WjX/15Qt+OapnnyCs/OhfSaMG8
         sybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JXLauDeVfOK/RFSMD1oz37DsWRJDY71l20Iu5aSVC1I=;
        b=K4w9R4PAC/bAVz0xK4DDuAIpTW+11Ayc59e2nG3ozZBGgoNAJlmoLry9MKrDRkO/dG
         80Sjfz7e1bA2n7WrMfAvnBwHkZTMd20xJG+zW7zosaXdybJ6rbBszYErFdprooSTuYuD
         VPyXw/FtQhtaLH8ufeMTEv5FzYYgbHBQCniTqWu6c2pg2YXFVUZOly5T6WWo6TYKAzhF
         YVHCYxv4UlN+TsBBjTx92XpVJYgny/h2XJfPQdDr/25hguMMBz8stpNXKq7engBYSDoB
         rf/5zv5WLDewQBys7WbHOVMnpIf/p9RTQJmdfNY1bB9e9BrKZqzTDtA5Jq9ujWWpqEpt
         zlVQ==
X-Gm-Message-State: AOAM533vBbAd2l5IAks0PmZp34B97NtKnu3RBD0UYzW7gEj30jDC8nrk
        U3q54+8geZZnpQbkS9bb1tEFHZpt61SviA==
X-Google-Smtp-Source: ABdhPJwHSvyJvpHfT1vVCvMfzKVNYBTvq3wOJTzN4uIyPgBO12Ltk4QNErDFgq6DlOZJ2YAZok7O0w==
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr2917850wrs.296.1630579343100;
        Thu, 02 Sep 2021 03:42:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m3sm1808525wrg.45.2021.09.02.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 03:42:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] makefile: teach git about NO_MSGFMT (as supported in
 GUI and gitk)
Date:   Thu, 02 Sep 2021 12:38:52 +0200
References: <20210902085438.54121-1-carenas@gmail.com>
 <87ilzjuv2t.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87ilzjuv2t.fsf@evledraar.gmail.com>
Message-ID: <87fsunuulu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Sep 02 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
>> NO_MSGFMT can be used to indicate there is no msgfmt available, so
>> make git recognize that and avoid failing to build while trying to
>> generate i18n files.
>
> Why would we want to avoid failing the build if we don't have msgfmt?
>
> I understand why you'd want NO_GETTEXT in that case, but what's the
> point of building with NO_GETTEXT=3D NO_MSGFMT=3DY?
>
> If we can't build the *.mo files we'll have a completely broken
> installation that can't do anything useful with gettext, so why not just
> build without gettext at that point?
>
> When this patch is applied a lot of things related to gettext in our
> tests fail if you build with NO_GETTEXT=3D NO_MSGFMT=3DY, because those
> things are assuming that if NO_GETTEXT isn't defined we'll have the *.mo
> files, po/build etc.

Some further digging reveals that we've got in-tree git-gui/po/po2msg.sh
and gitk-git/po/po2msg.sh (copy/pasted, but slightly different) that
supports some subset of "msgfmt --tcl".

I.e. those programs with NO_MSGFMT still ends up with locae files they
can use, whereas in this patch we don't end up with anything at all...
