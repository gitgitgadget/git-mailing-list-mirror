Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB2C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 09:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjATJBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 04:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjATJBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 04:01:33 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29E42D6B
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 01:01:32 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e204so2178608iof.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qde4LlLwk3SuxBIiNuGj7d+wAc5b28kNJvO6xwgOsoI=;
        b=o6KYEkFacWKDZlQaVADmgAiy4ZW91Z1MQVaOT6TSclfLbW8+7fjQ1tmh1A7mm9hwAk
         mt8A1Cx3dxHe+ZwnN5vkwrChvRA+77uGTdjTKntNHz78ZetS8dE6TJqF1b18B4sNEBEH
         VhFmgXsv56E09urSHkvKk0THxZaIwKan9KM2LvvB6EYbpxxl3YlybMA73XjhhfhuK7I7
         6AB0XO4kcpIYfsmw9Uq1ckINWumOVPNI1SLY3kJIebvonBUNZQqCNeXnY+UmjGozgx9p
         +F4l4qV0/pu3/azRTvJFh3quCoHE1TBwBccq0lYN7H80QhYuxDmPLNVIrsPyjecsX3xD
         2dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qde4LlLwk3SuxBIiNuGj7d+wAc5b28kNJvO6xwgOsoI=;
        b=G0q0owk9TodIJZRVhb4fkWTvKASjXC0BvYqgHL50hGCcgrXWCpUEzJuyQPNEvreIxi
         1tPKkhuEKDnIJYCxhAYEixC1eS7Fr/WUd2M+qldpzr8XaAoqKwZdElRTLju9en+1Fun9
         9lGboAff8aQyRbpmgUxRopjJixL9QQk/D8xewhGYXt8YgpbYOd7/TaMZTVAgTEQxCKUn
         tcLhOyxwSLCfFF3u7gsH/zKOdhW9nO9vtnx9YJvR0Kgsjcl6YeY+MYhF2kOlc3CEjJ+a
         q+6YRtQsZGg6nHTuwxEcJSZ+fALS6FnAETqo90P8wAhyAPJfysP+Bg0dsEP435K2XZ9r
         C0qA==
X-Gm-Message-State: AFqh2kpTwHULNf9uWEkdWGRlqP3BmW7lNF56fUeBnVHfSwOqAs2AAALA
        vVDNTE7MpI5gckktpsRteaKqNcaPJncL0JQhxXzAil5l
X-Google-Smtp-Source: AMrXdXu3SCKpFnZcH9Vu1McUkTx6PbwCOnWL0RFBoocIVUFF9tW6KB6HUUi9xigW/rtB6+OfOV3czGRmJOSz6UPUGJU=
X-Received: by 2002:a02:b794:0:b0:3a7:ce83:568c with SMTP id
 f20-20020a02b794000000b003a7ce83568cmr291958jam.193.1674205292176; Fri, 20
 Jan 2023 01:01:32 -0800 (PST)
MIME-Version: 1.0
References: <CAEcbrFdE6X6=ppBWmFZrm0Z2RqGqFatjNHdZbGb_RMteCk6P6g@mail.gmail.com>
 <CAPx1GvcBDcZ1K_YJKm3+fUBNYQWKE2FBz-qS6JrV2TJCTc5k1w@mail.gmail.com>
In-Reply-To: <CAPx1GvcBDcZ1K_YJKm3+fUBNYQWKE2FBz-qS6JrV2TJCTc5k1w@mail.gmail.com>
From:   Arthur Milchior <arthur.milchior@gmail.com>
Date:   Fri, 20 Jan 2023 10:01:21 +0100
Message-ID: <CAEcbrFdfZsRAxeMj+z_VBxHbtgBDKHC51rDz0duM3a0TFzqB-A@mail.gmail.com>
Subject: Re: Race condition on `git checkout -c`
To:     Chris Torek <chris.torek@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for the explanation. I=E2=80=99m ever so happy not to b=
e
working at the file system level nor on cross platform app.
Alas, it=E2=80=99s a computer configured by work, so not only do I have no
control over the disk configuration, but I=E2=80=99m not even allowed to pl=
us
external storage. So I guess I=E2=80=99ll just remain with the case
almost-insensitive branch. Not like I expect this to occur again in
the future.

Good luck with whatever next change git plans.

Regards,
Arthur

On Thu, Jan 19, 2023 at 11:56 PM Chris Torek <chris.torek@gmail.com> wrote:
>
> (Top note: you mean `git checkout -b` or `git switch -c`, not `git
> checkout -c`.)
>
> On Thu, Jan 19, 2023 at 1:24 PM Arthur Milchior
> <arthur.milchior@gmail.com> wrote:
> >
> > I expect either:
> > * to see an error message stating that `b` already exists
> > * to see `b` and `B` in the list of branch.
>
> [snip]
>
> > uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:03:51
>
> Darwin (macOS) is your problem here.  The same problem
> occurs on Windows, but not on Linux, by default.
>
> Technically the problem is in the file system itself, combined with
> the ways (plural) that Git stores branch names.
>
> As far as Git itself is concerned, branch names are *always* case
> sensitive, so branches named `b` and `B` are different.  But Git
> stores branch names in two different formats, at the moment:
>
>  * Some are kept in a plain-text file `.git/packed-refs`.
>  * Some are stored as directory-and-file-names in `.git/refs/`.
>
> If the OS's file system is case sensitive, as most standard Linux
> file systems are, there's no problem with the latter. But if the OS's
> file system is case-INsensitive, as the default file systems on
> Windows and MacOS are, this becomes a problem: the attempt
> to create both `refs/heads/b` and a different file, `refs/head/B`,
> fails, with one of the two names "winning" and the other attempt
> to create a new name simply re-using the existing name.
>
> If you create a case-sensitive disk volume on your Mac, which
> can be a simple click-to-mount virtual drive within your regular
> case-insensitive file system, you can happily use Git without this
> complication. Note that the same complication applies to file
> names: Linux users can create two different, separate files
> named `README.TXT` and `ReadMe.txt` in a GIt project, and
> if you use the default case-insensitive macOS file system, you
> won't be able to check out both files.  Using your case sensitive
> volume will allow you to work with the Linux group.
>
> If and when a future version of Git starts using reftables instead
> of the file system to store branch and tag names, this particular
> issue will go away, but until then, I recommend keeping a case
> sensitive volume handy on your mac, and more generally,
> avoiding mixing upper and lower case branch and/or file names
> (at all, ever) whenever possible.  This avoids a lot of problems,
> though nothing can get you past the Windows `aux.h` problem. :-)
>
> Chris
