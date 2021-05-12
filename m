Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D93C43470
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D1161106
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbhELRnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbhELQxP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 12:53:15 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB7DC03460F
        for <git@vger.kernel.org>; Wed, 12 May 2021 09:47:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso21083937otb.13
        for <git@vger.kernel.org>; Wed, 12 May 2021 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LKVbBvBT03SrTIEgJOgdsfcGl942taWniny9xCZaM/g=;
        b=faEpIYv2tgNlR9+9gWC4zKIoU0zbxPo9juLgZJYoqGfbIMQN9UFFTMwyqC8KUzH7xb
         keh4wUJdoqesJ6VE+UoxHH16/L7XB+DGm2/32mFcBCIvbG3wmEINSp51IlRXD8AwJVTk
         J10ni9LklCsG6IpqiG1v5r5Q/r8TFZ20I6Heu4rFIV4ydGr1272IlRdP0w9ro3VmGDhJ
         8DA99TcxthxHuc4Ruk3yX8WTJuX/3nmrykJ6eQS99tfjuHSrTeVDElMNh5UBcdgc23pJ
         u8uURpARh60Jv+AEgiM4ZmpXUij/tgyS5rnM0O5AXVFbR462Z0jvDcSRJDogmWUuvsZe
         iDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LKVbBvBT03SrTIEgJOgdsfcGl942taWniny9xCZaM/g=;
        b=T8aE8a2OYvQbzNXNd17diBOgyji50Vx8wcueJcXCSlIkGQ8CKWFeNFbqb1ZnykOLsf
         SwsUbRq/lxptRtMIAh8UflcAPkOg0d0xaGLqSchZH4QXhQ0vFFDR826CrhmFui+8pbPk
         M6As/lHVyNo1m99htEviKW9ngHIm6L7Vk5WAeR3Jh6V+N4K1I8BHXq12+TftR/I8HW1d
         lfq/EJeG78Bq85+PwB4NEnFLVcy1bfCvCyAdOhiQw3M9Ub2XzJ9KW5tuC7m2dhvLKaGb
         9wU/PA0bR1VJUX0FQuRWx4rluUAM7amSSLXlFZdQdGeO0PSIYTfzvz3IK6zCSjC1+zd/
         aWNw==
X-Gm-Message-State: AOAM530N8m6cPTsKplDk6rj6L0wujPjRe4j8nPbcYPGH7NInlecD4LIy
        afHJLG9WpMm8vr7+jBCUq/p+3TivO+35e46kclc=
X-Google-Smtp-Source: ABdhPJz7LTLVD9r60nLFJdfc2+RuSbFIeGGPWZgi4tvEE4kyUKGCnrXID8IjeEo1VnahnViPeAfAXjic0x0bb4mzIxs=
X-Received: by 2002:a05:6830:1d81:: with SMTP id y1mr12208731oti.24.1620838045693;
 Wed, 12 May 2021 09:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz> <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch> <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch> <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch> <20210512064733.GP12700@kitsune.suse.cz>
In-Reply-To: <20210512064733.GP12700@kitsune.suse.cz>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Wed, 12 May 2021 11:47:15 -0500
Message-ID: <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 at 01:47, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> On Wed, May 12, 2021 at 12:13:08AM -0500, Felipe Contreras wrote:
> > Michal Such=C3=A1nek wrote:
> > > On Tue, May 11, 2021 at 10:43:38PM -0500, Felipe Contreras wrote:
> > > > It is a paradox called "the bikeshedding effect". When you contribu=
te a
> > > > complex and convoluted change it's easier to get it in because few =
people
> > > > can object (as few people can understand it). But when you contribu=
te a
> > > > change as simple as changing the color of something, then *everyone=
* can
> > > > opine (literally).
> > >
> > > You forget that what you are doing right now is bikeshedding after th=
e
> > > fact.
> >
> > Except that's not what I'm doing.
> >
> > > You can use 'affect' or 'impact' and it generally conveys the same
> > > meaning.
> >
> > That's clearly *your* opinion, but that's not my opinon.
> >
> > I'm not arguing between blue and red; I'm arguing between water-based a=
nd
> > lead-based paint.
>
> No, you are not. There is no clear problem with 'impact', either.
>
> So if somebody comes along later and says that they find 'affect'
> confusing and impact should be used does that need to be accepted as
> well, back and forth ad nauseam?

This is whataboutism and hypothetical. But even if one were to
disregard those facts, I'm willing to bet actual money that no one (at
least anyone with access to a dictionary or even a basic grasp of the
English language) would do this because "affect" has a universal
definition and is not in the realm of jargon in any dictionary or
style guide. The same cannot be said about "impact".

>
> > The difference may not matter to you, but it matters to me.
> >
> > If it's bikeshedding to you, and it "gnerally conveys the same meaning"=
,
> > why are you arguing against?
>
> So if 'for' loops and 'while' loops generally convey the same meaning
> should we accept patches that replace some 'for' loops with 'while'
> lopps or vice versa?
>
> Surely not. There are different situations in which loops can be used,
> and different people find 'for' and 'while' loops clearer and and easier
> to understand in different situations. If you rewrite the piece of code
> that includes a loop it might be worthwhile to change the loop type for
> clarity, and at the time when the code is added or modified it is time
> to discuss which one is better, not after.
>
> On the other hand if you state the goal to not have redundant semicolons
> then even if code with and without redundant semicolons is the same and
> in most cases it does not make any difference for human understanding
> either patches that just remove redundant semicolons work towards a
> specific goal. That makes them acceptable even if they are very minor
> because there is clear metric they improve which makes the inverse patch
> not acceptable.
>
> If you want to make the case for 'impact' in general being obscure or
> hard to understand you will have hard time doing so. There are
> dictionaries that recognize 'impact' as synonymous to 'affect' without
> any difference in degree. In the COCA corpus there is around 200k
> instances of 'effect', around 100k instances of 'affect', and around
> 100k instances of 'impact' which makes effect/affect about 3 times more
> frequent than 'impact'. That's not even an order of magnitude - clearly
> not enough to claim it obscure. All of the words are within first 1k so
> arguably if you have intermediate knowledge of (US) English you should
> be familiar with all three.
>
> However, there is a different corpus that is much more relevant for the
> git project:
>
> =E2=9C=94 ~/git [master|=E2=80=A69]
> 06:35 $ git grep affect | wc -l
> 368
> =E2=9C=94 ~/git [master|=E2=80=A69]
> 06:41 $ git grep effect | wc -l
> 350
> =E2=9C=94 ~/git [master|=E2=80=A69]
> 06:42 $ git grep impact | wc -l
> 54
>
> There are only 54 instances of the word 'impact' in the git repository
> which make up only 7.5%. It is feasible to eliminate those 54 instances
> completely. In doing so you will make the git project use the same
> wording consistently which makes it arguably more approachable to
> non-native speakers with limited vocabulary. That states a clear metric
> that is improved by such patch which also makes the reverse patch not
> acceptable and prevents potential for infinite back-and-forth changing
> from one synonym to the other.
>
> Bonus points if you add a test that prevents adding new instances of
> 'impact' in the future.

So you're saying you're OK with getting rid of all instances of
"impact"? I'm for this, but insofar as I searched the code base, I
only found the ones I'm changing in my patch (save for a couple that,
as a previous reviewer mentioned, are included from other repos, so I
left those).

>
> Thanks
>
> Michal
