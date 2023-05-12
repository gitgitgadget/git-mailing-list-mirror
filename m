Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD0C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbjELTEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjELTED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:04:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482C2722
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:04:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f3956573fbso10065331cf.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683918241; x=1686510241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2nGtcSP0ARQqKAjvzzJ/2CbMUwQXkYq1monGxlh3Fs=;
        b=rkt0HpTFYDKmeW2rAF8WJ2pzSuYnSuiRuztcp1r9tdgXUqkiKvEg5Ws54TQbxGydft
         zmUAGexzlZF0jTD6LPSwGJpoXUOn6YWUiRUB2W49hF30Lx5BQhNqxtWYs0TWBpGgFNHh
         gLuIHFa4/uqKNb9NfEgeS7O4yHDULVCJzf7ZMS4HnLlNTViC2A8oybzpK3UTigxCvfjQ
         a/RenpqMq1H9j2ZU1hm6EVkejrO2IbQ9g/9VrQkermhV2GEoiEoTQcrK18jngpsUQzTL
         ctlvXIqaLb0riu1ZeI0gBt6iT/Dk/EmAWA0jRsUwn2suy3xqIYPcXZC8GmAihbbz1BAb
         gbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683918241; x=1686510241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2nGtcSP0ARQqKAjvzzJ/2CbMUwQXkYq1monGxlh3Fs=;
        b=X2PBCublxXJwgIkEW5jE9YRmkUpE1jKh0BlnF4BGIQaqCp2/mQNr2BeP46mvhT9kWb
         VjS6bO+wDdXwSTN2fArZG7JFgqHcJg0e9w6IK7e2pwJvKR/K0NshNHs51g8NcoEyXB69
         XontsWZOFwzP9RYS1aT8HisAD3GlnjnK2MsXQFO8E7KLa4X/cAshzUlcxa8h5bTIm2Qb
         kHtRqeDAAmyL/6KjY8sNIjVZtaJXmj0uA35ckLg4iC1ZKwCsos/49cXwuxOO6ewDn0Xn
         yWCf8a2gKKpbz7wPzk4+CaXPSE/Xwf2WzQz2s8Lv7dPXvWIokZErw64zDl6MNT/O4VGH
         wOSg==
X-Gm-Message-State: AC+VfDyf6k0hZWzs9o1WTptinzKc13vGzFnKxu5oF2xaEKBQAcj9mbuh
        e1KSQbPp7+l1OC6mehceXsVE439i11Q=
X-Google-Smtp-Source: ACHHUZ7KBzaCHJLK8dK3FBxwADn3jw9SoqAFjb18ODd64no/I9P323UGLSBLy7w1UHIe3HA86YY9uQ==
X-Received: by 2002:a05:622a:1450:b0:3f4:e4e5:af7c with SMTP id v16-20020a05622a145000b003f4e4e5af7cmr13350814qtx.5.1683918240803;
        Fri, 12 May 2023 12:04:00 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:4533:8b00:18f3:8a21:eac1:94c8])
        by smtp.gmail.com with ESMTPSA id c16-20020ac80090000000b003f3963d24ebsm3318477qtg.30.2023.05.12.12.03.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2023 12:04:00 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] pack-refs: teach pack-refs --include option
Date:   Fri, 12 May 2023 15:03:59 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <4086BA28-57C5-43FF-BD3D-D4731ACD6E64@gmail.com>
In-Reply-To: <b2f3b98cd2461a25ab708adbcd8a95f5e2b18e5e.1683828635.git.gitgitgadget@gmail.com>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
 <b2f3b98cd2461a25ab708adbcd8a95f5e2b18e5e.1683828635.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11 May 2023, at 14:10, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Allow users to be more selective over which refs to pack by adding an
> --include option to git-pack-refs.
>
> The existing options allow some measure of selectivity. By default
> git-pack-refs packs all tags. --all can be used to include all refs,
> and the previous commit added the ability to exclude certain refs with
> --exclude.
>
> While these knobs give the user some selection over which refs to pack,=

> it could be useful to give more control. For instance, a repository may=

> have a set of branches that are rarely updated and would benefit from
> being packed. --include would allow the user to easily include a set of=

