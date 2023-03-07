Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A491C6FD1A
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 14:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjCGOSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 09:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjCGOSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 09:18:25 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E78E3EE
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 06:14:10 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id s11so52764669edy.8
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 06:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678198325;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wuNuQ5NPLYuNP/IqqmIIqHft4JJBILrEdvSF/eqMvoo=;
        b=ZpAgIfOpm4NIZzYT+vIhCGBzsP1J3byu+iz0Lrp/5eHT0xljCnOeqKHsnsgx77v4qs
         P4B6oYKcBsDW4jlsc+sTeG47q2vXVA9VbT0UiIXcSJMedq+LDlmq6fi7sQR72sWqGc2W
         SsWyKWmuo1M6QjPNAIWP5qp7tYEOr8hdc0jWKtwSJ2yYChlQsbqA/hLQRXWcNUZi3z6F
         YbAFTdz0WuY7go6p9Ia/RFSz/z8Bb+A7WyNAhVK/34OeHRoeE5CgWYFVXWntHgcaFirl
         C3WRB9BmpCJPnOiKWSb8bPqtDeR4lDjVRMw07ExOxcn4A7EOekIzazZaiT3oqMuK3GFF
         k1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678198325;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuNuQ5NPLYuNP/IqqmIIqHft4JJBILrEdvSF/eqMvoo=;
        b=uSPgtBlL0ck9qeC43wwjfpMAbpNDNAl4dFcEaCCOJ9GmRClRAvRP46N8ezwyXgGZwq
         nCSnWLA9HMwkxIp4DLCLnyQUau5ut+Vz36KQH+TEL7MSU7SNfu8C+Jr0Lm0OAIyGX8oJ
         Hng73eHvVk7CH9eWqnvICvROaQsYlp6fa4JbrdbpuZHZ+DGJb8vWW/O3aC304CfbOLTL
         i7wfeN8Xu6eg52omtESpjX8SDgMdh6R4yH5TKw9cjCPLGLdNEYs6oPAXIEh8dA1M9NxM
         4/Ql8a//z2cbRZ+w72OyCO3UOPTStbWwOPwj7bLjc7Kz8FuN+Pj0QqVVzwUrG7xZM6hb
         qWRg==
X-Gm-Message-State: AO0yUKWlskf8oUURI655ENtB8Yiu9fyglGsa3j1qlHDbOX5vk4FdYoVJ
        Unxf23hg30GZzYqdT66zZa0=
X-Google-Smtp-Source: AK7set/fPSZoZhNQoUkol2kgXbH/qtm7H+WPl4L6n8jIhYvc5NhgBCoEx7U4ReM9ty7ZL+lpYTRZbQ==
X-Received: by 2002:a17:906:6c84:b0:8b1:32b0:2a24 with SMTP id s4-20020a1709066c8400b008b132b02a24mr15080811ejr.47.1678198324823;
        Tue, 07 Mar 2023 06:12:04 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm6163777ejb.97.2023.03.07.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:12:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZY2t-000kjv-0u;
        Tue, 07 Mar 2023 15:12:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] blame-tree: add library and tests via "test-tool
 blame-tree"
Date:   Tue, 07 Mar 2023 14:56:29 +0100
References: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
 <4ab0b2b0-b045-2346-ccc1-19f9b23d0a02@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <4ab0b2b0-b045-2346-ccc1-19f9b23d0a02@github.com>
Message-ID: <230307.86o7p4zm4s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 10 2023, Derrick Stolee wrote:

