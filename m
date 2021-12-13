Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbhLMQ3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbhLMQ3s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:29:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1CC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:29:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t5so53754963edd.0
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FrJPt2hoC28htuIgeAig3dIMlMqRzcUu5KBzyiW6lBw=;
        b=LcNFfyfjBWlJKVg/vxW39WhT+aJTxcacarYadIafc+bOPYvE9q+/GL/dxrSsPK2Y/Y
         7rdFnpzVqOKVoJ8P/AbX53pvWb1Ci5Z527yiMTnlPfN1oqKpGyb0W4ApUQUYa76JHjqz
         2NgoEXJio6a2thseU88J98r9lRLQw7su1FSlnqWDMNbVdD6sBONRITgzjf/tVm783WUt
         ie9ng8Vw7I0GcVdX5ebkRgtCp68ij/B+uR6DkJq3rtQd+BPIwwBbMFGbBnufDqp7YsIf
         JI8WuAghAOX+iX5wnh9O8qHUGbmXGnA/HYrjbRD69e58pAxzVNA8zszkFRyTIkSJHYDJ
         pwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FrJPt2hoC28htuIgeAig3dIMlMqRzcUu5KBzyiW6lBw=;
        b=kok7E2Vba9mtqJY/kWc7T2f6IHRGD3vTjcdscT/ToSCGUw3DggExhBDW5GXPifvhuq
         lb2l+lzrUu4iArue2u14VtXh8werUlcWoA38FWCFXXTRzEzMvmuzgVlLPawQC1k5OryC
         Yk/XBzxXRODqPZSF3C16BqW8wvgBNW6ERvrPGuaMx39CO6af7biwivv0DdJ9lLMJ5CeO
         yi+2RU4ISTLqClLgk0zK+2l4sk+lTsejltQd9qEadmgK0HXVBP+qs035jKoJzOLDyQ3m
         O23U2tdL+0S6CfcbPm/ti4PCqgD+3L0aBVJ/1TMTtSWFk1cvUlokJe4MHvz9kAIdpJiN
         B9rA==
X-Gm-Message-State: AOAM533LzESCJywbOBIHTSJJJHzTQqWeH1N93ZfbJWu9EBC29cWZl9fW
        FTDZYTxKGtO+Zggll1Fhye0=
X-Google-Smtp-Source: ABdhPJxnqX6r0xRcFU+BAEwTRxFRcqxv0YoZprmcfk27SeFdq9cItgLKw8Lwih3XQc3CNcTJ8yJTrA==
X-Received: by 2002:a17:906:3b18:: with SMTP id g24mr44851074ejf.27.1639412986953;
        Mon, 13 Dec 2021 08:29:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p26sm6463515edt.94.2021.12.13.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:29:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwoCv-000uHb-7R;
        Mon, 13 Dec 2021 17:29:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/13] test-lib-functions: add and use a "write_hook"
 wrapper
Date:   Mon, 13 Dec 2021 17:29:34 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-10.13-ca55471d134-20211212T201308Z-avarab@gmail.com>
 <CAPig+cSkiFd27o8uACdX9ftg=N2XukqNSU_Tt+7rWT08JD7CAQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cSkiFd27o8uACdX9ftg=N2XukqNSU_Tt+7rWT08JD7CAQ@mail.gmail.com>
Message-ID: <211213.868rwo8o3q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Eric Sunshine wrote:

> On Sun, Dec 12, 2021 at 4:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Add a "write_hook" wrapper for the common case of "write_script
>> .git/hooks/<NAME>". This also accepts a "-C" option like
>> "test_commit". Let's convert various trivial cases of "write_script"
>> over to it.
>> [...]
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> @@ -551,6 +551,32 @@ write_script () {
>> +## Usage: write-hook pre-receive
>> +## Usage: write-hook -C some-dir pre-receive
>> +write_hook () {
>> +       indir=3D &&
>> +       while test $# !=3D 0
>> +       do
>
> It's not clear whether the intention is to maintain the &&-chain in
> this function...
>
>> +               case "$1" in
>> +               -C)
>> +                       indir=3D"$2"
>> +                       shift
>> +                       ;;
>
> ... or not care about it since it's broken here before `shift`...
>
>> +               -*)
>> +                       BUG "invalid write_hook: $1"
>> +                       ;;
>> +               *)
>> +                       break
>> +                       ;;
>> +               esac &&
>> +               shift
>> +       done &&
>> +       git_dir=3D$(git -C "$indir" rev-parse --absolute-git-dir) &&
>> +       hook_dir=3D"$git_dir/hooks" &&
>> +       hook_file=3D"$hook_dir/$1"
>> +       write_script "$hook_file"
>
> ... and here before `write_script`.

Thanks, those should all use &&-chaining. Will fix.
