Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14016C4727D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 00:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79772076B
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 00:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYDIdD4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgJFAZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 20:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgJFAZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 20:25:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9727C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 17:25:54 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e7so11472067qtj.11
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zd0yjsSnIn1v1OHOnR5lhDhu35wTWUpcPL2hjXINSq8=;
        b=ZYDIdD4sz4PwPH4MGTiEifhQQEvHbgwERHV+kOM6NXbZFzVAxCjgCMLsQWR6ZoekfW
         b0X74s/fMZsK6rMXZxKU44qh1rQrJW89IPzNz7n9tgT5nKKapq1FajwrN2P4V7kH+mEX
         lGH9cdTABj/TUY3F/Gevo+nsaLq0NTCvwwDNZ8fM+k+/2O9uDNrtk1ZVhxa1XXkNDJsH
         4r4hnhm4skEU15pTA7+cCqpK25Lo+9OeJPFcOJfQePcwXbMoKtKdD1rMJujgGqDzjTog
         5LZD/KgZVUnKUy7ZdHgmCiRNOTCYvtIG+T5MPJCNysQcPDxxqKLQf9TbYLCJjhLEktAg
         OkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zd0yjsSnIn1v1OHOnR5lhDhu35wTWUpcPL2hjXINSq8=;
        b=amIcz29HKCD7nKLsuO2c2xXXmSYn6arUjII+vkrapd/+X8Azm710xRPByQdBhx+fFq
         QKYFPZlE+ug7TkUfdgDiJKNR7j4w7z6GsFZfX7zDzfMvL/hFnKLJitUGVD8WQkMIxagD
         165p7/IoLx/U/DmX0S+oIB5r0k5Bzx9YuGfkXlGFfhkmf3Y9BKqUSumQAESMKkuqg0x0
         fLokZFU+Ng0NG9GRwn+JcwP00+H/2O/G4Y6a/AN/TmrNWckQfdpXNI0hlVQ10laW8vVB
         7pOGXmsGcowzK0cre/FvtQfmigmSvGdUL7rCvKyZ73542LcZvdlTNsNgs5jkOU9HTIu/
         cB+Q==
X-Gm-Message-State: AOAM530RA8OlnZniv2uEukxv/LSF7mcV2af/nPNi2giimlXrpOrV6Pde
        zxRVaSD+McLcStvSF7A2B0LATYUfHeE=
X-Google-Smtp-Source: ABdhPJy8OPRpmh1CyL27HmzE2ZKFeFoVHcl72UTTGhdJtLwyI388/AyI+GPnn9WeAHqbiz1Kp7EKOQ==
X-Received: by 2002:ac8:23a3:: with SMTP id q32mr2657102qtq.361.1601943953878;
        Mon, 05 Oct 2020 17:25:53 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id e23sm1069100qtp.61.2020.10.05.17.25.52
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 05 Oct 2020 17:25:53 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git submodule init initialises submodules for which active=false has been defined
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <HE1PR04MB2987A255BC327320D1DDFE6692F70@HE1PR04MB2987.eurprd04.prod.outlook.com>
Date:   Mon, 5 Oct 2020 20:25:49 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE0C9CE4-7F18-4151-8F44-3467EF55DFAA@gmail.com>
References: <HE1PR04MB2987A255BC327320D1DDFE6692F70@HE1PR04MB2987.eurprd04.prod.outlook.com>
To:     Timur Delahaye <timur.delahaye@corpowerocean.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Timur,=20

> Le 18 mars 2020 =E0 08:50, Timur Delahaye =
<timur.delahaye@corpowerocean.com> a =E9crit :
>=20
> Hello,
>=20
> I am trying to prevent
> git clone --recurse-submodules
> from installing some of the submodules of the repo that are not =
necessary to most users.

OK.=20

> Here is what I did:
> In my main-project
>=20
> git submodule add --name one url1
> git submodule add --name two url2
>=20
> Then I edited .gitmodules as follows
>=20
> [submodule "one"]
> active =3D false
> url =3D url1
> [submodule "two"]
> active =3D true
> url =3D url2

Note: this could've been done with

    git config -f .gitmodules submodule.one.active false
    git config -f .gitmodules submodule.two.active true

> commited and pushed.
>=20
> =46rom a fresh folder when I run
> git clone --recurse-submodules main-repo-url
> both "one" and "two" get installed

