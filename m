Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD5DC433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 07:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbiETHd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 03:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346494AbiETHdy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 03:33:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716014AC97
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:33:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so13997841ejd.9
        for <git@vger.kernel.org>; Fri, 20 May 2022 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OUPUESvpnw0Vw7OS/bRpaZOuDt+UGokqlcCkvy9TlBE=;
        b=JYHjgQ4Pdx9Yk4VqAd7z7S8cJ4jgXJ0ntt3QpSbg7dV0LyYOgJ3WsO/Ookthyi5aNw
         wyGfbmRA7fS4YREj/EKD4lGj20v4R3fUopc/WPTXMbN/TG67Vui+O9xiRSoJT41Q0sLa
         dJok4iwND7GA+Ygii3RK29932p9t1BD5OKf85RMYRX5BHkC6Lr9YfqpGyFg5QG4+tUGy
         S0hkyUVQH5UnZS9XTK30Fqp0fKfTjuxJeEIUJFTIEvSUwsYrsw2Nz1SwGsbUlpTppEMo
         HLFyxDj21Xj9zDjWWFWaUPwcF6/Zk8CnNFGVm0d8cDIQml2Seo3B3LALFSsvVUezq9c5
         xsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OUPUESvpnw0Vw7OS/bRpaZOuDt+UGokqlcCkvy9TlBE=;
        b=wuB3VEGO1I5yOQp13/XYRz6A+sk7Q6yvZiEtfwyw06JaP7OI03zD+L6NxMQmSfZyYL
         M8dhOOWscbjUaRlYQLHE5nuq/YjL5P1OT086z6YeRvnTuOx4QueW3+KK3Ogc3XBSBhgx
         H+tkx1/nbn+FPco1QSinPx2j8owtO0Eay0XX+KgNmwTxJn+U8vVqljRpc5UbgSBex+42
         CBEhci+4VJFnrSWSVu4Al46sh+N6wgU4bNfFMMTL7UcIwsSR1KqYEgOLXQhu2pByNzC6
         8jLrOpvazbTBXzSPgA1rr8OnkkGqv0DnQam/S04NWcI4ZiAr4DjIMoTSPb+URMo+By96
         gtRw==
X-Gm-Message-State: AOAM532ZkU1s95EXjHrxk5u7VILYI5/xVE8zjMvTyIS42T/3lqgy8bWq
        DmoBOzcF99Ut78ma+8aSJ4A/6jjKDGqxaQ==
X-Google-Smtp-Source: ABdhPJxlA2PvxreGXxzU1XXDiKMOcO2sink8nTfUcMUih5zRGtZqxEcvbx7vW+WPcRY+H96HB//A4g==
X-Received: by 2002:a17:907:3e0e:b0:6fe:b42f:db81 with SMTP id hp14-20020a1709073e0e00b006feb42fdb81mr493112ejc.516.1653032032136;
        Fri, 20 May 2022 00:33:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ia20-20020a170907a07400b006f3ef214dfcsm2865507ejc.98.2022.05.20.00.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:33:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrx8v-002PBM-6u;
        Fri, 20 May 2022 09:33:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 02/17] pack-mtimes: support reading .mtimes files
Date:   Fri, 20 May 2022 09:32:50 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <8f9fd21be9fcdda5c73d800fc66d1087d61a6888.1652915424.git.me@ttaylorr.com>
 <220519.86zgjd4wvk.gmgdl@evledraar.gmail.com> <xmqqr14pr1jt.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqr14pr1jt.fsf@gitster.g>
Message-ID: <220520.86bkvs3bfm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, May 18 2022, Taylor Blau wrote:
>>
>> Nit:
>>
>>> +  - A 4-byte magic number '0x4d544d45' ('MTME').
>>> +
>>> +  - A 4-byte version identifier (=3D 1).
>>> +
>>> +  - A 4-byte hash function identifier (=3D 1 for SHA-1, 2 for SHA-256).
>>
>> Here we let it suffice that later we'll say "All 4-byte numbers are in
>> network order".
>>
>>> +  - A table of 4-byte unsigned integers in network order. The ith
>>
>> But here we call out "network order" explicitly, shouldn't this just be
>> s/ in network order//?
>>
>>> +    value is the modification time (mtime) of the ith object in the
>>> +    corresponding pack by lexicographic (index) order. The mtimes
>>> +    count standard epoch seconds.
>>> +
>>> +  - A trailer, containing a checksum of the corresponding packfile,
>>> +    and a checksum of all of the above (each having length according
>>> +    to the specified hash function).
>>> +
>>> +All 4-byte numbers are in network order.
>>
>> I.e. this is sufficient.
>
> Very good eyes.  One explicit mention among several others can
> indeed be misleading the readers.
>
> When asked for "network order", all your search engines show are
> entries about "network byte order", so let's use that longer form of
> spelling.

*Nod*, note that "network order" is on "master" already though,
i.e. this section re-used a template introduced in 2f4ba2a867f
(packfile: prepare for the existence of '*.rev' files, 2021-01-25) just
above this hunk.

Before that change the rest of the file used "network byte order"
consistently.
