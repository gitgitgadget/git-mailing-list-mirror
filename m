Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355F7C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE95204EC
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/8iBZ5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgF2Ss6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgF2Srn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E9C031C75
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:08:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dm12so8060900qvb.9
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2t3h0IgSGVQv33JELFGpGduKeXfugcdp4sAvUFrlSTA=;
        b=F/8iBZ5PHRBsWo3gWbk3IRJ+CspV1l8psUNq8e8+45ZxbpbMHDzdL23Un01Ye99zqI
         Qrd5Z2YvTq7/lUUBMt/p8GGmISbLlovo5NMdK5YDYTabtoScVSs3MXMIyVTD0CT3tqAd
         Y0/gGPwTZYKkojHhNqu2n6F2WKTPugUmWNfp6azCmsHOQHXCM4Pe+TT+sqpqgIfW6wYj
         exAK5oLHXD5fJ05r8/kppaOXYnPJiemIQF57SB2zFHMB+Qx7hf0ubKYORpxfFTIU0ElH
         iFS7EKYILqFz71xItYOryxbMZsIiNV+WmrPb7oP1X7YKqpF6jDlLPCW9spAsgu9Z7l8W
         UH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2t3h0IgSGVQv33JELFGpGduKeXfugcdp4sAvUFrlSTA=;
        b=MuXmAUzparQbuPTR2/jqBsFevSvv4nU+1FCFwPig1SHBMTZLg07v14lfjQOG9un63y
         Wx4lA+2SAb7pi/vgOmB/KofZjqNFqH+SOnPi/IK+lQyg1/dy+cAvuoQfWBzkfzY3meUG
         Ph5P3va8gXAq5O7494/xsayzKEvFFmKGYmRpdoq29MoLR0LSsUK1oUJ7myXdhR/ffrUQ
         M5fbrxkNAyGkK0WUOsEf/xMARqje5SLC+lKbuCA9APgXAVK7476yO1TchlMO4KXVNRsL
         WvYiwWTt8ZujJ6hT0lICfSAYPP0Bc76SXue38BYjo6EoC0DxsFyrJm7wTJffnofshFPy
         6IsQ==
X-Gm-Message-State: AOAM533JZxMN5QbOwDx/2YMqiISO3cLCQamLTHGnnBK1TrGoVSctdEYX
        vNdQBhkL9SWkpA7OlwC7FIl1DzbJ
X-Google-Smtp-Source: ABdhPJwV3h1Y6ptXqBTGokWqHPptYnXHFJzEEfPMuYLIv4bN7V76axQrYEEGoRmtRk7R7Lt8lj4rYQ==
X-Received: by 2002:a05:6214:969:: with SMTP id do9mr16507331qvb.85.1593454120989;
        Mon, 29 Jun 2020 11:08:40 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w77sm632426qka.34.2020.06.29.11.08.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2020 11:08:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG] SSH permission error doing `git clone --recurse-submodules <SSH url>` (was: "bug")
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CA+m5axz6QG5+AH5dB-J1dcD26z8z8uOUYUOgypu9kqoX49z0xA@mail.gmail.com>
Date:   Mon, 29 Jun 2020 14:08:37 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <114B6FFA-134F-4024-BB66-797B4367C5E4@gmail.com>
References: <CA+m5axz6QG5+AH5dB-J1dcD26z8z8uOUYUOgypu9kqoX49z0xA@mail.gmail.com>
To:     Luke Knoble <lupeknoble@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

> Le 26 juin 2020 =C3=A0 17:11, Luke Knoble <lupeknoble@gmail.com> a =
=C3=A9crit :
>=20
> Howdy,
>=20
> I've found an issue in which I'm using this command:
>=20
> git clone --recurse-submodules =
ssh://git@someurl:9999/someproject/repoX.git

Which version of Git ?

>=20
> git clones the repo successfully if I dont pass =E2=80=9Cgit clone=E2=80=
=9D any flags,

Does `git submodules update --init` then works ?
Can you share `.gitmodules` ? (is the submodules recorded with an HTTP
or SSH url in `.gitmodules` ?)

> but gives me this error when I use =E2=80=9C--recurse-submodules=E2=80=9D=
 and git
> attempts to clone a single submodule:
>=20
> git@someurl: Permission denied (publickey).
> fatal: Could not read from remote repository.
> Please make sure you have the correct access rights
> and the repository exists.
> fatal: clone of
> 'ssh://git@someurl:9999/someproject/submodule_repo.git' into submodule
> path 'C:/someproject/submodule_repo' failed
>=20
> The obvious answer is that my permissions are bad, but I can clone the
> submodule repo directly without issue.. This command succeeds:
>=20
> git clone --recurse-submodules
> ssh://git@someurl:9999/someproject/submodule_repo.git

Interesting. Could you retry your commands, prefixing them with =
`GIT_TRACE2=3D1 GIT_SSH_COMMAND=3D"ssh -vvv"` ?

Philippe.

