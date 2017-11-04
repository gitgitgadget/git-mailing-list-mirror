Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2E720450
	for <e@80x24.org>; Sat,  4 Nov 2017 04:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdKDDtX (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 23:49:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750959AbdKDDtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 23:49:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1E81B3A05;
        Fri,  3 Nov 2017 23:49:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+EHS0j1sHxev
        TS66AFcvNp9ALfI=; b=JQlSLhUwfIhmp4Iq6eaXj/mwM1ADzewF1P+wetw+0HHm
        8rkRLjkxT169Gcc2n1L5DSHd48n1O2ozgq+cToQxOTxewYNMXK2k79janw9wwRv/
        aB8O0dfrPsFH5wQQ/RDff73ZpvO2Z+HzfeWwy9ChyU+dD1Rs28LjQWaFlCipMU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=E3Tbtz
        8nWl17JS74MXXZGSZ16AL+bodnQv9Ik5bSI5JssOt1CzRqTgILIalQ7bA5hxWeRq
        hJiquaHWDdcZcfqrLhRE/4Dvz91EPwozJ46zbZ5KdEcWybtaBOnWnYfUwxIzieY1
        LdAq3UpjK5qbBbH5bcsDHLjO1H8qldaITPBkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8825B3A03;
        Fri,  3 Nov 2017 23:49:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 484D8B3A02;
        Fri,  3 Nov 2017 23:49:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-3-rafa.almas@gmail.com>
Date:   Sat, 04 Nov 2017 12:49:15 +0900
In-Reply-To: <20171104004144.5975-3-rafa.almas@gmail.com> ("Rafael
 =?utf-8?Q?Ascens=C3=A3o=22's?=
        message of "Sat, 4 Nov 2017 00:41:44 +0000")
Message-ID: <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2134FEDE-C113-11E7-B06F-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

> When `log --decorate` is used, git will decorate commits with all
> available refs. While in most cases this the desired effect, under some
> conditions it can lead to excessively verbose output.

Correct.

> Using `--exclude=3D<pattern>` can help mitigate that verboseness by
> removing unnecessary 'branches' from the output. However, if the tip of
> an excluded ref points to an ancestor of a non-excluded ref, git will
> decorate it regardless.

Is this even relevant?  I think the above would only serve to
confuse the readers.  --exclude, --branches, etc. are ways to
specify what starting points "git log" history traversal should
begin and has nothing to do with what set of refs are to be used to
decorate the commits that are shown.  But the paragraph makes
readers wonder if it might have any effect in some circumstances.

> With `--decorate-refs=3D<pattern>`, only refs that match <pattern> are
> decorated while `--decorate-refs-exclude=3D<pattern>` allows to do the
> reverse, remove ref decorations that match <pattern>

And "Only refs that match ... are decorated" is also confusing.  The
thing is, refs are never decorated, they are used for decorating
commits in the output from "git log".  For example, if you have=20

	---A---B---C---D

and B is at the tip of the 'master' branch, the output from "git log
D" would decorate B with 'master', even if you do not say 'master'
on the command line as the commit to start the traversal from.

Perhaps drop the irrelevant paragraph about "--exclude" and write
something like this instead?

	When "--decorate-refs=3D<pattern>" is given, only the refs
	that match the pattern is used in decoration.  The refs that
	match the pattern, when "--decorate-refs-exclude=3D<pattern>"
	is given, are never used in decoration.

> Both can be used together but --decorate-refs-exclude patterns have
> precedence over --decorate-refs patterns.

A reasonable and an easy-to-explain way to mix zero or more positive
and zero or more negagive patterns that follows the convention used
elsewhere in the system (e.g. how negative pathspecs work) is

 (1) if there is no positive pattern given, pretend as if an
     inclusive default positive pattern was given;

 (2) for each candidate, reject it if it matches no positive
     pattern, or if it matches any one of negative patterns.

For pathspecs, we use "everything" as the inclusive default positive
pattern, I think, and for the set of refs used for decoration, a
reasonable choice would also be to use "everything", which matches
the current behaviour.

> The pattern follows similar rules as `--glob` except it doesn't assume =
a
> trailing '/*' if glob characters are missing.

Why should this be a special case that burdens users to remember one
more rule?  Wouldn't users find "--decorate-refs=3Drefs/tags" useful
and it woulld be shorter and nicer than having to say "refs/tags/*"?

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 32246fdb0..314417d89 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -38,6 +38,18 @@ OPTIONS
>  	are shown as if 'short' were given, otherwise no ref names are
>  	shown. The default option is 'short'.
> =20
> +--decorate-refs=3D<pattern>::
> +	Only print ref names that match the specified pattern. Uses the same
> +	rules as `git rev-list --glob` except it doesn't assume a trailing a
> +	trailing '/{asterisk}' if pattern lacks '?', '{asterisk}', or '['.
> +	`--decorate-refs-exlclude` has precedence.
> +
> +--decorate-refs-exclude=3D<pattern>::
> +	Do not print ref names that match the specified pattern. Uses the sam=
e
> +	rules as `git rev-list --glob` except it doesn't assume a trailing a
> +	trailing '/{asterisk}' if pattern lacks '?', '{asterisk}', or '['.
> +	Has precedence over `--decorate-refs`.

These two may be technically correct, but I wonder if we can make it
easier to understand (I found "precedence" bit hard to follow, as in
my mind, these are ANDed conditions and between (A & ~B), there is
no "precedence").  Also we'd want to clarify what happens when only
"--decorate-refs-exclude"s are given, which in turn necessitates us
to describe what happens when only "--decorate-refs"s are given.

> diff --git a/log-tree.c b/log-tree.c
> index cea056234..8efc7ac3d 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -94,9 +94,33 @@ static int add_ref_decoration(const char *refname, c=
onst struct object_id *oid,
>  {
>  	struct object *obj;
>  	enum decoration_type type =3D DECORATION_NONE;
> +	struct ref_include_exclude_list *filter =3D (struct ref_include_exclu=
de_list *)cb_data;
> +	struct string_list_item *item;
> +	struct strbuf real_pattern =3D STRBUF_INIT;
> +
> +	if(filter && filter->exclude->nr > 0) {

Have SP before '('.

> +		/* if current ref is on the exclude list skip */
> +		for_each_string_list_item(item, filter->exclude) {
> +			strbuf_reset(&real_pattern);
> +			normalize_glob_ref(&real_pattern, NULL, item->string, 0);
> +			if (!wildmatch(real_pattern.buf, refname, 0))
> +				goto finish;
> +		}
> +	}
> =20
> -	assert(cb_data =3D=3D NULL);
> +	if (filter && filter->include->nr > 0) {
> +		/* if current ref is present on the include jump to decorate */
> +		for_each_string_list_item(item, filter->include) {
> +			strbuf_reset(&real_pattern);
> +			normalize_glob_ref(&real_pattern, NULL, item->string, 0);
> +			if (!wildmatch(real_pattern.buf, refname, 0))
> +				goto decorate;
> +		}
> +		/* Filter was given, but no match was found, skip */
> +		goto finish;
> +	}

The above seems to implement the natural mixing of negative and
positive patterns, which is good.

Unless I am missing something, I think these normalize_grob_ref()
calls should be removed from this function; add_ref_decoration() is
called once for EVERY ref the repository has, so you are normalizing
a handful of patterns you got from the user over and over to get the
same normalization, possibly thousands of times in a repository of a
project with long history.

You have finished collecting patterns on filter->{exclude,include}
list from the user by the time "for_each_ref(add_ref_decoration)" is
called in load_ref_decorations(), and these patterns never changes
after that. =20

Perhaps normalize the patterns inside load_ref_decorations() only
once and have the normalized patterns in the filter lists?

> +decorate:
>  	if (starts_with(refname, git_replace_ref_base)) {
>  		struct object_id original_oid;
>  		if (!check_replace_refs)
> @@ -136,6 +160,9 @@ static int add_ref_decoration(const char *refname, =
const struct object_id *oid,
>  			parse_object(&obj->oid);
>  		add_name_decoration(DECORATION_REF_TAG, refname, obj);
>  	}
> +
> +finish:
> +	strbuf_release(&real_pattern);
>  	return 0;
>  }
> =20
> @@ -148,15 +175,15 @@ static int add_graft_decoration(const struct comm=
it_graft *graft, void *cb_data)
>  	return 0;
>  }
> =20
> -void load_ref_decorations(int flags)
> +void load_ref_decorations(int flags, struct ref_include_exclude_list *=
data)
>  {
>  	if (!decoration_loaded) {
> =20
>  		decoration_loaded =3D 1;
>  		decoration_flags =3D flags;
> -		for_each_ref(add_ref_decoration, NULL);
> -		head_ref(add_ref_decoration, NULL);
> -		for_each_commit_graft(add_graft_decoration, NULL);
> +		for_each_ref(add_ref_decoration, data);
> +		head_ref(add_ref_decoration, data);
> +		for_each_commit_graft(add_graft_decoration, data);

Don't name that variable "data".

for_each_*() and friends that take a callback with callback specific
data MUST call the callback specific data as generic, e.g. cb_data,
because they do not know what they are passing.  The callers of
these functions, like this one, however, know what they are passing.
Also load_ref_decorations() itself knows what its second parameter
is.

    void load_ref_decorations(int flags, struct decoration_filter *filter=
)

or something (see below).

>  	}
>  }
> =20
> diff --git a/log-tree.h b/log-tree.h
> index 48f11fb74..66563af88 100644
> --- a/log-tree.h
> +++ b/log-tree.h
> @@ -7,6 +7,10 @@ struct log_info {
>  	struct commit *commit, *parent;
>  };
> =20
> +struct ref_include_exclude_list {
> +	struct string_list *include, *exclude;
> +};

The "decoration" is not the only thing related to "ref" in the
log-tree API; calling this structure that filters what refs to be
used for decoration with the above name without saying that this is
about "decoration" is too selfish and unmaintainable.

How about "struct decoration_filter" and rename the fields to say
"{include,exclude}_ref_pattern" or something like that?  The
renaming of the fields to include "ref" somewhere is coming from the
same concern---it will be selfish and narrow-minded to imagine that
the ways to filter refs used for decoration will stay forever only
based on refnames and nothing else, which would be the reason not to
have "ref" somewhere in the names.

