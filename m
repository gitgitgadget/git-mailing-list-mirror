Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F66C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91462074B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 20:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDmBq+yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407381AbgE1Usd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407348AbgE1Us3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 16:48:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B9C08C5C7
        for <git@vger.kernel.org>; Thu, 28 May 2020 13:48:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so1455790ejc.1
        for <git@vger.kernel.org>; Thu, 28 May 2020 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wrlKcK7g/QMImv1BWN2C80H8y+x+z9IZBf76mYgIbSc=;
        b=EDmBq+yudcx7XzJ/ky6L9UI4T9k2Wv9alNHjC3OTGTSinm7ctihAZeJj/J/5zpTRe2
         RwzDja0etWmB65uYBqgXefi/V2PY8EFJuwnQ/lm7XAYXOyKcVI69A75BxL2a/5Wxlebp
         mWOxv5Pxi0raFHrZdCGRfkbo/7WigkmdVgVrNffKnv/hLWV+u4K7TP9QCu3UGOM1m/tS
         jmJEPsUGFFsbb/0kc5adNmPQqbmdvo8WQVQHYmBtr07qpYv/qvHBzTPT7KWLlzpOMA+R
         vtxXvMzcBNRVakNBZsn8a4KOLOiF/b0LNQVnZdzcZKs3zQuFIChGyTCatn3ePCPsutWB
         5KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wrlKcK7g/QMImv1BWN2C80H8y+x+z9IZBf76mYgIbSc=;
        b=CZxaTRARMdTM7Hm4/LjCd85Sx42oG7AGujI3EhLRXilCK2XPMtbVNIZi/IAkhrMMMO
         rvl42HaGu6Hqzl7z68Yc9lkxU6sSJk1QS046Suq+i90YC7A7ifM2MTDw0UsZwmUBuwvr
         Qhs3TaS6z6gH0kDfT3/hW6f6cLdh+5Ia1nhGk3DHlGx3koINqONVlIMFtpCDy+GE2VVh
         bQJdgnOBmooOTGzKJ4KChTMviy11uYYSfjUoTCCeUngle9cO9KYbcOVp7Su5Aav5uvbr
         KWF9XOMIDG4LXYai4K7miDxKAiAkpGWqGrfzcnPRRxTIIo9BbfjujOZIRMp+suBbT82O
         LEgQ==
X-Gm-Message-State: AOAM532b3XKjs29GkxrTYM/Q/3YQnlshaS4rkBBkyZSha8WFv/ZFRmeI
        kMdqb2/tkWpxJYwnGdZow07oprNL9QfrigGZm5MpPmkORt0=
X-Google-Smtp-Source: ABdhPJwktYyWS0YopK0Av5C9WbyWP1v8BhHXVwo1/WcF0IA24p+ZgAG/bnbvA05eaxP9VgYyQ0SoTiPzlr++YaKWX4Q=
X-Received: by 2002:a17:906:3ed5:: with SMTP id d21mr5077559ejj.283.1590698907298;
 Thu, 28 May 2020 13:48:27 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 May 2020 22:48:16 +0200
Message-ID: <CAP8UFD2iMLbbQiXz18o=nLg+R+oTOK978AUrr=OcfGMt1gZewA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 63
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Elijah Newren <newren@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 63rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/05/28/edition-63/

Thanks a lot to Johannes Schindelin, Elijah Newren and Damien Robert
who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/433
