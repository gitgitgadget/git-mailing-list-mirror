Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D88C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184B461003
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhGTQmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhGTQly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:41:54 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDC6C061768
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:22:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r21so4965523pgv.13
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9vbuTuq8iY5+NR3rnN/rHZVHTZFRn3xfX1QzCbFnNQo=;
        b=mqrfziAvFUWS7WzI+Smm9VikaUJUjuLeVO1nmntawgsloresWvbIac4wumIImXetzf
         jYZO5fUSuAUTn7cuB64AmvKLYTfW8awAtakNmegeE3pmK/TRIAcQU5At4a/LjE6Zw7pb
         AySd4p8wWEltZd93DMu1iFfJlSqJxNCSzcKbxG+mVC0PWJoTHsjGcFfDVx2F/Mdjn5dU
         mcbcjnxx/acPdBwADJgg7hNUpOLxP+ldYq0TWCuN/ByZ/7mdYdPuyl0AGs6R0UTsTJHM
         4XI1cdRHHcNn0dmOaWaB99veOVasugZGxS9mdRptwgETfDns5RRydCNlEOd+Ejjlh4oE
         fqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9vbuTuq8iY5+NR3rnN/rHZVHTZFRn3xfX1QzCbFnNQo=;
        b=a1S+UYHl2b/MRO+FB8kbAovd1CjPm4Ls3wUHlPAyK1pxwHBF34Ajbz2VRb7lO7W+Tt
         c45DY2XM1LU1EuATyBwym/EM87uViGRs5I78ryJMdB1i294Z8UJla3VBCczJsNkGUZaQ
         cY66c0jmiWAINS80CoAQrg6o//x2thM1e5skAKkhN3g8StGsJCjMnqE6lIagIxePy8UA
         QOeO6o1qxkIs83KotAiBoGb0h4sEURpmwngNNJv1LlFBGdcMWE4XtgES21XZvBdpARsj
         9c7uztO0jXlBRlpbfgGqpkXMU5GIy8qt21uQglrOGXywxLX0ZzFtm3kfxDIJw1O8Z/ld
         VXhg==
X-Gm-Message-State: AOAM533axvM7qJspjU7A8xlY2tgXtW/jEmvI8xW4I6gu7cuHDItdFAjE
        NFS1uew6/FgUSTN4yOPud+U=
