Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A8C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 03:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C24020700
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 03:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomaszubiri-com.20150623.gappssmtp.com header.i=@tomaszubiri-com.20150623.gappssmtp.com header.b="gxiCDv+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfLODcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 22:32:17 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:33800 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfLODcR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 22:32:17 -0500
Received: by mail-qv1-f44.google.com with SMTP id o18so1356540qvf.1
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 19:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomaszubiri-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=83zVc+fUNLYNzog3tiF0VDtGC1NIGOtgbrHUg3jMst4=;
        b=gxiCDv+DDUd8JuV3SoKJcUgLzGCoC8diNX0inlsJ7NbBtd7VL0pOKgXduNq+abwEgk
         l8dypIFgUzD79RYcr4Zw/npwbW8sQIIZFxNnADl+tBqetXQ17uOeaETZo4UudiTa4gVW
         moxcL9qb3AHCV/IJJr0zqnmG+IMKtrhfknqNvhsc7Ho+BWqf7lfYxhd4kd5yidsukJdM
         jcpVDfOe/BYN8LqDI0KU7nkoIUnW0Gdj4X75IBdmRFZ8T448tWDvkKFlhEaaalyk3pnW
         HKt2f0r7wuqklowsBGtPVKdJwhY29RDvkVdX/1umjlUjrFtMSS7ZtXDGYPe0oXiWN6jY
         NaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=83zVc+fUNLYNzog3tiF0VDtGC1NIGOtgbrHUg3jMst4=;
        b=TxDwfMJhxjfqPG9pCqBBEtFcQaHPZclm4Ofx48zXDpk+qy4URrWT/ErjoKCLranHJj
         b5lA9BcWNRb66m4aSLFs+9eQY/EcxMb4iwB0yysN2N0cCFI2XbtZunAM0r1OOHV5abz1
         3NKYUW5v47MnSBIPltwdNssQgtgQT8cSmUPK5FUfLZI9vRp3k5l1tyM3s56+KZYyTKTm
         trH+Vc9zBcDBnVwQL6TjPglMAC5pNaxGboAX4CFgrYU74UMvhlKrb6Nd3fpm06Tc7OG5
         WK9P31buzk1GmrPS00ge4qBy2chxUf7O5Tzcf3fhXFg6zmBpdlZ50GdZZBI2YRj9r/ds
         lzHg==
X-Gm-Message-State: APjAAAUedQZ37K4wnk6/hGhoKc9GdCl3zLR0ZMbsxLNgQiJV4jwbA4cW
        +J3Q7hofc167uU1RnUQruJkGFoq1hnWm/A7eRM/s8lrx6CI=
X-Google-Smtp-Source: APXvYqzyhoZ/cFN1WwZBiVf9LGPhqtrtkTBwt1LZ1MRUWBpprGTU4b827GJKVHXF1rUQIw++1uMSY8JNArmGkKO1B+s=
X-Received: by 2002:a0c:936f:: with SMTP id e44mr6576171qve.248.1576380736000;
 Sat, 14 Dec 2019 19:32:16 -0800 (PST)
MIME-Version: 1.0
References: <CAE3VKEpPye+GyR7Uo9WBa=1i1L=dFq9AHfdNnhiw19K-jWLtBA@mail.gmail.com>
 <CAE3VKEppVv=rocJU7jHKu7i=dLyaHhpauTBmm91udjZ_DOpW+g@mail.gmail.com> <007401d5b2cf$ac787ed0$05697c70$@gmail.com>
In-Reply-To: <007401d5b2cf$ac787ed0$05697c70$@gmail.com>
From:   Tomas Zubiri <me@tomaszubiri.com>
Date:   Sun, 15 Dec 2019 00:32:04 -0300
Message-ID: <CAE3VKEozjFXBkQCWQ8FSOPJkwPCM05=eb7jdA4AYwJCtNSH1Ng@mail.gmail.com>
Subject: Re: Head, Branch != Head -> Branch?
To:     mattr94@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was just a combination of an old gripe I have with expecting git
branch to checkout and conflating (HEAD pointing to a commit and
branch pointing to a commit) with (HEAD pointing to a branch pointing
to a commit).

In what scenarios would you create a new branch and not check it out?
Is there a scenario where you would do this in detached head mode?

---

 Could HEAD attach itself to a nearby branch whenever a command
requiring an attached branch is called and HEAD points to a commit
with only 1 branch attached to it? This would not include commit,
since it does not require an attached branch and thus would not fail
on detached mode, this should not break bc because it only affects
commands that would otherwise throw an error.
Alternatively, a more specific error message could be printed,
prompting the user to attach their head to the branch on the commit.

Regards.
El s=C3=A1b., 14 de dic. de 2019 a la(s) 19:41, <mattr94@gmail.com> escribi=
=C3=B3:
>
>
> After going through the code and thinking about this. I think the unexpec=
ted results came from git branch not checking out the branch I created.
> I know git checkout -b master would have been the result I wanted. If I w=
ere to create another commit with HEAD checked out instead of master, maste=
r would not update, only HEAD would.
> > I guess the real crime here is that git branch does not checkout the br=
anch created. I don't think I ever wanted to create a branch without checki=
ng it out, otherwise I would use git tag.
>
> The problem with this is that git tag doesn't create a new branch, but ra=
ther just a new tag so running something like:
>
> git tag my-tag
> git checkout my-tag
> git add .
> git commit -m "message"
>
> wouldn't update my-tag either, you would need to create a new branch for =
that.  Sometimes I want to create a branch without checking it out, as I'm =
sure many other users do.  Is it an issue of documentation where maybe the =
behavior isn't clear? It does specifically say this in the description of g=
it branch, but to be fair it is buried 6 paragraphs in
>
