Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C932018E
	for <e@80x24.org>; Thu, 18 Aug 2016 19:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbcHRTK2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 15:10:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753008AbcHRTKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 15:10:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 56E2934E8F;
	Thu, 18 Aug 2016 12:52:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JN0sL0+P2v2GHNoUzFz8e3v2Rng=; b=xGO+/x
	SQP6zKH36fI1psqv1tYSzFfZmYt4wpzCtq4Zf53sIJPDCpeZa8X4IC7fRsOlzuxV
	P027qbPwoSWiWAqbrHzalaa4rBhc4HRPYwdnQWNi/52JoLXwpYX1T7niL2VXZl4e
	uNZ+y4Imkdu6NbWpfp+hOGY5g12hxXbWKV9tE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BECdpR1zOTaR3w67M61Id7g4vvnl4bpg
	EgcqC3J2ip+14wJt3vBbctCVOgPBNabi2Lp79lUemlLEp5O6u5VMD52kpzR2dfsl
	L5LPTvuY7vfD5cGCx1jNqYGYh4apHcy56kMWc+e4+RTWs0b//fmHUUVLSBNd7fBB
	Me87pXvpirM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EA0B34E8E;
	Thu, 18 Aug 2016 12:52:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA00034E8D;
	Thu, 18 Aug 2016 12:52:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 3/4] cat-file --textconv/--filters: allow specifying the path separately
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
	<787224ce9a382ddd1180a408e784ca26993e5603.1471524357.git.johannes.schindelin@gmx.de>
Date:	Thu, 18 Aug 2016 09:52:52 -0700
In-Reply-To: <787224ce9a382ddd1180a408e784ca26993e5603.1471524357.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 18 Aug 2016 14:46:23 +0200
	(CEST)")
Message-ID: <xmqqfuq26mu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3566422A-6564-11E6-BA4F-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There are circumstances when it is relatively easy to figure out the
> object name for a given path, but not the revision. For example, when

revision of the containing tree, I presume?

> Let's simplify this dramatically, because we do not really need that
> revision at all: all we care about is that we know the path. In the
> scenario described above, we do know the path, and we just want to
> specify it separately from the object name.

I wouldn't call it "simplifying dramatically".  It is just to
support two use cases that is different from the use case where you
want to use "<tree>:<path>".

We already have a precedent in "hash-object --path=<path>" for these
two different uses cases from the primary one.  That form can be
used when we know the contents but we do not know where the contents
came from.  It can also be used when we want to pretend that
contents came from a specific path, that may be different from the
file we are hashing.

Let's be consistent and (1) call it "--path", and (2) explain it as
a feature to allow you to tell the path separately or allow you to
pretend that the content is at a path different from reality.

After all, you would want to ignore <path2> part in this construct:

	git cat-file --filter --path=<path1> HEAD:<path2>

for the purpose of filtering, right?

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 0b74afa..5ff58b3 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -20,6 +20,8 @@ struct batch_options {
>  	const char *format;
>  };
>  
> +static const char *force_path;
> +
>  static int filter_object(const char *path, unsigned mode,
>  			 const unsigned char *sha1,
>  			 char **buf, unsigned long *size)
> @@ -89,21 +91,24 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  		return !has_sha1_file(sha1);
>  
>  	case 'w':
> -		if (!obj_context.path[0])
> +		if (!force_path && !obj_context.path[0])
>  			die("git cat-file --filters %s: <object> must be "
>  			    "<sha1:path>", obj_name);
>  
> -		if (filter_object(obj_context.path, obj_context.mode,
> +		if (filter_object(force_path ? force_path : obj_context.path,
> +				  force_path ? 0100644 : obj_context.mode,
>  				  sha1, &buf, &size))

The mode override is somewhat questionable.  Wouldn't you want to
reject

	git cat-file --filter --path=Makefile HEAD:RelNotes

when HEAD:RelNotes blob is known to be a symbolic link?  After all,
you would reject this

	git cat-file --filter --path=Makefile HEAD:t/

and it is quite similar, no?  I think this can be argued both ways,
but I have a feeling that obj_context.mode, if available, should be
honored with or without force_path.

> diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
> index e466634..fd17159 100755
> --- a/t/t8010-cat-file-filters.sh
> +++ b/t/t8010-cat-file-filters.sh
> @@ -31,4 +31,17 @@ test_expect_success 'cat-file --filters converts to worktree version' '
>  	has_cr actual
>  '
>  
> +test_expect_success 'cat-file --filters --use-path=<path> works' '
> +	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
> +	git cat-file --filters --use-path=world.txt $sha1 >actual &&
> +	has_cr actual
> +'
> +
> +test_expect_success 'cat-file --textconv --use-path=<path> works' '
> +	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
> +	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
> +	git cat-file --textconv --use-path=hello.txt $sha1 >rot13 &&
> +	test uryyb = "$(cat rot13 | remove_cr)"
> +'

I think I saw some code to ensure "when giving this option you need
that option in effect, too"; they should be tested here, too, no?
