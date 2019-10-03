Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6AB1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfJCXPX (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 19:15:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65244 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJCXPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 19:15:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EE1F23EEB;
        Thu,  3 Oct 2019 19:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9O3Z+EzdseWS
        jMvHEdsBUrZxBTI=; b=D56YEEHvib0WGxSNbu2wQaUGz+kPdOdHoWSnUQt4G2k2
        TNBlXBO16AtJc3IcKoTfYwrkZmBGMd+ERvgcKgzxmBL+FAT/mCYQobRBdj0N3tiJ
        Jo5qCRJFdFb14T3SDWMdKyq8/x5GkviiJPe69xiOWX+1xqNhUbvnGy+uAWV7a94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=j7guqR
        NPYZMCSBCU2qwDjhZ24ypNLidMGdSvUtRzKAOtuhr6FyUn/FqFgRGYdjpPFnZ/js
        VxV+N7KsR4OKVswH6a5GLx1lNo29F9uj+ye4iebF94cidwuhXyqOXj2QZCfIABvj
        av1C8BX58Z7tFKjIlws01oyUnNQU4GP/JoNtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7629023EEA;
        Thu,  3 Oct 2019 19:15:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE14423EE9;
        Thu,  3 Oct 2019 19:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: PATCH] remove duplicate #include directives
References: <1133ae3b-81e8-4ec1-c2d7-d071e7e65ec1@web.de>
Date:   Fri, 04 Oct 2019 08:15:18 +0900
In-Reply-To: <1133ae3b-81e8-4ec1-c2d7-d071e7e65ec1@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 3 Oct 2019 14:18:34 +0200")
Message-ID: <xmqqh84pa0ah.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AB0708C2-E633-11E9-B2C7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Found with "git grep '^#include ' '*.c' | sort | uniq -d".
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Patch formatted with --function-context for easier review.

I have a mixed feelings about that.

The only audience benefitted by --function-context patch are those
who read the patch only in MUA without looking at anything outside
and declare they are done with reviewing the patch.  For something
tricky, wider context does help to see what is going on, but then
I'd feel uncomfortable to hear "looks good to me" from those who did
not even apply the patch to their trees and looked at the changes
after "reviewing" tricky stuff that requires wider context to
properly review.

If there were topics in flight that touch any of these include
blocks, the patch would not apply and a reviewer who is interested
in these fixes ends up needing to wiggle them in somehow.  If a
reviewer does not trust you enough to feel the need to double check,
the result after applying the patches would be checked by running
"diff --function-context" by the reviewer (if it is tricky and
benefits from wider context) anyway.  If you've earned enough trust
that such a verification is not needed, the reviewer may not need to
see --function-context output.  So a patch that has less chance of
unnecessary conflict would be easier to handle in either case.

Having said all that, for _this_ particular case, I do not see a
reason why a review needs to look at anywhere outside the context
presented in this patch, so I'd say it is a narrow case that -W is
an appropriate thing to use.  I just do not want to see contributors
less experienced than you (hence cannot make good judgement on when
to and not to use the option) get in the habit of using -W all the
time.

And needless to say, the changes in the patch look good.

Thanks.

