Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A5C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC1220708
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNPctiCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGHXHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGHXHK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 19:07:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E24C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 16:07:09 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i3so263144qtq.13
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 16:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=GSmJ4b4DzhElGPbNScMXh8/bXPCtNWKg5MWSfINYSLg=;
        b=jNPctiCQ7lB6shdW1n1ZONFzg39k7qSu28UtxqRFH98uvXr6A0pmp8Sm0LaRCc1kOy
         d2g8kqraY5USgbcNcZK1ZoDEdxYUGNlewO8VZwZMz0UItyVg353gnCGB7HvRo8FYNCnU
         eFTAputhrWOj4Z9XqoG0e+mjlbZNC65dAGoBd5plIex+rc9wqYEF1B5ZGanlqirbEgti
         dwfmgUCf/ldDD+IfoijnBMxaKjCFNUQ6QZ2j6XZjsBjaFJ5odNoyBvwV9WYe0mixnY7V
         0NbO6YbP1SHqxcRWz5egvFBFepcUYmI8dwMFq+YrGBWpM3OcHkteKpt4oKWY/uOUVAgZ
         tMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=GSmJ4b4DzhElGPbNScMXh8/bXPCtNWKg5MWSfINYSLg=;
        b=NTFE+4oaTcIYD6UwQB+calwLyzPyblDyhwTCiQ5mOhUwTXYx19VWlHR7PE0c8y+Wya
         40EaET/RxE0tkJJUIf0xL1CYyZnOkaD0QF56bdvQdgGwv4h53QChCKvi99Ya09pbuOG4
         Jh5ucWFA8/XbIu3hD0BsXWCnhI3WRrFN4atBGMxO+d0lUP9BWaE+FKXh2znN8OWUvTj0
         qKLfMLG5rKM0+2egSuZ361cQekWuD7Dy1XIQa+QXKcGMkaPrnwUXmxVXQ3CCl/18zmuP
         Je2qJYJP1+09SecfmivdTZ6mKVy/Y+8JUXzi48e7yV0Wh9IfL6MSnasoB6kF+rQJEXfO
         BiOA==
X-Gm-Message-State: AOAM532rbRgm/X5pIUgUSGiwblnWxUOH/8C8V75oMZDVMbEl8/60+/2G
        oKZByIWIzxJ69F3PSkJf8Ccot0DC
X-Google-Smtp-Source: ABdhPJy82+yE40RCVCsaGucv8b7HeygqqAXR/AdW4BpO/n9JgDF/L++eDQ0qo6w1MbDfxIcWsQNB3g==
X-Received: by 2002:ac8:3837:: with SMTP id q52mr27570714qtb.186.1594249627950;
        Wed, 08 Jul 2020 16:07:07 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q189sm1546179qkd.57.2020.07.08.16.07.06
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 08 Jul 2020 16:07:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: rebase - "fixup!" conflict applied at the wrong code location, why ?
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <7A30EA48-72E3-47E1-9792-136D7B96DC84@gmail.com>
Date:   Wed, 8 Jul 2020 19:07:05 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <C284D053-AD17-4321-88CD-3596F0FAF1AC@gmail.com>
References: <7A30EA48-72E3-47E1-9792-136D7B96DC84@gmail.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 8 juil. 2020 =C3=A0 19:03, Philippe Blain =
<levraiphilippeblain@gmail.com> a =C3=A9crit :
>=20
> Steps to reproduce:

Forgot to mention that all of this was tested with both Git 2.27.0 and =
2.27.0.22.g20514004dd=
