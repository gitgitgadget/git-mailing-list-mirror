Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D656C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 15:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiFXPd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiFXPd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 11:33:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA15DF08
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:33:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fi2so5430006ejb.9
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xgYwTcMW3HjuhCtUCYUXrc4/4druj1MKp+pwhky4mEE=;
        b=eUJsD9XoZdHQyHhZ9P29kOsRjQkaaFlEE+gyHgpSrQQG58WRRlfKwKJ5QSqFqfE//g
         WEunp1WLln26UAQmfvHiIcBO00mn2Yygcs8ToLamHDI/kPjWtCvEAcUOsGH8dShgFEL9
         vjf79+xgkdWdKtvWkyIcDtxM5SrM6lIAgae+o4wSVM1XBwZ+6kPsAsXeFWZM2qxYMAYj
         Hkifu/qK6I/2LFbzJck0jFLGpeUIIGCotJQGSaS8PL4+lCnabJCDh4H+SnlBN+df9mVS
         R78p3iAEjZqBVr7pF4GJID1OXKr8GDYR6ldmmVw9TOSyIbLCVDm+zyUTkGciV32yIb69
         vhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xgYwTcMW3HjuhCtUCYUXrc4/4druj1MKp+pwhky4mEE=;
        b=nqBV86s7pOM7C5pl9PiX8XKY0Wd5d3XQeX4ov4k3tjbnaJYFiMOZD67AxifdLPubY2
         cTyewTTk3Aop5lvmL9wT2SILPK3QjNMoSdnuWztGXWn6JBbPPNLNGwwYsn4S69eMVJCF
         MLJcOkOCmAZ37aWlrHS/E043D1bDdRFMvaU40AQhSkHPrttFBxGppA/ilDocjVeFgVBa
         bx3NjdOSnzZGSqeHhKLe8dVba5uKXJAB0rWXIt2RJnZxnsftVWLRhtfzcLTa07pqmZ9C
         Rxd6p/GWjRH2cV5371kfgjDmUyYLPt5Ti4fYOoYouPO2n/aeoBIexHBRh5Khb6tlyouu
         xKzQ==
X-Gm-Message-State: AJIora/l9yHDB46KAUN++qNiGG7VA2vXiEbROhgtp6aWE+aB7J3eopkK
        Am4d1BBVEM6yuzK6mQgaAs4QUkJHDBruWQ==
X-Google-Smtp-Source: AGRyM1tIsDAWjvyvQhBlJ1H7Q06nUl2TXsepF9SNWPx+YlEBV6iYO9ucqEq5KlCiqgm89xKcKbJOjg==
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id s5-20020a17090699c500b006df82154ccdmr14139418ejn.684.1656084831775;
        Fri, 24 Jun 2022 08:33:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a18-20020aa7cf12000000b0043503d2fa35sm2315285edy.87.2022.06.24.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 08:33:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4lJe-001Ngi-Lf;
        Fri, 24 Jun 2022 17:33:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Tim Chase <git@tim.thechases.com>, git@vger.kernel.org,
        Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
Subject: Re: stashing only unstaged changes?
Date:   Fri, 24 Jun 2022 17:32:23 +0200
References: <20220621142618.239b02cd@bigbox.attlocal.net>
 <220624.86tu8ai4mr.gmgdl@evledraar.gmail.com>
 <CA+JQ7M8gaEWHHdx2or2kQfYpp=XBxQS=pXtEOS4x5SBdpPWdkQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CA+JQ7M8gaEWHHdx2or2kQfYpp=XBxQS=pXtEOS4x5SBdpPWdkQ@mail.gmail.com>
Message-ID: <220624.86czeyhy8x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 24 2022, Erik Cervin Edin wrote:

> On Fri, Jun 24, 2022 at 3:20 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Is what you want equivalent to:
>>
>>     # save the "git add -p"'d chunks
>>     git stash push --staged
>>     # save the "uncommitted"
>>     git stash push
>>     # pop the previously staged
>>     git stash pop --index stash@{1}
>>
>> ?
>
> Never noticed --staged before.
> I just tried to
>   seq 1 3 >> bar
> then git add -p to stage with 2 and 3
> followed by a git stash push --staged but that gave me the error
>
>> error: patch failed: bar:2
>> error: bar: patch does not apply
>> Cannot remove worktree changes
>
> But I'm guessing the command (and approach) work fine if the
> staged/unstaged are in different files.

Huh!

No, it does work when you stage chunks in the same file, I tested this
by modifying the top & bottom of our README.md.

But we do indeed have that error (which looks like an unrelated bug) if
you try to "git stash pust --staged" a hunk when that hunk overlaps with
changes that are unstaged.
