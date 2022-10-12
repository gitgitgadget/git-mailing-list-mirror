Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB3BC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 06:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJLGQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJLGQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 02:16:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DFCAA37F
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 23:16:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 63so18959953ybq.4
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I0GINF/H1prycjsAviYmPNxBR1jkIEVp3YabyTpOlz0=;
        b=CilJfee5acyqMyQ9fThZ+u/7GsY5xd8z8w38II7yCWvNFT5DGG4yixyyXZYSexsFcG
         YKRfjWhJAn37w7LHtQUwqekVVnQFUhu5MQ5YQZM++EScaLay9lFFz4mwGm96yin/s6TM
         rP4RPq9CNwSX8WaB/6FQMWW31qxphdt6nomHPIwMqqX4i9Wcd2ctId5ifl9/L6ykrV8K
         4hmPtNYtAZ0X6bn2WGTeOjnwI/d21RFbRETUbRHXWWHluq/73H51XjPR4r7xkBML/R/T
         VSwVdGYthUF/UZ2Y0KGYYLAsVCvjHb/DDu3X7u/cHpYSN6YFIHw4MYEtqPHeif1TP+O/
         Jz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0GINF/H1prycjsAviYmPNxBR1jkIEVp3YabyTpOlz0=;
        b=WaRt1UJfrx/L74iqLlEbr/fJAev0AIwwWsZVCugIrsCOHH2z7liQRp7WjPldjg9Eoq
         9vzLa+fqssWh+x3Rc4g5Kd8gksqjebx3VMQIYnngkSGiYa+MFRhfHOu6k36rU2FwY3EF
         smV9xTOhcpChr5SH52VXXFjwR1lRF7nQXKdEKIL1eB6p9KgNTJQ2FTVYl6e1SwGGWN0y
         UIERx9JBpAwELtLD7YTa+ox/0WExVOKObFqcCiGEdnztV8cjFuwXukauokur0TwHA1JI
         2YBrDhjUp4GABrw/xygBnfjBhB++allJyLBRNJmhJIbDfZuqKlD+Qqz8YQHZ9TSm700I
         vJVg==
X-Gm-Message-State: ACrzQf386kf4asTDEcWr6AApLuehCYfU8HTnE/k4U0h/tABHW4msu7me
        egK0Kn8VtUcGs88npRefb7bFjxDxYizfuinaT5s9E28EOk0=
X-Google-Smtp-Source: AMsMyM4pa+pkcAo0LkUlTgtS6rJ/BBOiE2uOnoSMd9K6N1mTXiSVl9/uMiXVkdrDuc2IDiANPLkl17TUN06uga78Rho=
X-Received: by 2002:a5b:8c2:0:b0:6bc:272:4f42 with SMTP id w2-20020a5b08c2000000b006bc02724f42mr27469907ybq.555.1665555390164;
 Tue, 11 Oct 2022 23:16:30 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Date:   Wed, 12 Oct 2022 09:16:19 +0300
Message-ID: <CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ1uBwVHuRrsQ@mail.gmail.com>
Subject: 2.38 "protected configuration" ignores includes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After Git 2.38 (specifically after commit 6061601d9), git no longer
honors safe.directory settings in files that are [include]'d from the
main global configuration file, even though they are shown as being in
global scope by `git config --show-scope --show-origin`.

The docs added by
https://github.com/git/git/commit/779ea9303a7de3d618f3b0e329ebb89529ab3285
only talk about scopes and do not mention anything about [include]
being specifically ignored.

$ git config --get-all --show-scope --show-origin safe.directory
global    file:/home/grawity/.config/git/config    /srv/this.works
global    file:/home/grawity/.config/git/config.local    /srv/this.does.not=
.work

# ~/.config/git/config (owned by grawity:users)
[safe]
    directory =3D /srv/this.works
[include]
    path =3D ~/.config/git/config.local

# ~/.config/git/config.local (also owned by grawity:users)
[safe]
    directory =3D /srv/this.does.not.work

--=20
Mantas Mikul=C4=97nas
