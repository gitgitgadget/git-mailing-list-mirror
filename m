Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B100C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 21:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjARVeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 16:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjARVeO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 16:34:14 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222064DA0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:34:05 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id f8so223509ilj.5
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YEFo8WQKnceOeed4NMBNMAhYuBSY7MJYXUlMaFcIer4=;
        b=YKrIRBKeYE0TyK+g00uJliRGDwlDiqZv96C56Ga/8gYZQANuFW5NBd3vIOMYE/f8TP
         aOCWbd1KSqLdYc5Gc2rRk2mIOW9dZYeU0hOzkKPIpgSpcAno7LF0ubHVIKoL6DudTvnl
         6yS9j51RmqjJXwNPw46ScEFrkEWHtFG2Ex00YHaD1MJ5Kh0VMfEVdV6FTpxcRqChtjLI
         1+YRmCermnkrowiGMmGHWz39sSxa+1eiJdFnm0FEBZtr32O7U3Ni0L/WiM0fidvVirfd
         DwBkSJbZnmutR6isrbzbGRFHB6r2c0oLYZjVkAaLGWnEarmRhFRJVTDBCUc6W3AtLXX+
         RHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEFo8WQKnceOeed4NMBNMAhYuBSY7MJYXUlMaFcIer4=;
        b=LK2glqBuUDSTvWKsTAIEZwtKatMlC5hekFwvT0ALTqthuWDVL2EK3RURzm/v8YXgHT
         u6KrO0repe3YhmHztwl7aNvlWrQ5PZmVnzAOW4liSN45B2N0R4kkfNlmkKphgTu0o1iY
         IdVt+s1xzdUU/WICLn2lT7ACsC8vtF1vsGuVGJGi+0c7kGXqDDew9K0oehQlT4zRZqd1
         CKUK80g557IY7BeBxdS0qLapKuZHDj3IIMZ6+zaG1W6RVx6YUpsjy9CGrRqJqESmS3Q3
         n/OG5dvJqEivBBDrDd3fqQs1br9HFLWC+VKOBPWD7wY3W34spDVcULwzvF8bNMwoG6ET
         jTgQ==
X-Gm-Message-State: AFqh2ko8ksre6tHQ8HAjadaRfJPH5rOYR8ThTVYRz3u1Tg7PxM6vbJPe
        QHEslc2UNCJc64f+GGTZjZrNPHzEOIsdtAjM5fs=
X-Google-Smtp-Source: AMrXdXtpNtKOPilQ63MRnw+yzejZi6vDCbdFPqwi7It9XFfSdftI7NutlYRqCLF8Rhf9EqeXvno3fg==
X-Received: by 2002:a05:6e02:1bc2:b0:30e:dcd5:6fda with SMTP id x2-20020a056e021bc200b0030edcd56fdamr7735368ilv.0.1674077644464;
        Wed, 18 Jan 2023 13:34:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n29-20020a02711d000000b00374bf3b62a0sm10659467jac.99.2023.01.18.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:34:04 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:34:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/6] hash-object: use fsck for object checks
Message-ID: <Y8hlyr0o6gs9omI5@nand.local>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 03:44:12PM -0500, Jeff King wrote:
> This is obviously going to be a user-visible behavior change, and the
> test changes earlier in this series show the scope of the impact. But
> I'd argue that this is OK:
>
>   - the documentation for hash-object is already vague about which
>     checks we might do, saying that --literally will allow "any
>     garbage[...] which might not otherwise pass standard object parsing
>     or git-fsck checks". So we are already covered under the documented
>     behavior.
>
>   - users don't generally run hash-object anyway. There are a lot of
>     spots in the tests that needed to be updated because creating
>     garbage objects is something that Git's tests disproportionately do.
>
>   - it's hard to imagine anyone thinking the new behavior is worse. Any
>     object we reject would be a potential problem down the road for the
>     user. And if they really want to create garbage, --literally is
>     already the escape hatch they need.

This is the discussion I was pointing out earlier in the series as
evidence for making this behavior the new default without "--literally".

That being said, let me play devil's advocate for a second. Do the new
fsck checks slow anything in hash-object down significantly? If so, then
it's plausible to imagine a hash-object caller who (a) doesn't use
`--literally`, but (b) does care about throughput if they're writing a
large number of objects at once.

I don't know if such a situation exists, or if these new fsck checks
even slow hash-object down enough to care. But I didn't catch a
discussion of this case in your series, so I figured I'd bring it up
here just in case.

