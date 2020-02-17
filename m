Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CFFC34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99F720725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvU4jcpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgBQQZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:25:42 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:40161 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgBQQZl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 11:25:41 -0500
Received: by mail-pl1-f171.google.com with SMTP id y1so6917637plp.7
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=QJbKmhMI1dLREiFAYoU6uAvbfM8CGBVwIEYVr2eo3fo=;
        b=OvU4jcpLdsu0CelTioMhiayZXxXlK55tFt48nbsY+InikPHcncu/lTuuZS673gJ+zS
         EZ9YDvEMRPh6KtV8gjTlGgvhFL+1pm3Btwgd9oOh4mDAVU8mzwVms5WLFnK0JsdbajTn
         wr3aj9IkYqAY9G7hHW6SJRYGv5EKaG0BB/XsRvGspnEnYW90iCS59+Elv8onF9u5Kw8t
         j4GivJIdnEzxCEa+fWQV6YnusXrQ4poS4hBvbPpzkqOjZt+HqOZrZ2FrzxIFMURRhW3W
         zaZNyfn+Wubuw+jY51TGDQ4r9QB6AEGl6FVCLBvJrYOSx/uxLu1+os9Po23KFf47ra6Q
         7NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=QJbKmhMI1dLREiFAYoU6uAvbfM8CGBVwIEYVr2eo3fo=;
        b=LSKJC7PhRqi0Oqhe2HPjDAAriCLQ3o/UzC8PY3dsOzDEOxYv+eIwNvX0olzeGWRXyc
         CJ0IqqbHkPudK8j0lthMWT/YLJMD8xiHoGXTgb9WJUG1m1H8ew164cUpAQqe2IDLLe1Z
         EG0BYq2xpb9l0Gzj76Cqwmx8qyuyTB0x/MXF7Z43GdhaJQs/ue2K+65VWw+dfg6mTHxo
         pNn/PTU3PyYS6FvtX0q3kzNgOO94aEiwWX3d1zum5O6KKGPXDD2fd38sluna9yMr8NZ9
         avk+QNfwR76QO4UV8a2liaEHWosEOg3EulPBZzy15hd8ThhgiDSEzUuKhgHqRejjOevh
         wzJA==
X-Gm-Message-State: APjAAAUswkxwiVNP9J6jpY2KhJ035kQXVXsaXoi1eoDwkbvCuDvir+5g
        rAQqZ3VO0lufrbWniXqk3jEJh3y4obQe2w==
X-Google-Smtp-Source: APXvYqx4fYp7wCSXhh0leLdNvxYxjCM3vtIzG2s/rpCooHSAVC1hLfD0leLyqi6OO4bNxUQEFJ+DOQ==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr16963678pls.258.1581956740983;
        Mon, 17 Feb 2020 08:25:40 -0800 (PST)
Received: from LJZDELLPC ([184.103.41.156])
        by smtp.gmail.com with ESMTPSA id r8sm1100409pjo.22.2020.02.17.08.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 08:25:40 -0800 (PST)
From:   <lyle.ziegelmiller@gmail.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com> <20200216211604.GE6134@camp.crustytoothpaste.net>
In-Reply-To: <20200216211604.GE6134@camp.crustytoothpaste.net>
Subject: RE: ! [remote rejected] master -> master (unpacker error)
Date:   Mon, 17 Feb 2020 09:25:38 -0700
Message-ID: <001801d5e5ae$e4375780$aca60680$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMhw4Eo4Ohz4QZPcWFj6oDqlRz55AI5bVuwpXYKphA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote a bunch of emails about this in December 2019. Did they all get =
lost?

I'm consistently able to clone the repository, but I can never push to =
it. I used to be able to. I've explored all possibilities that I know =
of.

I'm using Windows 10, and the Cygwin version of Git.

$ git --version
git version 2.21.0

Regards

Lyle

-----Original Message-----
From: brian m. carlson <sandals@crustytoothpaste.net>=20
Sent: Sunday, February 16, 2020 2:16 PM
To: lyle.ziegelmiller@gmail.com
Cc: git@vger.kernel.org
Subject: Re: ! [remote rejected] master -> master (unpacker error)

On 2020-02-16 at 16:10:12, lyle.ziegelmiller@gmail.com wrote:
> Hi
>=20
> Any updates on this error I emailed a while back?
>=20
> lylez@LJZ-DELLPC ~/python
> $ git push
> Enumerating objects: 5, done.
> Counting objects: 100% (5/5), done.
> Delta compression using up to 4 threads Compressing objects: 100%=20
> (2/2), done.
> Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
> Total 3 (delta 1), reused 0 (delta 0)
> remote: fatal: not a git repository: '.'

This error is telling you that Git doesn't think the remote location is =
a Git repository.  It could be because it really isn't one, or it could =
be that the permissions are wrong.

It could also be that the repository is mostly there but very slightly =
corrupt and therefore can't be detected as one.  For example, it could =
be missing its HEAD reference.
--
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

