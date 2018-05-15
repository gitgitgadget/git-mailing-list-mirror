Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844F41F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeEOIIk (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:08:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51675 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeEOIG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:06:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id j4-v6so17742667wme.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fUaaWQoe5Y9OpQV68I8LhOOWNpJjwzgSswh6AIBNkts=;
        b=rxwvapBwUTIa3mfNghTrHPJf0Y9w2WYTT2Bc8+YaXant/d0b5aw1zi2xVxyi4/kEr6
         Bwnl0GNW1PiOEryUHaE6OsVGSGnTgP0X4bKxIXhijX7to5cg6NPvFvqXL37FhztyePta
         pmRLpPj1uPP/lzakdqTBsvwWsj1SCCegM9paHlTFxBYZcyrFKobqd4UkjX2TGLwZIuS5
         39xzF/iEGFdyrPR1SAAllNktlnCla5UMQ5c5Lq7tVYFygRHob2uBdrj0ywPCKTdn3wsO
         5Zw4m9h0rndBGXVikNQ31kGySkH+9mUrsoMoEuCrOmvd0A+57mVXuBMV5WZOwEhmjVxJ
         tERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fUaaWQoe5Y9OpQV68I8LhOOWNpJjwzgSswh6AIBNkts=;
        b=daJeNLLEdwDJP+1oXilTLsKMORQyBnBz6mop/viLW7c3Wk6AtkED2Ad7iZIVNj7Di3
         xRyvXsNk+RuDc9s6pyz+nkOTte/JXvOw3d5aj43+tPtNysqfouR+5ZPiB/yBjd1kvY2X
         XgCgKsN6ShGiSxcBc8/GyNp9GW35AlFexhd9FG+Y5FOoDUeLfD1Q5O9sFQFsks2+8RPJ
         clNM8iRATZzRFItOPsaneFqN7QvTy2hkOQ0q10hSeuZvRj5Yc5UxOM6vQxySSsmIyrol
         D0Z7NU9AV+k0T8Gcc5EJZ3dYdZ0mgIIPSwT14OB3KoJjr9oFvjwbwZRbrmK5syIWRm+W
         TLsg==
X-Gm-Message-State: ALKqPwdbTENJXS3BqeLWt8BpnXu6jVBIi0uRrrasdxT2bT0b7F48lX3n
        RaA8lZBMknBeR0o7wq/16OdZzosF
X-Google-Smtp-Source: AB8JxZp+zfFC+7LXnUm2U3KEoIyfhBN7orOV3RKXrq49C/5q1NW82ZSgsDzF2W5Pzo4fL8DLr5c7ZQ==
X-Received: by 2002:a1c:6443:: with SMTP id y64-v6mr6758698wmb.108.1526371585525;
        Tue, 15 May 2018 01:06:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l53-v6sm18237935wrc.80.2018.05.15.01.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 01:06:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/35] refspec: move refspec parsing logic into its own file
References: <20180514215626.164960-1-bmwill@google.com>
        <20180514215626.164960-2-bmwill@google.com>
Date:   Tue, 15 May 2018 17:06:24 +0900
In-Reply-To: <20180514215626.164960-2-bmwill@google.com> (Brandon Williams's
        message of "Mon, 14 May 2018 14:55:52 -0700")
Message-ID: <xmqqr2md8hrz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> In preperation for performing a refactor on refspec related code, move

Preparation?

