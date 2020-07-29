Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9AC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A39220829
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSWp0H15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgG2WWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgG2WWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:22:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E5C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:22:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g19so12128133ejc.9
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BuGRkY8A1Q9jHWyP2Zq6rMqGE+mjkSeVaIvFmaKQSDk=;
        b=gSWp0H15BBme0ILTk1to/T/BYRSzRPk/Wbe3mr4LtiHBQl9FgqasK/Wg9NwaUXnt0d
         Ig6SSRKm5vIoKxEF2sSR9asE9bSPXAFDIz7cCpMfMnS+etaSRsidb6/vxIQscxSodRI8
         b8lBYdu8SiDDxKQhsqAleGUFapBwWyDh/ycWIiInY/DM7484KtqmBOytAvP01phDHlng
         B0gxj7KJPxjPqrL9WBn5ic3BHud/UuaLLrvNecFUq91e5UN9isBNcTTE0MPApW2kzf9M
         mmMSO6/wsreQDruugWZ2yfsJb/sYD3rRxq34W4rkd6eyL6lH2NAkjPajBH4aHr5RJPUa
         /ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BuGRkY8A1Q9jHWyP2Zq6rMqGE+mjkSeVaIvFmaKQSDk=;
        b=pNfbq9pxS5l+tnw+U2J40ktwbhn764AUl+0CIF3mFqENpY5x07szzQT+DbLJguXU1A
         6RaGdYzF3k3zhbMSNkCaDEsgfC4sUEdQLazQ+q2v2ckAG9kpUhjOZ26h0GqTtkimt3jh
         3F6vC2os2GwyDX1vXhddEm48JURdkBu/TO/JenxZwICGApcTbBCBk+1eTLoUhKP7zxoW
         xK9a8thjlQsMcsGhmnKCCOhyqcIWcmsrOo8fG91gtNg5x9bGnncJ3UakWl5+AeBknLMV
         2LA7cgoAO0voH6BVLjzuU0o/jfp+QddvgDOUKDCm9GhPbLKakvTqPoiVq8iMvMJ4Wwsx
         wF5g==
X-Gm-Message-State: AOAM530zvMvbehN3E5eouv1M+duAcW0GFJSt/yE+NplCOZA25esaWw+R
        IPn6VoOjIzB/Xd9sa/6O7wvt+VYjSi/a900A2MW/cCqGFYg=
X-Google-Smtp-Source: ABdhPJzw/vPR+4/z8JQ/n78r6JhqvBr3cDNxf2v5QZ9MQPLzhieXGKU8FvRw2AtOYcOlm7P9DX41aUTRTFJX+iIDFhA=
X-Received: by 2002:a17:906:38d8:: with SMTP id r24mr448385ejd.341.1596061354115;
 Wed, 29 Jul 2020 15:22:34 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Jul 2020 00:22:23 +0200
Message-ID: <CAP8UFD0DKCEtXBEzCNUUXsBQ3ZoKnqpR=p=4Zpoptvk-emFJAg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 65
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Garima Singh <garimasigit@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
        Taylor Blau <me@ttaylorr.com>,
        Brooke Kuhlmann <brooke@alchemists.io>,
        Liz Landau <lizzie.landau@gmail.com>,
        Carmen Andoh <candoh@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Petr Baudis <pasky@suse.cz>,
        Bastien Nocera <hadess@hadess.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 65th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/07/29/edition-65/

Thanks a lot to Andrew Ardill, Jonathan Tan, Brooke Kuhlmann, Eric
Sunshine, Carlo Marcelo Arenas Bel=C3=B3n and G=C3=A1bor Szeder who helped =
this
month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/453
