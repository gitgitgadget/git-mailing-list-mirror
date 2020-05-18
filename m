Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2231CC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF74207D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="PiG4neFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgERXWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgERXWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 19:22:13 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB47C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 16:22:13 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o7so10712611oif.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 16:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vv02fvGRYpkaFqMzMsvB/OzBv+P9G5TZsaFjQZEpfyc=;
        b=PiG4neFuA48R1vy9gAc3XBVCbP+kMnXf6rU0NLpbj5SNvlgmfDbFYDdyfJcSanLo7Y
         Mgsdb9/E3JF/FvlFScCq5KGaCTp5krp0gDPUzJ2fYp75/rhYcJkFMW4S4dFO7A152F9q
         8qeqJuZZ3LZeV8jshKAJrp1pyiQj3pOcRaqgGfqgxeeFy4DNu4ogXzuvbYAL9qzR0VSp
         YQOTXyhnqg5PxMs/nx5h5enJuG2TuRHiU0vkSv2+HkLJqxqfRb8KWxGGfpbteuOCKKo5
         VGU8fmeCpkRpqQTAB7Ajx36Byd567VZeK54+ey0raaIrmlJbSqEvMEz1FvlFDkldSRp4
         lgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vv02fvGRYpkaFqMzMsvB/OzBv+P9G5TZsaFjQZEpfyc=;
        b=gxUw+nzqpaaCz/K3BUFFc1poAH0QxzSxzvvd14OM0Qf7nL9DnWqR7kvapfCJdW7zle
         jiQ7G5PpKN29FZWTlaXaofEydIneMNxH6JDUGbfCVqsyTv/3XBilVUP307WPeZc8kcAj
         VD5OSrSgIaYODM/lewEyIYWAd4aDslVv7WOtEAwJ8Uug9jTA6Eno4J0ZqNEgNO5wVQQx
         RYEO86b/BOyA4nOmW63lr+LMzvtF9/zvG0LXdxwk0hhz5sG6cYMsXEX5yswIFfeC8SEt
         5PpgqjtuRca/T1QwKb0yRZWdU1mPjhQN7n9NqzzADBmaXiXu15rqmv8EkgQzjKmtbgCI
         iNoQ==
X-Gm-Message-State: AOAM530pJZ3JkaGaC55D4L7msODM7LPi8oHkiQgpy9oFTWmi+NpphDcb
        WbG2jggP48JqqdOk3MGjfhX23E1ZD7cij2ayQCIqNQ==
X-Google-Smtp-Source: ABdhPJwVkNSWHIuvcqRPUoKO/WhCHqyCVT7ZfJiQ9/ZfQik7MU4I9L/Wao37NEv9mB60WnUqa26diVZET8EDBD+fpBo=
X-Received: by 2002:aca:1312:: with SMTP id e18mr1289667oii.77.1589844132189;
 Mon, 18 May 2020 16:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com> <20200518153025.GD1980@danh.dev>
In-Reply-To: <20200518153025.GD1980@danh.dev>
From:   Darren Tucker <dtucker@dtucker.net>
Date:   Tue, 19 May 2020 09:22:01 +1000
Message-ID: <CALDDTe0BvyXYz39n0EqGnJgdfHMziwW7V5xQO_H=+OKm20jfFA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Redirect grep's stderr top null too.
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 May 2020 at 01:30, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
[...]
> > printf: \3: invalid escape
>
> Look like HP-UX's printf doesn't understand octal escape.

The HP-UX one is actually OK with that.  The error is from an old gnu
coreutils (2.0), and it's complaining because there no leading zero,
which POSIX says octal escapes have:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html

"""
The following <backslash>-escape sequences shall be supported:
[...]
"\0ddd", where ddd is a zero, one, two, or three-digit octal number
that shall be converted to a byte with the numeric value specified by
the octal number
"""

$ /usr/local/bin/printf '\03' | od -x
0000000 0300
0000001
$ /usr/local/bin/printf '\3' | od -x
/usr/local/bin/printf: \3: invalid escape
0000000

--=20
Darren Tucker (dtucker at dtucker.net)
GPG key 11EAA6FA / A86E 3E07 5B19 5880 E860  37F4 9357 ECEF 11EA A6FA (new)
    Good judgement comes with experience. Unfortunately, the experience
usually comes from bad judgement.
