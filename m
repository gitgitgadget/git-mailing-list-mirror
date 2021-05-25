Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE40C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 09:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF666100B
	for <git@archiver.kernel.org>; Tue, 25 May 2021 09:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhEYJHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhEYJHN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 05:07:13 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F846C061756
        for <git@vger.kernel.org>; Tue, 25 May 2021 02:05:43 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso6063325otl.13
        for <git@vger.kernel.org>; Tue, 25 May 2021 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lT5bahm8TSetELksePWOabkNdMAsY/YegEDylCSyOKs=;
        b=C5qK5HyXYBiX+RGISmnq1CHYvrjonNi7RT2HwpH6kWfjYss+vS+RJbQ6JoybW2KxcY
         vL6FYsIbzUhiPShUwCWZCp0PdpyurS9oCCpZuJdjpHsZFtzakOMvhZJb21VO8F+gjKpu
         T76CQNXBKOnPv4D99G6NqNrpN+6ALeZmK9ELsz/aEOowgHmYi7BSG1KBbDon9hTqUGAx
         aB81XmUM4CGCojJy3XaXor2MRmBs8qs4WJROWUJcFfqw44CfkZE6DNMszvl9EW4rI3TP
         dqO9usFZcFxPV/uQFHWSIWqzoBgY9npfnLUYkkiuRncTlW2G/9fkfFym0HEVw9HVJ2+i
         AEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lT5bahm8TSetELksePWOabkNdMAsY/YegEDylCSyOKs=;
        b=LNFy32WGBr+2jlIEDQ+2W22qzaa3BS4mc//b0XYl6sctcejCcauITvTEFuICigBbpO
         KGNxYYBvJXVdFiwwnA6UTLduuklJ5BjS1+ppE3SjralgLzT81rEQxZokGQJp+WIrlaO6
         Rd8tXCKBHYGVQCFfcpTArhWAD/k5CXHhH/GT6rrAmozuayvteu7aonNZmFlf1h0o8taD
         fj9onN5ZPGFBvWcXYkqRe475Bm2UClPWLl2WlOZ9iJvuj7l0npaS8GQAMqjS8t5l+Tz+
         yYBgM7azx6Np4CbSn4n4P7DWU1IBGRueNSliy6zsdjCFK3Q6P5n4uzXCTjIhAryzRFtj
         5pNQ==
X-Gm-Message-State: AOAM5320oUbAJcDMyvgwK54c8JomElsr/Jtc1QqHsug2tsT5O5PE4DSa
        J8iJ+6QFh/OO0bTK71DN7y8=
X-Google-Smtp-Source: ABdhPJwdxUKhwBriYCiQyB1Wqc74lkRaJy5lsapsaLeO81CNDcziE2sAUoUvEAN+yngwTsNauVxGpA==
X-Received: by 2002:a9d:7303:: with SMTP id e3mr22886438otk.216.1621933542418;
        Tue, 25 May 2021 02:05:42 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t16sm2785495oie.42.2021.05.25.02.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:05:41 -0700 (PDT)
Date:   Tue, 25 May 2021 04:05:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Message-ID: <60acbde4621f1_2257a20819@natae.notmuch>
In-Reply-To: <8c08ee45-d7e4-b816-e883-a18dfa69fbc1@gmail.com>
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
 <60ab17018efee_1691c20832@natae.notmuch>
 <87o8d0o2or.fsf@evledraar.gmail.com>
 <xmqqtumrfgqx.fsf@gitster.g>
 <8c08ee45-d7e4-b816-e883-a18dfa69fbc1@gmail.com>
Subject: Re: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 25/05/21 13.51, Junio C Hamano wrote:
> > I think dispelling the conception by distro people must begin with
> > an update to contrib/README where it clearly says these are
> > "contributed software" that are not part of "Git".  They are not
> > something we stand behind like what we have in the rest of the
> > source tree.
> > 
> Archlinux packagers did remove contrib/ because they don't interest
> on it [1]:

Huh? The whole content of contrib/ is installed in /usr/share/git/ [1]

Some stuff like git-completion.bash is installed *twice*.

Once in `/usr/share/bash-completion/completions/git` and another in
`/usr/share/git/completion/git-completion.bash`.

> > Right now the Arch Linux's git package does this:
> > 
> >   find contrib/ -name '.gitignore' -delete
> >   cp -a ./contrib/* "$pkgdir"/usr/share/git/
> 
> > Also, the description there is rather stale.  For example, the last
> > paragraph must go as its entirety.  The ecosystem has expanded
> > thousand-fold since the document was written, and we no longer
> > encourage people to add new things to contrib/ directory at all.  We
> > instead encourage them to write and sell their ware on their own
> > merit alone, without planning to "borrow" authority and gain undue
> > advantage over its competitors by being in the contrib/ area in our
> > tree.
> > .
> > 
> 
> So basically we should deprecate contrib/, and then after next few
> releases we proceed to remove it, right?

I tried that many years ago[2]. Didn't work.

[1] https://archlinux.org/packages/extra/x86_64/git/#filelink
[2] https://lore.kernel.org/git/1399662703-355-1-git-send-email-felipe.contreras@gmail.com/

-- 
Felipe Contreras
