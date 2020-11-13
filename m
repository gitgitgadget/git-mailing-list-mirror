Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3516C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E152223F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpzBvy37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgKMOFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMOFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 09:05:02 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CDAC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:05:01 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id a15so2438961qvk.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5gCuC9zYywQvQyhi71wuUgEyNDhaDD/2FN1JfINtvvY=;
        b=CpzBvy37h0zjADcAzrGtbvs290ooFihqs3V6/qZRjMajo8n2mzZr1Qf0bKM8c1JdVG
         yDCSBh/S0+sSUuv0vWPR9pLxMLcxK3mV/Fja0SHx5lsKT2ZOlltRMZdiHT8R+axg9HQW
         AlZqhO9amArurteWPQFWv2bCh4+EzPdq4TsG9KPq09JaVM1FCDR+QG5UszFRbAnuPLFC
         FvbABtD/pXgCYtO3M/S15kbaQDO9M706Rah4g8NJ7dCuHlPu+QZpY227ZHh2aKRQmRX1
         iTL+0dkB2yockXZC3bF3Ca4LiWUv5+cDGjPiThI7UOoK5j0ghZzFlarkrLrnQJnesGvA
         5W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5gCuC9zYywQvQyhi71wuUgEyNDhaDD/2FN1JfINtvvY=;
        b=rvv8PmUDtXaoNpBUbDtNgM9ce2bojtgsM+AmnPXxIYtfZF4WZs6QhozAKPXnpHcp9k
         BuxFh7Y9vtAk1heXfjdZDe3o2n7H3Y+cqj3y2z1LW5RdalYnNbWpkJROa8liU4wIDEty
         ajz7g42zR3Mnoog3CaMvB+w4u6HhIjfVeAmFtALjb1tHxzw48yL5JKoCG0pIaDo8tOzn
         NTbYicr/wwurLaGoBQz51KIpR1hzRduChHSjBhduvIur+bnbistA0SLShD8YVqKVUlIO
         +t8y8Hvx8wF8Lh1Xc8UKD61hi8XlUr/DuvcUAS8qsFe46HZerYYPocILTuyn7C6v8UMq
         1IRw==
X-Gm-Message-State: AOAM532doPDIbcJRwSjJ7DaKy1dQSbrwKG1EXECHJScsjW0zntiWUCo4
        oa6VUk4cfZ1HkTDo+XjM3Sc=
X-Google-Smtp-Source: ABdhPJzgWlXMn0gUMe1JNhDFd1GMmIVpim8KyPZC8bC2ODr0VLCog0x6DlAov43SWj0KESQkwo9+XA==
X-Received: by 2002:ad4:47b0:: with SMTP id a16mr2441626qvz.22.1605276301081;
        Fri, 13 Nov 2020 06:05:01 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x24sm2532436qkx.23.2020.11.13.06.04.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2020 06:05:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 10/11] add -p: prefer color.diff.context over color.diff.plain
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <48d8e0badfec5f0e576868f7a406ed7ede6c7200.1605097704.git.gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 09:04:58 -0500
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A02D618-34EB-4B20-A102-99B3CDAFD0BB@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <48d8e0badfec5f0e576868f7a406ed7ede6c7200.1605097704.git.gitgitgadget@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,=20


> Le 11 nov. 2020 =C3=A0 07:28, Johannes Schindelin via GitGitGadget =
<gitgitgadget@gmail.com> a =C3=A9crit :
>=20
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> This still needs

s/needs/leads/

> to inconsistencies when both config names are used: the
> initial diff will be colored by the diff machinery. Once edited by a
> user, a hunk has to be re-colored by `git add -p`, though, which would
> then use the other setting to color the context lines.

Philippe.=
