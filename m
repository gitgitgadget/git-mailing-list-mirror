Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C0EC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 15:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiLAPRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 10:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiLAPRD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 10:17:03 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7700CD9AA
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 07:16:58 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e141so2437393ybh.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 07:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TlWEJ410HKWjJEJhWb4U9AVG2D3Pak2NoC1//X/V4kc=;
        b=eukhTckkJdGdYVPh+L071ZnOgPX1PYNCN2cmBSfhbFTdgPbur47Da+LwByu37cCH27
         j36HULFcQVbi9NS408STLPQTpV9bCqZRoZNxnakyJdAncf97bMLnPxeBRrUh0vgs/g04
         b8WlcNh0mS3310A1cN9smdAbxu+z4L6OOmySJ5MUywc4ffUKGLG3s+gyfMDh1ZYRmUzD
         0kThODkUBwHHJMCn2vjYNosOhD/OENuGAnnltNlJ6IfnqQBRu35pu4lZ1nguHJmbNc9r
         8Z53XJFFx3eAHGN/P7tp2uhwTeHCe0OL9SDl4NPRKkiK94STPwD2bC9+/GLBGHnQTJtx
         XW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlWEJ410HKWjJEJhWb4U9AVG2D3Pak2NoC1//X/V4kc=;
        b=76LvgcnfXkqFYMWlASnPvf8SvclCCRPGWBjDh4d0H1kpF8k2/v7s8EUAz5h0Ffo7FR
         2UK7WVpgt2F2n03W4pbhPTJmA6HfrKOlIyywBXEbS2eEe2BH6e7HkCRcu2R2D2FNk9yk
         lJ+ODIEiIubiB/x3GwXrlnSo5fHL+GZEWpw1W8lX+syKFC76gJDelc9JQ+AGvoH1H1sN
         3M2N14pyBDjsnXLnud5AVCdmdNANHBL3VbqYaH4X4uM2hmhfdT66D1VwLIyvtXJLn+Ap
         Q9PM6bMUAq1cetBVAX5pojgHbXtHPgz+X/pDv7Y3pQRvB6rTJYxJTJRLl0nyQUAuvKvQ
         35kQ==
X-Gm-Message-State: ANoB5pkHH8Bp6ncF1ZauyGTa3Fwe2RC3DKJHQ1EyoyMy7T/fQ16vZRH8
        ok7m4nQn9X2N1gMS+8mUJt6ApCEf6jF7GmQxMOs=
X-Google-Smtp-Source: AA0mqf68aZIFjZwLrnuxW5dNc9jOUMdR/GbzAZ44qB2igRpyq6oOyaaWVe4/i5a9LjIay9e1kyPv7Bm0Tf03op3R66Y=
X-Received: by 2002:a25:dc11:0:b0:6ef:f9a4:a267 with SMTP id
 y17-20020a25dc11000000b006eff9a4a267mr40645710ybe.232.1669907817878; Thu, 01
 Dec 2022 07:16:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
 <pull.1384.v9.git.1669769536707.gitgitgadget@gmail.com> <xmqq4juftyan.fsf@gitster.g>
In-Reply-To: <xmqq4juftyan.fsf@gitster.g>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 1 Dec 2022 09:16:46 -0600
Message-ID: <CANaDLWLdkaJs96KTBA2B-h+Ei+f7ayS-gvvN06Y4T7w=GgPGrg@mail.gmail.com>
Subject: Re: [PATCH v9] status: modernize git-status "slow untracked files" advice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> (I thought you were going to update the proposed
> log message, too, though)

Oh, I'm sorry, what do you mean by updating the proposed log message?
I'm looking back at past feedback, and I can't seem to match it to an
unaddressed one. It was not intentional, so I would be very glad to
fix it if you'd like, I'll gladly leave it up to you.

Thanks a lot!