> branches to be packed while leaving everything else unpacked.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/git-pack-refs.txt | 14 +++++++++++++-
>  builtin/pack-refs.c             | 18 ++++++++++++++++--
>  refs/files-backend.c            | 15 +++++++--------
>  t/helper/test-ref-store.c       |  8 +++++++-
>  t/t3210-pack-refs.sh            | 21 +++++++++++++++++++++
>  5 files changed, 64 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-r=
efs.txt
> index c0f7426e519..85874a5f5dc 100644
> --- a/Documentation/git-pack-refs.txt
> +++ b/Documentation/git-pack-refs.txt
> @@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repos=
itory access
>  SYNOPSIS
>  --------
>  [verse]
> -'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
> +'git pack-refs' [--all] [--no-prune] [--include <pattern>] [--exclude =
<pattern>]
>
>  DESCRIPTION
>  -----------
> @@ -60,6 +60,15 @@ interests.
>  The command usually removes loose refs under `$GIT_DIR/refs`
>  hierarchy after packing them.  This option tells it not to.
>
> +--include <pattern>::
> +
> +Pack refs based on a `glob(7)` pattern. Repetitions of this option
> +accumulate inclusion patterns. If a ref is both included in `--include=
` and
> +`--exclude`, `--exclude` takes precedence. Using `--include` will prec=
lude all
> +tags from being included by default. Symbolic refs and broken refs wil=
l never
> +be packed. When used with `--all`, it will be a noop. Use `--no-includ=
e` to clear
> +and reset the list of patterns.
> +
>  --exclude <pattern>::
>
>  Do not pack refs matching the given `glob(7)` pattern. Repetitions of =
this option
> @@ -70,6 +79,9 @@ unpack it.
>  When used with `--all`, it will use the difference between the set of =
all refs,
>  and what is provided to `--exclude`.
>
> +When used with `--include`, refs provided to `--include`, minus refs t=
hat are
> +provided to `--exclude` will be packed.
> +
>
>  BUGS
>  ----
> diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
> index 2464575a665..5062206f22e 100644
> --- a/builtin/pack-refs.c
> +++ b/builtin/pack-refs.c
> @@ -5,9 +5,10 @@
>  #include "refs.h"
>  #include "repository.h"
>  #include "revision.h"
> +#include "trace.h"
>
>  static char const * const pack_refs_usage[] =3D {
> -	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
> +	N_("git pack-refs [--all] [--no-prune] [--include <pattern>] [--exclu=
de <pattern>]"),
>  	NULL
>  };
>
> @@ -15,13 +16,17 @@ int cmd_pack_refs(int argc, const char **argv, cons=
t char *prefix)
>  {
>  	unsigned int flags =3D PACK_REFS_PRUNE;
>  	static struct ref_visibility visibility =3D REF_VISIBILITY_INIT;
> -	struct pack_refs_opts pack_refs_opts =3D {.visibility =3D &visibility=
, .flags =3D flags};
> +	struct pack_refs_opts pack_refs_opts =3D { .visibility =3D &visibilit=
y,
> +						 .flags =3D flags };
>  	static struct string_list option_excluded_refs =3D STRING_LIST_INIT_N=
ODUP;
> +	static struct string_list option_included_refs =3D STRING_LIST_INIT_N=
ODUP;
>  	struct string_list_item *item;
>
>  	struct option opts[] =3D {
>  		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PA=
CK_REFS_ALL),
>  		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (def=
ault)"), PACK_REFS_PRUNE),
> +		OPT_STRING_LIST(0, "include", &option_included_refs, N_("pattern"),
> +			N_("references to include")),
>  		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
>  			N_("references to exclude")),
>  		OPT_END(),
> @@ -33,5 +38,14 @@ int cmd_pack_refs(int argc, const char **argv, const=
 char *prefix)