> the refspec parsing logic into its own file.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Makefile                    |   1 +
>  branch.c                    |   1 +
>  builtin/clone.c             |   1 +
>  builtin/fast-export.c       |   1 +
>  builtin/fetch.c             |   1 +
>  builtin/merge.c             |   1 +
>  builtin/pull.c              |   1 +
>  builtin/push.c              |   1 +
>  builtin/remote.c            |   1 +
>  builtin/submodule--helper.c |   1 +
>  checkout.c                  |   1 +
>  refspec.c                   | 168 ++++++++++++++++++++++++++++++++++++
>  refspec.h                   |  23 +++++
>  remote.c                    | 165 +----------------------------------
>  remote.h                    |  20 -----
>  transport-helper.c          |   1 +
>  transport.c                 |   1 +
>  17 files changed, 205 insertions(+), 184 deletions(-)
>  create mode 100644 refspec.c
>  create mode 100644 refspec.h
>
> diff --git a/Makefile b/Makefile
> index ad880d1fc..4bca65383 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -928,6 +928,7 @@ LIB_OBJS += refs/files-backend.o
>  LIB_OBJS += refs/iterator.o
>  LIB_OBJS += refs/packed-backend.o
>  LIB_OBJS += refs/ref-cache.o
> +LIB_OBJS += refspec.o
>  LIB_OBJS += ref-filter.o
>  LIB_OBJS += remote.o
>  LIB_OBJS += replace-object.o
> diff --git a/branch.c b/branch.c
> index 2672054f0..32ccefc6b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -3,6 +3,7 @@
>  #include "config.h"
>  #include "branch.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "remote.h"
>  #include "commit.h"
>  #include "worktree.h"
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 84f1473d1..6d1614ed3 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -14,6 +14,7 @@
>  #include "parse-options.h"
>  #include "fetch-pack.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "unpack-trees.h"
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 530df12f0..a13b7c8ef 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -7,6 +7,7 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "commit.h"
>  #include "object.h"
>  #include "tag.h"
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7ee83ac0f..1fce68e9a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -5,6 +5,7 @@
>  #include "config.h"
>  #include "repository.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "commit.h"
>  #include "builtin.h"
>  #include "string-list.h"
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 9db5a2cf1..c362cfe90 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -14,6 +14,7 @@
>  #include "run-command.h"
>  #include "diff.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "commit.h"
>  #include "diffcore.h"
>  #include "revision.h"
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 71aac5005..6247c956d 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -15,6 +15,7 @@
>  #include "remote.h"
>  #include "dir.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "revision.h"
>  #include "submodule.h"
>  #include "submodule-config.h"
> diff --git a/builtin/push.c b/builtin/push.c
> index ac3705370..fa65999b2 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -4,6 +4,7 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "run-command.h"
>  #include "builtin.h"
>  #include "remote.h"
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 8708e584e..c49513995 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -7,6 +7,7 @@
>  #include "strbuf.h"
>  #include "run-command.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "argv-array.h"
>  
>  static const char * const builtin_remote_usage[] = {
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c2403a915..6ab032acb 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -12,6 +12,7 @@
>  #include "run-command.h"
>  #include "remote.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "connect.h"
>  #include "revision.h"
>  #include "diffcore.h"
> diff --git a/checkout.c b/checkout.c
> index ac42630f7..193ba8567 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "remote.h"
> +#include "refspec.h"
>  #include "checkout.h"
>  
>  struct tracking_name_data {
> diff --git a/refspec.c b/refspec.c
> new file mode 100644
> index 000000000..ecb0bdff3
> --- /dev/null
> +++ b/refspec.c
> @@ -0,0 +1,168 @@
> +#include "cache.h"
> +#include "refs.h"
> +#include "refspec.h"
> +
> +static struct refspec s_tag_refspec = {
> +	0,
> +	1,
> +	0,
> +	0,
> +	"refs/tags/*",
> +	"refs/tags/*"
> +};
> +
> +/* See TAG_REFSPEC for the string version */
> +const struct refspec *tag_refspec = &s_tag_refspec;
> +
> +static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
> +{
> +	int i;
> +	struct refspec *rs = xcalloc(nr_refspec, sizeof(*rs));
> +
> +	for (i = 0; i < nr_refspec; i++) {
> +		size_t llen;
> +		int is_glob;
> +		const char *lhs, *rhs;
> +		int flags;
> +
> +		is_glob = 0;
> +
> +		lhs = refspec[i];
> +		if (*lhs == '+') {
> +			rs[i].force = 1;
> +			lhs++;
> +		}
> +
> +		rhs = strrchr(lhs, ':');
> +
> +		/*
> +		 * Before going on, special case ":" (or "+:") as a refspec
> +		 * for pushing matching refs.
> +		 */
> +		if (!fetch && rhs == lhs && rhs[1] == '\0') {
> +			rs[i].matching = 1;
> +			continue;
> +		}
> +
> +		if (rhs) {
> +			size_t rlen = strlen(++rhs);
> +			is_glob = (1 <= rlen && strchr(rhs, '*'));
> +			rs[i].dst = xstrndup(rhs, rlen);
> +		}
> +
> +		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
> +		if (1 <= llen && memchr(lhs, '*', llen)) {
> +			if ((rhs && !is_glob) || (!rhs && fetch))
> +				goto invalid;
> +			is_glob = 1;
> +		} else if (rhs && is_glob) {
> +			goto invalid;
> +		}
> +
> +		rs[i].pattern = is_glob;
> +		rs[i].src = xstrndup(lhs, llen);
> +		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
> +
> +		if (fetch) {
> +			struct object_id unused;
> +
> +			/* LHS */
> +			if (!*rs[i].src)
> +				; /* empty is ok; it means "HEAD" */
> +			else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(rs[i].src, &unused))
> +				rs[i].exact_sha1 = 1; /* ok */
> +			else if (!check_refname_format(rs[i].src, flags))
> +				; /* valid looking ref is ok */
> +			else
> +				goto invalid;
> +			/* RHS */
> +			if (!rs[i].dst)
> +				; /* missing is ok; it is the same as empty */
> +			else if (!*rs[i].dst)
> +				; /* empty is ok; it means "do not store" */
> +			else if (!check_refname_format(rs[i].dst, flags))
> +				; /* valid looking ref is ok */
> +			else
> +				goto invalid;
> +		} else {
> +			/*
> +			 * LHS
> +			 * - empty is allowed; it means delete.
> +			 * - when wildcarded, it must be a valid looking ref.
> +			 * - otherwise, it must be an extended SHA-1, but
> +			 *   there is no existing way to validate this.
> +			 */
> +			if (!*rs[i].src)
> +				; /* empty is ok */
> +			else if (is_glob) {
> +				if (check_refname_format(rs[i].src, flags))
> +					goto invalid;
> +			}
> +			else
> +				; /* anything goes, for now */
> +			/*
> +			 * RHS
> +			 * - missing is allowed, but LHS then must be a
> +			 *   valid looking ref.
> +			 * - empty is not allowed.
> +			 * - otherwise it must be a valid looking ref.
> +			 */
> +			if (!rs[i].dst) {
> +				if (check_refname_format(rs[i].src, flags))
> +					goto invalid;
> +			} else if (!*rs[i].dst) {
> +				goto invalid;
> +			} else {
> +				if (check_refname_format(rs[i].dst, flags))
> +					goto invalid;
> +			}
> +		}
> +	}
> +	return rs;
> +
> + invalid:
> +	if (verify) {
> +		/*
> +		 * nr_refspec must be greater than zero and i must be valid
> +		 * since it is only possible to reach this point from within
> +		 * the for loop above.
> +		 */
> +		free_refspec(i+1, rs);
> +		return NULL;
> +	}
> +	die("Invalid refspec '%s'", refspec[i]);
> +}
> +
> +int valid_fetch_refspec(const char *fetch_refspec_str)
> +{
> +	struct refspec *refspec;
> +
> +	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
> +	free_refspec(1, refspec);
> +	return !!refspec;
> +}
> +
> +struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
> +{
> +	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
> +}
> +
> +struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
> +{
> +	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
> +}
> +
> +void free_refspec(int nr_refspec, struct refspec *refspec)
> +{
> +	int i;
> +
> +	if (!refspec)
> +		return;
> +
> +	for (i = 0; i < nr_refspec; i++) {
> +		free(refspec[i].src);
> +		free(refspec[i].dst);
> +	}
> +	free(refspec);
> +}
> +
> diff --git a/refspec.h b/refspec.h
> new file mode 100644
> index 000000000..b1db91918
> --- /dev/null
> +++ b/refspec.h
> @@ -0,0 +1,23 @@
> +#ifndef REFSPEC_H
> +#define REFSPEC_H
> +
> +#define TAG_REFSPEC "refs/tags/*:refs/tags/*"
> +const struct refspec *tag_refspec;
> +
> +struct refspec {
> +	unsigned force : 1;
> +	unsigned pattern : 1;
> +	unsigned matching : 1;
> +	unsigned exact_sha1 : 1;
> +
> +	char *src;
> +	char *dst;
> +};
> +
> +int valid_fetch_refspec(const char *refspec);
> +struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
> +struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
> +
> +void free_refspec(int nr_refspec, struct refspec *refspec);
> +
> +#endif /* REFSPEC_H */
> diff --git a/remote.c b/remote.c
> index 91eb010ca..4d67c061a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2,6 +2,7 @@
>  #include "config.h"
>  #include "remote.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "commit.h"
>  #include "diff.h"
>  #include "revision.h"
> @@ -13,18 +14,6 @@
>  
>  enum map_direction { FROM_SRC, FROM_DST };
>  
> -static struct refspec s_tag_refspec = {
> -	0,
> -	1,
> -	0,
> -	0,
> -	"refs/tags/*",
> -	"refs/tags/*"
> -};
> -
> -/* See TAG_REFSPEC for the string version */
> -const struct refspec *tag_refspec = &s_tag_refspec;
> -
>  struct counted_string {
>  	size_t len;
>  	const char *s;
> @@ -499,158 +488,6 @@ static void read_config(void)
>  	alias_all_urls();
>  }
>  
> -static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
> -{
> -	int i;
> -	struct refspec *rs = xcalloc(nr_refspec, sizeof(*rs));
> -
> -	for (i = 0; i < nr_refspec; i++) {
> -		size_t llen;
> -		int is_glob;
> -		const char *lhs, *rhs;
> -		int flags;
> -
> -		is_glob = 0;
> -
> -		lhs = refspec[i];
> -		if (*lhs == '+') {
> -			rs[i].force = 1;
> -			lhs++;
> -		}
> -
> -		rhs = strrchr(lhs, ':');
> -
> -		/*
> -		 * Before going on, special case ":" (or "+:") as a refspec
> -		 * for pushing matching refs.
> -		 */
> -		if (!fetch && rhs == lhs && rhs[1] == '\0') {
> -			rs[i].matching = 1;
> -			continue;
> -		}
> -
> -		if (rhs) {
> -			size_t rlen = strlen(++rhs);
> -			is_glob = (1 <= rlen && strchr(rhs, '*'));
> -			rs[i].dst = xstrndup(rhs, rlen);
> -		}
> -
> -		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
> -		if (1 <= llen && memchr(lhs, '*', llen)) {
> -			if ((rhs && !is_glob) || (!rhs && fetch))
> -				goto invalid;
> -			is_glob = 1;
> -		} else if (rhs && is_glob) {
> -			goto invalid;
> -		}
> -
> -		rs[i].pattern = is_glob;
> -		rs[i].src = xstrndup(lhs, llen);
> -		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
> -
> -		if (fetch) {
> -			struct object_id unused;
> -
> -			/* LHS */
> -			if (!*rs[i].src)
> -				; /* empty is ok; it means "HEAD" */
> -			else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(rs[i].src, &unused))
> -				rs[i].exact_sha1 = 1; /* ok */
> -			else if (!check_refname_format(rs[i].src, flags))
> -				; /* valid looking ref is ok */
> -			else
> -				goto invalid;
> -			/* RHS */
> -			if (!rs[i].dst)
> -				; /* missing is ok; it is the same as empty */
> -			else if (!*rs[i].dst)
> -				; /* empty is ok; it means "do not store" */
> -			else if (!check_refname_format(rs[i].dst, flags))
> -				; /* valid looking ref is ok */
> -			else
> -				goto invalid;
> -		} else {
> -			/*
> -			 * LHS
> -			 * - empty is allowed; it means delete.
> -			 * - when wildcarded, it must be a valid looking ref.
> -			 * - otherwise, it must be an extended SHA-1, but
> -			 *   there is no existing way to validate this.
> -			 */
> -			if (!*rs[i].src)
> -				; /* empty is ok */
> -			else if (is_glob) {
> -				if (check_refname_format(rs[i].src, flags))
> -					goto invalid;
> -			}
> -			else
> -				; /* anything goes, for now */
> -			/*
> -			 * RHS
> -			 * - missing is allowed, but LHS then must be a
> -			 *   valid looking ref.
> -			 * - empty is not allowed.
> -			 * - otherwise it must be a valid looking ref.
> -			 */
> -			if (!rs[i].dst) {
> -				if (check_refname_format(rs[i].src, flags))
> -					goto invalid;
> -			} else if (!*rs[i].dst) {
> -				goto invalid;
> -			} else {
> -				if (check_refname_format(rs[i].dst, flags))
> -					goto invalid;
> -			}
> -		}
> -	}
> -	return rs;
> -
> - invalid:
> -	if (verify) {
> -		/*
> -		 * nr_refspec must be greater than zero and i must be valid
> -		 * since it is only possible to reach this point from within
> -		 * the for loop above.
> -		 */
> -		free_refspec(i+1, rs);
> -		return NULL;
> -	}
> -	die("Invalid refspec '%s'", refspec[i]);
> -}
> -
> -int valid_fetch_refspec(const char *fetch_refspec_str)
> -{
> -	struct refspec *refspec;
> -
> -	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
> -	free_refspec(1, refspec);
> -	return !!refspec;
> -}
> -
> -struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
> -{
> -	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
> -}
> -
> -struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
> -{
> -	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
> -}
> -
> -void free_refspec(int nr_refspec, struct refspec *refspec)
> -{
> -	int i;
> -
> -	if (!refspec)
> -		return;
> -
> -	for (i = 0; i < nr_refspec; i++) {
> -		free(refspec[i].src);
> -		free(refspec[i].dst);
> -	}
> -	free(refspec);
> -}
> -
>  static int valid_remote_nick(const char *name)
>  {
>  	if (!name[0] || is_dot_or_dotdot(name))
> diff --git a/remote.h b/remote.h
> index 2b3180f94..386ced901 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -68,18 +68,6 @@ int for_each_remote(each_remote_fn fn, void *priv);
>  
>  int remote_has_url(struct remote *remote, const char *url);
>  
> -struct refspec {
> -	unsigned force : 1;
> -	unsigned pattern : 1;
> -	unsigned matching : 1;
> -	unsigned exact_sha1 : 1;
> -
> -	char *src;
> -	char *dst;
> -};
> -
> -extern const struct refspec *tag_refspec;
> -
>  struct ref {
>  	struct ref *next;
>  	struct object_id old_oid;
> @@ -175,12 +163,6 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
>   */
>  struct ref *ref_remove_duplicates(struct ref *ref_map);
>  
> -int valid_fetch_refspec(const char *refspec);
> -struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
> -extern struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
> -
> -void free_refspec(int nr_refspec, struct refspec *refspec);
> -
>  extern int query_refspecs(struct refspec *specs, int nr, struct refspec *query);
>  char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
>  		     const char *name);
> @@ -313,8 +295,6 @@ extern int parseopt_push_cas_option(const struct option *, const char *arg, int
>  extern int is_empty_cas(const struct push_cas_option *);
>  void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
>  
> -#define TAG_REFSPEC "refs/tags/*:refs/tags/*"
> -
>  void add_prune_tags_to_fetch_refspec(struct remote *remote);
>  
>  #endif
> diff --git a/transport-helper.c b/transport-helper.c
> index 11f1055b4..b99e1cce9 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -11,6 +11,7 @@
>  #include "sigchain.h"
>  #include "argv-array.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "transport-internal.h"
>  #include "protocol.h"
>  
> diff --git a/transport.c b/transport.c
> index 37410d8aa..2cf63d18b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -11,6 +11,7 @@
>  #include "bundle.h"
>  #include "dir.h"
>  #include "refs.h"
> +#include "refspec.h"
>  #include "branch.h"
>  #include "url.h"
>  #include "submodule.h"
