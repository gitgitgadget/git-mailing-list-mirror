Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CFCD4F3B
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 09:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjIVJ2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjIVJ2F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 05:28:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7232BCE
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 02:27:59 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bf2427b947so1071682a34.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695374879; x=1695979679; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbdE7oKv7Wv+n1SY/6tK0EnsFRfTdv3G/M376S4j3RE=;
        b=B60hn9LPv+x6gZpC8IYbJVS5gdGYH1oCdFW3TZLl4g09/54s4T2fo4kP8K51KMkGnG
         T1c7DtTn03wWNJwca9MRb893BT1Zj6mvx1gxbcpAFZnUflApbLDAeA7iHpMbMbR5h79e
         4gSfisDaGcyb7Za41yyjlnZfbsLvF2Yvi8r3zeJEhUNQ6K5Zra47nOviXqdePqXbTo/l
         hcpu5iQjoIlPpYKenCfYFjRxZYuiY/IKgMn8i+A8q1GMgNdO03nP7PgbCJgFDgcUvuox
         O6rD1Owwrw79yKNIvCh2QJ/vrqmTaPu0kWWf8xOsFCqXbW/98cDU9Tfa8E1DvAKS+BMn
         4gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695374879; x=1695979679;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbdE7oKv7Wv+n1SY/6tK0EnsFRfTdv3G/M376S4j3RE=;
        b=cvXRlIJToE6pLlm6JoDc+okOJD4we6msM6wXC3NKerFZxoGmUzXU0q8kLuoIRLTJ7L
         lU14k3XL5mkQ0t/C6urvQ5ZW9/9Fvurz+uZxfSxoa5FkatuKTH8YdsU09us9FG/HLmcN
         AXAUEsUBJ+fi6jpXL01EruuG4I4f/2CHag45NbHDeYGrOv0VNWl60zmSjPDU/yCelE9O
         I57swTf0OemMpZVgFx7anUEkccuKmaRiq8wN9A2gfP4SxZM2YWb7q0VChzVNb+kJ25M6
         W5l22oESL1tDe5gUOHhcM+pIFRdSuRonSYZtCTo8e3KqmF7ZJucnmlawIWH2gya58KE1
         B9tw==
X-Gm-Message-State: AOJu0Yxk0XKgIL2Muqk8SdO4I0faHBQars/mB0wc5HiOHTAVMPxWnora
        7HbW0UQ2q/b4nA3V/mqBq0U=
X-Google-Smtp-Source: AGHT+IHQedyxLqAKXV6aQu5hdMIaHFsN/cp2yHmh+wpylabb/hvdLosDwWPYxmX2UzbwtJAGf6p8EA==
X-Received: by 2002:a05:6830:1156:b0:6b7:2515:e214 with SMTP id x22-20020a056830115600b006b72515e214mr8169431otq.34.1695374878706;
        Fri, 22 Sep 2023 02:27:58 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7880f000000b0067ab572c72fsm2765559pfo.84.2023.09.22.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:27:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6919681B96C9; Fri, 22 Sep 2023 16:27:55 +0700 (WIB)
Date:   Fri, 22 Sep 2023 16:27:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Message-ID: <ZQ1eGzqfyoeeTBUq@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QIuKOG7QKIAt7faq"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QIuKOG7QKIAt7faq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This regression is similar to one I reported earlier [1], with the same
error message but with slightly different reproducer (and as continuation
to the former report).

I use git-send-email(1) to submit patches (occasional doc fixes) to LKML.
Rather than having to type multiple --to/--cc addresses, I use the undocume=
nted
behavior of listing multiple addresses separated by comma in a single --to/=
--cc
option. i.e.:

```
$ git send-email \
  --to=3D"foo <foo@acme.com>,bar <bar@acme.com>" \
  --cc=3D"main list <main-list@acme.com>, sub list <sub-list@acme.com>" \
  /path/to/series/*.patch
```

[This is the same behavior as Thunderbird.]

In my linux kernel tree (linux.git) used for development, I add
sendemail-validate hook that adds DKIM-like attestation with patatt:

```
#!/bin/sh
# installed by patatt install-hook
patatt sign --hook "${1}"
```

Starting from Git v2.41.0, when I try to use git-send-email(1), I got
perl-related error:

```
Use of uninitialized value $address in sprintf at /home/bagas/.app/git/dist=
/v2.42.0/libexec/git-core/git-send-email line 1172.
error: unable to extract a valid address from:
```

