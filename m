Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AB8C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52629206B6
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUW15NNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKVDOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:14:14 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35310 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKVDOO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 22:14:14 -0500
Received: by mail-qv1-f65.google.com with SMTP id y18so2337492qve.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 19:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7lEOob1fFqQ3fDSUD2ge0Wi1sUiiDqpgCFs/QQ6MqNo=;
        b=VUW15NNdddTO+qzFdQLp6macAnJemhfz1Lz3qLs2dvbggyOA08vdxXiKMmXbtNofUa
         ii3v71X1GIqQkysPd4PgyrfWnW83IkaYj8Q3k74xIJIMquc+IKQ/mSoFrEhKW3o6w+WT
         3rgfJ6I1G9RfN/vhvsJWPvCIu2J+DSDM1w87IL6+5dQ6gL5AdR7jynEEpNXo12y98ufx
         xKZRzcAuw93pmJq2jPGwDJ80/BwZg2tUZvT+CBtEk8T6NSUU1wKEenbzTqoDTR5LDCXM
         OcUBCtbQclN3gY8O7Gsu4ffXnC09pYMGsi9ifCECzLZSikAhhurEmkTS9ISJi3CxXpvB
         MjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7lEOob1fFqQ3fDSUD2ge0Wi1sUiiDqpgCFs/QQ6MqNo=;
        b=Vmqs9tzZ17R5k7cf6Y3HoO7ik3QvH7ji955ChnQsvIhg0PPUlCAIGD2K+yfHdVJCNK
         36ggCuHo/TMJxApB3KQW/jCuhkUuMfTcWgixd75wKZJvQRZ2VSBwnCguWo43DtB0W/hK
         d6fD6F14Jsu6ou2L4siPX0VhWGCG32CmtnC2af8i4nYDV8fVa9zO3E61mH5iqS1RjVdr
         0QjfHRZhiUTzKxFWEj4KsD6vzggHpBaX7vBZojL2ssI4JB+rmXR/QlnUYbcnkNDyQ/9S
         UZ78Cv6VjSkAc+StjhPwOMY1gkaMO06vreV2mLiFmskemJaM3ARZ5y6C3iOVKum1iiXq
         zGiQ==
X-Gm-Message-State: APjAAAVQ12yjU1Bo3nk9IzuGlFZGuAwQAgl5A8pYGsk5vqXFeaNpv7n8
        AmpEkiMr68ifgTRsREJNopE=
X-Google-Smtp-Source: APXvYqzn5rK/1DkQwQo7zQt6FRlcHS6w6LmFv2zvpjFQFJSNL4GCYfTIy85MvqsxH+zYu4JB5BRb8A==
X-Received: by 2002:ad4:50a4:: with SMTP id d4mr11209905qvq.211.1574392452779;
        Thu, 21 Nov 2019 19:14:12 -0800 (PST)
Received: from localhost ([165.227.200.42])
        by smtp.gmail.com with ESMTPSA id q17sm2851632qtq.58.2019.11.21.19.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 19:14:11 -0800 (PST)
Date:   Thu, 21 Nov 2019 22:14:11 -0500
From:   Brandon McCaig <bamccaig@gmail.com>
To:     Tasnad Kernetzky <tasnadk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "git checkout BRANCH -- FILE" deletes staged commits
Message-ID: <20191122031411.zrg5hv4dvk6dxxus@test-chamber-21.localdomain>
Mail-Followup-To: Tasnad Kernetzky <tasnadk@gmail.com>, git@vger.kernel.org
References: <5cb30154-5753-f229-9fa2-6c82d2896abc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrvub26wdpuze46c"
Content-Disposition: inline
In-Reply-To: <5cb30154-5753-f229-9fa2-6c82d2896abc@gmail.com>
X-PGP-Key: https://castopulence.org/bamccaig/castopulence.asc
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nrvub26wdpuze46c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 06:10:01PM +0100, Tasnad Kernetzky wrote:
> Hi,

Hello,

