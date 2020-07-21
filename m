Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93332C433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 08:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABD120714
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 08:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNpPvOHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUI3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgGUI3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 04:29:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2BC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 01:29:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f18so20339732wrs.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:message-id:date:to;
        bh=dIIQSVf3LxjJt4hrdHgFRULDMWkMoqI8efiTHie+vFg=;
        b=GNpPvOHgdl1PgaI2das4V/Du7buTOXetKAPIFHl0I+MebP49xtRUObHi/IDIsFNTHL
         1YzHIyxEPCQrnbC0z06MS8DzYO7IPsu20bmYA5gi/PuFWAbMGfvUNjn43GbRQ0goUR7H
         ZpNitRZS5uskXQkTqNnjFNtpO6oJ4DF0QyatV1L5hjljoqZ/vHG5PwbuxvldNXSCekAX
         PmRbhKbjb0ippirdkdaA4Sx2xhkdUgHs5Fnj4s69TcOOYeY8c5SS901ARweFNvPQ62tl
         7dkDAGUMzDZ2CGnQj4dchs9rMkupuP0/lad26xVqRJimwY6bDDoetnbJcfXWdZN8HcaV
         AsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=dIIQSVf3LxjJt4hrdHgFRULDMWkMoqI8efiTHie+vFg=;
        b=sdtdYROAO286FTmhzcPWpXLskj2YY8sNombJbkVZCws7WaFB2LVSD20rY7srpaN3hH
         36yIVj21bGeHDUX8OZnDCNlBERS7zf563xwM6E42EjJiGCbFZEnCLuVCWH9a8BYkzFoO
         oKltX5zFwGI+E5rZllN3ScTi9nibMcfcaw9LMLkhiaT5Gn1g8sgqz2HHMtsC7ympVypA
         x6qc8z/Ert4PUrBzfy1skxXCwOhyeIQHxmUBUXZtxwn2f0DnBBjHuRus8JEChWzupAoR
         IFete73iXDIXVxqs0AvoGRGyUQr9dWGfUCbZln6CAM9v8j9W7AInzaU201lQpHRO03xQ
         Jaug==
X-Gm-Message-State: AOAM5317D4SfaeJlfKFzFcNqjVh6pk8yHKLxomXLesk+CxiZqhz1oWL1
        VMiYjfn+1a9NpuofR80eoGzB/RkfH5U=
X-Google-Smtp-Source: ABdhPJxFD5320Fd6lkq7VlyZ1cTMCjKrcNs82ol0NO/UylA8lMUOgaKHjtsHxq29IasANgKtuujE2A==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr25071263wrm.169.1595320139542;
        Tue, 21 Jul 2020 01:28:59 -0700 (PDT)
Received: from [192.168.1.154] (hw89.internetdsl.tpnet.pl. [80.53.100.89])
        by smtp.gmail.com with ESMTPSA id x1sm37329004wrp.10.2020.07.21.01.28.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:28:59 -0700 (PDT)
From:   Robert Muchacki <robert.muchacki@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4644C76D-EB72-4977-A266-362BFD7DC568";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: git - more like a feature request for pro-lifers
Message-Id: <B56E3052-2BD5-42D5-A854-2FAB528C3214@gmail.com>
Date:   Tue, 21 Jul 2020 10:28:54 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_4644C76D-EB72-4977-A266-362BFD7DC568
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_D471132B-E005-4AB0-B347-C8DE77FBEA83"


--Apple-Mail=_D471132B-E005-4AB0-B347-C8DE77FBEA83
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Greetings!

Attached is a feature request for the pro-lifers. Doesn=E2=80=99t seem =
to much work to do in the code.


--Apple-Mail=_D471132B-E005-4AB0-B347-C8DE77FBEA83
Content-Disposition: attachment;
	filename=git-bugreport-2020-07-21-1019.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="git-bugreport-2020-07-21-1019.txt"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I tried to switch branches:
```
  > git checkout other_branch
```

What did you expect to happen? (Expected behavior)
A friendly information, not confusing, not anti-life, that will tell me =
why the process stopped.


What happened instead? (Actual behavior)
I got a non-pro-life informatiom, that noticed that it was ABORTING.

What's different between what you expected and what actually happened?
It should have been STOPPED or ENDED. ABORTING and TERMINATING is =
unrespectful for the unborn code.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.27.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Sun Jul  5 00:43:10 =
PDT 2020; root:xnu-6153.141.1~9/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.3 (clang-1103.0.32.59)
libc info: no libc information available


[Enabled Hooks]

--Apple-Mail=_D471132B-E005-4AB0-B347-C8DE77FBEA83--

--Apple-Mail=_4644C76D-EB72-4977-A266-362BFD7DC568
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEypNxoCfLLnU7/umo6VQwLa2pYUoFAl8Wp0YACgkQ6VQwLa2p
YUpoHQ//U89goTzF+ebkWck9Gov1SbLL2ihDPJOJgMQUC2QoRzF+GhIrXxMph06j
79tii7zw1uPz2RI03pP/W7KD7rnWIc/vXt+eyWH0KqBX8CRmV9vY5dDSfL5qfJAe
mN9O60fEy5TL6GAP7x1fabGA3z0zm5k2YS7YIWfeQWImp1ohRpb//BDw6WoIb2gj
Aax1a+VNxhOYUjVzjiFD9gIM7rZszqlPAqQXmQI88U8RJX+QViFfY7EmUwM/U1Ab
gj66YVMyh2M0iR/fgvSBE4N74qv/Jel08y7SZigzUyf4sDQ2Rh0JDnjwz9BzIAxp
DY4hmE5YyIiVcDlbm3+9mhyH26aN+t/mCR39KuszuIODtCPYojbnvFj5WggYeXoJ
zD3l4ngiZZRuIntN5RQsTpalUtG9ILC6mMhmvQC/WxZU6bEAXTgRo1N7etEewNHl
TQZ/iOuYMY8S7bdMdA38w1cBNtFGYrBfAfl0EdOqyMOKSGRHW3Iujc0BS914X7St
5q3B9iz2gNbR+MdgAtFS1n911RjO49qv0sXOckNnqrDeKg3dtWCSW2+RVxC7MvLt
WRSt0ZEHUKDPp/4rQVehx12gKdWnmYegVQ90RNfp8JQBMc1zS1vlyfuKsjZEEaHD
dSw7uglGpT1pZAAhMK0pNOCKFvYj8wqjYDNr5xtZHFOZ+9OlCC8=
=bLts
-----END PGP SIGNATURE-----

--Apple-Mail=_4644C76D-EB72-4977-A266-362BFD7DC568--