It looks like git-send-email(1) trips on cover letter since there is no
recipient addresses there, and also on patches without Signed-off-by: trail=
er.

Bisecting between v2.40.0 and v2.41.0, the culprit is commit a8022c5f7b67
(send-email: expose header information to git-send-email's sendemail-valida=
te
hook, 2023-04-19). The perl error should have been reduced by [2], but this
address splitting (parsing) is still not addressed.

The full bisection log is:

```
git bisect start '--term-good=3Dok' '--term-bad=3Doops'
# status: waiting for both good and bad commits
# ok: [73876f4861cd3d187a4682290ab75c9dccadbc56] Git 2.40
git bisect ok 73876f4861cd3d187a4682290ab75c9dccadbc56
# status: waiting for bad commit, 1 good commit known
# oops: [fe86abd7511a9a6862d5706c6fa1d9b57a63ba09] Git 2.41
git bisect oops fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
# ok: [b64894c2063e5875bfd95b537eafcb3e1abf46ff] Merge branch 'ow/ref-filte=
r-omit-empty'
git bisect ok b64894c2063e5875bfd95b537eafcb3e1abf46ff
# ok: [ccd12a3d6cc62f51b746654ae56e26d92f89ba92] Merge branch 'en/header-sp=
lit-cache-h-part-2'
git bisect ok ccd12a3d6cc62f51b746654ae56e26d92f89ba92
# oops: [1e1dcb2a423cad350e8f20fdcc957064e5cff528] Merge branch 'jc/dirstat=
-plug-leaks'
git bisect oops 1e1dcb2a423cad350e8f20fdcc957064e5cff528
# oops: [40a5d2b79b57378cc36d43d3b30e704100dc1492] Merge branch 'fc/doc-man=
-lift-title-length-limit'
git bisect oops 40a5d2b79b57378cc36d43d3b30e704100dc1492
# ok: [07ac32fff94b245aec3e2b80efad0b5dada629cb] Merge branch 'ma/gittutori=
al-fixes'
git bisect ok 07ac32fff94b245aec3e2b80efad0b5dada629cb
# oops: [7f3cc51b284d696fdb8dfbd8c9f9d0c014019d93] Merge branch 'ar/test-cl=
eanup-unused-file-creation-part2'
git bisect oops 7f3cc51b284d696fdb8dfbd8c9f9d0c014019d93
# oops: [b6e9521956b752be4c666efedd7b91bdd05f9756] Merge branch 'ms/send-em=
ail-feed-header-to-validate-hook'
git bisect oops b6e9521956b752be4c666efedd7b91bdd05f9756
# ok: [e2abfa7212525daa24a52d9f53c45b736abb5dfe] Merge branch 'hx/negotiato=
r-non-recursive'
git bisect ok e2abfa7212525daa24a52d9f53c45b736abb5dfe
# oops: [a8022c5f7b678189135b6caa3fadb3d8ec0c0d48] send-email: expose heade=
r information to git-send-email's sendemail-validate hook
git bisect oops a8022c5f7b678189135b6caa3fadb3d8ec0c0d48
# ok: [56adddaa06d376f3977ee91e8a769cd85439d21c] send-email: refactor heade=
r generation functions
git bisect ok 56adddaa06d376f3977ee91e8a769cd85439d21c
# first oops commit: [a8022c5f7b678189135b6caa3fadb3d8ec0c0d48] send-email:=
 expose header information to git-send-email's sendemail-validate hook
```

To reproduce this regression:

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
   $ git send-email --to=3D"foo <foo@acme.com>,bar <bar@acme.com>" /tmp/tes=
t/*.patch
   ```

My system runs Debian testing (trixie/sid) with perl 5.36.0.

Thanks.

[1]: https://lore.kernel.org/git/ZQhI5fMhDE82awpE@debian.me/
[2]: https://lore.kernel.org/git/545729b619308c6f3397b9aa1747f26ddc58f461.1=
695054945.git.me@ttaylorr.com/

--=20
An old man doll... just what I always wanted! - Clara

--QIuKOG7QKIAt7faq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZQ1eEAAKCRB7tWyQc2rT
CIyYAQDZ5uLgGeilWbSLlyIf4UN2ov6hkTQ/mLz+tC51q2/xJgEAsbzv28L/w8BL
ZDfYw++vnaGvPl1trB9GBk6sEsaKdQE=
=k0Ap
-----END PGP SIGNATURE-----

--QIuKOG7QKIAt7faq--
