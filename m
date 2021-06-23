Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC651C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA28260E08
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFWTDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWTDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:03:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFBC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:01:03 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x196so4446005oif.10
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=X9ml+XqnHjnejiahYnVR+Z/58s2yVzy4MAWGe2YPcLA=;
        b=g11owPDdUX7Gq+eGPs9wm6jOLhY+UkNyW8VlxbGMI7dlVxx3Z3zD1CKYMljLXRqeZu
         KlXq0MYDzXulq+Nquywv+ZoYI/qbt1OSVB+bsIV3puZBFJ0ubZJh0KSsCnROe2seS4Xw
         Jox8gcnI7fkK5oxl8Wi+0saw87aVOPT3oMgQXsh/YUzszWPtijd7C8yI1FGoQWbNr1qI
         ULIeSVuTjjnE7Xzbd2exajq8mTMz4yyTf6CbsFgcQoJajs7vql5YYMcAiktzHUNvzJ5z
         P372VCUJ+/gffT/8lyxdp6U31t6H4iZpkZHjoTsmijgg0lWVKw66pRX3cIeFSxgNM33l
         /HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=X9ml+XqnHjnejiahYnVR+Z/58s2yVzy4MAWGe2YPcLA=;
        b=uh6sGvRdSkue0g+k7uHrc7O+v1arHiX/u5pBnE94M2QScZo32QpcV2xeYRFZyxLCKU
         malEGUw/YY9OuTM6/6SlcONopq2jdNrtVx2Hqow7BymdVvqXmOVWvELFCnXHUpOy4Ipx
         3i83xAkBftNjuyV3CHJC+G2owPO+TV08Fi3iIerYW5DdkT6RkOgMnpOEEUAJHHfKUkBB
         F79VS4HlVhEiMVuqI9mqe49MGzszZDgElw6sk75m5PMt3t0y0JJYbibwoDE92mjA0mev
         7r1abIJ3sCHFT3EzXNs0H1Nf9taBZWeCOjquxe1Fao8QdlzoHzR2ewOpxoBupKVdJKqN
         OXPw==
X-Gm-Message-State: AOAM5336rTWg5slkkZ5TWdyD6+hdxzPMsKJVxXkLRaiP+5sEyWqRczpQ
        F0Yy77Xl8A5s9fUeFgh+POg=
X-Google-Smtp-Source: ABdhPJwxnUwaiajTzTh+HH9rOGilHOWWnUJUW88rGWAvhr/MVabeudM/eM3YNf7tuZgo7SsSZH5zdg==
X-Received: by 2002:aca:59c3:: with SMTP id n186mr1101745oib.98.1624474862655;
        Wed, 23 Jun 2021 12:01:02 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w5sm149776ott.61.2021.06.23.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:01:02 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:01:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d384ecd5ad3_4290208c@natae.notmuch>
In-Reply-To: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
Subject: RE: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> As in db10fc6c09f this allows us to remove patterns of removing
> leftover $@ files at the start of rules, since previous failing runs
> of the Makefile won't have left those littered around anymore.
> =

> I'm not as confident that we should be replacing the "mv $@+ $@"
> pattern entirely, since that means that external programs or one of
> our other Makefiles might race and get partial content.

The reason I did it in db10fc6c09 is because both asciidoctor and
asciidoc should deal with temporary files by themselves (like gcc). If
you interrupt the build nothing gets generated.

However, other scripts like build-docdep.perl would indeed generate
partial output.

In my opinion it's the scripts themselves that should be fixed, and not
the Makefile, *if* we care about this at all.

-- =

Felipe Contreras=
