Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E38BC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0D60C3E
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 20:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhDVUXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhDVUXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 16:23:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94825C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 13:22:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 35-20020a9d05260000b029029c82502d7bso11963901otw.2
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lo2Z6iwx/afF6Ru1nvFDoWDfhIKFu/gahjCoOmk3O/Q=;
        b=XL7HP6KYdVzFXQ/YPnIJ4bOBN+6Z67Y4XgYOZNcllxSDD8NDQ2Ikj8+UjGVvsuTN+g
         pr///0HqreJFpSY6Y2MhgBSyEcyO+H2mmNvzsR2RNF1u4YJcquspsGV097mCUZ/wA/Az
         0Np2zNnSQ4j2UGSKFuzGx596JsMX++EmcbJ3d+276Ten4b9AfrOeMdN9qdOVpDxv+Ul/
         iMQJ+qq6Avay3eoAf8zw9IjSgKGD70jTo8ufjRokehYR6IOr0oTg8fxfMLVIvXi9egfe
         YR+t5rRO0HPjUScK68l7iVzCxYKtPyXryW8kkUE5PyGRqPhz0a/YDusCgHkrAGXFrq0Y
         p1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lo2Z6iwx/afF6Ru1nvFDoWDfhIKFu/gahjCoOmk3O/Q=;
        b=Zappu0fWi9lRQK+LXMSkuQb9C+FsvwQwcugZEqRT0UssfKU4BwBJdzhzDo7wpOyAjs
         TfTWG+upTRAxw9WqsjMxchqltIXdoy469BypCyLa1eOJICx2NvUKRRrQJJ6e5JjkUwDy
         oeqyq8X6ZXwrlW5JCs8BScOV5ZG5tAPzBeK/3/ECv2qWK4ZZRhEYmtx7gK7BIPxQj9nY
         2z0U1NyAkg9BOAvXipC8k+K5HH/9zpqnEYkitmbeA9QaGiohTUX/QPzO5zONy4g+9lZU
         3ZCD1ZFtsT67hJkxpv64AIHUcbO7ZXm6RRT0gO4q3JkfJBfd27LlBWacDw/PbOr1+SRn
         O27Q==
X-Gm-Message-State: AOAM532/q9Qp702oQ6G3P7E40jrcgxeTc8BvsWVyJYiP0Dq/O1crW3A1
        KL4p4lMiv+RN0qv/wjR8wog=
X-Google-Smtp-Source: ABdhPJzG2d/pXf2b9frFEULVU7Pogc2Xo3crUElA8KkvTa+HRib3hj3UjQ5hdScOCnsRg79YTTMuVQ==
X-Received: by 2002:a9d:3e1b:: with SMTP id a27mr292414otd.101.1619122967014;
        Thu, 22 Apr 2021 13:22:47 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t7sm887875otd.0.2021.04.22.13.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 13:22:46 -0700 (PDT)
Date:   Thu, 22 Apr 2021 15:22:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <6081db1246a7_127f620886@natae.notmuch>
In-Reply-To: <20210419203327.GV2947267@szeder.dev>
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
 <86k18rbbyz.fsf@gmail.com>
 <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
 <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
 <CABPp-BEcpasV4vBTm0uxQ4Vzm88MQAX-ArDG4e9QU8tEoNsZWw@mail.gmail.com>
 <20210419203327.GV2947267@szeder.dev>
Subject: RE: Pain points in PRs [was: Re: RFC: Moving git-gui development to
 GitHub]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor wrote:
> On Wed, Nov 20, 2019 at 09:13:04AM -0800, Elijah Newren wrote:
> > > On Wed, Oct 30, 2019 at 7:21 AM Elijah Newren <newren@gmail.com> wr=
ote:
> > > > Projects which switch to GitHub tend to have overall commit quali=
ty go
> > > > down IMO, because the system (a) makes it nearly impossible to re=
view
> > > > commit messages, so people eventually degrade to writing really b=
ad
> > > > ones,
> > > What do you mean here, exactly? In what way is it "nearly impossibl=
e"
> > > to review commit messages in GH?
> > =

> > My lengthy rant wasn't good enough for you?  ;-)  Well, I'll try even=

> > harder to bore everyone to death, then and extend my rant a bit...
> =

> Thank you very much for taking the time and effort to write it up.
> =

> It summarized some of my main gripes with PR-based collaboration on
> GitHub with such clarity that I would never been able to achive.
> =

> (The recent "Pain points in Git's patch flow" thread reminded me that
> I saved this message and even marked it as important ages ago... but
> haven't gotten around to read it until now.
> =

>   https://public-inbox.org/git/YHaIBvl6Mf7ztJB3@google.com/T/
> )

People in general follow the path of least resistance; if you make X
harder, people will spend more effort doing X, but they will do less of
it.

People have been using email for decades, and there's all kinds of tools
for dealing with it (I for example am using a free provider [Gmail], a
tool to download part of my mails [mbsync], another tool to index it
[notmuch], yet another tool to read it [notmuch-vim], yet another tool
to write a response [vim], and I will be using another to send it
[msmtp]). Or I cound simply use the Gmail app on my mobile phone.

Email is extremely convenient.

Since it's easy to reply, people do reply, often.

Which is why it's not rare at all that a patch series becomes a
discussion thread, which are easy to deal with through email.

GitHub adds a layer of inconvenience, so people tend to avoid big
discussions in a GitHub pull request. It's just not fun.

I also did a blog post explaining why email is just superior [1].

Two other points that were not mentioned that make email superior is
that 1) you can easily cross-post, simply CC another project and that
discussion spreads 2) it scales for projects that don't use GitHub; you
don't need an account anywhere, and usually you don't need to subscribe
to post in the mailing list.

It's no coincidence that the most successful project in history (Linux)
uses email to deal with contributions: nothing else comes even close.

Cheers.

[1] https://felipec.wordpress.com/2010/01/19/why-bugzilla-sucks-for-handl=
ing-patches/

-- =

Felipe Contreras=
