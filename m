Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C499CE7A9B
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 16:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjIYQLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjIYQLh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 12:11:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9CCB6
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 09:11:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso823464566b.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=milientsoftware.com; s=google; t=1695658288; x=1696263088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :organization:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Ikd57krDjzRFgmLe3wdLfuBcnVkoqxIR9Pe7bR6yY0=;
        b=XSb1mIfqj23Z9bWax2UVOvVhbekVaRRNldsJLeDpRSBC10VtGa3o8YzheKA3RKLbzC
         Y40tqY8k3KnEM+54XZO5T5wioIG4owLUTXOvmnVuhxJUCCtW3sd9gWLpHk2aXjX97emx
         XtPBc2Fh7GJGzHcrkSVl2pNuFzkDNLZqvTBSvoevJzEOaZIdFihzPMNTPZjEZOuXH9ib
         poZwfdhjHACjIptv0zU7xPScGs1Rz+vLcP3blBLv3r8UAPs1WGvKO5KDFHutJswTAjso
         zmGHzCA7AblKtpO5s0J7Lrf2qPMjbbjAyKtCKhmHqw2mXhvWLMOG/EzO0g9JIaWun7o6
         hXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695658288; x=1696263088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :organization:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ikd57krDjzRFgmLe3wdLfuBcnVkoqxIR9Pe7bR6yY0=;
        b=hGqVZBZThP4dxuzcWF32RhjP/tf7E3GOBlZSYhbxnbd6nj2gbp5e7RD78swukOu4Kt
         xmgxFW+VSZDAi8Ge69vJq7kU8puZM+Rnq43oalDeJfoI2IAVCRU+6SZW03G4mFcyrIrF
         FxkRpJdT/slOe6WlJQEPwTerYrs2Vvx6/6dAQt3RLXlKVfw9iUzhup/YbxLBOdcm+RFi
         1WhCxzMjXeXbyQ6wq6lOUu2pkfSoZYUz2Tzdx5qXPj+tzkDqSHpMhumDs9dzoCN4eJsk
         hTtuDLqRtnMVJcSn3+4D0gYGtvTMw2ytNwCRpFfxf8pkGL3G6TbgXzoRQJC3KQdekVCi
         qkkg==
X-Gm-Message-State: AOJu0YxNNZmn3IGmB/4vZYIwKdlt3UuqunvvVD2fuDMPGh9S+gwMi00D
        s41j8Git4cIAbqZjcKH2KgBtbdjF3TbSm03U4S9SNg==
X-Google-Smtp-Source: AGHT+IGiAkJR5ndbeGGmx4M2ujBYq80mTWrsy29kKKTed7c+W6b0VwzZW2PsCFkA6t8bxFw5MFi60Q==
X-Received: by 2002:a17:906:15:b0:9ae:6389:911 with SMTP id 21-20020a170906001500b009ae63890911mr6764938eja.31.1695658287852;
        Mon, 25 Sep 2023 09:11:27 -0700 (PDT)
Received: from utklippan.localnet ([2a02:5120:1005:1::21f9])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709061d0800b009a19701e7b5sm6608489ejh.96.2023.09.25.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:11:27 -0700 (PDT)
From:   Magnus Holmgren <magnus.holmgren@milientsoftware.com>
To:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Santi =?ISO-8859-1?Q?B=E9jar?= <santi@agolina.net>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: Please explain avoiding history simplifications when diffing merges
Date:   Mon, 25 Sep 2023 18:11:26 +0200
Message-ID: <6191124.FXmgHNBoPt@utklippan>
Organization: Milient Software AB
In-Reply-To: <ZQbNtgd82iARQ39D@debian.me>
References: <3337579.YDm8p7mPUg@utklippan> <2250343.okVFLFBGsW@utklippan>
 <ZQbNtgd82iARQ39D@debian.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

s=F6ndag 17 september 2023 11:58:14 CEST skrev  Bagas Sanjaya:
> On Fri, Sep 15, 2023 at 05:10:28PM +0200, Magnus Holmgren wrote:
> > Friday, 8 September 2023 11:09:20 CEST, I wrote
> >=20
> > > QGit was bitten by
> > > https://github.com/git/git/commit/0dec322d31db3920872f43bdd2a7ddd282a=
5be
> > > 67
> >=20
> > Maybe I should link to the QGit issue:
> > https://github.com/tibirna/qgit/issues/129
> >=20
> > > It looks like passing --simplify-merges to override the default solves
> > > the
> > > problem, but I still want to ask here because I'm not sure I fully
> > > understand
> > >=20
> > > the reasoning:
> > > > the default history simplification would remove merge commits from
> > > > consideration if the file "path" matched the second parent.
> >=20
> > As I wrote at the above URL, I realized that the old git log output
> > without -- simplify-merges and the output with --simplify-merges aren't
> > quite the same. The old output indeed omits some interesting merge
> > commits, which may explain why the change was made, but git log
> > --simplify-merges does include them, so it seems a reasonable default to
> > me.
>=20
> Can you provide examples?

git init git-test; cd git-test
echo foo > test; git add test; git commit -m Initial
git branch testbranch
git branch irrelevantbranch
echo foobar > test; git commit -am Change
git switch testbranch
echo barfoo > test; git commit -am Diverge
git switch irrelevantbranch
echo whatever > otherfile; git add otherfile
git commit -m "Add other file"
git switch master
git merge -m "Merge branch 'testbranch'" -s ours testbranch
git merge -m "Merge branch 'irrelevantbranch' irrelevantbranch
git log test  # old git doesn't show either merge commit, new git shows both
git log --simplify-merges test  # both versions show the first merge commit
git log --diff-merges=3Dseparate -p --simplify-merges test # only in new git
# note that only one diff is generated because the other would be empty,
# although the man page says "Separate log entry and diff is generated for
# each parent."

> > However, QGit has a problem: git log --diff-merges=3Dseparate includes a
> > separate diff for each parent, but only for each parent with differences
> > compared to the merge commit, *and* there's no custom format placeholder
> > for the current parent, only for the list of parents (%P/%p). How should
> > one go about adding that? I figure the format_commit_context struct in
> > pretty.c needs another field.
>=20
> What are you trying to accomplish with your proposed formatting verbs?

QGit builds annotated file histories by parsing git log output. To accompli=
sh=20
that, it needs to use a custom, more machine-readable format, and to handle=
=20
merge commits correctly, it either needs one diff per parent in the order t=
he=20
parents are listed, or it needs to know which parent each diff is relative =
to.

Because old git log (without --simplify-merges) only included merge commits=
=20
where the file in question is different to all parents, it didn't get confu=
sed=20
by missing diffs - it was all or nothing - but some merge commits were miss=
ing=20
in the file history view.

QGit should be rewritten to use libgit2, but regardless, I think all the=20
information you can get with a standard format should be available to custo=
m=20
formats as well.

=2D-=20
Magnus Holmgren
=2E/=AF\_/=AF\. Milient



