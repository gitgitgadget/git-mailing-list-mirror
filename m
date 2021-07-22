Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB1C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8609761222
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhGVJFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhGVJFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 05:05:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A480AC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:46:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qa36so7453133ejc.10
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjDoh62fV8uQfdWVMwwTvzLJCy0VZivFRx5JFFuj+64=;
        b=RoIjC74J7sxZQNyKAUYVYveWDCgZhHu2nGqne+fUMf2g+GeeZjLlcp9rqfNyekUrrt
         fi3YGHu/flwpwfrjV/9YZtI07Bsy1s5fTch7ZOahofRZTjcl8l+Cn4K99eDtSu42K01C
         N4zAWSokcQ7jVa8xNHqcFTRQBrLsGPH2M/Es6Iu+emgosyJBj3expW82Ebbi+w95Vgfe
         8RYbNppbBhOsZQJxCs5MJV5EQSyK2qzt8u1c9OEeOd8XXi9auMDYqhxkY5Ug40H86Xuf
         v9sFS3XyHQceqBT6KrJ+vkbBOJ3Oqtsm8PQLYUNTGX49Fv8HYw02RbH4SOGSThonMsKP
         MIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjDoh62fV8uQfdWVMwwTvzLJCy0VZivFRx5JFFuj+64=;
        b=qfCa9V3rl+53yrxoDYo28vtuapOysa0iDlgIOjk8Hwi+064lzQ5vnF+f/vIpZgSg5D
         kVrS0d0JbossEmfTAUfASEMOcT3dew0mix3M0CPAbqAbVW8Jn4YwrUr7wCAbNRI09NQd
         PlSphKhAiRpeUWQSa6mTcv6PWPn42ukVgvHFalMTjTTLngbm7m1CiX4kCAWBgAPF0dye
         4ONVv5fqHYBl2OUIhp3vbdjyT/xO3qj1yV+NrHgo0sQJuC+ARplLx8URpGCnpcS3FT5Z
         Da9th/x5JKzDrBraogC47O1w9pEta4tdYlvNrCG7B9nLIc4rAlR+aswbbfeUMiorv0wB
         /wDg==
X-Gm-Message-State: AOAM5312c+M7kvDy1t14gvASvut+9Sc6bsa0muw+URmnjWXDI5niPyxO
        pEESJXCTqio+/eSFYUxcQCVZKC0ATUc1MGO3nl8=
X-Google-Smtp-Source: ABdhPJwFMVEYMF3T50cf6WpFdOoWSDLj4/SVNMs2ViQcfunCrJafnVt/uzlok7qwIg9wKT2tKY66HjkbGSOzLcg9/zA=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr41895874ejn.57.1626947173306;
 Thu, 22 Jul 2021 02:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
 <871r7qvhhr.fsf@evledraar.gmail.com>
In-Reply-To: <871r7qvhhr.fsf@evledraar.gmail.com>
From:   Angelo Borsotti <angelo.borsotti@gmail.com>
Date:   Thu, 22 Jul 2021 11:46:01 +0200
Message-ID: <CAB9Jk9DqCR8C9qx6-gZmpTQfBAKnEupQTb1WkJgN3YOqSO0=2A@mail.gmail.com>
Subject: Re: Extracting a file
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

thank you for your quick reply.

Actually, I did not want to make git behave like a read-only filesystem,
but only to be able to get what is stored in it using some easy to remember
command.

I guess that:

    git mv A B &&
    git checkout HEAD -- A

renames file A in the work, current, directory to B, and then recovers
A from the
repository. This changes the file on which I am working. After having
read the old
A, and understood what changes I make that are not correct, I should delete=
 A,
and rename B back to A.
If something gets wrong with this, I risk to damage my original A.
This is why it is
better not to change it, and instead get a copy of the old one with
another name,
which is what

git show HASH:file/path/name.ext > some_new_name.ext

does.

-Angelo

On Thu, 22 Jul 2021 at 11:13, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
>
> On Thu, Jul 22 2021, Angelo Borsotti wrote:
>
> > Hi,
> >
> > sometimes there is a need to extract a file from a commit.
> > E.g. some changes have been applied to it in the work directory,
> > and the app being implemented no longer works properly.
> > It would be fine to have a look at that file, some commits ago,
> > when all worked fine.
> > Of course, it is possible to recover the entire old commit, or to
> > make a new branch, or checkout the file (which requires to save
> > the new one before), but the most simple and safe way is to
> > extract the file, giving it a new name.
> > That is possible, using this (hard to remember) trick:
> >
> > git show HASH:file/path/name.ext > some_new_name.ext
> >
> > Would not be better to have a "copy" command to copy a file from a comm=
it
> > to a new one in the current directory?
>
> That's an interesting feature request, FWIW you can do this now with:
>
>     git mv A B &&
>     git checkout HEAD -- A
>
> I wonder if having a "git copy" for that would be more confusing that
> not, i.e. a frequent difficulty new users used to have with git if they
> were used to cvs/svn was to look for a "copy" command, thinking that
> git's data model (like those older VCS's) needed the user to use a "mv"
> or "copy" to track history.
>
> On the other hand perhaps git's so thoroughly established that it's not
> much of an educational issue anymore.
>
> > This would make a git repository resemble a (readonly) filesystem, whic=
h
> > actually it is.
> > Note also that the ability to get from a repository what one has stored
> > in it is the most basic feature anyone wants from a repository.
>
> Git is actively not such a "read-only FS" in the sense of some version
> control systems, i.e. needing to declare that you are now going to
> "edit" the file etc.
>
> It is for bare repositories, but a checkout explicitly concerns itself
> with you doing arbitrary changes on the FS, and git needing to keep up.
>
> So maybe there should be a "copy", but if your starting point for
> wanting it is to make git behave like a read-only FS I don't think
> that'll lead anywhere productive.
