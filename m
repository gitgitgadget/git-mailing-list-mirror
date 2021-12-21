Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611CC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhLUOPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbhLUOPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:15:48 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0581FC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:15:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bm14so39745767edb.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/YCKC4GDQ8FSyWMWR+ANzeS5gYXH0VU+fM9gM0T+dRM=;
        b=AbjcrjfzSj+TnpAp6X6m2aqYTyaU16Tlgk4o6nsgDFZVL+LdbtLa3xfVxkh4v1paCn
         mdyWo7fOJlgD8J5PwNz7of4yEb4+KdEpleN5ZAW0bGYpnV9e7EBDm1CuG2EstM5MSBrZ
         ryEc3I9u6vw15udOK3yqEj+4Gm/mjD47FGDGtizA7xKvykRDfgutVvFmk9Ij3uUUaD2z
         OZSBIiyqSRvtMg/v9LGABqYMHI1kwxBTdSa9D502OAI8R8vxG0kpEZGmYwWDK13hw0qg
         8QLSmvUs7nGBs3SHPv2vr2vzBn0GYocHr/GWJG4Whj2We1DIB4IW8lNiqNQal9X/6qpM
         7o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/YCKC4GDQ8FSyWMWR+ANzeS5gYXH0VU+fM9gM0T+dRM=;
        b=OOHK3GK4bUrVYunT3M+nOtkZNqDvEPJsTomjA/B4Coe7k0CSzgtdIyonk6eXthcqYJ
         E9YthE3OvuWrZl7jQPHRllhkVh/nXjU+dE8RifumItM4y31axhX9iLd0Sd9cnnz1dMFq
         ngyTjBBzbDA2e143ultoR/Mhag7Mdn1noOJMxENmsZ1W10nMGiF/WCeKhxWPT7B9uz2o
         3RfP720YmB4jw/OJsF9bwdnRn76g0R3pK18Ivf8N1Qq7tkLR4mdCNi75b390xjdDvPgu
         0bOK3+y4/E3JximqIKFpljD81/54YxIrHHNAHQgPRH52YOAM/zlM8t/0CZPUsDkooI1M
         oapA==
X-Gm-Message-State: AOAM533JS44F3DjezNDSkV4daCgUsTQ3r4F2FD1W6viYERi0z75Z5ak1
        3IEgRdauhVCP0YBDOY73Azs=
X-Google-Smtp-Source: ABdhPJzJXGsZvOjIusP3cTEA+OJb/IfAbSTkZvnvbX5fVJmBDXHFwZ22d0ZaQsxgNP920vutw7c8Nw==
X-Received: by 2002:a17:907:1b24:: with SMTP id mp36mr2900410ejc.487.1640096144355;
        Tue, 21 Dec 2021 06:15:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a13sm8274891edk.29.2021.12.21.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:15:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzfvb-000kpf-4z;
        Tue, 21 Dec 2021 15:15:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v7 1/5] unpack-objects.c: add dry_run mode for get_data()
