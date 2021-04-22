Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760BDC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 12:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA8A6121E
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 12:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhDVMqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbhDVMqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 08:46:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158FFC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 05:45:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d21so33194960edv.9
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=F12bxKiR0fapcYJ1S4UPgF6v/Cw1NjME9jUVbzxzzJo=;
        b=vS5PyXmSDzvQHOmlEP4ZKWiEIQib1ZAv16udJL+tdXtLFUB8O31qpKqMLGrMcZnE8O
         +EzWbLvjxNdo59+W0ez8Px8M4/O7cMAm/AkaNLPzvXYp6VnNwpqxDaqc70uDNx2TxXyV
         XCEJ/NeVr4lQfRnX7uj8VaRNVbUfCHY+NMQ/+P47oawWgzJLSEk6GbzL9n6uQdr8MBai
         7AoSQ+AvkeJls8VTI9BjVTarwQE9VQnrCw50EsNaDYd45SX7a7/O13aHK5wQYN8L/pES
         3RGMauwKiB7S82ms5bmzxviKiGYbFFGyGlv6dt9H46JoV1uP5POKk99nw5FmhTCtgG6I
         GfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=F12bxKiR0fapcYJ1S4UPgF6v/Cw1NjME9jUVbzxzzJo=;
        b=KuXAYVYPC6R0Kv61mWir1+qKj/CWb4Tbo+7cjguXVqs+pjO0HlKTbBAutbnqyYsjcp
         dmKsq9FYSvgXHyYTxaON3EUwlabkj0teQ7jL8VAseJqj3PzC+nHxnMzsKoSSZQDL4p4R
         mBaGVZ4J+PJvnBdyJtpb6wxw7SoVJsZwfMUHUG7xjkYZKAKUUGtluA0JqY7hT4TeD2au
         bZc9N5SJb0xPeuZEup85LsTBjZfzap3khnO/FymhGjdubHlNKeP1A5sry7pzMZrtLkMt
         bsbZCadIjJHE99GIHN6gjttqvNrp4sJBoWea+G27jL/wXYdGhjTEni/SKbW2I8qgh4FU
         M0hA==
X-Gm-Message-State: AOAM531JTSczGKW1/Fi9hpNnojf975pdnnFByH6HHbpK9kJvlKSjr3SA
        cEs8q/gW/LchyetPTuFy1D0=
X-Google-Smtp-Source: ABdhPJwQuMa7P8VG14QF62Hi/9YuqxlSoJadXy33NaMSEdhvCvOIkfhbLMvLwNpVKAtxiRy+wfOqsQ==
X-Received: by 2002:aa7:c683:: with SMTP id n3mr3566273edq.214.1619095536739;
        Thu, 22 Apr 2021 05:45:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w13sm2031910edc.81.2021.04.22.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 05:45:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
References: <YIAAzJTG1UitiWyu@danh.dev>
 <20210421104102.3409-1-congdanhqx@gmail.com>
 <20210421104102.3409-2-congdanhqx@gmail.com>
 <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
Date:   Thu, 22 Apr 2021 14:45:35 +0200
Message-ID: <87sg3i1o9c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, Eric Sunshine wrote:

> On Wed, Apr 21, 2021 at 6:41 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
> <congdanhqx@gmail.com> wrote:
>> We will lose the exit status of "git ls-files" if it's being run in
>> anywhere-but-not-final part of a pipe.
>>
>> Let's send the output of "git ls-files" to a file first,
>> and adjust the expected result for "git ls-files -o" since a new
>> untracked file will be created as a side effect.
>>
>> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>
>> ---
>> diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
>> @@ -631,20 +663,33 @@ test_expect_success 'check handling of differently=
 renamed file with D/F conflic
>> -               test 5 -eq "$(git ls-files -s | wc -l)" &&
>> -               test 3 -eq "$(git ls-files -u | wc -l)" &&
>> -               test 1 -eq "$(git ls-files -u one~HEAD | wc -l)" &&
>> +               git ls-files -s >output &&
>> +               test_line_count =3D 5 output &&
>> +               git ls-files -u >output &&
>> +               test_line_count =3D 3 output &&
>> +               git ls-files -u one~HEAD >output &&
>> +               test_line_count =3D 1 output &&
>
> This idiom crops up so frequently in this test script that it almost
> begs for the introduction of a helper function rather than applying
> the manual transformation repeatedly. For instance, the helper might
> be called like this:
>
>     count_ls_files 5 -s &&
>     count_ls_files 3 -u &&
>     count_ls_files 1 -u one~HEAD &&
>     ...
>
> The nice thing about having a helper function is that it can clean up
> after itself by not leaving a new file lying around, thus you wouldn't
> have to make adjustments to the expected number of untracked files (as
> mentioned in the commit message). If this is the sort of thing which
> comes up often enough (if there are more such cases beyond the two
> scripts you changed in this series), then it might make sense to
> promote the helper function to test-lib-functions.sh.

Agreed, but I'd saythat it makes more sense to have something like:

	test_line_count =3D 1 -- git ls-files

Or maybe another function, but in any case not something specific to
ls-files, but just a wrapper like the various "$@" wrappers in
test-lib-functions.sh to count the lines emitted by an arbitrary
command.

It would also leave things open for:

    test_line_count --stout=3D1 --stderr=3D2 -- git ls-files
    test_line_count --combined=3D3 -- git ls-files

Or whatever, to count the different output streams.

