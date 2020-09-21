Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B910C4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 23:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2322388B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 23:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clMIcOEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgIUXOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgIUXOq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 19:14:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF6C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 16:14:45 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so8501746qvb.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 16:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gcDVBL8vH1F27uSlkYLdQSeriZ2Du5AkMTr627o8rus=;
        b=clMIcOEF8t/XExutOpdc4ikbSLeIrok72eV1eHRkLpCX0xfAF2RFC2KY+jUeYUq449
         2PldE3jpTDhG2UvJrQ9tZksClKI1LW9e0ykuPYC7s/goushrFtSrrQbhzJLKPnxcvge7
         kxirUOqLe5JV9JPVE0ElLJ/PNWsRb/b5mSLD4gEMuQgjNu/MHkEasnwyiYaxk7cAxBwJ
         5S6Q4s9Ji6NoeuT0SEjMLQPt5osm+1RGpqaa6usZwZgIp6QTNgemkyP7KvjifUPfMV3g
         /KRPVuCNyWZ/OieHBXmrYaabDf+/EKwo5PNERk1zWzT3UvFFpr036Rul7CBCs6lFZ8Of
         cCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gcDVBL8vH1F27uSlkYLdQSeriZ2Du5AkMTr627o8rus=;
        b=DUx6UIKaqS/RN847iGxK9irep8iqF3Bqemyky0YIT1K46a+JoFKHpUQDtdrZbeQzcP
         Le67aYnvmTpgxI1rPDxlHpW84mJng4OrSiZDJLlcl64NIitl4fHwB0j0M9yaYbt0COpI
         +/Nhwtzv/KMfI4XzlnKi8WkKR8BRI8bTPo7BEpWEsYMWtPRnAtQb7tDeug4XDX8+dRgl
         p0Ru+603LRsz1teSID03mAoGEBuDU2wTr86miUc7T+kV57eXep1bCSLkdtgatyAqUamR
         zNL/EeFLvQkGLbE74S3LuKdoCVLoLGnB1TvOUZAKcLuwKTM28KqWf2SHcbISN/c+cdBu
         Iftg==
X-Gm-Message-State: AOAM530XY21qWFUu5eaH0ft4R9C6uwwv3slkXoMXibTaglmMa/Yfuire
        tNQPORk1xXnEbTy5R6e54X4Wxaby4l48mw==
X-Google-Smtp-Source: ABdhPJy3x1BSzzlezOeTjGE/BgGqGJunLskHdJvJbXUIqhLCtuZg1iSUrijNF4J/i0IRrBY97fsp8w==
X-Received: by 2002:a0c:8064:: with SMTP id 91mr2774401qva.32.1600730085003;
        Mon, 21 Sep 2020 16:14:45 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id r5sm10996447qtd.87.2020.09.21.16.14.43
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 16:14:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to checkout a revision that contains a deleted submodule?
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <4eb688f2-0c17-9b85-e60e-f07485895622@gmail.com>
Date:   Mon, 21 Sep 2020 19:14:41 -0400
Cc:     Luke Diamand <luke@diamand.org>,
        Git mailing list <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFBB71FD-8D1F-4E86-9E37-813018AFC690@gmail.com>
References: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com> <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com> <4eb688f2-0c17-9b85-e60e-f07485895622@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke and Kaartic,

> Le 20 sept. 2020 =C3=A0 14:02, Kaartic Sivaraam =
<kaartic.sivaraam@gmail.com> a =C3=A9crit :
>=20
> On 20/09/20 3:14 pm, Luke Diamand wrote:
>> On Sat, 19 Sep 2020 at 10:03, Luke Diamand <luke@diamand.org> wrote:
>>>=20
>>> Maybe this is a FAQ, but I couldn't figure it out!
>>>=20
>>> I have a repo which has a couple of submodules.
>>>=20
>>> At some point in the past I deleted one of those submodules:
>>>=20
>>>     git rm sub2
>>>     git add -u
>>>     git commit -m 'Deleting sub2'
>>>     git push origin
>>>     ...
>>>     ... more commits and pushes...
>>>=20
>>> Now I go and clone the head revision. This gives me a clone which =
has
>>> nothing present in .git/modules/sub2.
>>>     login on some other machine
>>>     git clone git@my.repo:thing
>>>     cd thing
>>>     ls .git/modules
>>>     <sub2 not present>
>>>=20
>>> So when I go and checkout an old revision where sub2 is still around =
I get:
>>>     git checkout oldrevision
>>>     fatal: not a git repository: sub2/../.git/modules/sub2
>>>=20
>>> What am I doing wrong?
>>> What set of commands do I need to use to ensure that this will =
always
>>> do the right thing?
>>>=20
>>> Thanks
>>> Luke
>>=20
>> Replying to myself, adding Jens who added the section below.
>>=20
>> This is a known bug:
>>=20
>> https://git-scm.com/docs/git-rm
>>=20
>>> BUGS
>>> ----
>>> Each time a superproject update removes a populated submodule
>>> (e.g. when switching between commits before and after the removal) a
>>> stale submodule checkout will remain in the old location. Removing =
the
>>> old directory is only safe when it uses a gitfile, as otherwise the
>>> history of the submodule will be deleted too. This step will be
>>> obsolete when recursive submodule update has been implemented.
>>=20
>=20
> I don't think that part of the documentation applies to your case.

I also don't think this part of the doc applies here.=20


> So,
> I also don't think this is a known bug. As a matter of fact, I =
couldn't
> reproduce this with the following:
>=20
>=20
> git init checkout-removed-submodule &&
> cd checkout-removed-submodule/ &&
> echo "Hello, world" >foo &&
> git add foo && git commit -m "Initial commit" &&
> git init ../submodule &&
> cd ../submodule/ &&
> echo "Foo bar" >foobar.txt &&
> git add foobar.txt && git commit -m "Foo bar baz" &&
> cd ../checkout-removed-submodule/ &&
> git submodule add ../submodule/ foobar &&
> git commit -m "Add foobar submodule" &&
> git rm foobar/ &&
> git commit -m "Remove foobar submodule" &&
> git checkout HEAD~ # Checking out the "Add foobar submodule" commit

Yes. At this point "foobar" would be empty because =
'--recurse-submodules' was not used
on 'checkout'. Using `git checkout --recurse-submodules HEAD~` instead =
would populate it,=20
and it would work correctly because the Git repository
of foobar does exist at .git/modules/foobar.

> I also tried with a cloned version of that repository as follows:

here let's make sure we re-checkout 'master' before cloning:
git checkout -

> git clone /me/checkout-removed-submodule/ cloned-repo &&
> cd cloned-repo &&
> git co HEAD~
>=20
> I get:
>=20
> HEAD is now at 25270d8 Add foobar submodule

I get the same thing, with or without '--recurse-submodules'.

However, if I you have the 'submodule.active'=20
configuration set to '.', which is the case if you *cloned* with =
'--recurse-submodules',
and you then checkout with '--recurse-submodules',
then it fails as Luke describes:

git clone --recurse-submodules  checkout-removed-submodule cloned-repo=20=

cd cloned-repo &&
git co --recurse-submodules HEAD~
  fatal: not a git repository: ../.git/modules/foobar
  fatal: could not reset submodule index

This bug was reported earlier in May [1], and I suggested a couple ways
the experience could be improved.

I might add here that maybe a good idea would be that 'checkout'
be taught to try to clone the missing submodules if it does not find =
their=20
repository at .git/modules.

Cheers,

Philippe.

[1] =
https://lore.kernel.org/git/20200501005432.h62dnpkx7feb7rto@glandium.org/T=
/#u