> I suppose I found a bug in git version 2.24.0. Please consider the small
> shell script to reproduce.
*snip*
> # checkout copies over contents from B -> I guess the bug is here,
> changes are not detected
> git checkout B -- tst
> git status
> echo '-> this seems to be wrong, change is not detected'
>=20
> # if we now go to B and back to master, we loose staged changes
> echo '*** tst should contain [master, B]: ***'
> cat tst
> echo '-------------'
> git checkout B
> echo '*** tst should contain [master, B]: ***'
> cat tst
> echo '-------------'
> git checkout master
> echo '*** tst should contain [master, B]: ***'
> cat tst
> echo '-------------'
> echo '-> wrong / staged changes lost!?'

I don't think this is a bug at all.

This form of checkout is basically a way to "revert" or "restore"
a file to match whichever tree-ish you select:

    git checkout ... -- file...

It is not a merge. It is overwriting whatever version of the file
you have, and staging those changes. There's no point warning you
that your file is different because you're giving git strict
instructions to overwrite the file. You shouldn't be doing that
unless you already know what the file's state is and you know you
don't want it. If in doubt stash, commit, or copy the file
first.

When you do `git checkout B -- tst` you are basically saying to
checkout the file tst as it exists at the tip of branch B and
stage it for commit.

When you switch back to branch B the state of the tst file is the
same as it exists in the branch B. There is no conflict here so
it succeeds, and once it does you no longer have any changes made
to tst because the version in your index and working tree matches
the version in the HEAD commit.

git status at this point would report nothing (assuming no other
files are modified).

When you switch back to master it happily overwrites tst to match
the version committed to the head of master because the version
you had on B is already committed (and is easily recovered from B
if desired). There's no conflict there and no reason to fail or
refuse.

This is normal behavior. Check the documentation and if you think
it's unclear you can make suggestions to improve it or better yet
submit a patch that does just that for review.

I haven't really been paying much attention to the development of
git, but I recall efforts were being made to split the various
behaviors of git-checkout into separate commands to help improve
the interface because some people struggle with it. Sounds like
these take the form of git-switch to change branches and
git-restore to restore files to some other version. It sounds
like git-restore will still work the same way in this regard
though so I don't think that changes anything.

Regards,



--=20
Brandon McCaig <bamccaig@gmail.com> <bambams@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'


--nrvub26wdpuze46c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6A+1JeuAGnMhPkN33afWAiLlk/IFAl3XUoAACgkQ3afWAiLl
k/LA3RAA1rCund66Cyc8xEQoyWv0+yZ5Tq5CGsroCWwwtwdAohjx5laeh/BMxu8T
yBgc+2J7romOhjDuQOWhJMdfRDmbpmtlAAP8xEndTyi4/2UpkE0sQE6czmm5Am4q
eRwFJRDrohzFocSsp6+qB3xQ4hRO0uJ+QydBoVlR5B92BWjpku/4kGh9h0db3Vjw
pT4hdnOt48GQv/jjtG4Jcpk8BHSbkS210hc6+88cSGzhg09n6NJxQDaBvGuJoKSo
MGBIrqV5ALRi7/4thWbak5HsatAoSf8Qe0b4mTe6tsSn8J91ovkSfhpF+HEF5XTM
gHJDS8qzUI2ENblbJcsV7bp2R502vqmkd/Fs5mUi2bB1W9AkgIZFG+PGu8LK+6rP
aekwbV4WZ0moDAMgQf0J5mzHDp2DVGJSGBT7tf3KvLSzhjBkfFmu2fiQdx1ZaXL7
PbgZYvR9uUkWKPEpvfCbL43D0H9KtOjdD25rTLCylsKLxKsSCcnQZKT/jvXtzZgO
iCQZ0r+Wd55qPIXoxDHNqECAiNnpXyrLyMZx+9q+PDIZCwUzu3l7rEC/QgWrp9PQ
bJk6szMnBv2FbBCZgm8+jSIBqowGMRLwJWMZnDAa8kl6A2HyecEYb+/qfoe8g7V5
4smDFwfrgGgY0mRv8BOg3IX9tQIZNPhek5XYZLkY8jfVGfb/y2g=
=NfBC
-----END PGP SIGNATURE-----

--nrvub26wdpuze46c--