>  	for_each_string_list_item(item, &option_excluded_refs)
>  		add_ref_exclusion(pack_refs_opts.visibility, item->string);
>
> +	for_each_string_list_item(item, &option_included_refs)
> +		add_ref_inclusion(pack_refs_opts.visibility, item->string);
> +
> +	if (pack_refs_opts.flags & PACK_REFS_ALL)
> +		add_ref_inclusion(pack_refs_opts.visibility, "*");
> +
> +	if (!pack_refs_opts.visibility->included_refs.nr)
> +		add_ref_inclusion(pack_refs_opts.visibility, "refs/tags/*");
> +
>  	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_=
opts);
>  }
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3ef19199788..c669cf8001a 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1183,13 +1183,6 @@ static int should_pack_ref(const char *refname,
>  	    REF_WORKTREE_SHARED)
>  		return 0;
>
> -	if (opts->visibility && ref_excluded(opts->visibility, refname))
> -		return 0;
> -
> -	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
> -	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tag=
s/"))
> -		return 0;
> -
>  	/* Do not pack symbolic refs: */
>  	if (ref_flags & REF_ISSYMREF)
>  		return 0;
> @@ -1198,7 +1191,13 @@ static int should_pack_ref(const char *refname,
>  	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))=

>  		return 0;
>
> -	return 1;
> +	if (opts->visibility && ref_excluded(opts->visibility, refname))
> +		return 0;
> +
> +	if (opts->visibility && ref_included(opts->visibility, refname))
> +		return 1;
> +
> +	return 0;
>  }
>
>  static int files_pack_refs(struct ref_store *ref_store,
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index de4197708d9..0dec1223362 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -5,6 +5,7 @@
>  #include "worktree.h"
>  #include "object-store.h"
>  #include "repository.h"
> +#include "revision.h"
>
>  struct flag_definition {
>  	const char *name;
> @@ -116,7 +117,12 @@ static struct flag_definition pack_flags[] =3D { F=
LAG_DEF(PACK_REFS_PRUNE),
>  static int cmd_pack_refs(struct ref_store *refs, const char **argv)
>  {
>  	unsigned int flags =3D arg_flags(*argv++, "flags", pack_flags);
> -	struct pack_refs_opts pack_opts =3D { .flags =3D flags };
> +	static struct ref_visibility visibility =3D REF_VISIBILITY_INIT;
> +	struct pack_refs_opts pack_opts =3D { .flags =3D flags,
> +					    .visibility =3D &visibility };
> +
> +	if (pack_opts.flags & PACK_REFS_ALL)
> +		add_ref_inclusion(pack_opts.visibility, "*");

I was wondering about this test function. I had to add this in because no=
w we
are no longer checking the PACK_REFS_ALL flag in refs/files-backend.c and=

instead relying on the inclusions data structure.

However, this does not support --exclude and --include options. With the =
current
plumbing code in this file, it doesn't look like it supports options with=
 values
as it uses a bitmask.

My question is, do we need to add support for every option we add to
git-pack-refs here? Or are the changes in this patch sufficient.

thanks
John

>
>  	return refs_pack_refs(refs, &pack_opts);
>  }
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index ddfc1b6e5f1..9ff6326b646 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -124,6 +124,27 @@ test_expect_success 'test --no-exclude refs clears=
 excluded refs' '
>  	! test -f .git/refs/heads/dont_pack3 &&
>  	! test -f .git/refs/heads/dont_pack4'
>
> +test_expect_success 'test only included refs are packed' '
> +	git branch pack_this1 &&
> +	git branch pack_this2 &&
> +	git tag dont_pack5 &&
> +	git pack-refs --include "refs/heads/pack_this*" &&
> +	test -f .git/refs/tags/dont_pack5 &&
> +	! test -f ./git/refs/heads/pack_this1 &&
> +	! test -f ./git/refs/heads/pack_this2'
> +
> +test_expect_success 'test --no-include refs clears included refs' '
> +	git branch pack1 &&
> +	git branch pack2 &&
> +	git pack-refs --include "refs/heads/pack*" --no-include &&
> +	test -f .git/refs/heads/pack1 &&
> +	test -f .git/refs/heads/pack2'
> +
> +test_expect_success 'test --exclude takes precedence over --include' '=

> +	git branch dont_pack5 &&
> +	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack=
*" &&
> +	test -f .git/refs/heads/dont_pack5'
> +
>  test_expect_success \
>  	'see if up-to-date packed refs are preserved' \
>  	'git branch q &&
> -- =

> gitgitgadget
