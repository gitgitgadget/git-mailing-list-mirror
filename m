Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F6C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 14:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E3A64DCF
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 14:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhBOOIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 09:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhBOOIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 09:08:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6784C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 06:07:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cl8so3806196pjb.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 06:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mail-followup-to:mime-version:date:message-id:subject:to;
        bh=Z/UAot1Uo1nSfMAGNRKbx3mBwxmIXHBn4bL7fQbSnT4=;
        b=CsEYPRL0A7Z9JZ9teRmKShYMA7QnhFtOP0cipcRhrHzEopoqW17RrSU1LFiYQqk84T
         7QU4QWzviue7BKIC68ItR9FYIyIdG78ZW/xtlesiSZbTY+/TzIOEQPcYhINnr0jhugyI
         +XtT0ksZZ1P0zewEAngdYI9zJq9EI+x8qLV2rDjZLxVuS9p8flci88t6YZTlf8vz+ZaS
         zSgY1JxOsLoPRfb03d1wxepW5ORdc+ZkYkhm4uosuRk7SoqERVwWvsN08MZzXAs+I1Gf
         cYA1ctRp2ba5Au3dGhg/qiciW95yxF9MTEoPGfjH7Clsabcn11eRMufbGltQs1c+/pUz
         d4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mail-followup-to:mime-version:date
         :message-id:subject:to;
        bh=Z/UAot1Uo1nSfMAGNRKbx3mBwxmIXHBn4bL7fQbSnT4=;
        b=I1P1D6Ou2KR7Q3j0q6CMcEh40VCkWDDArLefhU18OMVcFWoMUlq+g/0i2gNjqseVo/
         T/CXT8alzoYATBUvFEmyn5J1/o8YvRNhotJVPIr/N7nsarjYrmTlFxSkD3lqBEJ45BiQ
         LTviG+2n6YApayewQGk5VwgRFJt+SvdFx88Yd+QW9KF0zKFVMVmKAUExnfTOxcS9mQfw
         TBLW3rfEP38jq7VC5+8I3F5vTBdvilj03jQwDFKmdPugrJo1gR3veebHz7MckheyGnPh
         d88TksgpzNag1OpjY3yLaPd6vYQxLRMv7oA+R2ASUjgnii3Qr0C80qNOySKEldTND+xN
         T/Cg==
X-Gm-Message-State: AOAM533cdbzHZumZeNJTQSYoaMoOY4laxEvmYkNPqu0caxN9GAka7Wdl
        lpcQUN1neYulJN7e84UfTdlmzI6d7/jXFm4X8rUmpxhgId8=
X-Google-Smtp-Source: ABdhPJw7AF6PMLxGR+3ZdndZlEsvcvvBzH9IgFQQBMnUGtJYnwUfk5WqSRNg4msNIvgKWBURF0V1/BhfjxeI/OP+guU=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr15342225pll.0.1613398052276; Mon, 15
 Feb 2021 06:07:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Feb 2021 06:07:30 -0800
From:   =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= 
        <khardix@gmail.com>
Mail-Followup-To: =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= <khardix@gmail.com>, 
        git@vger.kernel.org
MIME-Version: 1.0
Date:   Mon, 15 Feb 2021 06:07:30 -0800
Message-ID: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
Subject: git-send-email: smtpserver in $HOME
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c9acdc05bb60816a"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000c9acdc05bb60816a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
I ran into a bit of an issue when attempting to configure sendemail.
I use a GMail integration tool [1]
which is installed into my $HOME directory (~/.local/bin/gmi),
and I would like to use it as `smtpserver`.

[1]: https://github.com/gauteh/lieer

However, I also use different machines with different login/usernames,
which means the above is not so simple.
Basically I would have to keep login-specific configuration files
with appropriate absolute path to the tool "hardcoded" in.
Since I like to keep my configuration in git
and synced across my machines,
that is a state I do not like very much.

Would it be feasible to treat the `smtpserver` as path option
and expand `~`/`~user` paths?
Would it break anything
(i.e., is `~` a valid character for beginning of a hostname)?

Any other thoughts on this? Am I missing anything obvious? :)

Thanks in advance for any considerations and replies.
--
Jan Stan=C4=9Bk =E2=80=93 Khardix

--000000000000c9acdc05bb60816a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a1f3537a091720ff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUFCQ2dBZEZpRUVZdjczM3Vsa24w
UVpmdWczS1hMeUEzc2tPMjBGQW1BcWdDRUFDZ2tRS1hMeUEzc2sKTzIyTXJBLy9YcTVjM0UrbFpt
WkFxYWp6UVNwRDlwYmFyMFdPTVdKa0tuQXVuZHR3L3RIN1BveDJSckhua0twSApxd0NUalBIRXRD
V0tKM250YXl6S3hIZ29kTkdsK2IyMTZweE1wY0ZQU01xTUJma2ZWQVNpOVNUMG1kR1pOQk1SCkZN
VFp1eFZabGVtQkFDeXpLN1NtN1ZRWTI5TWhhVmI5amQ0UEJrK05idUx4WE1VbXNaUFMreVlEWXUz
ZnUwc2IKWW1KQkd2dHhVUHNzM1JxYzlPWS96K1JYVVZXUVJnbkZyMjQ5UEFvSFlCQ0pHSFhRZ0Y3
V2J4RkRZUFcrNzVSVApnKzRpR2lqN2tQSDFaSkdtcDJkYXhPZjNaOHI1bWJHQVNtWXJ5LzVsZXEz
dDUwVG8zTDZyTStqR09kSlRNSnR0Cll3c2F0K1VwNUdDelQveGZnalRwUXMydlU2M1NCTWtPYnE5
bmt2bTk0eEo0UDJjQlhPZTZvVmFLSUh3a0lCSmMKclpwemR5VUY1WVNZUmlqcEF6RG1KL1lRQjN5
dDRScEFDd0NGM0dNZGd4NXhuQW9jdVdJTGhDV3EyM0Z5ei9rbAo4UzNMSGczRU9sT2t2M0prSldP
cWc1TkRMWmhHLzh3b0VwRE53QlNudFZ2cDE4Wk1zb0dMTXA3K2JCSG5OQnRRCm9DaHVRNUhpRGsw
dHZHME1WZm5DenJsUTFpU2Zkd0JoVkw0OWZ6Wkp3TXB6SmdBNmF3QmJFeDBzTVh5WWdneHIKRVBB
OWNsZkJ6cEk4VUZFZEw5L2c0V0dwcUV3QXR1d2ozdGx3NDBuMFVHeXhYSUk5VW5IaUdueGhtMUNh
K3piNQpSem5sTmxhOUVLSW5RbjdHVEZKM1p6M2dSbEFXYWd1TnlNcFIzWXBadVhiLytIblZTbnM9
Cj1SRVFiCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=
--000000000000c9acdc05bb60816a--
