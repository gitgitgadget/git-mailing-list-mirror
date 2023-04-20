Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A2C77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 05:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjDTFZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 01:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjDTFZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 01:25:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B04C1E
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 22:24:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f167d0c91bso3772465e9.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 22:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681968271; x=1684560271;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpFQ64FqrEKjXexXOVxg+gysJtgsLRuacuXsBmCMGuQ=;
        b=e+VAUy7ffDiP9Sk3FU/X/XV8eYY165asJe8ha3lk2HPM2vD2GG74BREP+TyOTy4pvw
         h35AQQns0ar4zSBA1obh9Gfy58r0Liz7lRklEX3GoZcQ1aB2mjlD2ke3E0CfxGZf5W+j
         OCNQn0g8SONgtRcIguYWgaslBf00EWnAue+W4uhnRoaZOVnfnsDBjWCzOxvGEKo9NEn0
         ZgxgBdTVmx5lTI8hPcoYUaEKNWQI4ZXuy47hDMkPA21bnv+T12QJU9yok9f8NpZ7DhsJ
         /NjBvz5zPsufEGn84WscgxegopGIimZJNaN5fMZ7W90mQHxfwUoZofri1Ol39sRR3b3D
         E0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681968271; x=1684560271;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpFQ64FqrEKjXexXOVxg+gysJtgsLRuacuXsBmCMGuQ=;
        b=kE08LUsPDVW2eIo8+db3haI14d4DUhlYPtD7DC9yzgFI8opCGF9Al52VKPc43O9k77
         nZUV1cQuntAaqLpOyNVFBHWZw449+FSY71SVSpIfFFI7LcFhuSgZ+IHbArsIyuXjr9hs
         jnIxnJvSm2C520qYNlSoXV/gnj3bQBxKfRaBKqvgMpTcO3e7bsn7r03QAW+G4MV+C0EB
         05bXCPHrRY/3BlMKnQ7jEtX0TpcPxre758L8bpNzXbja2ea8LsiePhzxC3mRHAf6ugJT
         1o4rKt/SwvSRWewYHYgd+nkS6ktn5iMsLsz96lb5a1SWHPuupXps0eTgZjP1xQYYYAtM
         J3IA==
X-Gm-Message-State: AAQBX9dXJ4hCLW+p8kS4ITDGZeRiCCnnQL+fEteZus5Vz3X4hzW8AAA9
        OqNjTZrBjHRRZ4bKc42q14z3eKlveHhBWfOsD+g=
X-Google-Smtp-Source: AKy350YMAKfcKfyBUCEqJvw5h8Gl9sN1QBDHD7F9muiqSXzEwLXEoUrip7xwf+xIsd1CDkfeEAHLq0/0YtPUHEXqzKE=
X-Received: by 2002:adf:e8c4:0:b0:2f5:aadb:4642 with SMTP id
 k4-20020adfe8c4000000b002f5aadb4642mr192848wrn.41.1681968270705; Wed, 19 Apr
 2023 22:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230404003539.1578245-1-cheskaqiqi@gmail.com>
 <20230419072148.4297-1-cheskaqiqi@gmail.com> <xmqqildran7n.fsf@gitster.g>
In-Reply-To: <xmqqildran7n.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 20 Apr 2023 01:24:18 -0400
Message-ID: <CAMO4yUGzGzT4XC8t_LE=Z=ebERJq9Egq+wFj1K=1aUxHfPcnNA@mail.gmail.com>
Subject: Re: [PATCH v3] write-tree: integrate with sparse index
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Apr 19, 2023 at 11:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Shuqi Liang <cheskaqiqi@gmail.com> writes:
>
> > Update 'git write-tree' to allow using the sparse-index in memory
> > without expanding to a full one.
>
> Sorry, but after this exchange
>
>     https://lore.kernel.org/git/xmqqmt3bw9ir.fsf@gitster.g/
>
> I am confused what we want to do with this version.

Apologies for not noticing the patch was already merged to master.  I'll ma=
ke
the necessary changes and submit a new patch soon.

Thanks
Shuqi
