Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16820C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3ED6124B
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhEaPbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbhEaPZw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:25:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FAC043452
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:16:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jt22so16937387ejb.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bpicDOFH4XjPCTQHW2gzbOGOw/VUjoOEkIcy9LQuCxw=;
        b=Q2tT3V1mKhlDJyfuturpfsup6ijlhr3wx4E6lnemktnM26AMAs+4pdE07XKAsszSP6
         IxXe10G0iq5LxkcvK4c+bq3mUsOHwfAO333F5nA1a77Atty3NNPTAZj6X5z40W7l1vAq
         tF1qhzEEHCR/wnXx265UsCIcNtHiFMljDPBObiviY7Ld/aJMXCmqRc2g/DjlgqhoErw3
         Pl761RnDVUjpZ+SC8q7+4fsETLVXLvkAwArrz5upCU1QtWxjEaOrHl5SAGYweYhi8nKF
         ExvV72gDzm5bTwPSkELp2NZMrZ+d1+Qqw6zHuSbJy82ttf4VaBVK+ZHtY49e4Hl2X9Ct
         NWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bpicDOFH4XjPCTQHW2gzbOGOw/VUjoOEkIcy9LQuCxw=;
        b=WeH6uJury8uWTzrH9NUJO/tB8bhN9NYiHL44m6wk7XxtCjwbQ7HYcsrzWfJI0hif4Y
         ZcS3Qk5kB027xvO/KjAeq+4OfHjvv8bO8enzjp7WEUQldI6gigS/jtF2VnHA8CGVJYvm
         kIHZRBdGKH7YIW8F9PFx7THKIGKUT8vbXUytWo4oCSpuCZZATSxqUliAmh3Jo8AhozB0
         lLxukdVuzdN+CXfKOFvfhnb28Lu4D80QxMWC2Qc+PL5a2FOhimBsTRXsU1+F0kUAva3m
         utI6uQJFoFGHTPS7urvaK0I7S/I6GZQrKb71unsQ70fZIlB7O6i7ulkF0v4KoR8fmeS7
         MXfQ==
X-Gm-Message-State: AOAM5309EXEa0Mh7sTmFmOH1DkTUDRb7RX2gC450xtryVnPMB7IS/9Oq
        h9nTWDK7Cbqbcgaf6LLefMZ/XMttFzA=
X-Google-Smtp-Source: ABdhPJwNeG1RrhR19MhPSAwrAWZ/rGyeWqA8ptkZCQ14gA+E0IJLgPfImBjvWqHxAhmO3pfJ/soiiA==
X-Received: by 2002:a17:907:2815:: with SMTP id eb21mr19939891ejc.270.1622470559199;
        Mon, 31 May 2021 07:15:59 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t18sm1924757edw.47.2021.05.31.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 07:15:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Date:   Mon, 31 May 2021 16:01:01 +0200
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <87r1hsl4qb.fsf@evledraar.gmail.com>
Message-ID: <871r9n2dlu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 27 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, May 26 2021, Matheus Tavares wrote:
>
>> t2080 makes a few copies of a test repository and later performs a
>> branch switch on each one of the copies to verify that parallel checkout
>> and sequential checkout produce the same results. However, the
>> repository is copied with `cp -R` which, on some systems, defaults to
>> following symlinks on the directory hierarchy and copying their target
>> files instead of copying the symlinks themselves. AIX is one example of
>> system where this happens. Because the symlinks are not preserved, the
>> copied repositories have paths that do not match what is in the index,
>> causing git to abort the checkout operation that we want to test. This
>> makes the test fail on these systems.
>>
>> Fix this by copying the repository with the POSIX flag '-P', which
>> forces cp to copy the symlinks instead of following them. Note that we
>> already use this flag for other cp invocations in our test suite (see
>> t7001). With this change, t2080 now passes on AIX.
>>
>> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> ---
>>  t/t2080-parallel-checkout-basics.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-chec=
kout-basics.sh
>> index 7087818550..3e0f8c675f 100755
>> --- a/t/t2080-parallel-checkout-basics.sh
>> +++ b/t/t2080-parallel-checkout-basics.sh
>> @@ -114,7 +114,7 @@ do
>>=20=20
>>  	test_expect_success "$mode checkout" '
>>  		repo=3Dvarious_$mode &&
>> -		cp -R various $repo &&
>> +		cp -R -P various $repo &&
>>=20=20
>>  		# The just copied files have more recent timestamps than their
>>  		# associated index entries. So refresh the cached timestamps
>
> Thanks for the quick fix, I can confirm that this makes the test pass on
> AIX 7.2.

