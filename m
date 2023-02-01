Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15415C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBAXyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAXyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:54:03 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA73754F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:54:02 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id w12-20020a170903310c00b0019663abbe88so52149plc.20
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+eOKxnydpmO4q3zXYxWsr77Bi3ZnjgxaR6GSOUHcVCM=;
        b=c6GcDJGYR9ABlbC2nod3IMc/DQY6IzA4L88KWun+XjHQ2ZklhBEXtsuQhF4L4Bm3Hd
         9ftCFDl8Qs36SFOxQmuPkg005IjwirmcjYp1wQvepf4OBN9yBS6txByW3+PXdaGfNgAb
         c1bdimyUykhTmeNfe4dXO/chPvW48t1uM+bt727k9Le8fkxyrRPZUqO5KLloAWE6F3KI
         IabHzG6irUHI+AmmgA1263Xs5yNctd/dpUTNIDStfRQjADXwjBdgVSmtflOxO2eOLDEA
         c5Bpk6+xiX/nxBkleXF5ECBtEueXv9E6AE+acfsBDHF0Fgd7fjkZeZEVY1EfRtWACnMB
         XXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eOKxnydpmO4q3zXYxWsr77Bi3ZnjgxaR6GSOUHcVCM=;
        b=e6eQpLc7Ahm9oukWO+tEZ4I2WMnnKWXYNZq+8eBy37grzb2su1xj3zLXj66wK04/xS
         bWLHNkFq3TO67UYjm5Qrz/KmGVHP8kagEzRt+1KDiQwmvNzPIIJwhUIHL0yR+sQBLhon
         ItuvY/K5IR1VRUM6eKSh5bWGl+SVgbhCf3Go3+4JO1q0s6IEfUbWlQuh8lfsGlbNi9ZH
         pTV9uMgYpajPfaTDov6tMWmtZIzKdx9zAtNEVS+SMWRrvLg/KE0W5SeMILyVwU1R9EPf
         Cphxklr29+QeeB3rJEwRS9aQSYxZxF5HzZAkh48Qm21r0IGvTPN7t0zs1pbvLdPYQr5T
         F2Dg==
X-Gm-Message-State: AO0yUKVwgm19shclJAbwj7npbE9bsNZEEm3tAuUhKLNWpoyuNLW4N2Px
        lDoaCXcI+Y0dV9NfQurrTK4EdyZ4w7IqY/w=
X-Google-Smtp-Source: AK7set+dOkzIqY4CXLgvEzX8O6G/hg9571W3RBER+Erge1RfVEI7UPkNqFVXjwt2dMZpY1lITmvL4u7EnNAURD8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:da82:b0:196:81a6:2aa1 with SMTP
 id j2-20020a170902da8200b0019681a62aa1mr1185615plx.4.1675295641749; Wed, 01
 Feb 2023 15:54:01 -0800 (PST)
Date:   Wed,  1 Feb 2023 23:52:49 +0000
In-Reply-To: <20230119223858.29262-1-zev@bewilderbeest.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201235253.1891546-1-calvinwan@google.com>
Subject: Re: [PATCH 0/5] format-patch: Add --{to,cc}-cmd support
From:   Calvin Wan <calvinwan@google.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Patrick Hemmer <git@stormcloud9.net>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Emma Brooks <me@pluvano.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zev! Thanks for the patch series. I agree that these flags are a very
good idea to add. I appreciate the well written cover letter -- it does
well describing the need for this series and calling out design
questions. I'll leave the rest of my comments in the particular patches,
looking forward to the reroll!

>  - As currently written any commands specified are only run on the
>    patches themselves, not on the cover letter.  The slight
>    inconsistency with git-send-email is a bit unfortunate, but I
>    figure it's probably not often all that useful in that context
>    anyway (and the implementation looked like it would be just
>    non-trivial enough that laziness may have played a role as well).

It is also inconsistent with git-format-patch --to and --cc. I strongly
believe that your flags should also work with the cover letter, since
users should expect equivalency across similar flags. git-send-email has
config options, sendemail.tocmd and sendemail.cccmd, that I also believe
should be implemented.