X-Google-Smtp-Source: ABdhPJxGJ4wqMTSPZt7s9L1zmyL/P8ElYskuyIkSEj+W9lC93yoyrOkAqADpdcIhuX5T/FxQ6PhRxA==
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id e22-20020a62ee160000b02902feffcf775amr31814659pfi.59.1626801749118;
        Tue, 20 Jul 2021 10:22:29 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id a23sm25299619pfa.16.2021.07.20.10.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jul 2021 10:22:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] Git Blog 9
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAOLTT8QLrG+R3sOHpMsAiveOT1wTKR-_Nw8Ro6iXL1_MTMZ6eA@mail.gmail.com>
Date:   Tue, 20 Jul 2021 22:52:25 +0530
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DDACB9C-4AC8-45A8-B9AE-5727464AA95D@gmail.com>
References: <CAOLTT8QLrG+R3sOHpMsAiveOT1wTKR-_Nw8Ro6iXL1_MTMZ6eA@mail.gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-Jul-2021, at 12:25, ZheNing Hu <adlternative@gmail.com> wrote:
>=20
> [...]
> ### BUG REPORT 2
>=20
> * What did you do before the bug happened? (Steps to reproduce your =
issue)
>=20
> Normally execute the test under git/t.
>=20
> * What did you expect to happen? (Expected behavior)
>=20
> Pass the test t/t0500-progress-display.sh.
>=20
> * What happened instead? (Actual behavior)
>=20
> ```zsh
> $ sh t0500-progress-display.sh -d -i -v
> ...
> expecting success of 0500.3 'progress display breaks long lines #1':
> sed -e "s/Z$//" >expect <<\EOF &&
> Working hard.......2.........3.........4.........5.........6: 0%
> (100/100000)<CR>
> Working hard.......2.........3.........4.........5.........6: 1%
> (1000/100000)<CR>
> Working hard.......2.........3.........4.........5.........6: Z
> 10% (10000/100000)<CR>
> 100% (100000/100000)<CR>
> 100% (100000/100000), done.
> EOF
>=20
> cat >in <<-\EOF &&
> progress 100
> progress 1000
> progress 10000
> progress 100000
> EOF
> test-tool progress --total=3D100000 \
> "Working hard.......2.........3.........4.........5.........6" \
> <in 2>stderr &&
>=20
> show_cr <stderr >out &&
> test_cmp expect out
>=20
> --- expect 2021-07-19 06:09:39.800189433 +0000
> +++ out 2021-07-19 06:09:39.803522767 +0000
> @@ -1,6 +1,5 @@
> Working hard.......2.........3.........4.........5.........6: 0%
> (100/100000)<CR>
> Working hard.......2.........3.........4.........5.........6: 1%
> (1000/100000)<CR>
> -Working hard.......2.........3.........4.........5.........6:
> - 10% (10000/100000)<CR>
> - 100% (100000/100000)<CR>
> - 100% (100000/100000), done.
> +Working hard.......2.........3.........4.........5.........6: 10%
> (10000/100000)<CR>
> +Working hard.......2.........3.........4.........5.........6: 100%
> (100000/100000)<CR>
> +Working hard.......2.........3.........4.........5.........6: 100%
> (100000/100000), done.
> not ok 3 - progress display breaks long lines #1
> #
> # sed -e "s/Z$//" >expect <<\EOF &&
> # Working hard.......2.........3.........4.........5.........6: 0%
> (100/100000)<CR>
> # Working hard.......2.........3.........4.........5.........6: 1%
> (1000/100000)<CR>
> # Working hard.......2.........3.........4.........5.........6: Z
> # 10% (10000/100000)<CR>
> # 100% (100000/100000)<CR>
> # 100% (100000/100000), done.
> # EOF
> #
> # cat >in <<-\EOF &&
> # progress 100
> # progress 1000
> # progress 10000
> # progress 100000
> # EOF
> # test-tool progress --total=3D100000 \
> # "Working hard.......2.........3.........4.........5.........6" \
> # <in 2>stderr &&
> #
> # show_cr <stderr >out &&
> # test_cmp expect out
> #
> ```
>=20
> * What's different between what you expected and what actually =
happened?
>=20
> It seems that the progress display is not working normally.
>=20
> * Anything else you want to add:
>=20
> I am thinking:
> 1. Is this bug caused by my own patches?
> So I switched to other branches, including upstream/master, see the =
bug too.
> 2. Is this bug caused by zsh?
> So I switched to bash, and saw the bug too.
> 3. Does this bug only appear on my Arch-Linux?
> So I asked my classmates (who use arch linux too) to download git/git
> from github and perform the test, see the bug too.
> 4. Does Ubuntu also have this bug?
> No. In the case of using Ubuntu's docker and Centos's virtual machine,
> after cloning git/git from github, they actually passed the test!!!
>=20
> So what's wrong with Arch-Linux?

I noticed there's already a thread about this problem here:
=
https://lore.kernel.org/git/49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.=
net/

This seems to be a bug with a recent bash, and a fix was suggested =
there.

> * [System Info]
>=20
> ```
> git version:
> git version 2.32.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.12.15-arch1-1 #1 SMP PREEMPT Wed, 07 Jul 2021 23:35:29
> +0000 x86_64
> compiler info: gnuc: 11.1
> libc info: glibc: 2.33
> $SHELL (typically, interactive shell): /bin/zsh
> ```
>=20
> * [Enabled Hooks]
>=20
> None.
>=20
> [...]

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