> On 2/5/2023 3:47 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
>> +struct blame_tree_options {
>> +	struct object_id oid;
>> +	const char *prefix;
>> +	unsigned int recursive;
>> +	struct strvec args;
>> +};
>> +#define BLAME_TREE_OPTIONS_INIT(...) { \
>> +	.args =3D STRVEC_INIT, \
>> +	__VA_ARGS__ \
>> +}
>> +void blame_tree_opts_release(struct blame_tree_options *bto);
>> +
>> +struct blame_tree {
>> +	struct string_list paths;
>> +	struct rev_info rev;
>> +};
>> +#define BLAME_TREE_INIT { \
>> +	.paths =3D STRING_LIST_INIT_DUP, \
>> +	.rev =3D REV_INFO_INIT, \
>> +}
>> +
>> +void blame_tree_init(struct blame_tree *bt,
>> +		     const struct blame_tree_options *opts);
>> +void blame_tree_release(struct blame_tree *);
>> +
>> +typedef void (*blame_tree_fn)(const char *path, const struct commit *co=
mmit,
>> +			      void *data);
>> +int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *data);
>
> However, this API is too leaky. Specifically, it allows passing arbitrary
> 'args' instead of structured options.
>
> Before I get into what I think needs to change here, let's look at the
> initial implementation:
>
>> +int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *cbdat=
a)
>> +{
>> +	struct blame_tree_callback_data data;
>> +
>> +	data.paths =3D &bt->paths;
>> +	data.num_interesting =3D bt->paths.nr;
>> +	data.callback =3D cb;
>> +	data.callback_data =3D cbdata;
>> +
>> +	bt->rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
>> +	bt->rev.diffopt.format_callback =3D blame_diff;
>> +	bt->rev.diffopt.format_callback_data =3D &data;
>> +
>> +	prepare_revision_walk(&bt->rev);
>> +
>> +	while (data.num_interesting) {
>> +		data.commit =3D get_revision(&bt->rev);
>> +		if (!data.commit)
>> +			break;
>> +
>> +		if (data.commit->object.flags & BOUNDARY) {
>> +			diff_tree_oid(the_hash_algo->empty_tree,
>> +				       &data.commit->object.oid,
>> +				       "", &bt->rev.diffopt);
>> +			diff_flush(&bt->rev.diffopt);
>> +		} else {
>> +			log_tree_commit(&bt->rev, data.commit);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>
> When I think of 'blame-tree', I think of the following output:
>
>   For each path (within a pathspec, recursive or not), output the first
>   commit that changed that path according to simplified file history. This
>   history walk begins at a single commit, but may be terminated by a
>   negative commit range, so the output could indicate that we reached the
>   boundary.
>
> With that definition, the most-obvious first implementation would be to
> first generate the path list, then run
> `git rev-list -n 1 <revisions> -- <path>` for each path in the pathspec.
> This could be done by N prepare_revision_walk()/get_revision() executions
> within a loop instead of actually executing subcommands.
>
> The implementation in this patch is simultaneously smarter than that basic
> approach, but also not smart enough for the best performance. In order to
> get the optimal performance, the following parts of my output definition
> are critical:
>
>  1. We use simplified file history.
>  2. The history walk begins at a single commit.
>
> If either of these conditions are broken, then the current-best algorithm
> cannot be used (and even more: our proactive caching mechanism cannot be
> used).
>
> The API as currently defined does not allow us to enforce that restriction
> because the arbitrary arguments could specify `--full-history`, or worse
> `--simplify-merge` (and also `--first-parent`) to modify the history mode
> or even `--all` to modify the number of starting commits.

There's already a limitation on --all in this patch, or anything else
that would yield a many<->many rev<->path relationship, e.g. "--all" or
"HEAD HEAD~", that's covered by the "can only blame one tree at a time"
error condition.

For --full-history v.s. --simplify-merge the output on git.git at least
(maybe not on others?) would be the same:

	diff -u <(t/helper/test-tool -C "$PWD/t" blame-tree -- --full-history) <(t=
/helper/test-tool -C "$PWD/t" blame-tree -- --simplify-merge)

But of course for --first-parent it's not, but more on that below.

> The version we use in our custom fork has the historical baggage of this
> open-ended argument-parsing, but because we have full control of the
> callers to the CLI, we have enforced that those arguments are not being
> used. While we are not currently reviewing the CLI of a builtin, the API
> layer is essentially providing a pass-through of arbitrary revision optio=
ns.
>
> I am happy to see that the 'struct blame_tree_options' includes a callback
> for the output, as that is valuable for both reporting results to stdout
> or to collect results into a list for caching purposes, in the future
> where we have that ability.
>
> --- Recommended API ---
>
> Using 'struct blame_tree_options' instead of many parameters creates a
> good future-proof method prototype, so we can always _add_ options when
> explicitly understood as important to callers of one kind or another.
>
> However, to drop the arbitrary 'args' we need to instead make it very
> explicit which commits are being used in the history walk.
>
> struct blame_tree_options {
> 	struct object_id oid;
> 	const char *prefix;
> 	unsigned int recursive;
> 	struct commit *start;
> 	struct commit_list *uninteresting;
> };
>
> This definition of the struct should be enough to demonstrate the behavior
> we are describing. However, for the v1 of the API, we may even want to
> completely remove the 'uninteresting' choice, and instead focus only on a
> single starting position ('start'). If we decide that 'uninteresting' is
> valuable, then it can be added again later, hopefully after the primary
> use of this command is established.
>
> Again, thinking about the lifetime of this command in our infrastructure,
> the commit range behavior was used at one point as a performance improvem=
ent
> where a cache was given for a specific starting commit B, then we
> dynamically computed the blame-tree for the range B..A when given a new
> commit A, and merged the two results together. However, this was not alwa=
ys
> correct due to complexities around parallel changes. A different caching
> mechanism was built into the low-level algorithm itself which resolves
> these complications, but also _that cache cannot be used when given range
> queries_.
>
> Further, I recommend building the simplest implementation first, since it
> is actually closer to the very fast implementation in that it has two
> parts:
>
>  1. Compute the list of paths at the tip.
>  2. Perform history walks for those paths.
>
> The fast implementation does a single history walk that essentially walks
> the simplified history for all of the paths simultaneously, but it is
> critical to have that list of paths at the start of that walk. In that way
> it's actually easier to adapt the simpler algorithm to the current-best
> algorithm than it is to adapt the smart algorithm from this patch to the
> current-best algorithm.
>
> All this is to say, that I'd like to see this API start with the smallest
> possible surface area and with the simplest implementation, and then I'd
> be happy to contribute those algorithms within the API boundary while the
> CLI is handled independently.

I hear your concern about leaving this open for optimization, and in
general I'd vehemently agree with it, except for needing to eventually
feed a command-line to setup_revisions().

Ideally the revision API would make what you're describing easy, but the
way it's currently implemented (and changing it would be a much larger
project) someone who'd like to pass structured options in the way you'd
describe will end up having to re-implement bug-for-bug compatible
versions of some subset of the option parsing in revision.c.

Isn't a way to get the best of both worlds to have a small snippet of
code that inspects the "struct rev_info" before & after
setup_revisions(), and which would only implement certain optimizations
if certain known options are provided, but not if any unknown ones are?

That way those who'd like the faster happy path could use that subset of
options, while the general API would allow any revision options. We'd
then error() or BUG() out only if we fail to map our expected paths to
OIDs.

Specifically, I'm thinking of something similar to what
match_stat_with_submodule() in diff-lib.c now does with "orig_flags".

I also think as a practical matter it's acceptable for us to leave the
underlying low-level API open-ended for potential (ab)use, while any
porcelain or plumbing tool for this would document that a given narrow
subset of revision options is what we expect.

That's what we do for format-patch, and e.g. as of my df569c3f31f
(range-diff doc: add a section about output stability, 2018-11-09)
range-diff explicitly documents that feeding it options it won't expect
might result in nonsense output.

I think those are all good ways forward here, and I'd much prefer those
to having to re-implement or pull out subsets of the current option
parsing logic in revision.c. What do you think?
