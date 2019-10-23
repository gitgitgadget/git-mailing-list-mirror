Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6BF1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389979AbfJWSqn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 14:46:43 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:11991 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJWSqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 14:46:42 -0400
Date:   Wed, 23 Oct 2019 18:46:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1571856398; bh=kzPTULmSuis5UwGXqgt48/D4/Cse9eJpoH+hip4lG2I=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=koJbbUYmasBD0dAY6joQn7mLcnckUSvpj8lkdHip4U63W1Ac282xPt2HzcVLZtqlJ
         3uW02y3p3cqOBnyRKz0VAbvYbsQ00+ycQft0K4X8E4kdxrdvBbEB2CnOe7IteY6Tas
         eUugdgP/T0lePp4MbWa6+ZirnFPPVU0qku680kWMgUr7g/bjrqaj7P0DW1Vtdt/zvf
         CxGI4IEOrPZ8hlxE1bapBmug4vaKIbEhTrmdYA7H3f0Qiu/IH9cCwfHT4GJKNHSk7I
         msDgYtYryKAWWnQ0t3IvTHuYHLztZDRjCn45Hn/QzTmlIsmlgluMUhBTxaVlC/ZG7s
         Ix2j1+n3NABXQ==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "skinne@google.com" <skinne@google.com>,
        "djm@google.com" <djm@google.com>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: [RFC] Proposal for a new config-based git signing interface
Message-ID: <R3X1WzWH0sgOh85GuUmXwsTC6CPKysi4TRzN_BPecDVGr__ET2-mitZ2DZA0_bpKkzLRtnTtoomIWxZtL52_1XkihYBVBAuWMpSdwoboixY=@pm.me>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is a follow-up on my previous emails related to the proposal of a new =
signing interface:

https://public-inbox.org/git/CACi-FhDeAZecXSM36zroty6kpf2BCWLS=3D0R+dUwuB96=
LqFKuTA@mail.gmail.com/T/#r43cbf31b86642ab5118e6e7b3d4098bade5f5a0a
https://public-inbox.org/git/Z2XOTcGuVovMKhcdrrO08KWI2I7L9s0CyFITvvj3jkmGTQ=
PB6FkCiyOtTm6GdYWbnf25dsPD8M08kDCuD37EE1B-sxHQ3se9Kn1zVBrCPZw=3D@pm.me/T/#u
https://public-inbox.org/git/N31G34oKnfr3MVifk42-Kt3YtM_3fHuCp3V1cpGOK5f1jn=
1vbg1TaSCy9ukI-YD8qRfu4xMcHcPc78xFE0MSwJQWNrSvuQuer9wSNugNRLg=3D@pm.me/T/#u
https://public-inbox.org/git/8AMhjK19PJ35u3LCR57IvtAzOBN5bKK2vUn0Ns-4mmZzK9=
U14W5CGW5R8aITNXBm78J4Z7nd09RTVKW2pGaB4PnF7p2PireF_vzRST8DngE=3D@pm.me/T/#u
https://public-inbox.org/git/0oTOrSdJdIaEfs3NVkfRmLxjYRvUPkucwwaXPuhCjS2QL3=
ztRJLfIlBkcpjSRiZQaY70SKSkg8_w20rxnuD4Vu3IbRcGOZM-fht8G7ySEHk=3D@pm.me/T/#u
https://public-inbox.org/git/T4zS1hogOjySpdv7lDjVaZV83KKSeK9fx8m33SIo-e_BH4=
RtKcm67btmGzTPeflbRnQr7mWjTpObB0hCkX8VkGZElkQbLEgbrETg6Aq4nUg=3D@pm.me/T/#u
https://public-inbox.org/git/74R10RrvOffzj20d_Owd_1WFMh1bWq8mIhEEBSzbhkHfbv=
W5BLHZj-L-AgHYnpqkxgZdCfW5b72GoIvKHucQz7tdiGZEzietp0IKpU1_wuI=3D@pm.me/T/#u

The main feedback we received from the previous RFCs was that the drivers f=
or external signing tools were still written in C and that we should go mor=
e for a configuration based interface.

I'v been thinking about how to go about it and would love to have your feed=
back on my proposed approach:

- Implement updated user configuration to define signing tools
- Implement a tool-agnostic signing interface in C code
- Add the possibility to use bash helper scripts to drive additional tools =
in case the default interface don't work as intended.
- The same configuration aliases can be passed to command line arguments

You can find below a detailed description of the proposed config and comman=
d line options:

https://hackmd.io/ZHsddYXkSmyb6rYajdyGLg
https://hackmd.io/yxS9nfiQSvmRZntcfnHOGQ

The configuration part would look like this:

```
[signing]
  format =3D openpgp

[signing "openpgp"]
  program =3D "/usr/bin/gpg"
=09keyring =3D "--keyring pubring.kbx --no-default-keyring"
=09identity =3D "--local-user \"Jane Committer <jane@hackers.com>\""
=09sign =3D "--sign --status-fd=3D2 --detach-sign --ascii"
=09verify =3D "--verify --status-fd=3D2"

[signing "openpgp.signature"]
=09regex =3D "^-----BEGIN PGP SIGNATURE-----$[^-]*^-----END PGP SIGNATURE--=
---$"
=09multiline =3D true
```

The equivilent command line to do a digitally signed commit looks like:

```
git commit \
  --sign
=09--signing-format=3Dopenpgp \
=09--signing-openpgp-program=3D"/usr/bin/gpg" \
=09--signing-openpgp-keyring=3D"--keyring pubring.kbx --no-default-keyring"=
 \
=09--signing-openpgp-identity=3D"--local-user \"Jane Committer <jane@hacker=
s.com>\"" \
=09--signing-openpgp-sign=3D"--sign --status-fd=3D2 --detach-sign --ascii"
```

Cheers,


Ibrahim


