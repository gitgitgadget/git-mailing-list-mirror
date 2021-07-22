Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B2C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE4F61287
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 10:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhGVJnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhGVJnE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 05:43:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A7C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 03:23:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so3586191pjz.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=EO3hvB8LLSWOwtdV7ItEqB2Df4csYI3HqbQKdc3Usl8=;
        b=KhyTVc460UPyaadTgWB/VoHdrHmcyn1QJ8W3Yfy7dX+Ljfj6ySay8eB6wMXAiEqKGs
         U2NmyGfFJIdB9uizwdzIWubdorrUoM8m6IuBzkTwueqGl3w75Vs9vTEnI5jzojwM3ZE1
         njOKaOWPhRlu7/ijB7sIiMAl93C5/nzj/n3CFMns2Vz92NjmA004Pm4w5V3bAPqEfBVO
         lU75KCxf8gB8kyLjjqW4l5Bjp80iv9+u0L3ORgBRadID69S7wmaw9+0CCJpT74WhryO5
         tVrSqZuRsm/LbaEEsnOKSmHwuD4E2N4bNB0AIFsHuOjrNc+0zqIOvLXxQ8UHJbl33Qxg
         LO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=EO3hvB8LLSWOwtdV7ItEqB2Df4csYI3HqbQKdc3Usl8=;
        b=eyNNgq2qrTC4hCqcFZWRFXFsp+8Cpijzq/ACdXoLzV5ob53ttaJzB4bkTu2lb+q21k
         Id8HJO30IkhIyskyhOfL066UPEeMQjb4JTgG30Pf6M1jYX0Jp+bNrp8HDOBO1VpxMrRD
         SZ0B0NMrleTWmCT5kzVUIRwYKvteeJeM6HDsyEnFjpZPiKnfU4htsf0hoiMA2b+z3nFn
         ZriAr6728ZrkdyMMPQmVibjRauZ9tFvocoe7cE0yHLlCqomZHq65OEQK2SOTzB1Xp2Hv
         W9edzJ2LWA3TXKQQQrkhnzIa2qwEBX1dr/uHhRIF1PghoRaMqSzSQ1jeEiFXqCGhtaYE
         i1Eg==
X-Gm-Message-State: AOAM5310y5fNwAV0R31+lyes0at+OgviV5BQOZAcMtuzt+WClURaf73M
        lgb7ro6IZrL7N0wylumLmz1Wlu6xwjqXPg==
X-Google-Smtp-Source: ABdhPJy3Lu5nMOc6BC2P8TxVlOpkfmOOSVAFGQH3tURedcwcCpG9X2XewNhoxiHagSXps5EYIorNBQ==
X-Received: by 2002:a63:44a:: with SMTP id 71mr11893333pge.259.1626949419140;
        Thu, 22 Jul 2021 03:23:39 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm32257040pgm.15.2021.07.22.03.23.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 03:23:38 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: [BUG?] submodule-config.c:config_from() has left me confused
Message-Id: <FB8C1154-6092-48C7-96B8-6B6D9A28D9AA@gmail.com>
Date:   Thu, 22 Jul 2021 15:53:35 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Developers,

While I was working on converting submodule code from shell to C, I had
a question about the submodule-config API.

The usual way of obtaining the submodule configuration is by using the
'submodule_from_path()' or 'submodule_from_name()' functions. Taking the
example of the former, a call to it would look something like:

const struct submodule *sub =3D submodule_from_path(repo, oid, =
path-to-submod);

So my first question is what is the exact purpose of the second
argument?

The API docs say it should be a tree-ish:

   Given a tree-ish in the superproject and a path, return the submodule =
that
   is bound at the path in the named tree.

My guess is that the tree-ish that we pass lets us obtain the submodule
configuration for that specific commit or tree in the superproject.

Looking at the underlying implementation[1], it seems to me that the =
'oid'
argument treats the 'null_oid()' specially to mean "get the =
configuration from
the latest revision".

While I had these questions, Christian noticed a possible bug in the
implementation[2]:

---8<------8<------8<------8<---

> It seems to me that config_from() in submodule-config.c accepts a path =
or a
> tree oid and submodule_from_path() just calls config_from().
>=20
> By the way it seems to me that config_from() is buggy when it's passed =
a
> tree oid as it does:
>=20
> ```
>         if (!gitmodule_oid_from_commit(treeish_name, &oid, &rev))
>                 goto out;
> ```
>=20
> but gitmodule_oid_from_commit() returns 0 on success so instead of =
doing a
> `goto out` which will error out, it should continue to proceed using =
the oid
> it got. So I think it should be something like:
>=20
> ```
>         if (gitmodule_oid_from_commit(treeish_name, &oid, &rev)) {
>                 switch (lookup_type) {
>                 case lookup_name:
>                         submodule =3D cache_lookup_name(cache, &oid, =
key);
>                         break;
>                 case lookup_path:
>                         submodule =3D cache_lookup_path(cache, &oid, =
key);
>                         break;
>                 }
>                 if (submodule)
>                         goto out;
>         }
> ```
>=20
> Or maybe the gitmodule_oid_from_commit() call should be moved after =
the switch ().

---8<------8<------8<------8<---

I do agree that it looks wrong, but despite that, it still seems to pass =
't7411' [3][4].

This should have failed according to my understanding:

cat >super/expect <<EOF
Submodule name: 'a' for path 'a'
Submodule name: 'a' for path 'b'
Submodule name: 'submodule' for path 'submodule'
Submodule name: 'submodule' for path 'submodule'
EOF

test_expect_success 'test parsing and lookup of submodule config by =
path' '
	(cd super &&
		test-tool submodule-config \
			HEAD^ a \
			HEAD b \
			HEAD^ submodule \
			HEAD submodule \
				>actual &&
		test_cmp expect actual
	)
'

Since HEAD and HEAD^ are valid tree-ish objects, the =
gitmodule_oid_from_commit()
line should have returned early with a NULL object, but that does not =
happen.
The output seems to match what I would expect from the API.

Applying Christian's suggestions pass the same test as well.

I also wonder what is the situation with the case where, the oid is =
non-null
and invalid?

If we look at the code again:

static int gitmodule_oid_from_commit(const struct object_id =
*treeish_name,
				     struct object_id *gitmodules_oid,
				     struct strbuf *rev)
{
	int ret =3D 0;

	if (is_null_oid(treeish_name)) {
		oidclr(gitmodules_oid);
		return 1;
	}

	strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
	if (get_oid(rev->buf, gitmodules_oid) >=3D 0)
		ret =3D 1;

	return ret;
}

...what happens to the value of gitmodules_oid when get_oid() fails?

*If* it is set to NULL, it would probably lead to undefined behaviour =
when
we try to hash the oid for the submodule cache lookup in [1]. If it is =
set
to 'null_oid()' or zero'd out (like with oidclr()), then it should =
return
the submodule from the latest revision, which does not seem desirable, =
as
the input is invalid.

Is this a bug in my understanding or in the program? Or is it a bit of =
both?

Footnotes:
---------

[1]: =
https://github.com/git/git/blob/daab8a564f8bbac55f70f8bf86c070e001a9b006/s=
ubmodule-config.c#L545-L615
[2]: =
https://github.com/tfidfwastaken/git/commit/7ad7a9d1d03653aadfdc87b60e3a15=
2b1cb37f22#r53637226
[3]: https://github.com/git/git/blob/master/t/t7411-submodule-config.sh
[4]: =
https://github.com/git/git/blob/master/t/helper/test-submodule-config.c

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

