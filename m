Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A25C433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217CB21655
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdrGiuuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgJKQT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJKQT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 12:19:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D832C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 09:19:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f21so2692527qko.5
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gsWkT+xLIINJhkRPjhq2EU+sMrsS8FHv9njYgy9jiQ8=;
        b=MdrGiuuHSQ3UIU+AnPlI9CmS10O0tOtLKNVAEvi/gJXsdm/DbAcJuzVfUCGm6TdTkr
         jQm3chXl27wzcKZdTA3HStIouKPigmcVfzuZ+0++Ew1OuunNc6rUDMTE+4beXrXWg1pJ
         WUCNJFCYEHDgSw8S48uUr280K2BaIs+qZJeAW2opjBimMA1cbKZp/Ow0rsQTRr6RPbC4
         FojqaA6YFx9zs1OElUJJfA37NJ1BS5M0JJyfSqxloMMVgDAeajxspdn8u5k5xB+rveZA
         TjeaxfRZeg2oPE2EwB2qOJF1+3M5irofcqrgFnoISxilE2r/93YW6lRxhkLdNZhQ6CRH
         +SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gsWkT+xLIINJhkRPjhq2EU+sMrsS8FHv9njYgy9jiQ8=;
        b=OonecFKOx6qHRTa16Js2m2iiVfYK6JdAsXjnJDYzTAOJxVF8LZGA9C1K3bE48/wEVo
         L6/KnDD7bqEreRZYZF1AP2Lv1p0v6riaC/GqhKmgR8Xn1T1gpGI0ctYFQ03Y1AiXU+pS
         2dp/1kRKF+52QtLH/sCN21KYpe/FcLdXknoFhx4tuZT8sgYiK5pYZqvgaTLMF95Vk+iu
         q1KqiqS2waSBy50K4FeNLtQZj/u9A4xrlBRk/I1Q+a5vbuGsCpTf5M5l8S9NhbaEniqk
         gkVlV3F9uorCnQkZi5wPv6wf2dqn6fY7eP2lE8aqiJhY7wDOd990YHvgdBpBxFazRq5z
         qriw==
X-Gm-Message-State: AOAM531OCzGKjGKZunu+BP4fbG9dvz/h2EBotlbf6BRh59YzIRh/Y4MX
        BXC8zryuuq35SPN+e7rpB/q47uaYpHo=
X-Google-Smtp-Source: ABdhPJw2NV1cu78ysdr7PtkndUFLbpm+4JR98Q2RzMU9Zbae/e0F02V2IV2L+qOVRp6CVj6o7HslMQ==
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr6432668qka.388.1602433164155;
        Sun, 11 Oct 2020 09:19:24 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id c11sm11240646qkb.58.2020.10.11.09.19.23
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 11 Oct 2020 09:19:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG?] After 'git checkout', files deleted upstream are left in the working directory as untracked
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <8f88733f-4f20-6215-00a8-de3024b8c4cb@kdbg.org>
Date:   Sun, 11 Oct 2020 12:19:17 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F30E2AB-D742-4581-9AF8-6138A45A3F22@gmail.com>
References: <3D3C5F5D-830E-4EC7-A527-DC595D983BB2@gmail.com> <8f88733f-4f20-6215-00a8-de3024b8c4cb@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,=20

> Le 11 oct. 2020 =C3=A0 02:58, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit =
:
>=20
> Am 10.10.20 um 18:43 schrieb Philippe Blain:
>> The thing is, I can't reproduce it on a fresh clone. If I could, this =
would be a reproducer:
>>=20
>> ```
>> $ git clone git@github.com:phil-blain/git.git && cd git
>> $ git checkout stale-branch
>> $ git checkout other-branch
>> $ git status # the following is what is shown in my old clone
>> On branch other-branch
>> Untracked files:
>>  (use "git add <file>..." to include in what will be committed)
>>=20
>> 	git-legacy-stash
>> 	git-remote-testsvn
>> 	t/helper/test-line-buffer
>> 	t/helper/test-svn-fe
>>=20
>> nothing added to commit but untracked files present (use "git add" to =
track)
>> ```
>=20
> This is normal. These 4 files are build products and were never
> committed files. They had been mentioned in .gitignore in the past, =
but
> are not anymore.

Oops, I should've checked that. Thanks for answering!

Philippe.