Date:   Tue, 21 Dec 2021 15:09:43 +0100
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-2-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211221115201.12120-2-chiyutianyi@gmail.com>
Message-ID: <211221.86bl1arqls.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> In dry_run mode, "get_data()" is used to verify the inflation of data,
> and the returned buffer will not be used at all and will be freed
> immediately. Even in dry_run mode, it is dangerous to allocate a
> full-size buffer for a large blob object. Therefore, only allocate a
> low memory footprint when calling "get_data()" in dry_run mode.
>
> Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/unpack-objects.c            | 23 +++++++++---
>  t/t5590-unpack-non-delta-objects.sh | 57 +++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 6 deletions(-)
>  create mode 100755 t/t5590-unpack-non-delta-objects.sh
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 4a9466295b..9104eb48da 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -96,15 +96,21 @@ static void use(int bytes)
>  	display_throughput(progress, consumed_bytes);
>  }
>  
> -static void *get_data(unsigned long size)
> +static void *get_data(size_t size, int dry_run)
>  {
>  	git_zstream stream;
> -	void *buf = xmallocz(size);
> +	size_t bufsize;
> +	void *buf;
>  
>  	memset(&stream, 0, sizeof(stream));
> +	if (dry_run && size > 8192)
> +		bufsize = 8192;
> +	else
> +		bufsize = size;
> +	buf = xmallocz(bufsize);

Maybe I'm misunderstanding this, but the commit message says it would be
dangerous to allocate a very larger buffer, but here we only limit the
size under "dry_run".

Removing that "&& size > 8192" makes all the tests pass still, so there
seems to be some missing coverage here in any case.

> diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
> new file mode 100755
> index 0000000000..48c4fb1ba3
> --- /dev/null
> +++ b/t/t5590-unpack-non-delta-objects.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2021 Han Xin
> +#
> +
> +test_description='Test unpack-objects with non-delta objects'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +prepare_dest () {
> +	test_when_finished "rm -rf dest.git" &&
> +	git init --bare dest.git
> +}
> +
> +test_expect_success "setup repo with big blobs (1.5 MB)" '
> +	test-tool genrandom foo 1500000 >big-blob &&
> +	test_commit --append foo big-blob &&
> +	test-tool genrandom bar 1500000 >big-blob &&
> +	test_commit --append bar big-blob &&
> +	(
> +		cd .git &&
> +		find objects/?? -type f | sort
> +	) >expect &&
> +	PACK=$(echo main | git pack-objects --revs test)
> +'
> +
> +test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
> +	GIT_ALLOC_LIMIT=1m &&
> +	export GIT_ALLOC_LIMIT
> +'
> +
> +test_expect_success 'fail to unpack-objects: cannot allocate' '
> +	prepare_dest &&
> +	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
> +	grep "fatal: attempting to allocate" err &&
> +	(
> +		cd dest.git &&
> +		find objects/?? -type f | sort
> +	) >actual &&
> +	test_file_not_empty actual &&
> +	! test_cmp expect actual
> +'
> +
> +test_expect_success 'unpack-objects dry-run' '
> +	prepare_dest &&
> +	git -C dest.git unpack-objects -n <test-$PACK.pack &&
> +	(
> +		cd dest.git &&
> +		find objects/ -type f
> +	) >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_done

I commented on this "find" usage in an earlier round, I think there's a
much easier way to do this. You're really just going back and forth
between checking whether or not all the objects are loose.

I think that the below fix-up on top of this series is a better way to
do that, and more accurate. I.e. in your test here you check "!
test_cmp", which means that we could have some packed and some loose,
but really what you're meaning to check is a flip-flop between "all
loose?" and "no loose?.

In addition to that there was no reason to hardcode "main", we can just
use HEAD. All in all I think the below fix-up makes sense:

diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-delta-objects.sh
index 8436cbf8db6..d78bb89225d 100755
--- a/t/t5590-unpack-non-delta-objects.sh
+++ b/t/t5590-unpack-non-delta-objects.sh
@@ -5,9 +5,6 @@
 
 test_description='Test unpack-objects with non-delta objects'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-
 . ./test-lib.sh
 
 prepare_dest () {
@@ -20,16 +17,22 @@ prepare_dest () {
 	fi
 }
 
+assert_no_loose () {
+	glob=dest.git/objects/?? &&
+	echo "$glob" >expect &&
+	echo $glob >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success "setup repo with big blobs (1.5 MB)" '
 	test-tool genrandom foo 1500000 >big-blob &&
 	test_commit --append foo big-blob &&
 	test-tool genrandom bar 1500000 >big-blob &&
 	test_commit --append bar big-blob &&
-	(
-		cd .git &&
-		find objects/?? -type f | sort
-	) >expect &&
-	PACK=$(echo main | git pack-objects --revs test)
+
+	# Everything is loose
+	rmdir .git/objects/pack &&
+	PACK=$(echo HEAD | git pack-objects --revs test)
 '
 
 test_expect_success 'setup env: GIT_ALLOC_LIMIT to 1MB' '
@@ -41,51 +44,27 @@ test_expect_success 'fail to unpack-objects: cannot allocate' '
 	prepare_dest 2m &&
 	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
 	grep "fatal: attempting to allocate" err &&
-	(
-		cd dest.git &&
-		find objects/?? -type f | sort
-	) >actual &&
-	test_file_not_empty actual &&
-	! test_cmp expect actual
+	rmdir dest.git/objects/pack
 '
 
 test_expect_success 'unpack big object in stream' '
 	prepare_dest 1m &&
 	mkdir -p dest.git/objects/05 &&
 	git -C dest.git unpack-objects <test-$PACK.pack &&
-	git -C dest.git fsck &&
-	(
-		cd dest.git &&
-		find objects/?? -type f | sort
-	) >actual &&
-	test_cmp expect actual
+	rmdir dest.git/objects/pack
 '
 
 test_expect_success 'unpack big object in stream with existing oids' '
 	prepare_dest 1m &&
 	git -C dest.git index-pack --stdin <test-$PACK.pack &&
-	(
-		cd dest.git &&
-		find objects/?? -type f | sort
-	) >actual &&
-	test_must_be_empty actual &&
 	git -C dest.git unpack-objects <test-$PACK.pack &&
-	git -C dest.git fsck &&
-	(
-		cd dest.git &&
-		find objects/?? -type f | sort
-	) >actual &&
-	test_must_be_empty actual
+	assert_no_loose
 '
 
 test_expect_success 'unpack-objects dry-run' '
 	prepare_dest &&
 	git -C dest.git unpack-objects -n <test-$PACK.pack &&
-	(
-		cd dest.git &&
-		find objects/ -type f
-	) >actual &&
-	test_must_be_empty actual
+	assert_no_loose
 '
 
 test_done
