Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25425CD13DD
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 12:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbjIRM47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 08:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241509AbjIRM42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 08:56:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81839D1
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 05:56:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fbbea0dfeso3377229b3a.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695041772; x=1695646572; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Z4yHmZRRbaAjgz0qSUslqCsPtiUDzye9TEF2JkZLUo=;
        b=WVuiAXVN2jO+FeREDMWlZ7F/7pbz5H6DaTyVHdZXypujEkkEq+FJg/rHbk2xCDQfmg
         +cw1k6YkFJPJzK30KJFXj5SWTXWZE6A8D+dS2jTy23b52mj+L0FMPobCZ/T89HckU3bJ
         QHLM0xacITsGbwdH3+CpXQe/012m+QJ4uX5EGlEcnDnqRJSOsC9YUXP3EE/DXeFIQFqd
         /NlnW5xmgZb2c5Ws+fCq1YQ6YWK+Nw8VgwpW+ckAMRbYJMHnDiuxkpWqMWqSOjGGKwpF
         ySLwEgf7A48ddGEfYg87bNgFiJW4zOxPtK7P7h7qheeZub3HiXjw4luZHgC+d1LQQvP9
         Sf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041772; x=1695646572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z4yHmZRRbaAjgz0qSUslqCsPtiUDzye9TEF2JkZLUo=;
        b=pSQ2FvyOjtFYJOpWqRHwZihfyCsCJDdgnxVxEcgyGLSCLWhpPnbiN7emL1PE9SvKvn
         7YlzCaCAI2tec8QXdoCYLYifVrc6nUXcnfjaQMlUi6XVSCAMoHvkDAeXDeeqglioifA6
         R+c9EjRI/et2W9SvWwnkcKzkQn1+/FmNWTa0EB51Dn1Ie7XvYfRNO1MCKLQDK01QTHCS
         hB91YnktapTQ8FZPA347xSTARfxL09yp2fzez7dwYLgT7w7/ZpxVFx9FhmDTm6WdmhVW
         slynfJShQW/RdhaBR4C9TmOL9U649wNG9fITQn9BxWhWQTlU1i6APl2jd7uPxNB4DY8N
         jmig==
X-Gm-Message-State: AOJu0Yyiz5LSnBLI3ieMNPGnZBmysRbUnFzwH+xZLWOaV60osil62lZm
        ZHeo4u4dIz5LLOgGmd3CL7Q=
X-Google-Smtp-Source: AGHT+IFU2UI2IjuzktFX48ee7mkuwj6XLz+fOSo0FYydX44KwNZ3aPbIiRJUd/wTOf4Dtd+pimrujQ==
X-Received: by 2002:a05:6a00:c90:b0:68f:e0f0:85f4 with SMTP id a16-20020a056a000c9000b0068fe0f085f4mr7059120pfv.25.1695041771889;
        Mon, 18 Sep 2023 05:56:11 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id u9-20020a62ed09000000b0068fe39e6a46sm7047065pfh.112.2023.09.18.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:56:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EBB6181B96E6; Mon, 18 Sep 2023 19:56:05 +0700 (WIB)
Date:   Mon, 18 Sep 2023 19:56:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [REGRESSION] uninitialized value $address in git send-email
Message-ID: <ZQhI5fMhDE82awpE@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQ3VZLSXmo3MUHbg"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LQ3VZLSXmo3MUHbg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Recently when I was submitting doc fixes to linux-doc mailing list [1]
using git-send-email(1), I got perl-related error:

```
Use of uninitialized value $address in sprintf at /home/bagas/.app/git/dist=
/v2.42.0/libexec/git-core/git-send-email line 1172.
error: unable to extract a valid address from:
```

My linux.git clone has sendemail-validate hook which uses patatt (from b4
package). The hook is:

```
#!/bin/sh
# installed by patatt install-hook
patatt sign --hook "${1}"
```

This issue occurs on Git v2.41.0 but not in v2.40.0. Bisecting, the culprit=
 is
commit a8022c5f7b67 (send-email: expose header information to git-send-emai=
l's
sendemail-validate hook, 2023-04-19). Emily's earlier report [2] also point=
s to
the same culprit, but with different bug.

I triggered this issue on patch series with cover letter. To reproduce:

1. Clone git.git repo, then branch off:

   ```
   $ git clone https://github.com/git/git.git && cd git
   $ git checkout -b test
   ```

2. Make two dummy signed-off commits:

   ```
   $ echo test > test && git add test && git commit -s -m "test"
   $ echo "test test" >> test && git commit -a -s -m "test test"
   ```

3. Generate patch series:

   ```
   $ mkdir /tmp/test
   $ git format-patch -o /tmp/test --cover-letter main
   ```

4. Send the series to dummy address:

   ```
   $ git send-email --to=3D"pi <pi@pi>" /tmp/test/*.patch
   ```

git-send-email(1) trips on the cover letter since there is no recipient
addresses detected. It also errored out on patches without Signed-off-by
trailer. When the command should have been succeeded, I expected that it
asked me whether to send each patch or not.

My system runs Debian testing (trixie/sid) with perl 5.36.0.

Thanks.

[1]: https://lore.kernel.org/linux-doc/20230918093240.29824-1-bagasdotme@gm=
ail.com/
[2]: https://lore.kernel.org/git/CAJoAoZ=3DGGgjGOeaeo6RFBO7=3D6msdRf-Ze6Xcn=
L04K5ugupLUJA@mail.gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--LQ3VZLSXmo3MUHbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZQhI3wAKCRB7tWyQc2rT
COSnAQDiv3K2vicSLAwcX3AcdMP21mjdhw841j+tKk2ORd4tYAEApC+W9hag7fm/
DKA5exxCeaD9/OJgwdobUEbKqs+Wowk=
=ZBaG
-----END PGP SIGNATURE-----

--LQ3VZLSXmo3MUHbg--
