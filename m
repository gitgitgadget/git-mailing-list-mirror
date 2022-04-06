Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36920C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 20:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiDFUVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiDFUUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 16:20:33 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49191277961
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 10:57:19 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t4so2439401ilo.12
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BV7Db6Ou6k+winGvooYEa2ujn71469a06XHSfmkBCBw=;
        b=gxAD53yaLxGA8PQShmuy7EB9aIvxeLZOkSIAWT9N5mpOaS/dvCzTkDQMD8YC57uA2p
         2mFiqIq9KBU1gpnT1nBnTxHWIlirYkT3zm47vBXYPj6n0W+Aei22pvcyh2WsdeAuObbw
         eHb99KmiX/h9Lbwe9sxtfue1EF0uJjBdkcoZGV3ppc19B1LFhaa7CvDXw05DiC/tWYHY
         jXsHIUrz6HYxYD0fX10Osci7zMsK5G8MpnY01QCC1kGegOLGx7ev0P4aLhmjJQrBw3m2
         mgHa+UZ6LYWIsJFcoNh20p4ezQjD+EIHqfU2RZVaFPXNMa3rx4sjQZKfJpqIX7fB/0je
         k/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BV7Db6Ou6k+winGvooYEa2ujn71469a06XHSfmkBCBw=;
        b=x8++wwY/LGs/EwNviRKGTfqf0bO3WRuZYdgpkLT+jDEtNpDSbPGyFeEjkNew4RxGo+
         qjAseJwtHog7qh+X+a/utkF6L0CcQH6G67REr78yE7YZuebDsfxjk5CZQc6lmQgoeYrk
         yJK5pY/QOEIeGfl9YEVDxms7OXR4HTq5fZKtjRp2TnS9bhZ8x60eY0EAw4PSZODz7wuf
         nf67jXZ2qF88k2ItbZ2q5FmIB1n1LGeLv0Y28eSdDNqLLiSnEBQ5nEb6x4P8q8BOf3bM
         Nw1NmHQxiOxpGNOdjbfevhwX81o5CBcPk4RnW8dY2HD61d1ooSXxoGeRDddn8ovyKwv4
         JQLw==
X-Gm-Message-State: AOAM531n7Lt1MoFAp1Zf4Jsx4+5gIoCYPybhnfDQThRgQINDXtuQ4fsi
        VRlX2O79lXc+YX68nSrpshSqecPsoJFiNH/fFI8=
X-Google-Smtp-Source: ABdhPJyOcRjoZ4OCcOrWm6DGUffc68koe8bUVXdJgGecI0M6Kl2MJzaf2xXdH4wQ1VT3Dh3k51t2Oth/ufdmswMCCwU=
X-Received: by 2002:a92:cbc3:0:b0:2c6:78fa:41e9 with SMTP id
 s3-20020a92cbc3000000b002c678fa41e9mr4613125ilq.112.1649267838416; Wed, 06
 Apr 2022 10:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220405165806.842520-1-eantoranz@gmail.com> <220406.86wng2eh0l.gmgdl@evledraar.gmail.com>
In-Reply-To: <220406.86wng2eh0l.gmgdl@evledraar.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 6 Apr 2022 19:57:07 +0200
Message-ID: <CAOc6etbgsgb6J+0RW-y6HrOvPzpt1daNOeuMnSc8oiRwXbCcnQ@mail.gmail.com>
Subject: Re: [PATCH v3] blame: report correct number of lines in progress when
 using ranges
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 6, 2022 at 10:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> Hint: use --in-reply-to on re-rolls, this is in reply to v2 here:
> https://lore.kernel.org/git/20220404182129.33992-1-eantoranz@gmail.com/
>
> Also the --range-diff option to git-format-patch is really helpful,
> it'll make a diff between v2 and this v3 and attach it after "--".
>
> Anyway...
>

Thanks for the tips. I realized I left a garbage line in the v3 patch
that I would like to never see moving forward so I will send a clean
patch for v4 just like the previous ones, hope that's not a problem. I
will keep the tips in mind for a future time.
