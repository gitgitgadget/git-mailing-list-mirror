Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B68C4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3957123A1B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYmRGmk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIUWqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgIUWqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:46:19 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE65C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:46:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v54so13970854qtj.7
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mkAOUs9RPUzWIihV9H+Ih5bOym6X8ErMfDP7tkaqknU=;
        b=oYmRGmk450fgNPkga9xQPsED27liGjugdtyMWVIHXw7GJk/5QGDnDJgsMsDR/8xtEG
         WqLIAKwjv//ZvClWxkxSbCKxndCIzueB2KSJarvSiveou/s15N3Tu9Rp6o0u8EWnWDz6
         WEcdaNILbPEICtZIuGF6kyhJOr6ragVxLF2X8+ZPrR1t2vYUvQyCH386VJ7CvsHeqkJ4
         R1FKT9YNT1VvaX1PFgWnDCbVuPQQG/VMGxRtYPa+bXcW8qnHYSMKZGCLu+AbX95Y12pK
         +Gn6OzL+Gp1OH8pHxLTyJqkaTsiYQVp0tBQeX00mIYIwam9IofnctjOV0fZG4i5rxK5n
         CLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mkAOUs9RPUzWIihV9H+Ih5bOym6X8ErMfDP7tkaqknU=;
        b=Ln3Io0AqtnGyzC3o1mpnf+xCnoOed6kZn90hvekC4gX4wjFYZvzE/BI1Zrf3QoE5BI
         fQudAQ57nx7vTP/E3R5HK10G49dNwkhtZpi9LX3CVg3l2aOtTRrHHszMc8dXsz5kpR4j
         d52YBCB7cb0XPWBsyBx66JvtGYLm6aQNaqKsuubCX6nSZyuKWtwEAzvEXuim/eMjKnSb
         33h2R5WEDWcyFV17eM6qhFzvE8b0jlLdf97Ss8xFJt4qYaXsikyD5A84WxbXsV0hoDvP
         f3fz1RcCa3HdiWe06MLFWzUV6Rq+BjKPjvINrf1UgJE6lEDuxc8p7C6SDyX3KAqA1Xm8
         +eQw==
X-Gm-Message-State: AOAM531vVCv5yylJ3g3k2j1ZVEvRn8+ET3yL+Owt2uGDVr420ReukDw4
        53UCaqdWhJYa3poABOAyonY=
X-Google-Smtp-Source: ABdhPJz+GkCNsPzT+rEt6MdQujzT6s1WYBcxJy2N3Y2c9JmomL6xJfrWfM50PRaRgFQvs3P9mmsGWA==
X-Received: by 2002:ac8:4807:: with SMTP id g7mr1933750qtq.54.1600728377921;
        Mon, 21 Sep 2020 15:46:17 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id b79sm10366866qkg.10.2020.09.21.15.46.16
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 15:46:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to checkout a revision that contains a deleted submodule?
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com>
Date:   Mon, 21 Sep 2020 18:46:13 -0400
Cc:     Git mailing list <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>, kaartic.sivaraam@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B191753-C1AD-499C-B8B2-122F49CF6F14@gmail.com>
References: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com> <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com>
To:     Luke Diamand <luke@diamand.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,=20

> Le 20 sept. 2020 =C3=A0 05:44, Luke Diamand <luke@diamand.org> a =
=C3=A9crit :
>=20
> On Sat, 19 Sep 2020 at 10:03, Luke Diamand <luke@diamand.org> wrote:
>>=20
>> Maybe this is a FAQ, but I couldn't figure it out!
>>=20
>> I have a repo which has a couple of submodules.
>>=20
>> At some point in the past I deleted one of those submodules:
>>=20
>>    git rm sub2
>>    git add -u
>>    git commit -m 'Deleting sub2'
>>    git push origin
>>    ...
>>    ... more commits and pushes...
>>=20
>> Now I go and clone the head revision. This gives me a clone which has
>> nothing present in .git/modules/sub2.
>>    login on some other machine
>>    git clone git@my.repo:thing
>>    cd thing
>>    ls .git/modules
>>    <sub2 not present>
>>=20
>> So when I go and checkout an old revision where sub2 is still around =
I get:
>>    git checkout oldrevision
>>    fatal: not a git repository: sub2/../.git/modules/sub2
>>=20
>> What am I doing wrong?
>> What set of commands do I need to use to ensure that this will always
>> do the right thing?
>>=20
>> Thanks
>> Luke
>=20
> Replying to myself, adding Jens who added the section below.
>=20
> This is a known bug:
>=20
> https://git-scm.com/docs/git-rm
>=20
>> BUGS
>> ----
>> Each time a superproject update removes a populated submodule
>> (e.g. when switching between commits before and after the removal) a
>> stale submodule checkout will remain in the old location. Removing =
the
>> old directory is only safe when it uses a gitfile, as otherwise the
>> history of the submodule will be deleted too. This step will be
>> obsolete when recursive submodule update has been implemented.
>=20
> I'm wondering what "recursive submodule update" is. If I do:
>=20
>    git submodule update --checkout --force --remote --recursive
>=20
> then those stale repos are still left lying around. I guess that's a
> different kind of recursive?
>=20

I think Jens was referring to this project :
=
https://github.com/jlehmann/git-submod-enhancements/wiki/Recursive-submodu=
le-checkout

of which some parts were implemented over the years,
a lot of them by Stefan Beller.=20

In fact this part of the doc is stale and should be removed since `git =
checkout` now=20
understands `--recurse-submodules` and will
automatically transform "old-style" subdmodules (i.e. with an embeded =
.git repository)
into "new style" submodules (with a gitfile) (see gitsubmodules(7), at =
[1], for more info)
when switching to a commit where the submodule is not present.

Cheers,
Philippe.=
