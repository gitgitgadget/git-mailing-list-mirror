Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC57C2BC11
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF10A221ED
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxxOOn91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgIKQoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIKPIW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A6C061359
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 07:30:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n18so8002524qtw.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qYcbsq2SpWXujz/oOvUC0TxNA6T+Dwygk1bw3Tkm0Y0=;
        b=YxxOOn91Bg5bJG7Od2Hnih8TJev1YVi6Gf9rJ2Rzrl88s7A01fVbk3PaZmBzaCay/n
         OO4LR4nsbwHd9oVg9AOuuc3jewdecCYw3LTWYUgLHwyNV1I/oN7jr+aQ64LMWlWCXs2e
         wMlf1qcXUkJK5xPXLR6LSUX8W1nwQZEziH2Cy26vschfaKQ2smy6oy2UJVyUtcnXdRFk
         avcJlpyLwtzbfQpRzRq08NdMWiN/IrlF7yaqkR3htrYMNzWonJ/XFO3hov6yu4zw0+z3
         ga3LHISWft2HvK/OMCSAV1f4mjGhUUbijpYrTG2vZzEzNO2W00/5Ry38t/2bQYzxKVaW
         6QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qYcbsq2SpWXujz/oOvUC0TxNA6T+Dwygk1bw3Tkm0Y0=;
        b=U5p2ZkYueEpPbDpvIqrBcy8YnhUhIfgrb+N3tB1UfybOSSPKrwZ37VQp4eDGMOXTTC
         yzzFmz/MbMDxlN5NYeEYPXXk0LtbBIq6SazI86Q4bUtlTLyIhzOXOnq8IPyZ7P8Cgomi
         po93nJ2qNh9093MhnqCM+LV9CsQOwngPr5sPkiUXa15T2nkVB2/HazweSiWUlyXB1awf
         c8vHjFfLfcvwWm/uDyBJjqariaD9ye+w4pHJFU3eYImfAIQ3XgbA+mPBbSUEwfMi5v9D
         jfvywNPwwH4L96kgehfwQ62WnUbtRiW5+Bvy7G+GHnM0Dx3leziDApKlThUKWwvDpQZs
         lxJw==
X-Gm-Message-State: AOAM531iyMEIaKhrpVON83GrIRZphwU1k5JYdfYZTsZ9OD127WXZE1o2
        coZtB1ux46N27xx+kAt/hwY=
X-Google-Smtp-Source: ABdhPJz/DM6BE/UIJf1ifQHoZhNjIvTsEbHWhwX2QChonhmDBrj13DPc4dllzidAxMG53HqiyqzGBA==
X-Received: by 2002:ac8:24f1:: with SMTP id t46mr2032738qtt.93.1599834643966;
        Fri, 11 Sep 2020 07:30:43 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id z26sm2949563qkj.107.2020.09.11.07.30.42
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2020 07:30:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqmu1ys09f.fsf@gitster.c.googlers.com>
Date:   Fri, 11 Sep 2020 10:30:41 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8142F2B-A707-4896-A03D-2EB71FD95A56@gmail.com>
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com> <xmqqv9gms1fp.fsf@gitster.c.googlers.com> <xmqqmu1ys09f.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 10 sept. 2020 =C3=A0 00:50, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> So, no.  I am not enthused to see this change.
>=20
> A more relevant question to ask you is what the motivation behind
> this change is. =20
>=20
> If it is an apparent "inconsistency" that the plumbing command in
> question takes an explicit command line option but ignores user
> configuration, then we can stop there---I think we would want to
> keep it that way.

Yes, in part this (and as I said in my previous email, to bring the code =
in
line with 'gitsubmodules(7)').

> But if it is because "I use this command interactively quite often,
> and I find it inconvenient because I need to type the long command
> line option", we may want to step back and understand why you need
> to run the low level plumbing command in your interactive use case.
> Perhaps most, but not quite all, of your need, whatever it is, is
> already satisfied by higher level commands (like "status"?) and what
> we need is to enrich these end-user facing higher level commands to
> fill the "gap" to satisfy the need in your use case.

Yes, I use ls-files interactively quite often. For example, I know a =
source file
is named 'such_and_such' but I don't remember where in the directory =
hierarchy
of the project it is located, so `git ls-files **/such_and_such` is the =
quickest way to=20
find it (and I have to then add '--recurse-submodules' when I get no =
results, remember
that the file in in a submodule, and rerun the command). So I use it =
mostly
as a Git-aware find(1) replacement.

