Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C161C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341432226B
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGjWWLrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIKOfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgIKNLy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 09:11:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30531C0617A5
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:11:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so9716889qkn.11
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qYcbsq2SpWXujz/oOvUC0TxNA6T+Dwygk1bw3Tkm0Y0=;
        b=BGjWWLrdmO0QxneWAVKrZbW0R8Y90jkB+lExGGFcqC8Ccqjb4+b5Nd3U5K9NWJoLpE
         DWzZaO6LaO88yYHuKYF1AWGdLNsh4hs83b4kUy5ap3M13609S/wmfhuQdSSlVolgz8Q7
         jn2rh8bwo6WUnsU8dZztBu/WTfS+r+tQ8xGYCyKt/LyVP/S1yYHX86v+ybUYHZYSN4JF
         d5sN/JkFLB5nQnwM/SFoHZ2sUfzavXzPi6DCYwsoPUfQ5vEKbpoShc3pBl3X1qqSv9kH
         W3IyAYYSEiMwMCUk2PBBkvVq0IZu/Mwl+IZ/4Sv0q/0S/aMacvgyPrAnrv7PSIoxbFdS
         tTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qYcbsq2SpWXujz/oOvUC0TxNA6T+Dwygk1bw3Tkm0Y0=;
        b=mF6Mx6BE7Q52ff9szL01I8ZQ50dxRKqxtS0zrpDpxGqiUR2iEns00yMXWP/lYlHhdp
         /6J3S1TpnO+0SdfTqT7re/AiUtw0LyrqnsndREaRFbjpoAIkWJz/8EpT0XTCAWQtEnHN
         NZOaYym1YzT7vdNClNITWdctukaXSO83jnVN/6piL4SZweJOxHsFkQL1Izx5tior+97a
         Cgr1JPgTfd4rYsK/i8vNWbkc5OpaukVVOCmP+ZTkvhOzQ7vzq4aD0huJhTR5mNNAMSKs
         LpJ2MVcTaDuqJZhQUvNMWkYEDvhZBfS5sGNleCzN0KeHpo8kHkabYDfd0jCjxsog4U5n
         oxAA==
X-Gm-Message-State: AOAM531S6KhAGCQN+r648ExS+5b7r2HxuP21q87ew8PizjJ6PIw1ONl1
        DoQkBhXP15MqUqYJAu/mkuQ=
X-Google-Smtp-Source: ABdhPJy+uo065j5UF9RmDGbqOHxx2nKpHhALupKAU2DJP1klx0kGiady2kYgmydi3S3b1ofkGLIBXA==
X-Received: by 2002:a37:62c4:: with SMTP id w187mr1442251qkb.102.1599829880856;
        Fri, 11 Sep 2020 06:11:20 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y73sm2751630qkb.23.2020.09.11.06.11.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2020 06:11:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqmu1ys09f.fsf@gitster.c.googlers.com>
Date:   Fri, 11 Sep 2020 09:11:18 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3384182A-89F6-45A4-AD65-57B0E2B95FFA@gmail.com>
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

