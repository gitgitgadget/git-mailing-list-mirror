Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6FC433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D0864E4A
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 15:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhB1Plp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 10:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhB1Plo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 10:41:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C41C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 07:41:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id r17so23501741ejy.13
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 07:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=iHCXzj53H7+ByJOxNoIPU7Q1IEhyjez5rvugSmVkFQ0=;
        b=b6NsoRyS5r7KokQDZuFCta5vsscUGCABAtEisTomcl58a92HvRwFzZ9sSYSpt0eoye
         Sza2q5syPh8wzYikBsopmtwDcOUsVFm0wI/DMovzigMZf0ld0S4DCVtTvQ5UEzHW8FK4
         dTXbJoyrit0EJ9CwdGrXOspLni/Yh22Luw9buC0Ica3HogHNs0if5jAevC15rw1w0ec7
         qTZwHteDzpKbDU5CMomdBgypAuxfp6/Mn6lKkxPtWpbED5ZYjA07qHonPotwWbSiwRT3
         RuPLronGSQvaDhNBfTl8yy+0xPuAVEYF0e+Xo1E1PCOf4tAOQkDb1vrpy4sA9PUSUZ4h
         o1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=iHCXzj53H7+ByJOxNoIPU7Q1IEhyjez5rvugSmVkFQ0=;
        b=V8kkm2t0+P9MrTT/YDMmFkXqjMUKFsMyVcQi3tKE1c4Txv7449aWLnfM6LY3ek9Uta
         A6DpH+ZuqeaGyGTHBS6R23C8PTX5LEKfGgs/b3W9lVHToMVL4kmfLpk992KeNI2pVlyf
         vmWB8H6B0xIS9GVNQH12CxSlbCKNjYkJCwLU1qiziHBI05b2AG1a8SDnCU3QGtDar4Yi
         V38eoAlba9UKTk9346BVymxrFb2a+jHgmCrnOVGXHJtOFX3LMotlhZdy6yaM9H6oaUHu
         MJ1YPhsMQKQ8hbTz8jprweOEnUXhBcMUDY/E4txCr1T6JVylVHLINbM/kZJJrjDuInU1
         PxrA==
X-Gm-Message-State: AOAM532mZVAkkbB7DaSdpvvlEEjSluL8Sfkk3/7lEjcQ+K6jdLj4U3lS
        S4RXm8ESytFmm3qV4Sq8grI=
X-Google-Smtp-Source: ABdhPJzB4t4W74Sodpmg/D0s1ss0nWICHK3iy0DVaAfBlBMEQzBVwvLPcWY7JLP9OJZPg1T6FE5HTA==
X-Received: by 2002:a17:906:1416:: with SMTP id p22mr12081725ejc.302.1614526862697;
        Sun, 28 Feb 2021 07:41:02 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g3sm10235655ejz.91.2021.02.28.07.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:41:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Eli Schwartz <eschwartz@archlinux.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
 <YC1hHYeCmC6+heWZ@coredump.intra.peff.net>
 <b7e1f6c0-6b13-efe4-74b5-ec8249855644@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <b7e1f6c0-6b13-efe4-74b5-ec8249855644@web.de>
Date:   Sun, 28 Feb 2021 16:41:00 +0100
Message-ID: <87blc4kxo3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 28 2021, Ren=C3=A9 Scharfe. wrote:

