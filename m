Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EFCC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843DC61279
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhETHHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhETHHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 03:07:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D69C06175F
        for <git@vger.kernel.org>; Thu, 20 May 2021 00:05:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d16so11660798pfn.12
        for <git@vger.kernel.org>; Thu, 20 May 2021 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VyI5tNs+SLjw++hBr60Q/qfGjwP2ta4OoiJhK/n9aYg=;
        b=DLOkhbjcIlurET2KJ83Jw5stLR8lm9e8eDR8HF98MPdURm7zTiqqMb217LiXHVPHwv
         pGBPRMjeTKQdyt0qlPk5kGy8rIzH5BPHQujhGQK2ZPCAwbW+TcIvIDN+MMysstzUt3zG
         iGMJ2r6WEY68qAHLdUeSc+AeVW/njb/ohARCJZKFq9Dfvf7qUZtXmSaKKAMrXEJ8NE74
         Au4mamN4S2tjiWeISOOogiwsFXWFVtfJUx12OtddlrZKn2bPCudJD9odJxYBVGRQxFF6
         j1Ja8l5fyzfxwX2uzo/r91E+Z767XVKhLucmqKZlOwM3Ri0WDcJS6JpLuRYMqVcnAMzJ
         cDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VyI5tNs+SLjw++hBr60Q/qfGjwP2ta4OoiJhK/n9aYg=;
        b=a4PuVVl8HHIyi4lcOQemkCF6O3Q71aVULb5d0VtC5MgPstqkBfP6tNlBrzhWunhIwY
         dAxMfyIFQ6/x3EiB9d8UbueL7yeRv7FRDqXtJR5BEETVEgxZclYkLqrmw8S7yyaGPgb6
         PfvO1KUnTuKKmfl8JEV7YSVuedg1Ew22t/hucvjcLcO2ENK0H5H+KIgAKzwmW1DOO0nK
         u0sxJv7BOAJK6/wa8U3cKHNPRqW3LER+oqOCVxZ7ZnCOkxTUwbXHwIrxOn+A7emNLfkK
         3ZsnqmbI/WK11HL4CWR81FKYjJZB4ht6z8sTEQ8qyHM+2xPMMbVWOZxEG0FH2GNlp2qX
         drbQ==
X-Gm-Message-State: AOAM531jxkPV9aG/dED0GpKONjQ/k/YutbTWje1jicXRjln9wSH7fCPE
        Ref7W5TXIXv0lh7gZXTdnkx1zrpWfGfAEw==
X-Google-Smtp-Source: ABdhPJxI7KpoI9eJm0KPGqdOKpSXbbj1P6mQdIyj3g21GW/L4aB747SHKVu3hGd2vXv+UkpZd3DFRg==
X-Received: by 2002:a63:205b:: with SMTP id r27mr3180174pgm.95.1621494352035;
        Thu, 20 May 2021 00:05:52 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id x6sm1169501pfj.24.2021.05.20.00.05.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 00:05:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [Bug Report] git log -L:<funcname>:<file>
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAH6yD_bkY+_7XrzHdOqnnE=qvnnvxAWEQPtOyVh=BwvbcheTCA@mail.gmail.com>
Date:   Thu, 20 May 2021 12:35:48 +0530
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <415E9638-B035-49A2-B2AF-1CBD988421D4@gmail.com>
References: <CAH6yD_bkY+_7XrzHdOqnnE=qvnnvxAWEQPtOyVh=BwvbcheTCA@mail.gmail.com>
To:     Weishi Zeng <amwish.zeng@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20-May-2021, at 05:41, Weishi Zeng <amwish.zeng@gmail.com> wrote:
>=20
> Summary:
> git log -L:<funcname>:<file>
> would fail if there's any java-style comment that appears before the
> <funcname> string in the file.
>=20
>=20
> Details:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your =
issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your =
issue)
> git log -L:'myFunction':~/a.java
> The file is a java file that contains comment before the function =
name.
> E.g.
> /**
> * comments will interrupt the regex match
> */
> private static void myFunction() {}

I was able to reproduce a similar problem, but it was not the comments
that were causing it. It was happening to methods that were indented
(ie, defined within a class, as is always the case in Java).

> What did you expect to happen? (Expected behavior)
> As described, it should return me the commit history that touched this =
function
>=20
> What happened instead? (Actual behavior)
> It returns error:
> fatal: -L parameter 'myFunction' starting at line 1: no match

Can you try adding a .gitattributes file at the root of your repository,
with the following contents:

*.java diff=3Djava

After that, try running the command again, and see if that helps.

I suspect the default regex that tries to locate your function might not
be matching as well as it should, and does not handle indented function
definitions properly.

(More on what the .gitattributes file does:
https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_header)

> Anything else you want to add:
> If the function name string to search for appears before any
> java-style comment, it returns a valid response.
>=20
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>=20
>=20
> [System Info]
> git version:
> git version 2.30.1 (Apple Git-130)
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 20.4.0 Darwin Kernel Version 20.4.0: Thu Apr 22 21:46:47
> PDT 2021; root:xnu-7195.101.2~1/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.5 (clang-1205.0.22.6)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>=20
>=20
> [Enabled Hooks]
> post-commit
> post-rewrite

--
Atharva Raykar=
