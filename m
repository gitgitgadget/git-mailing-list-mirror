Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38205C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349254AbiHSOhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiHSOhU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 10:37:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0889EC4DD
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 07:37:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r16so5414078wrm.6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=TDRUTdn6bZTVr/X6ND2pIiLvztX4hoesL+OoYaAA7zk=;
        b=jplD9VLuzCdKXM2B0MNXSNnoDnQ6GEgrSII4REQoMAqK7PP1BhzTGVr2jTbkc4Ffu2
         902ZYGqli+Ghw/78MeL/bKAggL1xeaGnKkddDajb+gp6Egv2JfY5itv0IVx8EaLDX8cq
         Op3PrF58B6u7Uz+6YHnRUB5iNywkkT5Xx+qUPeV+wYCP0Y0jt1GhHkB2BFMhqIZmrzsG
         uveAIpf9dYjW5GH7Zuh614e7cci8SmKF32PbvdSl+HpPpF9otwnbiT4bNYCR9QCXCvk0
         uSRHyOgc+zXkH8/5bPX5arKniaazpJ34Si4o5VZUf7sfh3tUtU+Re4OirO0jXsFDlhHI
         59sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=TDRUTdn6bZTVr/X6ND2pIiLvztX4hoesL+OoYaAA7zk=;
        b=VYvkFxnb52M24bLtgnBdDVVEvNBNdUvt7C6VxzCPDqr5QbbG78kQH3z21drF5H0TFk
         Ta3CZ+5z1V6Jlr7mgGs9P21uibvzpNc+ACGiX0SMc45/yqMAh6jOZ+YyRYf4Y03UIIoP
         uQDWNksB6XWd1Tel0+DCM/tLMghTFlRNqdLUNuSf71vDB5uSQjP7Nrlgbav03SPCy5mf
         idzq6UYWvu7zREYo8mhimHoC4E9LBqwdU6M7dYVclB8UQosPn6UumacmF3+br0hL6Kty
         sRF8wx3Pbaf94s6mVsUvKL1IiH/RbC4idRCWmZMQIWft2xLiAbeHBYkkneldCfn007TP
         hVlg==
X-Gm-Message-State: ACgBeo3c0bf93zSynsW+rO+9MZctKy9TsH4D7+8L8D0WWlaRUO76Zxrc
        vfj1TnhvOkL96JkpchZxhFo=
X-Google-Smtp-Source: AA6agR6eSSxOr+lvoNfqujFJH7PHAzv2weNnHPI0Y3pHxxd+0lD/E4UzfRw5fDeurj3THAKozntolw==
X-Received: by 2002:a5d:6488:0:b0:225:f99:338b with SMTP id o8-20020a5d6488000000b002250f99338bmr4523831wri.638.1660919837363;
        Fri, 19 Aug 2022 07:37:17 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003a5ee64cc98sm10476092wmq.33.2022.08.19.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:37:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP37b-000kI7-15;
        Fri, 19 Aug 2022 16:37:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: js/bisect-in-c (was: What's cooking in git.git (Aug 2022, #06;
 Wed, 17))
Date:   Fri, 19 Aug 2022 16:28:03 +0200
References: <xmqq7d36s31e.fsf@gitster.g>
 <220818.86czcxafew.gmgdl@evledraar.gmail.com>
 <285nq583-p3p0-q9q3-90s9-q2po503rsp0n@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <285nq583-p3p0-q9q3-90s9-q2po503rsp0n@tzk.qr>
Message-ID: <220819.86wnb4710k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Johannes Schindelin wrote:

> On Thu, 18 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Aug 17 2022, Junio C Hamano wrote:
>>
>> > * js/bisect-in-c (2022-06-27) 16 commits
>> >  - bisect: no longer try to clean up left-over `.git/head-name` files
>> >  - bisect: remove Cogito-related code
>> >  - Turn `git bisect` into a full built-in
>> >  - bisect: move even the command-line parsing to `bisect--helper`
>> >  - bisect: teach the `bisect--helper` command to show the correct usag=
e strings
>> >  - bisect--helper: return only correct exit codes in `cmd_*()`
>> >  - bisect--helper: move the `BISECT_STATE` case to the end
>> >  - bisect--helper: make `--bisect-state` optional
>> >  - bisect--helper: align the sub-command order with git-bisect.sh
>> >  - bisect--helper: using `--bisect-state` without an argument is a bug
>> >  - bisect--helper: really retire `--bisect-autostart`
>> >  - bisect--helper: really retire --bisect-next-check
>> >  - bisect--helper: retire the --no-log option
>> >  - bisect: avoid double-quoting when printing the failed command
>> >  - bisect run: fix the error message
>> >  - bisect: verify that a bogus option won't try to start a bisection
>> >
>> >  Final bits of "git bisect.sh" have been rewritten in C.
>> >
>> >  Expecting a (hopefully final) reroll.
>> >  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>
>>
>> The msgid here is typo'd, the correct one is
>> https://lore.kernel.org/git/220627.86ilolhnnn.gmgdl@evledraar.gmail.com/
>> (i.e. a "2" is missing from the front).
>>
>> The more recent
>> https://lore.kernel.org/git/220817.86pmgzabv0.gmgdl@evledraar.gmail.com/
>> also has some more follow-up, and a proposed fix-up for one of the
>> issues I noted with the series (the completion helper interaction with
>> the new "bisect").
>
> So now we should also include changes for the completion into this patch
> series? Are you serious?

The proposed fix-up is for a part of git.c that only exists with your
series applied.

Before your series "git bisect--helper" supported
"--git-completion-helper" (although not to do anything useful in
practice).

With your series we have a "bisect" built-in. Built-ins by default claim
to support "--git-completion-helper", but as your series also migrated
the code away from parse_options() it doesn't anymore.

So it makes sense for the relevant patch(es) to update the corresponding
flag as that's changed, see also the in-flight 68494127d6c (git.c:
update NO_PARSEOPT markings, 2022-07-25).
