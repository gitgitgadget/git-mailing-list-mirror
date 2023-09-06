Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A50EB8FAD
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 06:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjIFGKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 02:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjIFGKE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 02:10:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301BA198
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 23:10:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so4547621a12.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693980598; x=1694585398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:mime-version:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xb/1rxEpEjiZGLeX8BItb+u90M0U5ga0wJV4/Cpz83k=;
        b=jYn36rJe3LUBNuqoyUDvgAo64BHHfv1sUC7VvUMBB/OWl3j9iYztkbPsTbhZJiAxK8
         Qn5zVc9v9CnK9nciFRK88Vr6DD4pYpqsRTZi+fkQsG7LA5NG1NAM+Byr/K33PB7DMxTf
         3kzfQgwcBmZqt2Ntda5Blzg5bB/LhhcSEX4OX4av5YRpvUoQLPX1fxvO0Elvf60UQ1mH
         4bFdbORXX1UtriuCOVhiaqRzDczT+NynriD/upzKmzigNAsSKjUN5UlwVXgzS1YSHeAu
         GaCanGdaDpRuV/3NGXM/EY0iy2ZYGKiStlI75fLAceIwdj8XbO3j41qAjuE68tNM92Cv
         9Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693980598; x=1694585398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:mime-version:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xb/1rxEpEjiZGLeX8BItb+u90M0U5ga0wJV4/Cpz83k=;
        b=aQO8rNoIa1ICvbqRaOEsSX1qEzVeAI/BzmFSFfMYtee0idWdh62dMfhPNVBtDQs8ST
         EUHB9NtHR2z8myHmLXdAaX1WP88QxCXnKPzyYcDsB9h9qsGf8YF2nQ6XLTZqoL5Ycb6x
         p3oFqPq8xcB1b/bV+0kxUQVqG9YBL8mVw/s3isa7GkAXjL/5Vi19iYGLsUCCqviHLivF
         2q0qMSS9fGV2a6UtXaXgerb+jumVSE2E5u42bD9iFO6jghWRE3xR8L5CWkjTlIKsH33X
         GkvATlKRE2fwayNVqLvCt+stqSZxqntmryxFn3MkD45/1dTg1Jorro+/c15q+envS++f
         X2LQ==
X-Gm-Message-State: AOJu0YzG337iJFuxwf9fPMCWWTl5tyZszqoqzDeWZlQckgx4Qx/AM1lz
        IW2Vn5wdyj+MzeDhszCz2HNS+yqe6xjHuqmfcg8Pa2ci0eege6uq
X-Google-Smtp-Source: AGHT+IFBam4O0L4sQW937xhuURYK3lfIQSqd/8N7bYNMi6psclPq0+b7P+Ek2ZaKQ5U95pfFahRpepxIwjE3TAO9FBw=
X-Received: by 2002:aa7:d159:0:b0:522:2ba9:6fce with SMTP id
 r25-20020aa7d159000000b005222ba96fcemr1484644edo.8.1693980598660; Tue, 05 Sep
 2023 23:09:58 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 5 Sep 2023 23:09:58 -0700
From:   Han Young <hanyang.tony@bytedance.com>
Mime-Version: 1.0
References: <20230905121219.69762-1-hanyang.tony@bytedance.com> <xmqq7cp4p5gd.fsf@gitster.g>
In-Reply-To: <xmqq7cp4p5gd.fsf@gitster.g>
Date:   Tue, 5 Sep 2023 23:09:58 -0700
Message-ID: <CAG1j3zFYbeXokd9kwN06RG7Wih_WsLVBf6jSi-JKtUpa=i4QJg@mail.gmail.com>
Subject: Re: [PATCH] show doc: redirect user to git log manual instead of git diff-tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Strictly speaking, "options to control how the changes are shown"
> are options that are meant for "diff" command (e.g. "--stat", "-w"),
> but "log" understands some of the "diff" command options, the
> updated text is *not* incorrect.

On a closer look, the manual page of git show does lists
all the "diff" options by including diff-options.txt.
The options omitted are revision parsing related.
Perhaps we remove the line

> The command takes options applicable to the git diff-tree command to
> control how the changes the commit introduces are shown.

And rephrase the line

> This manual page describes only the most frequently used options.

to

>=C2=A0 This manual page describes only the most frequently used options.
> Some options that `git rev-list` command understands can be used to
> control how commits are shown.
