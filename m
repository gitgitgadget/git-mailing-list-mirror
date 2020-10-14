Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2AAC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A05322201
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGiln0XF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbgJNNKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgJNNKH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 09:10:07 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A3C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:10:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r10so4942633ilm.11
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Na2gwxg4PPc9iJNHf9zNMpQ/KhtAEMu+j40rr667xrQ=;
        b=kGiln0XFli5c+zTLSIYJu5z4K0lIV/LPXcmVoBHsMVgJKwo3c431226arlH7CgFuak
         3q2/MLAZwRE1UpF1rpFE/KEtgca5acIjmPIY25q7PugyHCe/yG8awPCCu4f5B1oJb4Z0
         SzT+5iBj+A921O0MWgRtmtSqQkwEdyQFjb9HEiOlk/JbN/0tYRkdE6vOpvwAAJgTSZnQ
         RjawzFj/42LCMJL/4JEY0oQZzrKK4u2Taue55MSBo0NXCNXX4/VSfNyvxXtfqKKb2VJC
         BQ9kGZfiyVc10Bfv750g1u51GRvOYV9ALYFLxAX25CN+kwLz5YRJkzp56xL32R5/Fgto
         XENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Na2gwxg4PPc9iJNHf9zNMpQ/KhtAEMu+j40rr667xrQ=;
        b=LHR5NTK/3I6e6rO28MCor7YX6ZVoZ+QDb3Fv11TO98ri5cwdEI2rqr7sTsYW8tGs7j
         qyGB8V1d9SJgQT/GeZud9H5ZmUze41m7x7y6o5UgwQ82gyNzl5lEtcNDbSxBywWR/kG9
         YRcxwRsqvJeFtO1YSjNwvUuf6jrZLAquOR8y/Fj1jOWj3bYhk+O/sJ9IiNdv4K27TYND
         zyuopiMrs4VfsDqgghgQAEI3SnlThh6JkURzYkURd+Yxv4lSBRB3Oz6MJG5pfqo6FyOo
         MMlcsHT10mjcrEJiG6aWb16lZltQchlS63ORQYow4c1kLBsbqcYsDF+zDL/u01rt5P/x
         X7zg==
X-Gm-Message-State: AOAM533N2ThXSq8KepzxS4fQH9wiTxOXoDyfajtzxzIzDrEGAruCaVOj
        QbAq82MwMTDWx5xKipW7oJ0=
X-Google-Smtp-Source: ABdhPJwQrr1/+lOKWrFZIsOxg9PiAkvJqdxrBy+SxnN26td7kzm5z92GEQ7Fvj4AC6WHxNzFOcbO7g==
X-Received: by 2002:a05:6e02:966:: with SMTP id q6mr573518ilt.21.1602681005164;
        Wed, 14 Oct 2020 06:10:05 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id b2sm2824481ila.62.2020.10.14.06.10.02
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 06:10:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 2/3] ref-filter: handle CRLF at end-of-line more gracefully
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqh7qzm6ai.fsf@gitster.c.googlers.com>
Date:   Wed, 14 Oct 2020 09:09:59 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1902E2D2-5265-48BC-877F-21B6C2D201B1@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com> <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <11d044a4f7feccdf20da6364a1f9bbe934e9981f.1602526169.git.gitgitgadget@gmail.com> <xmqqh7qzm6ai.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 12 oct. 2020 =C3=A0 18:24, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> -	for (i =3D 0; i < len; i++)
>> -		if (r[i] =3D=3D '\n')
>> -			r[i] =3D ' ';
>> +	for (int i =3D 0; i < len; i++) {
>=20
> We do not allow this in our codebase (yet).
>=20
> cf. Documentation/CodingGuidelines
>=20
> - Declaring a variable in the for loop "for (int i =3D 0; i < 10; =
i++)"
>   is still not allowed in this codebase.

Indeed. Will fix (and re-read the guidelines).

>=20
>> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
>> index 71818b90f0..c06eca774f 100755
>> --- a/t/t3203-branch-output.sh
>> +++ b/t/t3203-branch-output.sh
>> @@ -3,13 +3,11 @@
>> test_description=3D'git branch display tests'
>> . ./test-lib.sh
>> . "$TEST_DIRECTORY"/lib-terminal.sh
>> +. "$TEST_DIRECTORY"/lib-crlf-messages.sh
>>=20
>> test_expect_success 'make commits' '
>> -	echo content >file &&
>> -	git add file &&
>> -	git commit -m one &&
>> -	echo content >>file &&
>> -	git commit -a -m two
>> +	test_commit one &&
>> +	test_commit two
>> '
>=20
> What does this change have to do with the topic at hand?

In the previous iteration, the expected output of one of the tests
I was adding had commit hashes,=20
so the change above was necessary to make those hashes reproducible.
However in this series I removed the hashes from the expected output
because it would break the "linux-clang" CI job which runs with SHA-256.

Maybe we should add a note in t/README specifically saying that raw =
commit
hashes should not appear in expected output, but use $(git rev-parse =
"${ref}")
instead ? Could this be a preparatory patch, or would deserve a separate =
topic ?

