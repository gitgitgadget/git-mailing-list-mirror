Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D54C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8F9613F4
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGDJuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDJut (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 05:50:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6AFC061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 02:48:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x2so1212441edr.10
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3IXYgdJPnF//erV0bzERkV+/BIR+wE8IfGytOYv92mw=;
        b=GyU+al9b76enmj+iEXnNDJM+Lu0OR+Q18XBRKY1SZ5dzpMDTnEwVlPpoI6fJiQZasf
         2dPTSbn65JYwsZFLxAnaMnWHpox363AkNe524cSgcg4Mx2r/WkSJXGy00ngtvxTBvtrX
         qhwrWzbdakDaeY/lcYHJRReDqn9dj9e7JQJzMs8M774G32IF8u+sFX0ltu91O5vRNjCf
         ctho8fZIdoHADjnDO47rsWuo3oqcLJ1EBXFhKznlStyW1V67gji8WzsO1niCRf31t2gT
         l9Y4JQa+c4DihanbytFb9of/ma9cStlmrEEn0PLV9SHDd3BUsOpjBc5aolldHSqE7ET3
         KLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3IXYgdJPnF//erV0bzERkV+/BIR+wE8IfGytOYv92mw=;
        b=PjYrxVWNomcb0z/GZU8OB241rc4aXdNLUnEBhX6M0++b/q4bvkVPvrk868/ifjJGq4
         NnlXNuUCMuDf2ovAnG9p4x7nPK4JekqtGZLLj+yPQf4D4GHbFWmT9z4VbWkh4c1yPimB
         Q9MK9XKGxGYWS0eW4MZvWIa62XNzdqvqOx01373OemWcSVwv/qxeHx3UnIAb896B3Z3L
         uSv210uM6KBYMnoX7iBKnmcC+ArfsHHs1M8dReE28Nvj3OXhk7Ek3kdDFt3HKUqqfosz
         t5OKzZt6RRf7ReVf5NFUV20Ux3AMn87MwSW3s3FrodMX0FxSSmOP2V3fgtk6IsPSrnKh
         Fo0Q==
X-Gm-Message-State: AOAM531YG2PFdv0cPzo2AtYIQ7f4evu228aogcOi15LERWqz7C+Cy68U
        qaQbRCAnj4SLLatwQXco0G4=
X-Google-Smtp-Source: ABdhPJzVLdIZmqpQM+LbKPNp2Ulqu0KJWUj9nNC5f46e3pCeU6YNZOkm7iLhfY8hMI0DlOPHUbM+1w==
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr9892788edd.66.1625392093190;
        Sun, 04 Jul 2021 02:48:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jl10sm3060192ejc.56.2021.07.04.02.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 02:48:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
Date:   Sun, 04 Jul 2021 11:32:50 +0200
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210629205305.7100-6-e@80x24.org>
Message-ID: <87zgv276lf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 29 2021, Eric Wong wrote:

> +struct alloc_state;
> +struct oidtree {
> +	struct cb_tree t;

s/t/tree/? Too short a name for an interface IMO.

> +	struct alloc_state *mempool;
> +};
> +
> +#define OIDTREE_INIT { .t = CBTREE_INIT, .mempool = NULL }

Let's use designated initilaizers for new code. Just:

	#define OIDTREE_init { \
		.tere = CBTREE_INIT, \
	}

Will do, no need for the ".mempool = NULL"

> +static inline void oidtree_init(struct oidtree *ot)
> +{
> +	cb_init(&ot->t);
> +	ot->mempool = NULL;
> +}

You can use the "memcpy() a blank" trick/idiom here:
https://lore.kernel.org/git/patch-2.5-955dbd1693d-20210701T104855Z-avarab@gmail.com/

Also, is this even needed? Why have the "destroy" re-initialize it?

> +void oidtree_destroy(struct oidtree *);

Maybe s/destroy/release/, or if you actually need that reset behavior
oidtree_reset(). We've got

> +void oidtree_insert(struct oidtree *, const struct object_id *);
> +int oidtree_contains(struct oidtree *, const struct object_id *);
> +
> +typedef enum cb_next (*oidtree_iter)(const struct object_id *, void *arg);

An "arg" name for some arguments, but none for others, if there's a name
here call it "data" like you do elswhere?

> +void oidtree_each(struct oidtree *, const struct object_id *,
> +			size_t oidhexlen, oidtree_iter, void *arg);

s/oidhexlen/hexsz/, like in git_hash_algo.a

