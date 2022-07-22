Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5EEC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 22:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiGVWA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiGVWAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 18:00:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044D1AF25
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 15:00:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k16so5611076pls.8
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RztH4CmqD/r3Lr4MCe13E+UGFlct2+ay9mICHwrIiHA=;
        b=IA1XWlrYh+YDXSyGuAFdO6VkrRjWYRMJhopanZfRm1LWchojm6uCQZGkc04bwOgtvq
         z09qlRRaeXuWbqt03C0ueXe6aVNMj6oFca56cD2mw5SkpKQ5WCUlC37Kl16egYLRbpnl
         wBXvZtO6oLkMz+bkDSysRA/6rsPinQuOtBppvQdlFqT1fMfgkQyUfkDza38PeIQw17TG
         n8fUFRDAiWpDjcvt2o1O140wLUmv/UIVPreKWUNda7IHz6/2FlKpIYUUOoGseyjE7PkZ
         lgOE5p+pBcEUAQAIwMZdtUuMHQIwrkZ2Gi/pK7SikHzBPYkZP+ur/nSOeJT7rS4PhJwr
         KcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RztH4CmqD/r3Lr4MCe13E+UGFlct2+ay9mICHwrIiHA=;
        b=Gpx9ARRb92JPWmNiqZqxECJhGP9Tw+nwGDqajOycnkp37uR8zW4XnAdU+XkGUWKZd+
         xuQHDQgU4POiPNYr3j2rSipBtcMmdZUmOk63T6NCVadOBXKuikkWRxpQrZc5hIB4OtO1
         EmLn3JTjZ0/uRO6rAwuohINf6rQR3sdmpHXSCir+F6dF/2G1zRubCdVTp0cHXq7KzzYV
         NkyUNwIsAwptYiwDagSvGZbBafvL3kxM6PEj1hDhfH1vcZTSSWrwWXffVxgv/az2De/A
         0D9VXfk9xgTJfb6+pFsU0HJeEoUctWdkI6SshwSxFyv2CJuBxbmGtIkxDiPceY6cSEQN
         NWrQ==
X-Gm-Message-State: AJIora9VO3PS52o442D6JOyiWGs8h5d5rdJHLT6UXUFVpfLz5CiTCpTC
        WYfoKZ2weoEoQggsuKDl++eC1ksi7sWV3ZogeLLML/4npv0=
X-Google-Smtp-Source: AGRyM1tLSgM9w627K/zSFBZtTgLKQ8ccgcYgt/Vk8oDtv3mFP5poOqjHgAUoaFIGqLw13OrVgugqYKC++/uPgwgQ9Lk=
X-Received: by 2002:a17:902:e74a:b0:16c:3bdf:26bd with SMTP id
 p10-20020a170902e74a00b0016c3bdf26bdmr1894140plf.116.1658527223245; Fri, 22
 Jul 2022 15:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq35etc4vm.fsf@gitster.g> <20220722212232.833188-1-martin.agren@gmail.com>
 <xmqqtu78bz25.fsf@gitster.g>
In-Reply-To: <xmqqtu78bz25.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 23 Jul 2022 00:00:11 +0200
Message-ID: <CAN0heSqQLhM=mGhOVKyR+fqM3hm3na+dZhx+HPnq+UJFaGudVA@mail.gmail.com>
Subject: Re: [PATCH] read-cache: make `do_read_index()` always set up `istate->repo`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>,
        Tao Klerks <tao@klerks.biz>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Jul 2022 at 23:46, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > +test_expect_success 'empty repo (no index) and core.untrackedCache' '
> > +     git init emptyrepo &&
> > +     cd emptyrepo/ &&
> > +     git -c core.untrackedCache=3Dtrue write-tree
> > +'
>
> I'll tweak this with "-C emptyrepo" so that future developers do not
> have to get bitten when they add more tests to this script.

Yikes. I should have known better. Thanks for catching that. If a v2 is
needed for any reason, I'll include this change.

Martin
