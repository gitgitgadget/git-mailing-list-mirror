Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2653CC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 02:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C3A6056B
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 02:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhHDChl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhHDChg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 22:37:36 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA1C061575
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 19:37:23 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id 79so361414uau.9
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MTDdy4GXrHA0CZStzzJNbHH+uQs0f4ZEE6eLtkXFaB0=;
        b=aO3SQIi3GK7eetFWzXvGQhJPwdTCj5QTObTo8mIZmk8eJBcpOHrCftwdY8WOrEjpV5
         IFCVV/lDbarTSdNPncbJjWsT5yDdSaI10/Ve+r52MueUIl1vga4HZZAtAHkx7Zh25YXF
         0QbtLEYzLf2PJPa5cEc5nzD3ktZ803wA/HvHoV5+dF+24DKOx6baxBnZmy+2xye5GA/R
         CPB2JmZWopLf5yBe0KNkv3MnYnbRbsESeBuf3UMg13iHUVZtRi3dSweBlcKLbvv3cCE2
         GywO1nzbP8hxZgH8AubWRIf7UaSi7YsPbD4w6WQIoThhu/meKT9fqpkjvDj0OzFGFm9X
         FxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MTDdy4GXrHA0CZStzzJNbHH+uQs0f4ZEE6eLtkXFaB0=;
        b=nlDUkO+lFeihmwD/S8ARnxJce1F8dlLZsosmmUdm5uQaEwsNWF/Hg6Z9vAk79u0YJE
         8UMY+L4mBBDNcPVqpLg2ElGQbcgEPRmzYMmreTu0Duy/bj9Xrd2QaK9sjJKOGMGA6ItS
         J+mNnm8NAeHHatWSJBcWvv5joP1df3K9K7OZbX6u6zFkIGdJr94kmqLQoDYr1IO1u2CF
         qX1gSmr86Lvu+jAMak1zioM3guwvjnpD+F0Z5+lqm8QpsIhoHoeW0W/+ab7JnZxn3TJV
         hF9WLLuzYkoQjRXIiPog/AvDPicFKPINb92VgY+j8Ul67mnt908AHYwNAq3aQzzTaBAR
         ilnA==
X-Gm-Message-State: AOAM532im5OYwRh8VPkeLiqosjKiLiEqWv/jN9SpowyVxZj42vNijyq5
        nQMKYuryR9qMINrJmVrfQn1U7JRNhE26zj8DTCZ/r6Wi
X-Google-Smtp-Source: ABdhPJy5Soe1RKIxSqjq5sOQ4BBMhQjzyAl1OQGKeEuftn5T0qINPG1OSWcA+KznE3V4W1N7YmJl8Eneael4KyCxD5E=
X-Received: by 2002:ab0:2814:: with SMTP id w20mr16713151uap.140.1628044642047;
 Tue, 03 Aug 2021 19:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210804010900.33133-1-carenas@gmail.com>
In-Reply-To: <20210804010900.33133-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 3 Aug 2021 19:37:11 -0700
Message-ID: <CAPUEspj56Pc6Ubbj+nY2gM3f7TX3PfvnSj8BGcMcG2evaeG4vw@mail.gmail.com>
Subject: Re: [PATCH 0/3] gitk: macOS improvements
To:     git@vger.kernel.org, paulus@samba.org
Cc:     sunshine@sunshineco.com, tair.sabirgaliev@bee.kz,
        lists@haller-berlin.de, tobias.pietzsch@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested in Windows (with 8.6) as well not to introduce any regressions

+CC Tobias (gmail instead of the one bouncing in the SoB)

On Tue, Aug 3, 2021 at 6:09 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> The following patches improve the user experience for gitk in macOS
> by avoiding to abort if the terminal where it is running hasn't been
> authorized for Automation as reported a few[1,2] times already.
>
> It has been tested in macOS 11.5.1 using both the system tk (8.5) and
> the latest (8.6.11) from brew, the third[3] patch is needed for using
> 8.6 and has been included with the gitk version from brew as well.
>
> Carlo Marcelo Arenas Bel=C3=B3n (2):
>   gitk: skip calling osascript to set frontmost for tk >=3D 8.6
>   gitk: avoid fatal error if `exec osascript` fails
>
> Tobias Pietzsch (1):
>   gitk: check main window visibility before waiting for it to show
>
>  gitk | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> [1] https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshineco=
.com/
> [2] https://lore.kernel.org/git/20201025175149.11853-1-dev+git@drbeat.li/
> [3] https://lore.kernel.org/git/pull.944.git.git.1610234771966.gitgitgadg=
et@gmail.com/
> --
> 2.33.0.rc0.433.g9a510e7e11
