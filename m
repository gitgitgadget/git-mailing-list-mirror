Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475F7C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 21:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBEVgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 16:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEVgN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 16:36:13 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28719CA09
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 13:36:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so29230153ejc.4
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 13:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2V5ESQOdmLkGav881EYV7JvyRcGgEQgDIqw4ib7MIIA=;
        b=gbT82yu/7nkeUXh8572CizvZeeHdFW7Vw7KuSDTfC1V6t/bsfKg2b/gm/NkAiQsFE1
         XPasu5Pqo/RxNtSxAFbrpUXEy0CUI0P+1iPjLSjgFZcpuHtE+XYaima/twieb0qzJJYb
         dzRFrh2RighqxtYhv3icZSuTzjy5R1nz7yJqzZjNYyAk4+02Z05jdCE3XMb2fYmtx8Tg
         TbUEGyMDY0YXKjaSGomoYNIQ59pGorMCKbgweDnN8RFdfzXRk8wejnH47tMKDY505oqA
         hr97IQcZf4nZ3/SFegaJIrH4ybsfr24eUiQziovSxobou5dA9Pt/RJ89of//dGxZZERQ
         xXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2V5ESQOdmLkGav881EYV7JvyRcGgEQgDIqw4ib7MIIA=;
        b=1Ek3HOtm9GUnXsmFPke03PmLl+8CUchQzIrewdy19Q+uM8OiLXom1wTs9bDrDG8zaQ
         geylLBEcX92cgaZ8cWEaT8smP4G4q1Ie+ERahn3AS9KN14Mf0JiUlPaf+D04o7ukKJOM
         EUN5vzhy3SvzylijwNDSV11ClcbNUn9A8G1y1C8nrbl2aAVKaCXxBmLw574vq4/9TTCL
         Pjxzc3ZvsmDK41T3knssBT3eS4JBbyMmtPz6EOpF83kpc8T09z5MFKSJOOSWVb+JmZkh
         xV6TXNBD4aizSORDgymdejSOLSGKsbxZepVUCQKMLYkNzOPrFTs9p1bsVDkBqSj5q21s
         j6ng==
X-Gm-Message-State: AO0yUKWilGj6f7Ccw88M8cxbyAgjZg/NlSLa4HBGH+jNebRqwKW64lK0
        mQIEjJ9K+0PCU3n8hTz/t6c=
X-Google-Smtp-Source: AK7set9F3gQd8jCDxx9PNLf8yWJZi8rC+VKMmlkbjBcGrAyei3Pei/TUP5p1KNqApGFvkGRBxgzkhg==
X-Received: by 2002:a17:906:885:b0:86f:356e:ba43 with SMTP id n5-20020a170906088500b0086f356eba43mr18007716eje.18.1675632970667;
        Sun, 05 Feb 2023 13:36:10 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906701300b00888f92f0708sm4655922ejj.15.2023.02.05.13.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:36:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pOmgD-0007Tj-19;
        Sun, 05 Feb 2023 22:36:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz93@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
Date:   Sun, 05 Feb 2023 22:30:41 +0100
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
        <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
        <xmqq5yckvxtb.fsf@gitster.g>
        <c3f215ca-b4ae-79a2-c14a-3c0f1799e6f7@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <c3f215ca-b4ae-79a2-c14a-3c0f1799e6f7@web.de>
Message-ID: <230205.86mt5r7q2e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 04 2023, Ren=C3=A9 Scharfe wrote:

> Am 02.02.23 um 17:25 schrieb Junio C Hamano:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> As the disruption of changing the default isn't worth it, let's use
>>> gzip(1) again by default, and only fall back on the new "git archive
>>> gzip" if it isn't available.
>>
>> It perhaps is OK, and lets us answer "ugh, the compressed output of
>> 'git archive' is unstable again" with "we didn't change anything,
>> perhaps you changed your gzip(1)?" when they fix bugs or improve
>> compression or whatever.  Of course that is not an overall win for
>> the end users, but in the short term until gzip gets such a change,
>> we would presumably get the "same" output as before.
>
> Restoring the old default is an understandable reflex.  In theory it
> worsens consistency and stability of the output, but in practice using
> whatever was found in $PATH did work before -- or at least it was not
> our problem if it didn't.

"In theory" because the user might be flip-flopping between different
gzip(1) versions?

> Are there still people left that would benefit from such a step back,
> however?  As far as I understand forges like GitHub relied on git
> archive producing the same tgz output across versions.  That assumption
> was violated, trust lost.  They had to learn about the configuration
> option tar.tgz.command or find some other way to cope.  Changing the
> default again won't undo that.

I think it's safe to assume that git is used by enough users that
anything breaking at a major hosting provider is likely to have a very
long tail in the wild, almost all of which we'll never see in "this
broke for me" reports to this ML.

So no, that ship has clearly sailed for GitHub, but this series aims to
address more than that.

Even if it wasn't for that breakage, I think 4/9 and 6/9 here show the
main problem you were trying to solve in making "git archive gzip" the
default didn't need to be solved by changing the default. I.e. the aim
was to have it work when "gzip(1)" wasn't available, which we can do by
falling back only if we can't invoke it, rather than changing the
long-standing default.
