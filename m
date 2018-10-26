Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969841F453
	for <e@80x24.org>; Fri, 26 Oct 2018 07:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeJZQHV (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 12:07:21 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43599 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 12:07:21 -0400
Received: by mail-ed1-f42.google.com with SMTP id y20-v6so395452eds.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A10v8CbT6iFgODGuU8B5VNJJ+Fg2RtbUDu7apxhZbNo=;
        b=BTljUYZQhbFRm2aU9M+MwIukpURD8MJl1KEkWyRsqOkrp4vpypDb4TVYcz4OrP+4LG
         XwQPhfXYjCmdLDV/z9NDn3dmgWiDVqOJGn7a+E1w3lQB48pK/kFMwP2xymtU4vVJsL8C
         SpBPA3hKCL7TMK24aTShZJLs0JC8LpU2ynGIaAlh2B6Uon07xZ80aifqxr3939k/1RP4
         w4o7+e0y7XNiLaBaaatwja3gHsT20SNI67zc4Yjf3G1/5sVPrpion3xh2PKLplxkqqu/
         lzrXMVcyOdyIuPAdx+K2YuYcUgKczj20KubzUrWO/pCk6Y1c5+ky6xxk06QjptQXi/UH
         bGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A10v8CbT6iFgODGuU8B5VNJJ+Fg2RtbUDu7apxhZbNo=;
        b=h8C1DOYYSbAF1HlVOFhAMQnGIlCXF1vpjcox9fDoBNEw/2IB7aHKUUv6nNFECi5Uwq
         wPQ17UwyXdrdnCwciPrqoNFVVusqMzEtVPigkSsF9vvINXttMo2tRTZv77otTVRznXD0
         QDUdP3oXPnvOxkpZgZms/KYtrkniYkNhI8aRiZWWNppud9uWaKxFzxs5NVPgYY8F/ghh
         UlwrhcRJlB2lfQxh9CFsUk/2GuWd1ioahkb5tvJjnkswbo/Phv4X3g0x8UOjFnomISLX
         aoKxl2YUaRXpFtKaTs/PD2mjWNA2vXOReC2cLacJIagXViPuNFydiBCoZqC88QG3w0B0
         Hmhg==
X-Gm-Message-State: AGRZ1gILc2RI6nE2ZZD9CfgPSt25CNqWQiChWp9NHP01H+mmN7CykMHU
        VQ7F0FgBrvm6640Bm6egTpQxWkJcPIqFbS9lFHh8grBj
X-Google-Smtp-Source: AJdET5fcUbP8iVFnoQDUsMFa88J47dhVxxIUZ4RyOyjbFvFWKOx/yR/6G/Odxb9NM4G7Ax4P9br92+OxHk6YksIjDq8=
X-Received: by 2002:a17:906:6582:: with SMTP id x2-v6mr1656981ejn.22.1540539086664;
 Fri, 26 Oct 2018 00:31:26 -0700 (PDT)
MIME-Version: 1.0
From:   Raphael Stolt <raphael.stolt@gmail.com>
Date:   Fri, 26 Oct 2018 09:30:51 +0200
Message-ID: <CAM-9DY2KVjq2879TJUNhBsRBbAjScMS7U5scP-fAY0NsvCan9A@mail.gmail.com>
Subject: Possible bug in referenced configuration file loading
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Configuration for global ignore patterns in ~/.config/git/config:

[core]
    excludesfile = .gitignore

doesn't get looked up per default in ~/.config/git/ which might be
considered a bug as the .gitignore file isn't loaded. It's only loaded
when .gitignore is located in $HOME or explicitly referenced via
~/.config/git/.gitignore.

Configuration for a conditional include also in ~/.config/git/config:

[includeIf "gitdir:~/Work/git-repos/"]
    path = .oss-gitconfig

does get looked up per default in ~/.config/git/ and  therefor the
.oss-gitconfig is loaded.

So there seems to be a difference in Git's configuration loading strategies.

Environment details:

macOS High Sierra
git version 2.19.1

Windows 10
git version 2.16.1.windows.2
