Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335FEC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE3820773
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvMy1rOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGGNIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGNIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 09:08:16 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8AC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 06:08:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j80so38005159qke.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xkASg0J9aksilTVpCRcKELRhoEsbnXlCIcqXiXCj+Vw=;
        b=KvMy1rOAAzog2ChKM+2/W+ZFbXBNmkmldP8h2L8wIp6gyFV75sq4WFtLO9og50M+pj
         YPClfZrO3zNFP1N/u+fhWWpyg/78jffioDyWxSPSYRSrpbdXWt+kEkULm87ekYGCJ2x1
         8MgXWl+K7uCMmqhZjOKKWLS3slQrJu+H6yqb92zEd0zyK14r/p10NuGIAB0+r0w9ea/r
         d7eN4j9yvk57VXoBK34F1bV4hQSjom6ch0+zb4seQvwTEzL9mdLePC0hhqGEGDxmOSh1
         PivjtOV1Jr9C6De6z8FaBYgpKJQ69TPlv7Le4mEwq0fqv2UsuEG1J21xNI2h1H529Zgw
         TIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xkASg0J9aksilTVpCRcKELRhoEsbnXlCIcqXiXCj+Vw=;
        b=lLPmnsxD+QvCs/cpaiWEPxc0jQosIukEwRFLbqP2mzI+7jYJ4x+ZDPr8DTdk0EjltC
         R066FxIpqeIkaTMnFsY2E8QNGfyum4lIs9yFQO1/XTpjn1IgRkjGvw2eK23FC8ZAHTXY
         xhdXf8VUuIT0htNpK7J2VxknZjqavKWa9K+iRLuYeVIp3N6Eak9yygDnjPo19jgjDCf0
         dQFc3T/kKPySqn9+2Nc9UYGNPjkRSkI1WDA5pxvJDAHgB0Ouj4htAgcRdZBPgLr9BH0z
         /hLLlUNIfpT57ll+NtK61FoftNw6R4eB4n6uAhW0f5ZtjwWlBHOns378OzOEN+V6yCWi
         6FjQ==
X-Gm-Message-State: AOAM533LBLuUMe61T3W7uWRwq5HXfvJzs4V2hlOGU1oLMD+hrjx3AEOo
        Oi2BkmICe3uTvuVL/pFv0P8=
X-Google-Smtp-Source: ABdhPJyDMObsiC+chBCusDJQB6gKKuq9zi95nmUsCfjgWOWe4LuAnCErlEUfh/txc0USDSJEkNDdhw==
X-Received: by 2002:a05:620a:65a:: with SMTP id a26mr50239876qka.290.1594127293614;
        Tue, 07 Jul 2020 06:08:13 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y67sm21412505qka.101.2020.07.07.06.08.12
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2020 06:08:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] doc: log takes multiple revision ranges
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <f55e0109-af9a-7c21-1cbf-41b2531560e4@iee.email>
Date:   Tue, 7 Jul 2020 09:08:11 -0400
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11841F90-5F2B-4786-AFE9-7A2CA62C7A19@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com> <xmqqd08wc5bd.fsf@gitster.c.googlers.com> <51E0F312-E132-4E8E-AFE6-570CB02B4590@gmail.com> <f55e0109-af9a-7c21-1cbf-41b2531560e4@iee.email>
To:     Philip Oakley <philipoakley@iee.email>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

> Le 5 juil. 2020 =C3=A0 16:42, Philip Oakley <philipoakley@iee.email> a =
=C3=A9crit :
>=20
> Hi Philippe,
> This had been sitting in my inbox..
>=20
-----8<-----
>>=20
>> What I wanted to achieve with this patch is to make readers aware =
that=20
>> they can write e.g.
>>=20
>>    git log branch1 branch2 branch3 branch4 --not master
>>=20
>> to see commits on each of branch1-4, that are not on master,=20
>> since this is not immediately obvious (at least to me)
>> in the 'git log' man page.=20
>=20
> The whole revision walk stuff is tricky. Finding the right starting
> point for explanations is key, along with picking out where 'normal'
> errors are made, as these do help users who aren't simply 'checking =
the
> manual'. (the 20-20 hindsight problem)
>=20
> For example, your "that are not on master", and what that means, needs
> to be brought out to the new reader rather than being buried
> mid-sentence. Most readers will miss those mid-sentence key points and
> they can't learn until they have some significant problem that points =
it
> out to them. Sometime we need to point at the 'wrong' things, not just
> the right things. (e.g. if branch3 had ben merged a couple of =
revisions
> ago...)

Yes, here I meant "on master" in the "not yet merged into master" sense, =
of course.
I'd be more careful if I was writing a commit message or part of the doc =
itself.

>=20
>> Even following the link to gitrevisions[7],=20
>> it is not explicitly mentioned in the "Specifying Ranges" section=20
>> that a range denotes the set of all commits reachable by all given =
refs,=20
>> minus the ones reachable by all given refs prefixed by '^' or =
'--not'.
>> However, this is really clear in the 'git rev-list' documentation,=20
>> which uses  '<commit>...' in the synopsis
>> and clearly talks about the "set of commits" point of view:
>>=20
>>    You can think of this as a set operation. Commits given on the =
command line form=20
>>    a set of commits that are reachable from any of them, and then =
commits reachable=20
>>    from any of the ones given with ^ in front are subtracted from =
that set. The remaining=20
>>    commits are what comes out in the command=E2=80=99s output. =
Various other options and=20
>>    paths parameters can be used to further limit the result.
>>=20
> Set operations don't help everyone, just sayin'.
>=20
> In some cases: The fact that we exclude any commit reachable from any =
of
> the "^" commits should be mentioned first, and then we select any left
> that are reachable from the named tips. This puts a different spin on
> the  understanding, and helps catch those that have not understood the
> other descriptions. It can then be easily linked to the 'two ranges'
> case producing otherwise unexpected results.

I'll try to tweak the wording for v3.

Thanks,
Philippe.

