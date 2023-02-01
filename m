Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA86C636CD
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 15:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjBAPTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjBAPTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 10:19:23 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D014F7165C
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 07:18:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k4so46926454eje.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 07:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mSaflnWTDyzoQHqoyP3elF9nNHJEBvTdwBB5VKrw3kU=;
        b=F4TkI3jKGypg23fFrryp74HvpQdcKON9wP4hqzMxPKQHOrv8319pYkj/lgDgvJ0gFh
         HqBaIKPfPDT2zeK/TMUVxhTXLGNs6BAM9AiBKSA2aVFm93KDfCA3J08m+cBKCf12HALg
         wRPylfCr0uZCQO7Mn9XguUgUlFp09KNqTnoLeD61+hgistdQDVyFlavkNPllJ//wjgmw
         AP4SH8eYO9X3NgSjzoXT9YvCAxWGbSr2wMkToYzmurj8EmHPztk8JpzvZNCMg7dIOI82
         8JO0KHFuKDXg5HGJGBQ8t4G4fSrwGEgcTgqrIHLonyX4v4LOnoiYluVV+Wyr6nswHu5A
         YF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSaflnWTDyzoQHqoyP3elF9nNHJEBvTdwBB5VKrw3kU=;
        b=Zz7yiDOMjX1LrR1te8Q9yWqP7nkXE2yyYokid1zkQ4q1CgQG3e1/jROcAPM9pUjs3j
         d18D2LBypXNvMchwNRuQSaQAOqopsl7aSzV/UmIOfKc4yjTqhrObG4kzdssNNIzw/Ggv
         yPD3OHYbCOhLJnqyCRWCtWRbX+WxOUidy/WPPUbYksYKbWx1oREn83LmU4KlLYIWHZas
         iv0Yr9O0JoDfCZd/EO17XcplbvOMvQfSMxDGvVgn99ncXtg1oBAtcN7qq7LRhcJPcjk3
         ZFp9UUQ/Z6PHH4YlRyOmo34Vmrlfs1IDean6BwJbCTJ3G4N+19hQ0n6lms/EZFWr6FWJ
         JkkA==
X-Gm-Message-State: AO0yUKXtB6wLMzWLWES7jyIvSOWgRrT8NaFdhirXvFb7kqLQfUi8X309
        bPb11O2U5c4EQYuLBfxeT6+yXqQ+ED8PJscwrbhH6uymsXs=
X-Google-Smtp-Source: AK7set9KN3t6TpJSczi6ZEjc2XRrBv0LV02eYFVRyzj5XOVPnZqjViUqZFcjm55/WPvWKN2+v00CAXfkT/KnFhGKf/g=
X-Received: by 2002:a17:906:6886:b0:877:612e:517e with SMTP id
 n6-20020a170906688600b00877612e517emr802634ejr.152.1675264731224; Wed, 01 Feb
 2023 07:18:51 -0800 (PST)
MIME-Version: 1.0
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Wed, 1 Feb 2023 10:18:39 -0500
Message-ID: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
Subject: RE: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently updated to git 2.39.1 and noticed today that `git diff
--word-diff` fails for files with `diff=3Dscheme`. I was able to narrow
the failure down to the inclusion of control characters \xc0, \xff,
\x80, \xbf by https://github.com/git/git/blob/2fc9e9ca3c7505bc60069f11e7ef0=
9b1aeeee473/userdiff.c#L17
in the definition of the scheme diff pattern (really, all patterns).

I suspect the commit referenced in the subject, given that it messes
with regex handling on macOS.

Relevant environment that I can think of:
```
# locale
LANG=3D"fr_FR.UTF-8"
LC_COLLATE=3D"fr_FR.UTF-8"
LC_CTYPE=3D"fr_FR.UTF-8"
LC_MESSAGES=3D"fr_FR.UTF-8"
LC_MONETARY=3D"fr_FR.UTF-8"
LC_NUMERIC=3D"fr_FR.UTF-8"
LC_TIME=3D"fr_FR.UTF-8"
LC_ALL=3D"fr_FR.UTF-8"
```

I'm on macOS 11.7.

Failure (using Zsh to produce the characters; I think there's a Bash
equivalent):
```
# git diff --word-diff --word-diff-regex=3D$'[\xc0-\xff][\x80-\xbf]+'
fatal=C2=AC=E2=80=A0: invalid regular expression: [=C2=BF-=CB=87][=C3=84-=
=C3=B8]+
```
(Looks like the output is a bit scrambled; here's the hexdump)
```
# !! |& xxd
00000000: 6661 7461 6cc2 a03a 2069 6e76 616c 6964  fatal..: invalid
00000010: 2072 6567 756c 6172 2065 7870 7265 7373   regular express
00000020: 696f 6e3a 205b c02d ff5d 5b80 2dbf 5d2b  ion: [.-.][.-.]+
00000030: 0a                                       .
```

--=20
D. Ben Knoble
