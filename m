Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD209C2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 13:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF39214AF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 13:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3ae3fyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894868AbgDPNJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894835AbgDPNJg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 09:09:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44605C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 06:09:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j4so21082096qkc.11
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RmAspcDNaqjt3qqMMvKUZyR8mHI4p4IbJZ5l+YTzwXY=;
        b=P3ae3fyxNPgHWDoeJ8u/8hQP5LY13BT94rBJV8YpM2L0cEWQOvAtLhBuEAe+YmogFA
         Nx3gIuVA4RLt7Lf//G/Q1jy08/zxUF+KpptTj9Kt2jTqLPNTe8JRJoTIAPEcOHPIEhh0
         EL9bwn3tIQcbbBuzPnme60YUmDalRfQiFc7CY8gvyb8sYrDCF0yu26R/2BaGZJQkaHC1
         ne6PNqId6DuYoN+kjFq735QF6aKy6PW2mS+o62OSPLymQ0geEtLHJL5BuH7GQA/2E1db
         KJDHUL4rCzVXiOf04HcSny3z/wxLnckyCMnuWa0LQ/OjYCUC1VHYOPb0g8txHt96PFiP
         uPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RmAspcDNaqjt3qqMMvKUZyR8mHI4p4IbJZ5l+YTzwXY=;
        b=V5+4byoqp+eIKYOziuFH2ZjjiFYOG8w0/SHpH1SzGBHXhxw9xNJDQpGgvh9pRW+7dJ
         NuvaGxKIfMHNjDzymGbpKBK6h2Gpfe7S2Fj9vIo34LocFaLAfC2rlYw+MuLif2m4g2qz
         8IkCZRAZ5Ok79IqBqeDXXECKmh4rauj0bj7Lg22wxrNkDBwa6xaM7dcy//rJuUq9PiWs
         82E5mTWJQ/+3KPwvCImOoLBGe18NbbrosOZXAjRVVI7WyAJIRwZpYx/TZHfv75MiJia8
         bEpGvK9tLh8cqy247tXLc1FKEeqAwVdJldYbnHqRWs3GTiKmkCdpwbaG0hhiNU2AmWdr
         ed5g==
X-Gm-Message-State: AGi0PuaKgEb3ffFSnF2LdL/9SODdiOiDE+So4uWiyzLTfNwsqPioAUXG
        oz/riK5nyLIKNYB7xp7bAJOELSQgka4=
X-Google-Smtp-Source: APiQypJAkzQXcWUtzRaXGwy8B8rlCnHImjZgCuvj/k5+5kzvjk03w/ICDvNwkOMAp605WhVOxhNsJg==
X-Received: by 2002:a37:80c4:: with SMTP id b187mr19625029qkd.302.1587042575490;
        Thu, 16 Apr 2020 06:09:35 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a62sm14805844qkb.134.2020.04.16.06.09.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 16 Apr 2020 06:09:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 0/5] doc: --recurse-submodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
Date:   Thu, 16 Apr 2020 09:09:32 -0400
Cc:     git <git@vger.kernel.org>,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B4732CF-967E-4FF6-86F0-CE3612AB3CA4@gmail.com>
References: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Damien,

> Le 6 avr. 2020 =C3=A0 09:57, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Fix typo mentioned by Junio.
>=20
> Damien Robert (5):
>  doc: list all commands affected by submodule.recurse
>  doc: document --recurse-submodules for reset and restore
>  doc: explain how to deactivate submodule.recurse completely
>  doc: be more precise on (fetch|push).recurseSubmodules
>  doc: --recurse-submodules mostly applies to active submodules

A little late to the game, but consider this series

Reviewed-by: Philippe Blain <levraiphilippeblain@gmail.com>


(It's my first review, so I don't know if I should explicitly add that =
to each patch?...)

Anyway, thanks a lot for putting time into this!

Philippe.


