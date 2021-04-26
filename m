Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E4C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF616127A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhDZObp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhDZObo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:31:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC85C061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:31:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so2325583edn.7
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=piZ7AreG4oucu7Ed/yI0KWprhr+1d9XQCBtniHLaHac=;
        b=pskvKj4N1ll2yJ6iZxhESKq8oRzIlP5Ig2Cj0Hslfc926SEfol4YyarkbUeyTDwoGK
         7BkqhFDZdAMERTS5mAy8au2gCiVYy27rdhJxEzAxqr9REvAO/QrlFHO2+Rx99eW+9jyH
         eI+fCZB7Vh828clboIy4uMLUgRAGeM8sp8pIPhm68zsr+RCzn2GshyhUgjLSWk2jpsZK
         Rwxdrm1vqKHQ0AlEif/AmR4pQ2duMIYoIF/bzVmvS3q93746sn/NpTsG5M7nrZEXu0k2
         mEB5OJjKcIbhLjwJPVsHAWiD1Q17/45T4kIPp6EIRcffs6AChhKH9lce4WbEo1fCh0X9
         /0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=piZ7AreG4oucu7Ed/yI0KWprhr+1d9XQCBtniHLaHac=;
        b=lvW9CsMFtnpREOBNdGDczbOhYJONvkViE20fR/QAVTPYyCcn1SMqDJJQkXNmSaRmXu
         /2m7+19ZHPzUKGis6BPTZYaO5vPHM/+s3QCvdd/ezO8qeXlu6uL65vrlSDQEGaUxs397
         3DAJl3IVklqsjlKw6HvfCz1pu8ko2zXrRaljRbHOF83Fb1VcizD2AZoD/qHuAXVnf5C8
         07P7AD4eE0HUiO4D23k5EBSyP//3+dq2soBgtU/9uRQiVTzEGqWjQrWaoUG1U/fk0Ec3
         cY0JRqM9GS1Pa4d1ahNKQ+p/MPxsU7U18h7QelQlNkbdSYgMZbw3n4hSOjLAycnZS6If
         ZWfg==
X-Gm-Message-State: AOAM533/WiHX8FbhYEAhQqStuj/wsueuQSGNaBa1Y6Af0/TaCv8KlVr6
        Xo0kF8HAG2ME5a8DQ0ob1mw=
X-Google-Smtp-Source: ABdhPJzz7i9KaMB3wdUMDVhJ3B2AM6t1/hdBCF5hXvN4qSVa41QBpUi0SNKwzE5N3KrLZiQZzbUtWg==
X-Received: by 2002:a50:fd0c:: with SMTP id i12mr21903384eds.103.1619447460277;
        Mon, 26 Apr 2021 07:31:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u9sm13892edq.68.2021.04.26.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 07:30:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 5/6] fsck: report invalid types recorded in objects
Date:   Mon, 26 Apr 2021 16:28:30 +0200
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
 <patch-5.6-5fb6ac4faee-20210413T093734Z-avarab@gmail.com>
 <YILbk34nwqCPmxGQ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YILbk34nwqCPmxGQ@coredump.intra.peff.net>
Message-ID: <87im493yos.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, Jeff King wrote:

> On Tue, Apr 13, 2021 at 11:43:08AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Continue the work in the preceding commit and improve the error on:
>>=20
>>     $ git hash-object --stdin -w -t garbage --literally </dev/null
>>     $ git fsck
>>     error: hash mismatch for <OID_PATH> (expected <OID>)
>>     error: <OID>: object corrupt or missing: <OID_PATH>
>>     [ other fsck output ]
>>=20
>> To instead emit:
>>=20
>>     $ git fsck
>>     error: <OID>: object is of unknown type 'garbage': <OID_PATH>
>>     [ other fsck output ]
>
> Sounds good.
>
>> @@ -92,7 +93,8 @@ static int cat_one_file(int opt, const char *exp_type,=
 const char *obj_name,
>>  	switch (opt) {
>>  	case 't':
>>  		oi.type_name =3D &sb;
>> -		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
>> +		ret =3D oid_object_info_extended(the_repository, &oid, &oi, flags);
>> +		if (!unknown_type && ret < 0)
>>  			die("git cat-file: could not get object info");
>>  		if (sb.len) {
>>  			printf("%s\n", sb.buf);
>
> Surprised to see changes to cat-file here, since the commit message is
> all about fsck. Did the semantics of oid_object_info_extended() change?
> I.e., this hunk implies to me that it is now returning -1 when we said
> unknown types were OK, and we got one. But in that case, how do we
> distinguish that from a real error?
>
> Or more concretely, this patch causes this:
>
>   $ git cat-file -t 1234567890123456789012345678901234567890
>   fatal: git cat-file: could not get object info
>
>   $ git.compile cat-file --allow-unknown-type -t 123456789012345678901234=
5678901234567890
>   fatal: git cat-file 1234567890123456789012345678901234567890: bad file
>
> Or much worse, from the next hunk:
>
>   $ git cat-file -s 1234567890123456789012345678901234567890
>   fatal: git cat-file: could not get object info
>
>   $ git cat-file --allow-unknown-type -s 12345678901234567890123456789012=
34567890
>   140732113568960
>
> That seems wrong (so I think my "this hunk implies" is not true, but
> then I am left with: what is the point of this hunk?).

That's very well spotted.

I started re-rolling this today but ran out of time. For what it's worth
the combination of this and 6/6 "makes sense" in the sense that all
tests pass at the end of this series.

But the cases you're pointing out are ones we don't have tests for,
i.e. the combination of "allow unknown" and a non-existing object, as
opposed to a garbage one.

Hence the bug with passing up an invalid (uninitialized) size in that
case. It's fallout from other partial lib-ification changes of these
APIs, i.e. making them return bad values upstream instead of dying right
away.

I'll sort that out in some sensible way. Starting with adding meaningful
test coverage for the existing behavior.

