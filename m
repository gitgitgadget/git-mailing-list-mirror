Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BDFC43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442721D7E
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEz2lh+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgIMPNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMPNa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 11:13:30 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA660C06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:13:28 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b123so8117871vsd.10
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jOnwVbH3riBQRvZtJs5USrS+um5oihgG01t1pG3byY=;
        b=kEz2lh+EDwF/Rb/jK77Xnz5hrWluAThpDP/+M1qx2vrRP2yFhuqNjgOS920ITJXuaP
         RapOZ/8acrxcy7X23ffoowxJkQGiQvef/1chXuxKei7maAnuYcNWDx1lzXYmfMIHm64m
         aP0zaGTe4QXu6AtGtxEGVCMFnPX0KQJ7vSNNJDN7LO9Dc7flyhVDHkLvkC3tzrM2pBCk
         QzD2cnLfFHajkdlKhQKaHltUTEqQfVAby4/kH/2FyLsEW7C2ZwZgEyAEwTaFYfiperVE
         U9h5b4whdcatOd5gUx1T1Iu8Tg26zwENTMPPFY7AzgDvI2QXlt1Zi+8vZJRuV/9GzE0V
         tAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jOnwVbH3riBQRvZtJs5USrS+um5oihgG01t1pG3byY=;
        b=ECRJsCgY/9SgrTeg0d1cVAQysIjhBFjgZcTS55hi8ljALhQukMLY/0mkJJ9i1Lppgs
         mgzBdrXd1IriRD7UAXqPfq8ymlUbC8uXUnBybBR/067A2amH/PGb5nguTgvM87qu+QvN
         M9NWbNAT0Ot5K6kPzRx0+f9htdGk1TOkMZiRi953Fd/ZFlLFkG7UBHVx7jtp5ktAuKyu
         2qZuQSNGAeMar9In0DrLtp3ax0lmnW9dss4TKfhHxjAv5rgOTS6J83wQLZC7jeoPcCcd
         3U1pNAl75grBk0EuFI/CEWk+tGi5/XF/Ber6Gn4b1hHuSreol6F6WwhZjPww+KApsYRT
         l0XQ==
X-Gm-Message-State: AOAM530vqoBKqwhJIY1Uzi6XUcDuPfjbkGDZ1I6xoT6jQL9m7oZgIuyo
        GeGAThrlOIoqHKltcrIOr6OkOQHaCXHky9DVO9hP6f6C
X-Google-Smtp-Source: ABdhPJwaZPnCOOuM4DcfTxwTGgOlRAxd8QUDk19AMSM+tPQsaNtXoqc+f2il5KcgRmg4oNjOBdS6FKlAHZngWyLhDN8=
X-Received: by 2002:a67:ff17:: with SMTP id v23mr5467982vsp.107.1600010002881;
 Sun, 13 Sep 2020 08:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net> <20200912204824.2824106-4-sandals@crustytoothpaste.net>
In-Reply-To: <20200912204824.2824106-4-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 13 Sep 2020 17:13:10 +0200
Message-ID: <CAN0heSp-Uhp9QZdjV3GeUkhMn513-GADJg1D9UXsrB7ok8J_gw@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs: explain how to deal with files that are always modified
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Sep 2020 at 22:52, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Users frequently have problems where two files differ only in case,

s/files/filenames/ ? Anyway, clear enough here, but let's keep it in
mind when reading the proposed FAQ entry..

> causing one of those files to show up consistently as being modified.
> Let's add a FAQ entry that explains how to deal with that.
>
> In addition, let's explain another common case where files are
> consistently modified, which is when files using a smudge or clean
> filter have not been run through that filter.  Explain the way to fix
> this as well.

> +Why do I have a file that's always modified?::
> +       Internally, Git always stores file names as sequences of bytes and doesn't
> +       perform any encoding or case folding.  However, Windows and macOS by default
> +       both perform case folding on file names.  As a result, it's possible to end up
> +       with multiple files or directories that differ in case.  Git can handle this

I think this could be clearer with something like s/that differ in case/where
their names only differ in case/, i.e., explicitly talking about the names
of the files and also sticking an "only" in there.

> +       just fine, but the file system can store only one of these files, so when Git
> +       reads the other file to see its contents, it looks modified.

That concludes my reading of these patches. I only had some minor
comments. I think these are good entries to add to the FAQ.


Martin
