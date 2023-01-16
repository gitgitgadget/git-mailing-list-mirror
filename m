Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8128C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 13:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjAPNke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 08:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjAPNka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 08:40:30 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7A71F5CD
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 05:40:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx13so9802424ejb.13
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wz6TD4ejuuhZLGZXcjKtuYC5sOjKOdeeEKbTE9BquNM=;
        b=iAmb66lYZ37TnEpykTy91GTmiWDCpna3mjQzyoClDMDwbMm1inq6UNBg915tvh1r4a
         tmBDr/KyRocAdeU6D5JF31uTaJwxJS4TpANGcG1V6zM1QyGtKAoRVVQnKqyERCuonoBB
         f/Dx8D8HwkD3maHN4cNkrEp/aA+c3ZxH/+j8yztUkrMxuE+xu/lUMs1STVGxl+Z1VLdZ
         lsMpuoswkRITjFu3w8e7vf9eJZwkyg/8F3F4L17xbZ3vTogF6E0Bj1dgPHYmeRr1iixH
         3MvuGEZGP3wb2Jc22Iq36TiJDnAdi1kREyN4rtQXU752g3gTm3+UM3SShEibuWKIY0fI
         RhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wz6TD4ejuuhZLGZXcjKtuYC5sOjKOdeeEKbTE9BquNM=;
        b=YjfBZV02jsucsbJiAhRaMMGNt5X70TkyeZZxIyL9mVCIMlJBoHw2VdkhwKL7j+w9GC
         nUPOqhIbWFfmDJjbrkqordf9qMufXo94yeuoPWTcjXoRfgdvyXEnq4KcQwbbjMRFpka6
         GhETo2ITyo585d5burb3r0OxnJAWlnUQPkejDJwBFHCLJHLCG6DPnmSjoy8NMAZ6zCeY
         gwApSeSFoHLni8/rXBLiacm9Ei6IFA3jMU+KIAy5tRDnhBL5RHsq/amIEueOh0TnI3wV
         v9LjxPv445naQ5pFUIu89qk0YNfpR3qztDqXQPTSYzWaMFsqZb30KDRgejdsLS97JI3Q
         HWkA==
X-Gm-Message-State: AFqh2kr1R8s+x9+thK3Tq/K4Ur917Jx8S8wFpS3PUH8bzTvfgzhUf3y9
        2Wq8AeG3ijiAywvbm5LQsYKxm5sXLwc=
X-Google-Smtp-Source: AMrXdXvMD6kyxx79Jyxx4ohcyGxoF6V0E0BnUwVcXuFW19JD9CWke540C3voOtbIWoZUqlvmyfy45A==
X-Received: by 2002:a17:907:ca0:b0:86f:8ccb:5d0a with SMTP id gi32-20020a1709070ca000b0086f8ccb5d0amr5041735ejc.36.1673876427015;
        Mon, 16 Jan 2023 05:40:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kw17-20020a170907771100b0084c4b87aa18sm11895640ejc.37.2023.01.16.05.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:40:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pHPis-002Uon-0U;
        Mon, 16 Jan 2023 14:40:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] cache API: always have a "istate->repo"
Date:   Mon, 16 Jan 2023 14:38:31 +0100
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
 <xmqqtu0u2q9u.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqtu0u2q9u.fsf@gitster.g>
Message-ID: <230116.86a62izjg5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 13 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The "struct index_state" contains a "repo" member, which should be a
>> pointer to the repository for that index, but which due to us
>> constructing such structs on an ad-hoc basis in various places wasn't
>> always available.
>
> I'd exclude 6/6 for now, as it seems to depend on some changes only
> in 'next'.  Feel free to resend only that step with reduced scope so
> that it applies to 'master', and send in incremental updates when
> each of these topics that are only in 'next' graduates.

Okey, the 6/6 requires ds/omit-trailing-hash-in-index. As both it and
the 1-5/6 of this are in "next" now I think it's best that I just submit
the 6/6 stand-alone after both of those have graduated.

