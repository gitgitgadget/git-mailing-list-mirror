Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC672C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8151F2074D
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 00:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDzoVdbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgFPAQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFPAQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 20:16:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69249C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:16:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b5so7416994pgm.8
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=AaT1t8OGFzlKx7MkMQFD2hj/wixCSlTo3qTCWDzdVKM=;
        b=NDzoVdbFOP7cBZe+Olgkaow9Kfk7AeB3/vtJLY98pWWbHwSa/fcIBSYpQsD4BSMuYh
         QNL7ZD+O5HwlKkw7nBbEnGAX9mF/iN8OSzfVc/Yu1T/xtBMMsKpC6UHcwj859rTq0Tvd
         arZ4YMKJCXXi88aHuGytLw4JESQs66CpK6KOZgD5C9q1MN5sVIVX+wrIeihSO/i+COkZ
         2ag3+LoDLUccNW4EWhz3MLENP9wrOheq9jNTrT8iW4USguRkUvXSham1qPQFpZwxxu5j
         BjVL7vBa64qgK32SVPfLWeyQvn/WuV644YjNd7gMgcHSsRt5fILsZU2S/AV4DedSECmw
         05Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=AaT1t8OGFzlKx7MkMQFD2hj/wixCSlTo3qTCWDzdVKM=;
        b=aPKScOIGcEDzouKhlfl7djIc7SfcQxzWr41RCWyJJXVPmJiMArODPhUJxIuKCzW6mX
         8eM6g6N0/Jv5ohlxqb2ZA4k1AlKHcqNb5iA2uOrG4uy9uzo2wpjM7O3wdvZIxICa9xg5
         bY/syjMouFopT7/O1aupO0+VxuWsayjuE6xF2WyZqpEz+szZcmr0UZgPjf1+/xevorrU
         lk8J4gmlmZ/o6olRoTZfPd3XVG/tVM5Y2YHELftKtZ7Bd56MqX35jBAAWJkbNmoPJ+sm
         v9/lL6ZBeseWI0UKteZh6XVUgUO4i2DN5NpbaaTLSrsPM3BLVuyMrpdxFXMQc0UQYPyD
         AAmw==
X-Gm-Message-State: AOAM531j2FxkXDXuy94RCO+iOPS/72prU4lttG7u054YjO8hLYzyn/Uo
        ZT/ZpJYb9l7SKnTNzCPr28esZf4yWnU=
X-Google-Smtp-Source: ABdhPJx2JwFKBfTEy8tam8RskHceISFv0DELs5czrxWTSrjGB0bZtxp/Pyu5ajOPF+HFwZ8UxqIzvw==
X-Received: by 2002:a63:8dc4:: with SMTP id z187mr60795pgd.199.1592266583676;
        Mon, 15 Jun 2020 17:16:23 -0700 (PDT)
Received: from [192.168.0.32] (S0106bcd165660845.vs.shawcable.net. [96.55.138.35])
        by smtp.gmail.com with ESMTPSA id 74sm11907512pgd.40.2020.06.15.17.16.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 17:16:23 -0700 (PDT)
From:   Abram Wiebe <ethanpet113@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: Rename offensive terminology (master)
Message-Id: <F17A9CF6-E020-45BA-863B-D85F098691B1@gmail.com>
Date:   Mon, 15 Jun 2020 17:16:22 -0700
Cc:     git@vger.kernel.org
To:     simon@bocoup.com
X-Mailer: Apple Mail (2.3445.9.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr It sounds like you mean well- but that has the potential to break =
a lot of things that expect the name master, so I=E2=80=99m not sure =
it=E2=80=99s a good plan.

I am against this as a default for technical reasons, and as an aside =
because as others have mentioned master is the in the context of a =
**Gold Master** meaning a product which is ready to ship. I=E2=80=99m =
sure your intent is well meaning but this does not appear to have the =
connotations you are ascribing to it.  Given that I am against it purely =
because I see it being confusing and a maintenance/backwards =
compatibility headache to change.

Someone said you can create whatever kind of _git init template_ you =
want and I think that is probably the best course of action who continue =
to take issue with what I think most consider pretty innocuous =
terminology.

----
Now for the technical problems that could arise from changing such a =
thing on a whim.

In software there is a concept of a known value which is expected to =
exist for min(lifetimeOfProduct,HEAD_DEATH_OF_UNIVERSE),
and no matter how much you want to get out from under it you always have =
unforeseen consequences.
It=E2=80=99s not quite as strong as a hardcoded constant, but it=E2=80=99s=
 effectively a convention everyone follows kind of like a system=E2=80=99s=
 environment variables.

In this case I can already see a few things that will go wrong:

1) Any utility that augments git and treats master as a special default =
branch (regardless of the note in the docs that there is nothing special =
about master except that it is created by default) is going to break or =
need to be reconfigured.

	1A)There are infrequently modified code bases with small teams =
that will have to unpick this,and may do so slowly=20
	causing their package to be semi broken for some time

		1A.1)Any codebase which pulls dependencies form those =
repose will cascade into failure. goto (1A)

2)Any automation written by a user which expects the branch master to =
exist will break.
3)People who have already checked out the master ref may accidentally =
cause a divergent master history as habit causes them to merge into =
master rather than say main.
4)Any documentation of git either in official git documentation or in =
professional training materials will become considerably more confusing =
to new users as there are at present 15 years of archived documentation =
that refer to this branch as master.

We run into this kind of issue in software all the time, which is why =
you see packages like PHP deprecate interfaces=E2=80=A6 but then still =
need to keep them around for decades, simply out of fear of how much =
would break if they actually took them out.

Probably there will be more issues that we can=E2=80=99t predict without =
testing it (which again I am personally against doing unless it=E2=80=99s =
you=E2=80=99re own repo with your own template and your own rules).

It will probably be a maintainability nightmare that isn=E2=80=99t worth =
the fuss and I don=E2=80=99t even want to think of the aggregate lost =
man hours.=
