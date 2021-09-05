Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF18C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B35460F92
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhIEHnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhIEHnD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:43:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56838C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:42:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q3so4970090edt.5
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8x2HFJQLpMQH3RofIyBszIQdE7izGnF82uiyTGxI/Sw=;
        b=eczyO4YX2WmBYioNBjcM31Sfh5gyBFLd5CvDDCbzGBPjtZtEeNMAfwMWe1MkoByaFT
         MsQa0H+9pQeIePP95lT8TZkAzo+nVS7YGikT1EkpCg+1D3wB9itkuQJQV9fMHZMUAPnh
         C3NnKsCiOUcuz5fWzs6j37BA/8GXzg3lCIivBpCENJNfn0vL2AqHaCiH/r2JLDxPbHAh
         aavEJIH82FSNCd/DSUnbbWqHWuBTDgU/JnpqbrRP9TB1FAVpJDOtejC0raO6TIxXLeAV
         YeBXUoKDj2aABd66YyLBOS6iwiWRfW/eKDjo8Hc7AwBbqxMQriTloiZtK1qFaIaCBLbt
         ni3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8x2HFJQLpMQH3RofIyBszIQdE7izGnF82uiyTGxI/Sw=;
        b=QezbfJuvfOORxgcadl+e40qoPqO39ZI+z4uG5dRrI+FCUVkAJZfIvDpm5C9AWDyOZP
         /L3OaP3rM9K52WQy/4pe4aKun0bRpDZFHL3dF0o40VYxesQUBGgHC6ztgCt0xVyXu60Y
         DSegwP4Jd5evqifWQF5iU83LXxpfWV1DzwX4app+WgH00vRSsqSnWe4Ix6QF6T1JF6zq
         9Jtr6+gMxldRBO5Fx8PrdbiHdPz2GIEQdMOPq2ZTXdXr30DV/BJIEkLrFnT7iMsfIOeq
         1ANwCD1yDIoiXCr+bB3rXxaNsDHFU13lYfiAPGYoWPN4kxcAO0KPLtPKu0sxHxNi/LZb
         GQAQ==
X-Gm-Message-State: AOAM530/5cgjF7A9kmTTvw5WQt8JajrcnewTIpaEo3W+GsWdyOkFDK0H
        Gpb7dt9zL7BsSjXGcu1UBwg=
X-Google-Smtp-Source: ABdhPJwRWZqunvrmOJgXFqS1kHqIp3JpmzCi4X64tmnKW1OfB85zy4GfudJ3H/Zdm0bD0SeuP1TG9w==
X-Received: by 2002:a50:8e42:: with SMTP id 2mr7741822edx.338.1630827718733;
        Sun, 05 Sep 2021 00:41:58 -0700 (PDT)
Received: from evledraar (2a02-a45a-de66-1-2cbc-c868-da6a-49d1.fixed6.kpn.net. [2a02:a45a:de66:1:2cbc:c868:da6a:49d1])
        by smtp.gmail.com with ESMTPSA id dc7sm2440126edb.46.2021.09.05.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:41:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Sun, 05 Sep 2021 09:32:28 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
 <87lf4f9gre.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109042138410.55@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109042138410.55@tvgsbejvaqbjf.bet>
Message-ID: <87wnnvpiyj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 04 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 2 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> >  git-rebase--preserve-merges.sh | 1057 --------------------------------
>>
>> You could, but certainly don't have to, squash in the below. I.e. this
>> is the last user of eval_ngettext!
>
> s/last user/last in-tree user/
>
> Since we install `git-sh-i18n` and semi-advertised it as something to use
> in user scripts (which makes removing it somewhat questionable a goal,
> certainly when you do not even offer a deprecation period), and since the
> removal of such things is completely orthogonal to the intention of this
> patch series, I will not include this patch, let alone squash it into a
> commit whose purpose has nothing to do with gettext whatsoever.

Unlike whatever controversy we're having over git-sh-setup being removed
(see <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>[1]), the
git-sh-i18n's gettext() and eval_gettext() can't be useful to anyone out
of git.git's tree, since they accept strings that are expected to be
found in git.git's generated *.mo files.

So it's certainly possible that someone's used out out-of-tree, but that
use of eval_gettext() won't have been doing anything useful in terms of
translation, and if it did that would have been because someone copied a
to-be-translated string as-is, and expected git.git to keep it
byte-for-byte the same as their sources.

Anyway, if you don't want to squash this in I can submit it as some sort
of follow-up, perhaps along with some of the suggestions in
<62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>[2] if you're generally
aiming to keep the changes here to the depth of the first callstack,
i.e. remove the --preserve-merges use of a foo(), but not a foo()
function itself if that foo() then becomes orphaned as a result.

1. https://lore.kernel.org/git/cover-0.9-00000000000-20210902T155758Z-avara=
b@gmail.com/
2. https://lore.kernel.org/git/62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.c=
om/
