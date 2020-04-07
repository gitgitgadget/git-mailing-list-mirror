Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781B6C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4816020730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8kjYprN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDGQyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:54:05 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40408 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgDGQyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 12:54:05 -0400
Received: by mail-ot1-f54.google.com with SMTP id q2so1075221otk.7
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hs1rRlczfv3KIGV3jjwEnJRFraZOna3euUgCqEkf1X4=;
        b=A8kjYprN1RJyq18kfJ83eqxNbIHmYWCTBK77oCoBq2EdoKe5nMgm/7/ldE/jSeTfhj
         n6kEoAaXSvffnIlG0EHJtgteldF/GR4i80ZXg8diRNwsX+uE73RW2odjJ75jJjYcIebE
         avsDv28oVFWaySrm1WCurEqzC6xDet6KMpuqSdedRzU4F4gkgSqcRwuNiAu+ippAmJXr
         /sTjWipLqoqX2z67Fl5PvuhvElzDLLpi/7l9dE0x3+5VDETGM6ehkPWQF5j9s+//gaJG
         hmFDYxR+RxyQrbTDipilgSuFOZ3ovdkBVluRmo9ga/EP6beJod35bqv8RlC/y1RVk1hs
         Fr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hs1rRlczfv3KIGV3jjwEnJRFraZOna3euUgCqEkf1X4=;
        b=CTweqyMwJu87E4N3SqRQVGI1grW5KR/Y5MIYg73y90w0JR2tZ34pxkWFONyZx/wBLg
         /WLbj6WDXp/xsTt6Cm1JDnkl80juhY2Fj720dfi0nKrW49M86IiErqHN5dkhq4sQrfFA
         cbYUdAo/yMQd2e4mrP4+oHulzHG6ESI9pmrHnzvKeuMdEHK5cYb64ry7n8h9PSvvHi94
         esAMCkqpww1iGKB+OVLeXFqXUO/zLWkvRRW8wLNEJkTnFeXXSfKthZZa0ZyppcAYs3V0
         TShnXiM79Oi+GLR4k73DXNTzbaIJD25qSpDFhqDoP6l3N3kLcp8mZEZ32C+5WzKKtI6o
         Oe0w==
X-Gm-Message-State: AGi0Puboh6FxIMXU55vG2gqnzPs1mQWV9E0JctauxY0OXdwib2vDL9z4
        ep7Lx2AQ2q+00ksGh9wTCB+ghSv0PGTy23bV3UcI6i3DwBQ=
X-Google-Smtp-Source: APiQypIwVAjXE18bhQOlY3v+0v06h8TZefVJ1Y/+QuvLHzZQyCs7s6KUJZYMzfP89f39EjWauhAt28hgAagOpHE7KY0=
X-Received: by 2002:a4a:9451:: with SMTP id j17mr2648493ooi.30.1586278443884;
 Tue, 07 Apr 2020 09:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
In-Reply-To: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 09:53:53 -0700
Message-ID: <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
To:     Sami Boukortt <sami@boukortt.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 9:33 AM Sami Boukortt <sami@boukortt.com> wrote:
>
> Hi,
>
> Using git 2.26.0, I just tried using `git rebase` to strip empty
> commits from a branch, but it leaves them as-is, even with
> `--empty=3Ddrop`. With the =E2=80=9Capply=E2=80=9D backend, it removes th=
em properly. Am
> I holding it wrong?
>
> `git rebase -i` also doesn=E2=80=99t pre-comment them like it used to.

Yes, from the manpage:

"""
--empty=3D{drop,keep,ask}::
        How to handle commits that are not empty to start and are not
        clean cherry-picks of any upstream commit, but which become
        empty after rebasing (because they contain a subset of already
        upstream changes).  With drop (the default), commits that
        become empty are dropped....
"""

and

"""
Empty commits
~~~~~~~~~~~~~

The apply backend unfortunately drops intentionally empty commits, i.e.
commits that started empty, though these are rare in practice.  It
also drops commits that become empty and has no option for controlling
this behavior.

The merge backend keeps intentionally empty commits.  Similar to the
apply backend, by default the merge backend drops commits that become
empty unless -i/--interactive is specified (in which case it stops and
asks the user what to do).  The merge backend also has an
--empty=3D{drop,keep,ask} option for changing the behavior of handling
commits that become empty.
"""

To remove previously intentional commits, whether empty or not, use -i
and remove the lines corresponding to the commits you don't want.

Hope that helps,
Elijah