There's still a failure[1] in t2082-parallel-checkout-attributes.sh
though, which is new in 2.32.0-rc*. The difference is in an unexpected
BOM:
=20=20=20=20
    avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ d=
irectory.t2082-parallel-checkout-attributes/encoding/A.internal=20
    efbbbf74657874
    avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ d=
irectory.t2082-parallel-checkout-attributes/encoding/utf8-text=20=20
    74657874

I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.sh also
fails similarly[2], so perhaps it's some old/iconv/whatever issue not
per-se related to any change of yours.

I tried compiling with both NO_ICONV=3DY and ICONV_OMITS_BOM=3DY, both have
the same failure.

In any case, I think AIX test failures (or other obscure platforms I
test) are rather uninteresting per-se, I mainly test on these to smoke
out bad assumptions elsewhere. E.g. non-POSIX code, perhaps in this case
we're relying on some unportable iconv assumption, or maybe not...
=20=20=20=20

1.
Initialized empty Git repository in /scratch/avar/git/t/trash directory.t20=
82-parallel-checkout-attributes/encoding/.git/
+ cd encoding
+ echo text
+ 1> utf8-text
+ write_utf16
+ 0< utf8-text 1> utf16-text
checking prerequisite: NO_UTF16_BOM

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-NO_UTF16_BOM" &&
(
        cd "$TRASH_DIRECTORY/prereq-test-dir-NO_UTF16_BOM" &&
        test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) =3D 6

)
+ mkdir -p /scratch/avar/git/t/trash directory.t2082-parallel-checkout-attr=
ibutes/prereq-test-dir-NO_UTF16_BOM
+ cd /scratch/avar/git/t/trash directory.t2082-parallel-checkout-attributes=
/prereq-test-dir-NO_UTF16_BOM
+ printf abc
+ iconv -f UTF-8 -t UTF-16
+ wc -c
+ test 6 =3D 6
prerequisite NO_UTF16_BOM ok
+ echo A working-tree-encoding=3DUTF-16
+ 1> .gitattributes
+ cp utf16-text A
+ cp utf8-text B
+ git add A B .gitattributes
+ git commit -m encoding
[master (root-commit) 65fa7e8] encoding
 Author: A U Thor <author@example.com>
 3 files changed, 3 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 A
 create mode 100644 B
+ git cat-file -p :A
+ 1> A.internal
+ test_cmp_bin utf8-text A.internal
utf8-text A.internal differ: char 1, line 1
error: last command exited with $?=3D1
not ok 2 - parallel-checkout with re-encoding
#
#               set_checkout_config 2 0 &&
#               git init encoding &&
#               (
#                       cd encoding &&
#                       echo text >utf8-text &&
#                       write_utf16 <utf8-text >utf16-text &&
#
#                       echo "A working-tree-encoding=3DUTF-16" >.gitattrib=
utes &&
#                       cp utf16-text A &&
#                       cp utf8-text B &&
#                       git add A B .gitattributes &&
#                       git commit -m encoding &&
#
#                       # Check that A is stored in UTF-8
#                       git cat-file -p :A >A.internal &&
#                       test_cmp_bin utf8-text A.internal &&
#
#                       rm A B &&
#                       test_checkout_workers 2 git checkout A B &&
#
#                       # Check that A (and only A) is re-encoded during ch=
eckout
#                       test_cmp_bin utf16-text A &&
#                       test_cmp_bin utf8-text B
#               )
#

2.=20

avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ direc=
tory.t0028-working-tree-encoding/test.utf8.raw=20=20
68616c6c6f20746865726521
63616e20796f752072656164206d653f
avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ direc=
tory.t0028-working-tree-encoding/test.utf16.git=20=20=20=20
efbbbf68616c6c6f20746865726521
63616e20796f752072656164206d653f
