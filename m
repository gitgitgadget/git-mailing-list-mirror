Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0823C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10302075D
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEhf3BEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHDNoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDNoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 09:44:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35189C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 06:44:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d14so38351523qke.13
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9VMs2dNSv+0ply14yUEJoPJYPm2nq16rSVBpTqvQVxQ=;
        b=YEhf3BEhYoFIxR6XTwfDTxmAjH9n93NA+TX6RnI9Nk2OiKymnTCJsa+TolzVJUHiTP
         sWU+M6mCto/u1uaBmFmpSavmpURwQmhrHJA0/9tYowPmNVz6f77+g1x/TEnJZ4e+0G7u
         LRPH/RwiIVwbHbUUgBRfkLHwddTUQZ/uKlzKQxbq8H1Qdjw20fL5UhsCNBSGC8uvM/hV
         6ennp8AVw4XbI9lET0tHm/84fC9QUay8jkLLvYI/lRbCOlSqhOW6w91if1xCu6x1hwgF
         D6/uhYtomGTB3xcbbRv3JVDA7EH6G6NDx1+YQxRvaErlFjPtUqG96AXK9cus1K0bc3Hr
         FV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9VMs2dNSv+0ply14yUEJoPJYPm2nq16rSVBpTqvQVxQ=;
        b=ASggvn+mG7dgQN5fTHdxGOAmmEDTGsIioCfu+7A28QNzD1c/RuDrn97t/bJvJ1SM60
         t06Slhg49xnceu63kjirtGPlgPHIUFjMtvDg+V4lqCgiF39QripH53RHjuSb0T/MheRl
         Qq6vSp4SMc1Q126ZKU1dCvy0K7WbemSZYZTEtn6hggKILi/lnzgXg8/MQoHdZqVEWPUh
         q/o0irNpZ9QNVpurqp3qu+97PhsGxaGYA9usascVMmu/Evj3h7XzmSrpQJ/VXE69UW0s
         Zb8eO58Hu2Kr4sYN2f7J8BqOu/ZcaPeQwi3CPXJsLTROlKQYRx4ayRzS33FfnVKD9bEf
         m8ow==
X-Gm-Message-State: AOAM532ScTh6A8tbb3Zyo+VDVNW90DekEIUulJVCb5deXp5c/yOJxyWJ
        IEkCf6l1ZqgUc0A53x6a4cIRK54Tp8Q=
X-Google-Smtp-Source: ABdhPJyJPxUAD4CABoE2X6X5JK4A3fBQYSgQ2M2MMJ2yu8yA/uBdS7SwfU/YT/m80WCNk0h0w+8Yyg==
X-Received: by 2002:a37:4f07:: with SMTP id d7mr22436482qkb.144.1596548682459;
        Tue, 04 Aug 2020 06:44:42 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i7sm20963171qtb.27.2020.08.04.06.44.41
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2020 06:44:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/3] List all guides in git(1)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqh7tjtfx6.fsf@gitster.c.googlers.com>
Date:   Tue, 4 Aug 2020 09:44:39 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4174B93F-AE21-4F63-A847-06EBF28199DD@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com> <pull.691.v2.git.1596500459.gitgitgadget@gmail.com> <xmqqh7tjtfx6.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 3 ao=C3=BBt 2020 =C3=A0 20:26, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> Changes since v1:
>>=20
>> * Incorporated Junio's suggestion to reduce duplication.
>>=20
>> v1: This series adds a list of the guides to git(1).
>>=20
>> The first commit adds the misssing guides 'gitcredentials' and
>> 'gitremote-helpers' to command-list.txt. The only missing guide after =
this
>> change is 'gitweb.conf', but I think this one is obscure anough, and =
already
>> linked to in 'gitweb.txt', that it does not matter much.
>>=20
>> The second commit drops the usage of 'common' and 'useful' for =
guides. This
>> was suggested as one of two ways forward by Duy in [1] but was not =
commented
>> on. I'm CC'ing the people that were CC'ed on that message.
>>=20
>> The third commit tweaks 'Documentation/cmd-list.perl' so that it also
>> generates a list of the guides, which gets included in 'git.txt'. I =
chose to
>> put this list just after the end of the list of commands.
>>=20
>> [1]=20
>> =
https://lore.kernel.org/git/CACsJy8ADj-bTMYDHxRNLOMppOEdPbVwL49u3XCfNBCmoL=
LZo+A@mail.gmail.com/
>>=20
>> Philippe Blain (3):
>>  command-list.txt: add missing 'gitcredentials' and =
'gitremote-helpers'
>>  help: drop usage of 'common' and 'useful' for guides
>>  git.txt: add list of guides
>=20
> I think the "dedup the list of cmds-$category.txt" is logically a
> separate step from "we forgot to add guide category so add it", so
> either (1) "add guide twice, and then refactor" or (2) "refactor
> before adding guide, and then add guide only in one place" would be
> more appropriate than (3) "add guide while refactoring".  IMHO, (2)
> would make the most sense.
>=20

I agree that (2) makes the most sense, I've split it for v3. (Your =
"SQUASH???" message on pb/guide-docs=20
may have mislead me :)

Philippe.