>   - the resulting messages are much better. For example:
>
>       [before]
>       $ echo 'tree 123' | git hash-object -t commit --stdin
>       error: bogus commit object 0000000000000000000000000000000000000000
>       fatal: corrupt commit
>
>       [after]
>       $ echo 'tree 123' | git.compile hash-object -t commit --stdin
>       error: object fails fsck: badTreeSha1: invalid 'tree' line format - bad sha1
>       fatal: refusing to create malformed object

Much nicer, well done.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-file.c          | 55 ++++++++++++++++++------------------------
>  t/t1007-hash-object.sh | 11 +++++++++
>  2 files changed, 34 insertions(+), 32 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 80a0cd3b35..5c96384803 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -33,6 +33,7 @@
>  #include "object-store.h"
>  #include "promisor-remote.h"
>  #include "submodule.h"
> +#include "fsck.h"
>
>  /* The maximum size for an object header. */
>  #define MAX_HEADER_LEN 32
> @@ -2298,32 +2299,21 @@ int repo_has_object_file(struct repository *r,
>  	return repo_has_object_file_with_flags(r, oid, 0);
>  }
>
> -static void check_tree(const void *buf, size_t size)
> -{
> -	struct tree_desc desc;
> -	struct name_entry entry;
> -
> -	init_tree_desc(&desc, buf, size);
> -	while (tree_entry(&desc, &entry))
> -		/* do nothing
> -		 * tree_entry() will die() on malformed entries */
> -		;
> -}
> -
> -static void check_commit(const void *buf, size_t size)
> -{
> -	struct commit c;
> -	memset(&c, 0, sizeof(c));
> -	if (parse_commit_buffer(the_repository, &c, buf, size, 0))
> -		die(_("corrupt commit"));
> -}
> -
> -static void check_tag(const void *buf, size_t size)
> -{
> -	struct tag t;
> -	memset(&t, 0, sizeof(t));
> -	if (parse_tag_buffer(the_repository, &t, buf, size))
> -		die(_("corrupt tag"));

OK, here we're getting rid of all of the lightweight checks that
hash-object used to implement on its own.

> +/*
> + * We can't use the normal fsck_error_function() for index_mem(),
> + * because we don't yet have a valid oid for it to report. Instead,
> + * report the minimal fsck error here, and rely on the caller to
> + * give more context.
> + */
> +static int hash_format_check_report(struct fsck_options *opts,
> +				     const struct object_id *oid,
> +				     enum object_type object_type,
> +				     enum fsck_msg_type msg_type,
> +				     enum fsck_msg_id msg_id,
> +				     const char *message)
> +{
> +	error(_("object fails fsck: %s"), message);
> +	return 1;
>  }
>
>  static int index_mem(struct index_state *istate,
> @@ -2350,12 +2340,13 @@ static int index_mem(struct index_state *istate,
>  		}
>  	}
>  	if (flags & HASH_FORMAT_CHECK) {
> -		if (type == OBJ_TREE)
> -			check_tree(buf, size);
> -		if (type == OBJ_COMMIT)
> -			check_commit(buf, size);
> -		if (type == OBJ_TAG)
> -			check_tag(buf, size);
> +		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
> +
> +		opts.strict = 1;
> +		opts.error_func = hash_format_check_report;
> +		if (fsck_buffer(null_oid(), type, buf, size, &opts))
> +			die(_("refusing to create malformed object"));
> +		fsck_finish(&opts);
>  	}

And here's the main part of the change, which is delightfully simple and
appears correct to me.

> diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> index 2d2148d8fa..ac3d173767 100755
> --- a/t/t1007-hash-object.sh
> +++ b/t/t1007-hash-object.sh
> @@ -222,6 +222,17 @@ test_expect_success 'empty filename in tree' '
>  	grep "empty filename in tree entry" err
>  '
>
> +test_expect_success 'duplicate filename in tree' '
> +	hex_oid=$(echo foo | git hash-object --stdin -w) &&
> +	bin_oid=$(echo $hex_oid | hex2oct) &&
> +	{
> +		printf "100644 file\0$bin_oid" &&
> +		printf "100644 file\0$bin_oid"
> +	} >tree-with-duplicate-filename &&
> +	test_must_fail git hash-object -t tree tree-with-duplicate-filename 2>err &&
> +	grep "duplicateEntries" err
> +'
> +

For what it's worth, I think that this is sufficient coverage for the
new fsck checks.

Thanks,
Taylor
