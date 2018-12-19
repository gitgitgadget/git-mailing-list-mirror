Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531351F405
	for <e@80x24.org>; Wed, 19 Dec 2018 07:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeLSH0G (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 02:26:06 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:54994 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeLSH0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 02:26:06 -0500
Received: by mail-it1-f181.google.com with SMTP id i145so8199002ita.4
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 23:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gregy.cz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=EoF4z6/U5PbgpBjXOENeJPOkZdTeyA4pO6z1LYfjpm0=;
        b=W9Sn87BrWASpll1kVql0vUhWVQXCzQodWKtKy2oykIcSRFvJlRmRmEN3aKRkToCii8
         u7N4h7Hg6tobdXeeapT92iJ+HwibMCPmhNVmron6swM5ZwLW9E6rSzO86owJ61hocVfc
         tzXP285fuu8i7SyP/Sj8dCdzSZNA15Ue6N+70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EoF4z6/U5PbgpBjXOENeJPOkZdTeyA4pO6z1LYfjpm0=;
        b=cyCnP/kW8h5vt1L62J6X+rzqtfndinhyR9+dUNs5ZdAYl1+G7lq3kUoQNiGCDMeDo2
         Ge2Q22tyNZGsgLJK08rwh/3ZemjX6g++TnFmJybhxSDv/Il29T5QTLBj3BXhG7UwUEiX
         5F/zLemu4YKeZ5io4zAsikAXm8rEIm+fn54EuuBOzRm6vvngWmgB0uaqg3hwm9raXjPw
         Kj+DGYzUrS6P6XwFOe08jw4V4eGOW66KOO4tFpSqY85CHxfs0V+iVJycoPTCentapBXz
         klhHAsFEwecqzfogGAUmx0qgeGpkMMf7YjOiccta4lKzzh24C9CIf8Gjv+Xo+Z6Eu3gR
         G95w==
X-Gm-Message-State: AA+aEWaUJBdKWbw5yYq5B4FkyeNlaMDBbhi/XelEKOVf6W6P2Pz2cHP7
        5E299yxWtrh0UL6cDN0yGjpGe9zVQ6DBrNdXzo7yOoFJbv2G8g==
X-Google-Smtp-Source: AFSGD/U9fVaxr2cmcl4VDi9PKpYSDFZjfAN940qAW3D6GX4EsLMP2jloEke7dpk+nN2qMA0GgcyWit4fCjuG0Frzknc=
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr5378727itd.148.1545204364632;
 Tue, 18 Dec 2018 23:26:04 -0800 (PST)
MIME-Version: 1.0
From:   Petr Gregor <gregy@gregy.cz>
Date:   Wed, 19 Dec 2018 08:25:53 +0100
Message-ID: <CAHsG2VT4YB_nf8PrEmrHwK-iY-AQo0VDcvXGVsf8cEYXws4nig@mail.gmail.com>
Subject: bugreport: git checkout --recurse-submodules overwrites unstaged changes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I believe we found a reproducible bug in git checkout
--recurse-submodules command. Documentation says, that this command
should not overwrite unstaged changes in submodules unless -f is
given. In reality local changes can be accidentally overwritten even
without -f flag.

I reproduced the issue with git version 2.20.1 like this:

git init
git submodule add https://github.com/Gregy/znapzend-debian submodule
git add . && git commit -m 'first'
git checkout -b 'newbranch'
(cd submodule && git checkout a3a7b0)
git add . && git commit -m 'set new branch to different submodule commit'
echo 'test' > submodule/debian/compat #create an unstaged change
git checkout master --recurse-submodules
#my change is overwritten

Thank you for maintaining git, it is awesome!

Petr Gregor
