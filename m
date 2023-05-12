Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD13C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbjELTRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjELTRI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:17:08 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7C510DA
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:17:05 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-187df75c901so4260855fac.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683919025; x=1686511025;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2VpCphzp6jxdVgrdyQgVNTt/yKYzejzftN7iSJ8A9c=;
        b=C755nCSt1kCpzZ/jl7KS6gblMox2ixrWq/UOUjQjF37F7xsnU4nn3KwbNwCGPnzRPU
         sWCCtytUcNNVZVGOSw7ko+Xw0hg3rGQqD+yOLBf7F1GwZl678xB5h1oCW09SlfA+I1tN
         DGTo3biznkNIUnWEjuCPc7uMuV0qMpz0aSFiKx9XA12kTZa6ntl1uSEiJEk6mgI7U9lr
         kPVGNtVQnIQuKwuoR+yc7I+iidfI4HR4YI9cqPir+i4K5sl8e4fez9YnluZzA0E9SVXH
         GMI0CkdQuG2861EHilU2dVALWTuKxroRehP4Kv6Sg+cdXCvXkMDwkF+PbiWzWVI859op
         2pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683919025; x=1686511025;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M2VpCphzp6jxdVgrdyQgVNTt/yKYzejzftN7iSJ8A9c=;
        b=l2yPrPTEg1IUOTOYokcg4OnWO8clMY7knvlOEpbbu1mR4zxj7l/MaUxC4wujlx0N5C
         brrj/hu25ptYr2MMWZr+B+0DCtLkk3dgvE/3z4B8URZGzJIQ7LebQGI06y8GJS6xSsuc
         CW8VUTi/YHnhhRFMAVpxUzvCsTo9ABnhU8Iemoqpdc02ev2RcsBN+sPYEI2bOuTlDzvD
         NM4whiPjUxefgfkeYu/Pixw4eDXmI9fvg21NyVjmJQzZGy0bnuD6KGXSpKwDufVydQ2H
         kEqXoGpIPIdhguSzerx3fPO6q8sQEOdxIw2+eWpUxSxg7xi7n3r5a0V/xaMewRrLZWpo
         j1Fw==
X-Gm-Message-State: AC+VfDzdLZD7XjziFUenLSh9oNUq64Cv0Eet+BzPoMCghh5LwDIt2Jcd
        DHpVqfzmyw/6RmCX/0VMR2Ahr/+Vjwk=
X-Google-Smtp-Source: ACHHUZ5dBKshHKEGassI3Rkl1mwCVDZ6hY/uIsBV1AcuhlXtii2kIfA+gSu9dD7MP6JCE6aLE9n88Q==
X-Received: by 2002:a05:6870:e403:b0:192:55c8:4545 with SMTP id n3-20020a056870e40300b0019255c84545mr11643446oag.17.1683919024639;
        Fri, 12 May 2023 12:17:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dt12-20020a0568705a8c00b00195e943f958sm6814131oab.1.2023.05.12.12.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:17:03 -0700 (PDT)
Date:   Fri, 12 May 2023 13:17:03 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <645e90af2eccb_21989f294af@chronos.notmuch>
In-Reply-To: <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy wrote:
> [ I apologize for not being more reactive the last few years. I still 
> love Git and this ml, but I'm struggling to find time to contribute. ]
> 
> On 5/11/23 19:37, Junio C Hamano wrote:
> > The behaviour came in the v1.8.4 days with a series that was merged
> > by e2ecd252 (Merge branch 'mm/diff-no-patch-synonym-to-s',
> > 2013-07-22), which
> > 
> >   * made "--no-patch" a synonym for "-s";
> > 
> >   * fixed "-s --patch", in which the effect of "-s" got stuck and did
> >     not allow the patch output to be re-enabled again with "--patch";
> > 
> >   * updated documentation to explain "--no-patch" as a synonym for
> >     "-s".
> > 
> > While it is very clear that the intent of the author was to make it
> > a synonym for "-s" and not a "feature-wise enable/disable" option,
> > that is what we've run with for the past 10 years.
> 
> That's too old for me to remember exactly my state of mind, but if you 
> want to do a bit of archeology, the origin is there:
> 
> https://public-inbox.org/git/51E3DC47.70107@googlemail.com/

Yes, I had already sent a link to that thread [1].

> Essentially, Stefan Beller was using 'git show --format="%ad"' and 
> expecting it to show only the author date, and for merge commits it also 
> showed the patch (--cc). I suggested -s and noticed that the option 
> wasn't easily discoverable, hence the patch series to better document it 
> and add --no-patch as a synonym.

That was my understanding. So the goal was to make the silencing of `git show`
output more accessible.

> Probably I did not get all the subtleties of the different kinds of 
> outputs. I guess I considered the output of diff to be the one specified 
> by --format plus the patch (not considering --raw, --stat & friends), 
> hence "get only the output specified by --format" and "disable the 
> patch" were synonym to me. Looking more closely, it's rather clear to me 
> they are not, and that
> 
>    git show --raw --patch --no-patch
> 
> should be equivalent to
> 
>    git show --raw

Indeed, but at the time such funcionality was not easy to achieve, on the other
hand making `--no-patch` be synonymous with `-s` was easy, so that's the path
that was followed. But that was not the goal, that was a means to an end.

Adding `--silent` as a synonym to `-s` would have also served a similar goal.

I sent a patch to add such `--silent` alias [2], and I also sent a patch to
decouple `--no-patch` from `-s` [3].

All these three keep working as it was originally intended by your patch:

 * git show -s
 * git show --silent
 * git show --no-patch

The only difference is that now these are different:

 * git show --patch --raw --no-patch
 * git show --patch --raw --silent

Which wasn't considered back then.

Cheers.

[1] https://lore.kernel.org/git/645d3122bd1d2_26011a2947a@chronos.notmuch/
[2] https://lore.kernel.org/git/20230512080339.2186324-7-felipe.contreras@gmail.com/
[3] https://lore.kernel.org/git/20230512080339.2186324-6-felipe.contreras@gmail.com/

-- 
Felipe Contreras
