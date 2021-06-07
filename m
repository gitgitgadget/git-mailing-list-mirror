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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE5C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEB461105
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFGLap (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhFGLao (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:30:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5ACC061787
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 04:28:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k7so25997821ejv.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OIS9IruBndFXaKFpP0W/9vYlJmiekQPCx2ILzNcMDFs=;
        b=RBq7VZ1u29ov6CMPbt4hN15WNrz52KeK7/m8HOWWPyZSEvWzv7B5NXMwtf0KC6gag4
         EibuJaA68JTC56Xxx8A7xbu63OAJNQDFTwBQhLFBp+9svqqWTa010tVSM/AsTGVdeY0A
         PRyhktGfHJkwxFfAZRVOXLJQ0hYly2Cx91OGu/68wfc92F98ACLMap2XiekbhNyeJJTd
         42lb74nYddRYOwE+2+iYcFBXCCgckDO0lyARiHp6wY70igvxDvaJb0D8NWOkkBBUah3j
         5GfO+NcUYEwTdsueBV3o2wS7cpnhNktZf3JBpU8cUd1vz4CYgO3Lh1M/edGBJEie80TV
         gXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OIS9IruBndFXaKFpP0W/9vYlJmiekQPCx2ILzNcMDFs=;
        b=dLO+gtHIqc7czMMqPZMhr5dDerb6typXzgV21TVGihqfwAe7orWgk0s9RcNY7hsiiW
         RfcyEq5eaqvKm+pSV3gt2TquAuc9PiGAiFJTlrU2kN3VBLRUZcRUt+cpOpuuLFaJ0E+y
         dprN9qXpQSQn6Vk17NAS/UlzVCycNQpW/94oRC1U4IJyg1mDkGGwU3DNoE7hVN0XTjTA
         beN8ycawgdXgCGAVjD0FUuHlFkEzF2jJtpxrtOIZfzqjazxm/ts1BcuyFf43t15TCTsS
         WP8dUd01z1GO+aPp2G2/nSmeymrkRsQZgaA6+Lh51x47VXjB+oOInhwRCmYJqZUrYCJ/
         7TGQ==
X-Gm-Message-State: AOAM5310r9EKpRHW7LECM/q7r1qh3WLmk9bcFo3YRcj3+WkAdOEmXnlD
        IjyCLK2oYrLmL4C9vq7o9Go=
X-Google-Smtp-Source: ABdhPJy0TOc3GTnHCHC7HJkHoKVLsLS1JdaZr1dLRKwTt6l5RWtzxKZLL7PsxE8fzYjU0DgQNgUbnA==
X-Received: by 2002:a17:906:944a:: with SMTP id z10mr17381648ejx.224.1623065322493;
        Mon, 07 Jun 2021 04:28:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f26sm7541722edu.31.2021.06.07.04.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:28:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t0001: fix broken not-quite getcwd(3) test in bed67874e2
Date:   Mon, 07 Jun 2021 13:24:23 +0200
References: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
 <patch-1.1-c70791bbd3-20210601T003743Z-avarab@gmail.com>
 <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <b650bef5-d739-d98d-e9f1-fa292b6ce982@web.de>
Message-ID: <871r9d6hhy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Ren=C3=A9 Scharfe wrote:

> Am 01.06.21 um 02:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> With a54e938e5b (strbuf: support long paths w/o read rights in
>> strbuf_getcwd() on FreeBSD, 2017-03-26) we had t0001 break on systems
>> like OpenBSD and AIX whose getcwd(3) has standard (but not like glibc
>> et al) behavior.
>>
>> This was partially fixed in bed67874e2 (t0001: skip test with
>> restrictive permissions if getpwd(3) respects them, 2017-08-07).
>>
>> The problem with that fix is that while its analysis of the problem is
>> correct, it doesn't actually call getcwd(3), instead it invokes "pwd
>> -P". There is no guarantee that "pwd -P" is actually going to call
>> getcwd(3), as opposed to e.g. being a shell built-in.
>>
>> On AIX under both bash and ksh this test breaks because "pwd -P" will
>> happily display the current working directory, but getcwd(3) called by
>> the "git init" we're testing here will fail to get it.
>>
>> I checked whether clobbering the $PWD environment variable would
>> affect it, and it didn't. Presumably these shells keep track of their
>> working directory internally.
>>
>> Let's change the test to a new "test-tool getcwd".
>
> Makes sense.
>
> If /bin/pwd can figure out the path to the current working directory
> without read permissions to parent directories then it might be possible
> to teach strbuf_getcwd() the same trick, though.  How does it do it?
>
> Perhaps it falls back to $PWD; POSIX says the behavior of pwd is
> unspecified if that variable would be changed, so a compliant
> implementation would be allowed to do that.  I think that way is not
> interesting for strbuf_getcwd(), though, because if we trust that
> variable then we can read it directly instead.  It gets stale if any
> parent directory is renamed.  E.g. the following commands would print a
> string ending in "stale":
>
> 	mkdir stale
> 	cd stale
> 	mv ../stale ../fresh
> 	chmod 111 ../fresh
> 	/bin/pwd -P

Yes, AIX prints "stale" here, but e.g. my Linux box prints "fresh".

> Perhaps it asks the kernel, like getcwd() does on FreeBSD.  It would
> be a bit weird to expose this functionality in a command line tool, but
> not in the library function, so this is unlikely.  You seem to say that
> /bin/pwd is a shell builtin on your system, which is also weird, though.
> The commands above would print a string ending in "fresh" with the
> syscall method.
>
> An evil way would be to temporarily add read permission to all parent
> directories.  It would also print a string ending in "fresh".  You'd
> probably see chmod calls when running /bin/pwd using truss in that
> case, and it would fail if chmod is not allowed.
>
> That's all I can think of.
>
> If strbuf_getcwd() were to learn any of these tricks, then so would
> "test-tool getcwd", via its xgetcwd() call.  At that point we'd better
> rename GETCWD_IGNORES_PERMS to XGETCWD_IGNORES_PERMS.
>
> But I guess we need none of that because we never got a request from
> an AIX user to support a /home directory without read permissions,
> right?

I don't really see the point of trying that hard. Yes, we could make
some forward progress if we bent over backwards and got the current
working directory, but what would we be left with? A git repository the
user can't "ls" inside of.

So any number of other thing after that now-working xgetcwd() call would
fail, we couldn't list any files in the working tree or .git directory.

Why not just fix the bug in there being disconnect between pwd and
getcwd() here and move on?

>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> Not an issue new in v2.32.0, but an easy enough fix, so I thought I'd
>> send it now anyway in case we'd like these various AIX fixes in one
>> batch...
>>
>>  Makefile               |  1 +
>>  t/helper/test-getcwd.c | 26 ++++++++++++++++++++++++++
>>  t/helper/test-tool.c   |  1 +
>>  t/helper/test-tool.h   |  1 +
>>  t/t0001-init.sh        |  5 ++++-
>>  5 files changed, 33 insertions(+), 1 deletion(-)
>>  create mode 100644 t/helper/test-getcwd.c
>>
>> diff --git a/Makefile b/Makefile
>> index c3565fc0f8..8c000ba48b 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -711,6 +711,7 @@ TEST_BUILTINS_OBJS +=3D test-example-decorate.o
>>  TEST_BUILTINS_OBJS +=3D test-fast-rebase.o
>>  TEST_BUILTINS_OBJS +=3D test-genrandom.o
>>  TEST_BUILTINS_OBJS +=3D test-genzeros.o
>> +TEST_BUILTINS_OBJS +=3D test-getcwd.o
>>  TEST_BUILTINS_OBJS +=3D test-hash-speed.o
>>  TEST_BUILTINS_OBJS +=3D test-hash.o
>>  TEST_BUILTINS_OBJS +=3D test-hashmap.o
>> diff --git a/t/helper/test-getcwd.c b/t/helper/test-getcwd.c
>> new file mode 100644
>> index 0000000000..d680038a78
>> --- /dev/null
>> +++ b/t/helper/test-getcwd.c
>> @@ -0,0 +1,26 @@
>> +#include "test-tool.h"
>> +#include "git-compat-util.h"
>> +#include "parse-options.h"
>> +
>> +static const char *getcwd_usage[] =3D {
>> +	"test-tool getcwd",
>> +	NULL
>> +};
>> +
>> +int cmd__getcwd(int argc, const char **argv)
>> +{
>> +	struct option options[] =3D {
>> +		OPT_END()
>> +	};
>> +	char *cwd;
>> +
>> +	argc =3D parse_options(argc, argv, "test-tools", options, getcwd_usage=
, 0);
>> +	if (argc > 0)
>> +		usage_with_options(getcwd_usage, options);
>> +
>> +	cwd =3D xgetcwd();
>> +	puts(cwd);
>> +	free(cwd);
>> +
>> +	return 0;
>> +}
>> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
>> index c5bd0c6d4c..3c13cb19b5 100644
>> --- a/t/helper/test-tool.c
>> +++ b/t/helper/test-tool.c
>> @@ -33,6 +33,7 @@ static struct test_cmd cmds[] =3D {
>>  	{ "fast-rebase", cmd__fast_rebase },
>>  	{ "genrandom", cmd__genrandom },
>>  	{ "genzeros", cmd__genzeros },
>> +	{ "getcwd", cmd__getcwd },
>>  	{ "hashmap", cmd__hashmap },
>>  	{ "hash-speed", cmd__hash_speed },
>>  	{ "index-version", cmd__index_version },
>> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
>> index e8069a3b22..e691a4d9e9 100644
>> --- a/t/helper/test-tool.h
>> +++ b/t/helper/test-tool.h
>> @@ -23,6 +23,7 @@ int cmd__example_decorate(int argc, const char **argv);
>>  int cmd__fast_rebase(int argc, const char **argv);
>>  int cmd__genrandom(int argc, const char **argv);
>>  int cmd__genzeros(int argc, const char **argv);
>> +int cmd__getcwd(int argc, const char **argv);
>>  int cmd__hashmap(int argc, const char **argv);
>>  int cmd__hash_speed(int argc, const char **argv);
>>  int cmd__index_version(int argc, const char **argv);
>> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>> index acd662e403..df544bb321 100755
>> --- a/t/t0001-init.sh
>> +++ b/t/t0001-init.sh
>> @@ -356,7 +356,10 @@ test_lazy_prereq GETCWD_IGNORES_PERMS '
>>  	chmod 100 $base ||
>>  	BUG "cannot prepare $base"
>>
>> -	(cd $base/dir && /bin/pwd -P)
>> +	(
>> +		cd $base/dir &&
>> +		test-tool getcwd
>> +	)
>>  	status=3D$?
>>
>>  	chmod 700 $base &&
>>