Yes. That's working as it should. If you take a look at the `git clone` =
documentation [1],=20
you'll see that using '--recurse-submodules' without a pathspec will=20
clone and initialize all submodules, and write '.' as the value of =
'submodule.active'
(meaning, all submodules in the superproject are interesting).

If you do=20

    git clone --recurse-submodules=3Dtwo main-repo-url

then only "two" is cloned and initialized, but I think you're looking =
for something
more automatic than that.

> Likewise if I do
> git clone main-repo-url
> git submodule init
> both "one" and "two" are installed and appear in .git/config as well =
as .git/modules/

I would say that this is also working as it should. If you read=20
the documentation  for `git submodule init` [2],=20
you'll see that=20

    "If no path is specified and submodule.active has been configured,
     submodules configured to be active will be initialized,=20
     otherwise all submodules are initialized."

Note: nothing appears in .git/modules after `git submodule init`,=20
but only after `git submodule update`, which is the logical next step
(or, you could do it in one step with `git submodule update --init)

I after your clone you instead do

   git submodule update --init two

then you'll get what you want (but again, I think you're looking for an =
automatic
way to do it that does not require spelling out "two" at or after the =
'clone' step.)
Notice that if after your clone you do

    git config submodule.active two
    git submodule update --init

Then you get the same result (this is essentially what=20
`git clone --recurse-submodules=3Dtwo ...` does).

> =46rom reading https://git-scm.com/docs/gitsubmodules/2.25.0 my =
understanding was that both procedures should have installed only "two" =
and that I should have needed to do
> git submodule init one
> in order to force the local installation of the inactive module "one".
>=20
> Either I misunderstood the manual or there is a bug with
> git submodule init

I'd be interested to know which section of gitsubmodules(7) made you =
think that the 'active'=20
setting would work in the way you're describing here, so it could be =
improved.=20
(I have a feeling it's the sentence "Git only recurses into active =
submodules
 (see "ACTIVE SUBMODULES" section below).", but maybe there are other =
places).

Now, let's see if we can actually somehow achieve what you want to do.
If you read gitmodules(5) [3], you'll notice that =
'submodule.<name>.active' is not
listed in the list of settings that can be found in a '.gitmodules' file =
! So whatever
you were expecting Git to do with these settings is not happening.=20
However, you'll also notice the setting `submodule.<name>.update`, which=20=

can be set to 'none' (see also [4]). And this, I think, is closer to =
what you want:

       git config -f .gitmodules submodule.one.update none
=20
Try it out! with such a '.gitmodules', then=20

   git clone --recurse-submodules

gives the following output:

$ git clone super-update/ clone-update --recurse-submodules=20
Cloning into 'clone-update'...
done.
Submodule 'one' =
(/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/submodule-active/one) =
registered for path 'one'
Submodule 'two' =
(/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/submodule-active/two) =
registered for path 'two'
Skipping submodule 'one'
Cloning into =
'/private/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/submodule-active=
/clone-update/two'...
done.
Submodule path 'two': checked out =
'd02974612a8f64c1fff7e9de1d90d488606103d2'

and 'one' is neither cloned nor checked out. Similarly you can do

    git clone super-update clone-update
    cd clone-update
    git submodule update --init

and the last command outputs:

$ git submodule update --init
Submodule 'one' =
(/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/submodule-active/one) =
registered for path 'one'
Submodule 'two' =
(/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/submodule-active/two) =
registered for path 'two'
Skipping submodule 'one'
Cloning into =
'/private/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/submodule-active=
/clone-update/two'...
done.
Submodule path 'two': checked out =
'd02974612a8f64c1fff7e9de1d90d488606103d2'

and 'one' is neither cloned nor checked out.=20

> If this is not a bug but an error on my side, I would really =
appreciate some explanation about the active=3Dfalse flag so I can =
achieve my purpose.

I hope the above helps!=20
Note that I don't have a lot of experience with the =
'submodule.<name>.update=3Dnone'
setting, (especially how it interacts with `git checkout =
--recurse-submodules`)
so I'd be really interested to know if the approach above works for you.


Cheers,

Philippe.

[1] =
https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---recurse-s=
ubmodulesltpathspecgt
[2] =
https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-ini=
t--ltpathgt82308203
[3] https://git-scm.com/docs/gitmodules
[4] =
https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-non=
e=