> +
> +#endif /* OIDTREE_H */
> diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
> new file mode 100644
> index 0000000000..e0da13eea3
> --- /dev/null
> +++ b/t/helper/test-oidtree.c
> @@ -0,0 +1,47 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "oidtree.h"
> +
> +static enum cb_next print_oid(const struct object_id *oid, void *data)
> +{
> +	puts(oid_to_hex(oid));
> +	return CB_CONTINUE;
> +}
> +
> +int cmd__oidtree(int argc, const char **argv)
> +{
> +	struct oidtree ot = OIDTREE_INIT;
> +	struct strbuf line = STRBUF_INIT;
> +	int nongit_ok;
> +	int algo = GIT_HASH_UNKNOWN;
> +
> +	setup_git_directory_gently(&nongit_ok);
> +
> +	while (strbuf_getline(&line, stdin) != EOF) {
> +		const char *arg;
> +		struct object_id oid;
> +
> +		if (skip_prefix(line.buf, "insert ", &arg)) {
> +			if (get_oid_hex_any(arg, &oid) == GIT_HASH_UNKNOWN)
> +				die("insert not a hexadecimal oid: %s", arg);
> +			algo = oid.algo;
> +			oidtree_insert(&ot, &oid);
> +		} else if (skip_prefix(line.buf, "contains ", &arg)) {
> +			if (get_oid_hex(arg, &oid))
> +				die("contains not a hexadecimal oid: %s", arg);
> +			printf("%d\n", oidtree_contains(&ot, &oid));
> +		} else if (skip_prefix(line.buf, "each ", &arg)) {
> +			char buf[GIT_MAX_HEXSZ + 1] = { '0' };
> +			memset(&oid, 0, sizeof(oid));
> +			memcpy(buf, arg, strlen(arg));
> +			buf[hash_algos[algo].hexsz] = 0;

= '\0' if it's the intent to have a NULL-terminated string is more
readable.

> +			get_oid_hex_any(buf, &oid);
> +			oid.algo = algo;
> +			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
> +		} else if (!strcmp(line.buf, "destroy"))
> +			oidtree_destroy(&ot);
> +		else
> +			die("unknown command: %s", line.buf);

Missing braces.

> +	}
> +	return 0;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index c5bd0c6d4c..9d37debf28 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
>  	{ "mktemp", cmd__mktemp },
>  	{ "oid-array", cmd__oid_array },
>  	{ "oidmap", cmd__oidmap },
> +	{ "oidtree", cmd__oidtree },
>  	{ "online-cpus", cmd__online_cpus },
>  	{ "parse-options", cmd__parse_options },
>  	{ "parse-pathspec-file", cmd__parse_pathspec_file },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index e8069a3b22..f683a2f59c 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -32,6 +32,7 @@ int cmd__match_trees(int argc, const char **argv);
>  int cmd__mergesort(int argc, const char **argv);
>  int cmd__mktemp(int argc, const char **argv);
>  int cmd__oidmap(int argc, const char **argv);
> +int cmd__oidtree(int argc, const char **argv);
>  int cmd__online_cpus(int argc, const char **argv);
>  int cmd__parse_options(int argc, const char **argv);
>  int cmd__parse_pathspec_file(int argc, const char** argv);
> diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
> new file mode 100755
> index 0000000000..0594f57c81
> --- /dev/null
> +++ b/t/t0069-oidtree.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description='basic tests for the oidtree implementation'
> +. ./test-lib.sh
> +
> +echoid () {
> +	prefix="${1:+$1 }"
> +	shift
> +	while test $# -gt 0
> +	do
> +		echo "$1"
> +		shift
> +	done | awk -v prefix="$prefix" -v ZERO_OID=$ZERO_OID '{
> +		printf("%s%s", prefix, $0);
> +		need = length(ZERO_OID) - length($0);
> +		for (i = 0; i < need; i++)
> +			printf("0");
> +		printf "\n";
> +	}'
> +}

Looks fairly easy to do in pure-shell, first of all you don't need a
length() on $ZERO_OID, use $(test_oid hexsz) instead. That applies for
the awk version too.

But once you have that and the N arguments just do a wc -c on the
argument, use $(()) to compute the $difference, and a loop with:

    printf "%s%s%0${difference}d" "$prefix" "$shortoid" "0"

> +
> +test_expect_success 'oidtree insert and contains' '
> +	cat >expect <<EOF &&
> +0
> +0
> +0
> +1
> +1
> +0
> +EOF

use "<<-\EOF" and indent it.

> +	{
> +		echoid insert 444 1 2 3 4 5 a b c d e &&
> +		echoid contains 44 441 440 444 4440 4444
> +		echo destroy
> +	} | test-tool oidtree >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'oidtree each' '
> +	echoid "" 123 321 321 >expect &&
> +	{
> +		echoid insert f 9 8 123 321 a b c d e
> +		echo each 12300
> +		echo each 3211
> +		echo each 3210
> +		echo each 32100
> +		echo destroy
> +	} | test-tool oidtree >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done

