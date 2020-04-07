Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F30EC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6F52063A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN5o9taB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgDGSDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:03:35 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33827 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGSDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:03:35 -0400
Received: by mail-ot1-f45.google.com with SMTP id m2so4116318otr.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wLClme5rZY8GX2VrSieYB0LbEflUoTjRQR7R3D2cpio=;
        b=PN5o9taBNeacCmhDIJlOdanBLwywgY6Dugj6Qc+Truf07D8SujyMCpMBGAx1ZeUGlM
         SzHrB+SfabJN0y2PYJibspSD1yKzgUjwCSuZ2okY5CabNl8uTsPlfpOdiSKirlJxyADX
         bVjen/YEfvw2rJ2xT9awsB0oFfjWAgPP4w+i+5pLRXNElBb69MlGGHTy32rg+wKd7vBr
         /oNdVSQKxtCLCjzN96OZnB3wdi03LFBoDbY2Sn5YCd3Idc/ulr9SYob8ss2UaESwcq+8
         0k3Z0hYjGcfuM/m6MV4R6wZ/Q90/mga62ez87hzTEzoVAaBgJF6W/DJnlH3S85xwN1pU
         siJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wLClme5rZY8GX2VrSieYB0LbEflUoTjRQR7R3D2cpio=;
        b=Hpsak4DKDyAgVHNpGoANiQgr0tdKhVILmjeyT6X9k/VR3m4G9n/u/tk32fnqdui5FC
         4QM396M5KFhIG8WGcOPIFXThgH43rkX60n6hkys40gTo3Jd1jcrMqa17WvJsn+bYw6Ly
         vWSHpIFtEgx+8yQXcpTpt69RsmuTg+L1K3gv3cflwxmthtV0s7WZ2u5O3AkHlRL2CbM/
         ANxYKY6xKQHXH04CxzSku7m4GqzaTKBiosr9BUc0sg09kyyToBxkx2S7LVWYiuGOhDj+
         /sDcUruYPZ/oLB07E0SCoBJjdRx6FgrK5r1ThICBpE2O92R7tQnAht+HUxMgqwnqgB1a
         kYcQ==
X-Gm-Message-State: AGi0PuY9U9USW5nt7/1HX0lpPweoqQkyXaUjfzHBgN7DxJSgMBTzT/qr
        EJnbiLyQ+L2uiwsnYg82fidBUp0XqXSPslOw85rVmGZ3
X-Google-Smtp-Source: APiQypIgE3NjDfUy9bH48mPd/5FUbBhKiOhJn7rZW+yEX8DKCFNnXqwj+DYqWat34rU4MoW77hZE/OQRUd87yIa8hBE=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr2705374oti.162.1586282613626;
 Tue, 07 Apr 2020 11:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
 <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com> <CAAb+AL-95RKhTghJX4uLxiM3dqZW6U914XBXaLcwK+gC_FezWw@mail.gmail.com>
In-Reply-To: <CAAb+AL-95RKhTghJX4uLxiM3dqZW6U914XBXaLcwK+gC_FezWw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 11:03:22 -0700
Message-ID: <CABPp-BE1mDQYcj6nRfS4osn8-E_WdV-Nenn9dQSA+JCr+pjKLQ@mail.gmail.com>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
To:     Sami Boukortt <sami@boukortt.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 7, 2020 at 10:28 AM Sami Boukortt <sami@boukortt.com> wrote:
>
> Thank you for the very prompt response.
>
> Le mar. 7 avr. 2020 =C3=A0 18:54, Elijah Newren <newren@gmail.com> a =C3=
=A9crit :
> >
> > On Tue, Apr 7, 2020 at 9:33 AM Sami Boukortt <sami@boukortt.com> wrote:
> > >
> > > Hi,
> > >
> > > Using git 2.26.0, I just tried using `git rebase` to strip empty
> > > commits from a branch, but it leaves them as-is, even with
> > > `--empty=3Ddrop`. With the =E2=80=9Capply=E2=80=9D backend, it remove=
s them properly. Am
> > > I holding it wrong?
> > >
> > > `git rebase -i` also doesn=E2=80=99t pre-comment them like it used to=
.
> >
> > Yes, from the manpage:
> >
> > """
> > [=E2=80=A6]
> > """
>
> D=E2=80=99oh, not sure how I missed this. :) Thanks.
>
> > To remove previously intentional commits, whether empty or not, use -i
> > and remove the lines corresponding to the commits you don't want.
>
> Sadly, that is somewhat inconvenient, as those commits are not
> actually =E2=80=9Cintentional=E2=80=9D from my viewpoint (though I unders=
tand that git
> has no way of knowing this), but rather created by another tool
> (git-imerge), which means that I have to check each commit

git-imerge creates non-merge commits?  Is this in the case when it is
acting like rebase?  If so, is this possibly a bug in git-imerge (in
that it doesn't drop commits which become empty)?

> individually and risk mistakes. The old `rebase -i` behavior, where
> such commits were automatically commented out, would be an acceptable
> compromise, or even a comment added at the end of the commit line (so
> that they are still kept if the editor is closed without changing the
> rebase list). If there are plans to eventually remove the =E2=80=9Capply=
=E2=80=9D
> backend, could that workaround be considered?

Automatically commenting them out is bad; that causes frustration for
people having to uncomment all the commits they intended to add.

But we could add some kind of option.

> Alternatively, I could also use `git filter-branch` (with
> `--prune-empty`), but apparently, its use is heavily discouraged.

You could use
   git filter-repo --prune-empty always