> Am 17.02.21 um 19:31 schrieb Jeff King:
>> On Sun, Feb 14, 2021 at 11:10:57AM +0100, Ren=C3=A9 Scharfe. wrote:
>>
>>> Allow restricting the tags used by the placeholder %(describe) with the
>>> options match and exclude.  E.g. the following command describes the
>>> current commit using official version tags, without those for release
>>> candidates:
>>>
>>>    $ git log -1 --format=3D'%(describe:match=3Dv[0-9]*,exclude=3D*rc*)'
>>
>> An interesting side effect of this series is that it allows remote users
>> asking for archives to fill in this data, too (by using export-subst
>> placeholders). That includes servers allowing "git archive --remote",
>> but also services like GitHub that will run git-archive on behalf of
>> clients.
>>
>> I wonder what avenues for mischief this provides. Certainly using extra
>> CPU to run git-describe.
>
> A repository can contain millions of files, each file can contain
> millions of $Format:...$ sequences and each of them can contain millions
> of %(describe) placeholders.  Each of them could have different match or
> exclude args to prevent caching.  Allowing a single request to cause
> trillions of calls of git describe sounds excessive.  Let's limit this.
>
> -- >8 --
> Subject: [PATCH] archive: expand only a single %(describe) per archive
>
> Every %(describe) placeholder in $Format:...$ strings in files with the
> attribute export-subst is expanded by calling git describe.  This can
> potentially result in a lot of such calls per archive.  That's OK for
> local repositories under control of the user of git archive, but could
> be a problem for hosted repositories.
>
> Expand only a single %(describe) placeholder per archive for now to
> avoid denial-of-service attacks.  We can make this limit configurable
> later if needed, but let's start out simple.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  Documentation/gitattributes.txt |  3 ++-
>  archive.c                       | 16 ++++++++++------
>  archive.h                       |  2 ++
>  pretty.c                        |  8 ++++++++
>  pretty.h                        |  5 +++++
>  t/t5001-archive-attr.sh         | 14 ++++++++++++++
>  6 files changed, 41 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
> index e84e104f93..0a60472bb5 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -1174,7 +1174,8 @@ tag then no replacement will be done.  The placehol=
ders are the same
>  as those for the option `--pretty=3Dformat:` of linkgit:git-log[1],
>  except that they need to be wrapped like this: `$Format:PLACEHOLDERS$`
>  in the file.  E.g. the string `$Format:%H$` will be replaced by the
> -commit hash.
> +commit hash.  However, only one `%(describe)` placeholder is expanded
> +per archive to avoid denial-of-service attacks.
>
>
>  Packing objects
> diff --git a/archive.c b/archive.c
> index 5919d9e505..2dd2236ae0 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -37,13 +37,10 @@ void init_archivers(void)
>
>  static void format_subst(const struct commit *commit,
>  			 const char *src, size_t len,
> -			 struct strbuf *buf)
> +			 struct strbuf *buf, struct pretty_print_context *ctx)
>  {
>  	char *to_free =3D NULL;
>  	struct strbuf fmt =3D STRBUF_INIT;
> -	struct pretty_print_context ctx =3D {0};
> -	ctx.date_mode.type =3D DATE_NORMAL;
> -	ctx.abbrev =3D DEFAULT_ABBREV;
>
>  	if (src =3D=3D buf->buf)
>  		to_free =3D strbuf_detach(buf, NULL);
> @@ -61,7 +58,7 @@ static void format_subst(const struct commit *commit,
>  		strbuf_add(&fmt, b + 8, c - b - 8);
>
>  		strbuf_add(buf, src, b - src);
> -		format_commit_message(commit, fmt.buf, buf, &ctx);
> +		format_commit_message(commit, fmt.buf, buf, ctx);
>  		len -=3D c + 1 - src;
>  		src  =3D c + 1;
>  	}
> @@ -94,7 +91,7 @@ static void *object_file_to_archive(const struct archiv=
er_args *args,
>  		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
>  		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &bu=
f, &meta);
>  		if (commit)
> -			format_subst(commit, buf.buf, buf.len, &buf);
> +			format_subst(commit, buf.buf, buf.len, &buf, args->pretty_ctx);
>  		buffer =3D strbuf_detach(&buf, &size);
>  		*sizep =3D size;
>  	}
> @@ -633,12 +630,19 @@ int write_archive(int argc, const char **argv, cons=
t char *prefix,
>  		  const char *name_hint, int remote)
>  {
>  	const struct archiver *ar =3D NULL;
> +	struct pretty_print_describe_status describe_status =3D {0};
> +	struct pretty_print_context ctx =3D {0};
>  	struct archiver_args args;
>  	int rc;
>
>  	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unr=
eachable);
>  	git_config(git_default_config, NULL);
>
> +	describe_status.max_invocations =3D 1;
> +	ctx.date_mode.type =3D DATE_NORMAL;
> +	ctx.abbrev =3D DEFAULT_ABBREV;
> +	ctx.describe_status =3D &describe_status;
> +	args.pretty_ctx =3D &ctx;
>  	args.repo =3D repo;
>  	args.prefix =3D prefix;
>  	string_list_init(&args.extra_files, 1);
> diff --git a/archive.h b/archive.h
> index 33551b7ee1..49fab71aaf 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -5,6 +5,7 @@
>  #include "pathspec.h"
>
>  struct repository;
> +struct pretty_print_context;
>
>  struct archiver_args {
>  	struct repository *repo;
> @@ -22,6 +23,7 @@ struct archiver_args {
>  	unsigned int convert : 1;
>  	int compression_level;
>  	struct string_list extra_files;
> +	struct pretty_print_context *pretty_ctx;
>  };
>
>  /* main api */
> diff --git a/pretty.c b/pretty.c
> index c612d2ac9b..032e89cd4e 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1247,6 +1247,14 @@ static size_t format_commit_one(struct strbuf *sb,=
 /* in UTF-8 */
>  		struct child_process cmd =3D CHILD_PROCESS_INIT;
>  		struct strbuf out =3D STRBUF_INIT;
>  		struct strbuf err =3D STRBUF_INIT;
> +		struct pretty_print_describe_status *describe_status;
> +
> +		describe_status =3D c->pretty_ctx->describe_status;
> +		if (describe_status) {
> +			if (!describe_status->max_invocations)
> +				return 0;
> +			describe_status->max_invocations--;
> +		}
>
>  		cmd.git_cmd =3D 1;
>  		strvec_push(&cmd.args, "describe");
> diff --git a/pretty.h b/pretty.h
> index 7ce6c0b437..27b15947ff 100644
> --- a/pretty.h
> +++ b/pretty.h
> @@ -23,6 +23,10 @@ enum cmit_fmt {
>  	CMIT_FMT_UNSPECIFIED
>  };
>
> +struct pretty_print_describe_status {
> +	unsigned int max_invocations;
> +};
> +
>  struct pretty_print_context {
>  	/*
>  	 * Callers should tweak these to change the behavior of pp_* functions.
> @@ -44,6 +48,7 @@ struct pretty_print_context {
>  	int color;
>  	struct ident_split *from_ident;
>  	unsigned encode_email_headers:1;
> +	struct pretty_print_describe_status *describe_status;
>
>  	/*
>  	 * Fields below here are manipulated internally by pp_* functions and
> diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
> index e9aa97117a..1c9ce3956b 100755
> --- a/t/t5001-archive-attr.sh
> +++ b/t/t5001-archive-attr.sh
> @@ -128,4 +128,18 @@ test_expect_success 'export-subst' '
>  	test_cmp substfile2 archive/substfile2
>  '
>
> +test_expect_success 'export-subst expands %(describe) once' '
> +	echo "\$Format:%(describe)\$" >substfile3 &&
> +	echo "\$Format:%(describe)\$" >>substfile3 &&
> +	echo "\$Format:%(describe)${LF}%(describe)\$" >substfile4 &&
> +	git add substfile[34] &&
> +	git commit -m export-subst-describe &&
> +	git tag -m export-subst-describe export-subst-describe &&
> +	git archive HEAD >archive-describe.tar &&
> +	extract_tar_to_dir archive-describe &&
> +	desc=3D$(git describe) &&
> +	grep -F "$desc" archive-describe/substfile[34] >substituted &&
> +	test_line_count =3D 1 substituted
> +'
> +
>  test_done

This whole thing seems rather backwards as a solution to the "we run it
N times" problem I mentioned in <87k0r7a4sr.fsf@evledraar.gmail.com>.

Instead of taking the trouble of putting a limit in the
pretty_print_context so we don't call it N times for the same commit,
why not just put the strbuf with the result in that same struct?

Then you can have it millions of times, and it won't be any more
expensive than the other existing %(format) specifiers (actually cheaper
than most).

Or is there some edge case I'm missing here where "git archive" can
either be fed N commits and we share the context, or we share the
context across formatting different revisions in some cases?
