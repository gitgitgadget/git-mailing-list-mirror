Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A044C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F06207DE
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+FYIc0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgJaRSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaRSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 13:18:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D07EC0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 10:18:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l2so7949520qkf.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QNMHsS3BEk5DcwdWdKk2fcxmcFf3EJ7ZgTh7fNLT5wI=;
        b=f+FYIc0oUNE1clmyN36utvwFDM+8uYyhwbbJ9bvdBJZIgsV+EYp2mpBsY86Y65G6cj
         GaUde6K1BnfQRBKFi+uMKWawE1aY4JfOenJQdlu6M1EXqRLLX/A0b1Rh/O4oMr4MLBTo
         tmf38ghVuuVjzy1RJHFBdLag6+B8CJuld+/JXV3kNhlWZXXwURzOoVPw8MEsqzihJjR2
         bmNUnYxtJ4PfF34ezIUl2Z2wVqXqmyDjEVpwLFZ2CfUH/HVLYQlymZtJ2dwbyajInXni
         lJIL86nZk4q9pd70CuNvSK9Z9RpPt2QSZHL+fhoge9Aao6FmfOhOpVPUweoBGEZz7B4X
         gYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QNMHsS3BEk5DcwdWdKk2fcxmcFf3EJ7ZgTh7fNLT5wI=;
        b=URXhd8k/aiYS4D5EiGoeOQedXkyR5weD4jwOU7KXiZlX6nSVu7vl7b5SIv7GCQkIuA
         D34ZskrU8Sx7PAJN1ybn6rT/jSln/VN+omwQ6YCVmyGIhN6v23kQwa09u6eREbQgg8+z
         cgYXxPg0pI8XGcpKoI+UlkFEWCCV+piGP98BtcIGY7GUE4yMyF88esjeBjMR8U7WNTjF
         Es54lmf0pzCaOX5aOajAUFm83Fx+PI4Ic0GvBpShGCLvg8RjJXamDhI+kPrZWA5gjPpK
         sncMB7A1Dz39/Du1VqKbtAop73HIqgpagmwjmiv/oqykQeTNDzJ8NJmhKf8RrX6gFEIV
         HlQA==
X-Gm-Message-State: AOAM5318YK6SvirPjfaks+qTtj5/G03UW+aba24EES+jifsozmBiyeZn
        XiUrftCyCAscZeplrDZXBFs=
X-Google-Smtp-Source: ABdhPJzI1CyLcPPJXVmkqtsB9MWIKhACZvAe53D/LXC0/Dn5Y9LWcn5G5r9Y/EAvfFumC+5lncdHTg==
X-Received: by 2002:a37:b5c4:: with SMTP id e187mr7515046qkf.253.1604164684548;
        Sat, 31 Oct 2020 10:18:04 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id e6sm4662063qtb.32.2020.10.31.10.18.03
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 31 Oct 2020 10:18:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/6] doc: log, gitk: move '-L' description to 'line-range-options.txt'
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqft5w7poo.fsf@gitster.c.googlers.com>
Date:   Sat, 31 Oct 2020 13:18:01 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8539F4F-D51D-463B-825F-385AD743723E@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <96f6f95abcbd79d432073cb294ba12b71300580f.1603889270.git.gitgitgadget@gmail.com> <xmqqft5w7poo.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 29 oct. 2020 =C3=A0 16:16, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> The description of the '-L' option for `git log` and `gitk` is the
>> same, but is repeated in both 'git-log.txt' and 'gitk.txt'.
>=20
> They are moral equivalents but differ slightly, both in
> an insignificant way (i.e. SP after -L and its parameters) and a
> significant way (i.e. Note about gitk usage), so "the same, but is
> repeated" is not sufficient to explain why the contents of the new
> file looks the way it is.

OK. I'll expand on that.

>> Remove the duplication by creating a new file, =
'line-range-options.txt',
>> and include it in both files.
>=20
> Makes sense.  As to the conditional, I actually think the version
> with SP after -L do not have to be listed and instead to show just
> the "stuck" form as the standardised way.  If the option takes an
> optional value, you must have to use the "stuck" form anyway, and
> showing that you _could_ have SP there unnecessarily throws extra
> bytes at the reader with no real gain.

I'm not sure I understand here... The <range> argument is not optional
here (`git log -L` by itself is meaningless)... I know gitcli(7) =
recommends the
stuck form, but this option has been listed as `-L <range>` in the =
git-log
documentation ever since it appeared... So I did not think it wise to =
change it,=20
that's why I introduce the conditional.

Thanks,

Philippe.