> diff --git a/builtin/am.c b/builtin/am.c
> index ee7305eaa6..b015e1d7d1 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1,40 +1,39 @@
>  /*
>   * Builtin "git am"
>   *
>   * Based on git-am.sh by Junio C Hamano.
>   */
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "builtin.h"
>  #include "exec-cmd.h"
>  #include "parse-options.h"
>  #include "dir.h"
>  #include "run-command.h"
>  #include "quote.h"
>  #include "tempfile.h"
>  #include "lockfile.h"
>  #include "cache-tree.h"
>  #include "refs.h"
>  #include "commit.h"
>  #include "diff.h"
>  #include "diffcore.h"
>  #include "unpack-trees.h"
>  #include "branch.h"
>  #include "sequencer.h"
>  #include "revision.h"
>  #include "merge-recursive.h"
> -#include "revision.h"
>  #include "log-tree.h"
>  #include "notes-utils.h"
>  #include "rerere.h"
>  #include "prompt.h"
>  #include "mailinfo.h"
>  #include "apply.h"
>  #include "string-list.h"
>  #include "packfile.h"
>  #include "repository.h"
>
>  /**
>   * Returns the length of the first line of msg.
>   */
> diff --git a/builtin/blame.c b/builtin/blame.c
> index bfd537b344..9858d6b269 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1,32 +1,31 @@
>  /*
>   * Blame
>   *
>   * Copyright (c) 2006, 2014 by its authors
>   * See COPYING for licensing conditions
>   */
>
>  #include "cache.h"
>  #include "config.h"
>  #include "color.h"
>  #include "builtin.h"
>  #include "repository.h"
>  #include "commit.h"
>  #include "diff.h"
>  #include "revision.h"
>  #include "quote.h"
>  #include "string-list.h"
>  #include "mailmap.h"
>  #include "parse-options.h"
>  #include "prio-queue.h"
>  #include "utf8.h"
>  #include "userdiff.h"
>  #include "line-range.h"
>  #include "line-log.h"
>  #include "dir.h"
>  #include "progress.h"
>  #include "object-store.h"
>  #include "blame.h"
> -#include "string-list.h"
>  #include "refs.h"
>
>  static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] [=
<rev>] [--] <file>");
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 2048b6760a..9d73102c42 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1,44 +1,43 @@
>  /*
>   * Builtin "git clone"
>   *
>   * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>,
>   *		 2008 Daniel Barkalow <barkalow@iabervon.org>
>   * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
>   *
>   * Clone a repository into a different directory that does not yet exi=
st.
>   */
>
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
>  #include "lockfile.h"
>  #include "parse-options.h"
>  #include "fetch-pack.h"
>  #include "refs.h"
>  #include "refspec.h"
>  #include "object-store.h"
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "unpack-trees.h"
>  #include "transport.h"
>  #include "strbuf.h"
>  #include "dir.h"
>  #include "dir-iterator.h"
>  #include "iterator.h"
>  #include "sigchain.h"
>  #include "branch.h"
>  #include "remote.h"
>  #include "run-command.h"
>  #include "connected.h"
>  #include "packfile.h"
>  #include "list-objects-filter-options.h"
> -#include "object-store.h"
>
>  /*
>   * Overall FIXMEs:
>   *  - respect DB_ENVIRONMENT for .git/objects.
>   *
>   * Implementation notes:
>   *  - dropping use-separate-remote and no-separate-remote compatibilit=
y
>   *
>   */
> diff --git a/builtin/describe.c b/builtin/describe.c
> index e048f85484..90feab1120 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -1,22 +1,21 @@
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
>  #include "commit.h"
>  #include "tag.h"
>  #include "blob.h"
>  #include "refs.h"
>  #include "builtin.h"
>  #include "exec-cmd.h"
>  #include "parse-options.h"
>  #include "revision.h"
>  #include "diff.h"
>  #include "hashmap.h"
>  #include "argv-array.h"
>  #include "run-command.h"
>  #include "object-store.h"
> -#include "revision.h"
>  #include "list-objects.h"
>  #include "commit-slab.h"
>
>  #define MAX_TAGS	(FLAG_BITS - 1)
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index b8dc2e1fba..fb8187fba5 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -1,24 +1,23 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "commit.h"
>  #include "diff.h"
>  #include "revision.h"
>  #include "list-objects.h"
>  #include "list-objects-filter.h"
>  #include "list-objects-filter-options.h"
>  #include "object.h"
>  #include "object-store.h"
>  #include "pack.h"
>  #include "pack-bitmap.h"
>  #include "builtin.h"
>  #include "log-tree.h"
>  #include "graph.h"
>  #include "bisect.h"
>  #include "progress.h"
>  #include "reflog-walk.h"
>  #include "oidset.h"
>  #include "packfile.h"
> -#include "object-store.h"
>
>  static const char rev_list_usage[] =3D
>  "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7f094f8170..0a53788151 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1,16 +1,15 @@
>  #include "cache.h"
>  #include "checkout.h"
>  #include "config.h"
>  #include "builtin.h"
>  #include "dir.h"
>  #include "parse-options.h"
>  #include "argv-array.h"
>  #include "branch.h"
>  #include "refs.h"
>  #include "run-command.h"
>  #include "sigchain.h"
>  #include "submodule.h"
> -#include "refs.h"
>  #include "utf8.h"
>  #include "worktree.h"
>
> diff --git a/object.c b/object.c
> index 07bdd5b26e..3b8b8c55c9 100644
> --- a/object.c
> +++ b/object.c
> @@ -1,13 +1,12 @@
>  #include "cache.h"
>  #include "object.h"
>  #include "replace-object.h"
>  #include "object-store.h"
>  #include "blob.h"
>  #include "tree.h"
>  #include "commit.h"
>  #include "tag.h"
>  #include "alloc.h"
> -#include "object-store.h"
>  #include "packfile.h"
>  #include "commit-graph.h"
>
> diff --git a/packfile.c b/packfile.c
> index f3f962af4c..87512540f8 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1,20 +1,19 @@
>  #include "cache.h"
>  #include "list.h"
>  #include "pack.h"
>  #include "repository.h"
>  #include "dir.h"
>  #include "mergesort.h"
>  #include "packfile.h"
>  #include "delta.h"
> -#include "list.h"
>  #include "streaming.h"
>  #include "sha1-lookup.h"
>  #include "commit.h"
>  #include "object.h"
>  #include "tag.h"
>  #include "tree-walk.h"
>  #include "tree.h"
>  #include "object-store.h"
>  #include "midx.h"
>  #include "commit-graph.h"
>  #include "promisor-remote.h"
> diff --git a/shallow.c b/shallow.c
> index 5fa2b15d37..ae813658fb 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -1,21 +1,18 @@
>  #include "cache.h"
>  #include "repository.h"
>  #include "tempfile.h"
>  #include "lockfile.h"
>  #include "object-store.h"
>  #include "commit.h"
>  #include "tag.h"
>  #include "pkt-line.h"
>  #include "remote.h"
>  #include "refs.h"
>  #include "sha1-array.h"
>  #include "diff.h"
>  #include "revision.h"
>  #include "commit-slab.h"
> -#include "revision.h"
>  #include "list-objects.h"
> -#include "commit-slab.h"
> -#include "repository.h"
>  #include "commit-reach.h"
>
>  void set_alternate_shallow_file(struct repository *r, const char *path=
, int override)
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f0f56d40ac..33ea7810d8 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1,27 +1,26 @@
>  #include "cache.h"
>  #include "argv-array.h"
>  #include "repository.h"
>  #include "config.h"
>  #include "dir.h"
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "cache-tree.h"
>  #include "unpack-trees.h"
>  #include "progress.h"
>  #include "refs.h"
>  #include "attr.h"
>  #include "split-index.h"
> -#include "dir.h"
>  #include "submodule.h"
>  #include "submodule-config.h"
>  #include "fsmonitor.h"
>  #include "object-store.h"
>  #include "promisor-remote.h"
>
>  /*
>   * Error messages expected by scripts out of plumbing commands such as
>   * read-tree.  Non-scripted Porcelain is not required to use these mes=
sages
>   * and in fact are encouraged to reword them to better suit their part=
icular
>   * situation better.  See how "git checkout" and "git merge" replaces
>   * them using setup_unpack_trees_porcelain(), for example.
>   */
> --
> 2.23.0
