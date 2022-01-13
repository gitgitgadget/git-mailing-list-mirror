Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E0C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 09:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiAMJE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 04:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiAMJE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 04:04:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68680C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 01:04:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so20481596edc.11
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 01:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hYOOOJWki/+dOh0I4vjIJ74XbJx2VS9Qug8jjgd4w24=;
        b=i9mlxPG7fpEUWXG8P+NqwKiCZXad31PbV7o7wQV/ZnCAf2CMEngkhYIah5Ai301UAX
         oefXNeH5XeA66A9C1wDEKJO8XGqJu6Vd2AJm65zqRmlGwckeLsL9RLsgKVscM2p3RNNK
         XcMXhY7JlHhk5Do1X72yfQGNCoVBIltQ86OBoxjEkYQwr0bT+0io253G94h6pazwQoD/
         F1vTYXYeeBsAk9cXu9DgJ6904msaZmArQEIwuvOdZLfqmfYwGtLO3ImfXHx2b8p+2mfT
         fbPzwSk9CTLgTr1m9YDZFFnACMNbNakAzb3KOFZBSSYZscBgqsz2UlMCGYDsSOtTJG05
         eJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hYOOOJWki/+dOh0I4vjIJ74XbJx2VS9Qug8jjgd4w24=;
        b=cbP06Opd/DanY2u+Bl5i8upwEjFslv2rkDauNFVAj3PbD5lYUGoN/8d5/PK4WtYiCz
         O5/h1ZtUh6WdU/k8QFglcbsRtxU0sPloh3JKfnXlMqGokw7XwtNRPsEnK/Gjah5Si3wV
         /ArydbvByD/bkHAFKbtLDcc4GN15WU4lXiMOv7fkR+mTnXyG6jcTRTIfBrGpAbzMMo/E
         SsbLe0HATbaOU+ukAlhw0SjuiQ8fVwPTyudsIxKpKqK+vgfyW8mStbzs3sPBTSwHHRcu
         Z+RduCbbhD8Kf6xZZObxSYQRX5wRAuFoq3vfqDcDLzz9Aq/wyqxP2+vYXxzkBpDIxKiQ
         XhVQ==
X-Gm-Message-State: AOAM530Wnrs30TzbjSdCskbY+tZu/cqBC7BkcD8MpExygYN80kS7A+iP
        3xj73p0wjj9is8ji3+Mqkcs=
X-Google-Smtp-Source: ABdhPJz0khu0law6FYlgbhpib9pBZ4RPzPvLM07FiCIk0r9V9yb3CPY1Qg+bQyztyDYQdE+h/ZeD0A==
X-Received: by 2002:a17:907:160d:: with SMTP id hb13mr2819683ejc.588.1642064663692;
        Thu, 13 Jan 2022 01:04:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn8sm663803ejc.23.2022.01.13.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:04:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7w1u-000pL3-GZ;
        Thu, 13 Jan 2022 10:04:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v10 9/9] ls-tree.c: introduce "--format" option
Date:   Thu, 13 Jan 2022 08:16:52 +0100
References: <cover.1641978175.git.dyroneteng@gmail.com>
 <db058bf670c5668fc5b95baf83667cc282cb739b.1641978175.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <db058bf670c5668fc5b95baf83667cc282cb739b.1641978175.git.dyroneteng@gmail.com>
Message-ID: <220113.86o84gvwfd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Teng Long wrote:

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-ls-tree.txt |  51 +++++++++++++-
>  builtin/ls-tree.c             | 129 +++++++++++++++++++++++++++++++++-
>  t/t3105-ls-tree-format.sh     |  55 +++++++++++++++
>  3 files changed, 230 insertions(+), 5 deletions(-)
>  create mode 100755 t/t3105-ls-tree-format.sh
>
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index 729370f235..ebdde6eae3 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -10,9 +10,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
> -	    [--name-only] [--name-status] [--object-only] [--full-name] [--full=
-tree] [--abbrev[=3D<n>]]
> -	    <tree-ish> [<path>...]
> -
> +	    [--name-only] [--name-status] [--object-only]
> +	    [--full-name] [--full-tree] [--abbrev[=3D<n>]]=20

Let's split up this re-flow only change into its own commit? I.e. the
only non-whitespace change here is beginning with [--format].

If it was the right thing to do to re-flow this then we didn't need
[--format=3D<format>] to exist to do so...

> +	    [--format=3D<format>] <tree-ish> [<path>...]
>  DESCRIPTION

Removing this \n breaks the formatting in the file. See "make man && man
./Documentation/git-ls-tree.1". The ./Documentation/doc-diff utility is
also handy for sanity checking the documentation formatting.

>  -----------
>  Lists the contents of a given tree object, like what "/bin/ls -a" does
> @@ -79,6 +79,16 @@ OPTIONS
>  	Do not limit the listing to the current working directory.
>  	Implies --full-name.
>=20=20
> +--format=3D<format>::
> +	A string that interpolates `%(fieldname)` from the result
> +	being shown. It also interpolates `%%` to `%`, and
> +	`%xx` where `xx` are hex digits interpolates to character
> +	with hex code `xx`; for example `%00` interpolates to
> +	`\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
> +	When specified, `--format` cannot be combined with other
> +	format-altering options, including `--long`, `--name-only`
> +	and `--object-only`.
> +

These new docs make sense & seem to cover all the basis, thanks!

> +
> +Default format:
> +
>          <mode> SP <type> SP <object> TAB <file>

Here because we've added --format discussing the previous pseudo-format
as a "default" format becomes confusing. Let's instead say:

        The output format of `ls-tree` is determined by either the `--forma=
t` option,
        or other format-altering options such as `--name-long` etc. (see `-=
-format` above).

        The use of certain `--format` directives is equivalent to using tho=
se options,
        but invoking the full formatting machinery can be slower than using=
 an appropriate
        formatting option.

        In cases where the `--format` would exactly map to an existing opti=
on `ls-tree` will
        use the appropriate faster path. Thus the default format is equival=
ent to:
        ---
        %(mode) %(type) %(object)%x09%(file)
        ---

Or something like that. We could then discuss e.g. --name-long being
`%(mode) %(type) %(object) %(size:padded)%x09%(file)` when we discuss
that option.

>  This output format is compatible with what `--index-info --stdin` of
> @@ -105,6 +118,38 @@ quoted as explained for the configuration variable `=
core.quotePath`
>  (see linkgit:git-config[1]).  Using `-z` the filename is output
>  verbatim and the line is terminated by a NUL byte.
>=20=20
> +Customized format:
> +
> +It is possible to print in a custom format by using the `--format` optio=
n,
> +which is able to interpolate different fields using a `%(fieldname)` not=
ation.
> +For example, if you want to only print the <object> and <file> fields wi=
th a
> +JSON style, executing with a specific "--format" like
> +
> +        git ls-tree --format=3D'{"object":"%(object)", "file":"%(file)"}=
' <tree-ish>
> +
> +The output format changes to:
> +
> +        {"object":"<object>", "file":"<file>"}

This one-liner is guaranteed to result in invalid JSON on some
repositories, both because JSON is inherently a bad fit for git's data
model (JSON needs to be in one Unicode encoding, Git's tree data might
me in a mixture of encodings), and because it'll break if the file
includes a '"'.

I think it's better to just replace this with some example involving -z,
or at least prominently note that this is broken in the general case,
but can be used ad-hoc to quickly check things with "jq" or whatever.

> +FIELD NAMES
> +-----------
> +
> +Various values from structured fields can be used to interpolate
> +into the resulting output. For each outputing line, the following
> +names can be used:
> +
> +mode::
> +	The mode of the object.
> +type::
> +	The type of the object (`blob` or `tree`).
> +object::
> +	The name of the object.
> +size[:padded]::
> +	The size of the object ("-" if it's a tree).
> +	It also supports a padded format of size with "%(size:padded)".
> +file::
> +	The filename of the object.

In
https://lore.kernel.org/git/cover.1641043500.git.dyroneteng@gmail.com/
you noted that you changed the field names of e.g. "objectname" to
"object" etc. You're right that I picked these as-is from the
git-for-each-ref formatting.

1/3 of your reasoning for doing so was to make it consistent with the
documentation examples of e.g.:

     <mode> SP <type> SP <object> TAB <file>

I think in any case (as noted above) we should change those to use the
--format), so that leaves just:

 - "I prefer to make the name more simple to memorize and type"
 - "I think the names with "object" prefix are [from git-for-each-ref
   and the object* prefixes aren't redundant there, but would be here]".

I think both of those still apply, but I think having these consistent
with git-for-each-ref outweighs the slight benefit of shorter names.

Right now only a handful of things support these sort of --format
directives, but we've already got RFC/WIP patches to add that to
git-cat-file, and are likely to add more in the future.

I'd also like us to eventually be able to combine what are now separate
built-ins with their own --format to expose more deeply some internal
APIs via IPC. E.g. now you can do this:

    git for-each-ref --format=3D'%(refname) %(tree)'

But to list each of those trees you'd need to pipe that output into this
new 'git ls-tree --format. But imagine being able to do something like:

    git for-each-ref --format=3D'%(refname) %(git-ls-tree --format %%(objec=
tname) %(tree))'

Where we'd just invoke git-ls-tree for you without running a full
sub-process. I think both for that hypothetical and working with the two
--formats now having to use %(type) in some places but %(objecttype)
etc. in others is just needlessly confusing. Let's just consistently use
the same format names everywhere.

Specifically for your s/path/file/ name change, that's just inaccurate, con=
sider:

    $ ./git ls-tree --format=3D"%(mode) %(type) %(file)" -t HEAD -- t/README
    040000 tree t
    100644 blob t/README

And:

    $ $ (cd t && ../git ls-tree --format=3D"%(mode) %(type) %(file)" -t -r =
HEAD -- README)
    040000 tree ./
    100644 blob README

I.e. we talk about <path> in the existing SYNOPSIS for a reason. That we
had a "<file>" in the existing format demo was a bug/shorthand that we
shouldn't be propagating further.

> [...]
> +static const char *format;
> +static const char *default_format =3D "%(mode) %(type) %(object)%x09%(fi=
le)";
> +static const char *long_format =3D "%(mode) %(type) %(object) %(size:pad=
ded)%x09%(file)";
> +static const char *name_only_format =3D "%(file)";
> +static const char *object_only_format =3D "%(object)";
> +

One advantage of keeping the variable names I picked in
https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avar=
ab@gmail.com/
is that they align, so you can instantly see that the first two are
equivalent until the "%x09".

It also makes it easier to review to avoid such churn, to see what you
really changed I'm looking at a local version of a range-diff where I
renamed these, the struct you renamed etc. back just to see what you
/really/ changed. I.e. what are functional v.s. renaming changes.

>  static int parse_shown_fields(void)
>  {
>  	if (cmdmode =3D=3D MODE_NAME_ONLY) {
> @@ -76,6 +82,72 @@ static int parse_shown_fields(void)
>  	return 1;
>  }
>=20=20
> +static void expand_objectsize(struct strbuf *line, const struct object_i=
d *oid,
> +			      const enum object_type type, unsigned int padded)
> +{
> +	if (type =3D=3D OBJ_BLOB) {
> +		unsigned long size;
> +		if (oid_object_info(the_repository, oid, &size) < 0)
> +			die(_("could not get object info about '%s'"),
> +			    oid_to_hex(oid));
> +		if (padded)
> +			strbuf_addf(line, "%7" PRIuMAX, (uintmax_t)size);
> +		else
> +			strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);

Here you changed my '"%"PRIuMAX' to '"%" PRIuMAX'. The former is the
prevailing style in this codebase, and avoiding the formatting churn
makes the inter-diff easier to read.

> +	} else if (padded) {
> +		strbuf_addf(line, "%7s", "-");
> +	} else {
> +		strbuf_addstr(line, "-");
> +	}
> +}

Ditto some harder to review interdiff due to renaming
churn. I.e. s/line/sb/ in both this and expand_show_tree(). I really
wouldn't care at all except because of all the manual work in reviewing
the inter-diff between my original version & this derived version.

In the case of "line" that's not even an improvement. With a --format
we're not building a "line", the user is free to insert any arbitrary
directives including \n's, so we might be working on multiple lines.

> +test_expect_success 'ls-tree --format usage' '
> +	test_expect_code 129 git ls-tree --format=3Dfmt -l HEAD &&
> +	test_expect_code 129 git ls-tree --format=3Dfmt --name-only HEAD &&
> +	test_expect_code 129 git ls-tree --format=3Dfmt --name-status HEAD &&
> +	test_expect_code 129 git ls-tree --format=3Dfmt --object-only HEAD
> +'

This & several other changes v.s. my version are good, e.g. here I seem
to have repeated the logic error I noted for your version (i.e omitting
"HEAD"), oops!

> +test_expect_success 'setup' '
> +	mkdir dir &&
> +	test_commit dir/sub-file &&
> +	test_commit top-file
> +'
> +
> +test_ls_tree_format () {
> +	format=3D$1 &&
> +	opts=3D$2 &&
> +	shift 2 &&
> +	git ls-tree $opts -r HEAD >expect.raw &&
> +	sed "s/^/> /" >expect <expect.raw &&
> +	git ls-tree --format=3D"> $format" -r HEAD >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'ls-tree --format=3D<default-like>' '
> +	test_ls_tree_format \
> +		"%(mode) %(type) %(object)%x09%(file)" \
> +		""
> +'
> +
> +test_expect_success 'ls-tree --format=3D<long-like>' '
> +	test_ls_tree_format \
> +		"%(mode) %(type) %(object) %(size:padded)%x09%(file)" \
> +		"--long"
> +'
> +
> +test_expect_success 'ls-tree --format=3D<name-only-like>' '
> +	test_ls_tree_format \
> +		"%(file)" \
> +		"--name-only"
> +'
> +
> +test_expect_success 'ls-tree --format=3D<object-only-like>' '
> +	test_ls_tree_format \
> +		"%(object)" \
> +		"--object-only"
> +'
> +
> +test_done

As I noted in my RFC CL (https://lore.kernel.org/git/RFC-cover-0.7-00000000=
000-20211217T131635Z-avarab@gmail.com/):

	"the tests for ls-tree are really
	lacking. E.g. I seem to have a rather obvious bug in how -t and the
	--format interact here, but no test catches it."

So first, in my version of adding --format I was careful to make
--name-only etc. imply a given --format, and then only at the last
minute would we take the "fast path":
https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avar=
ab@gmail.com/

You rewrote that in
https://lore.kernel.org/git/e0add802fbbabde7e7b3743127b2d4047f1ce760.164104=
3500.git.dyroneteng@gmail.com/
and qremoved the limited "GIT_TEST_LS_TREE_FORMAT_BACKEND" testing I
added, so now the internal --format machinery can't be run through the
existing tests we do have.

Even with that re-added I really wouldn't trust that this code is doing
the right thing (and as noted, I don't trust my own RFC version
either). I think e.g. our "coverage" Makefile targets would be a good
start as a first approximation, i.e. running the /ls-tree/ tests and
seeing if we have full coverage.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>

As I noted in 7/9 I think this patch is 9/9 still mostly something I
wrote, so that the "author" and Signed-off-by should be preserved. The
below is a range-diff of an amended version I've been looking at in
trying to review this. It undoes several (but not all) of your
formatting/renaming-only changes, just so that I could see what the
non-formatting changes were:

1:  6c96dff15c5 ! 1:  917bb168d45 ls-tree: add a --format=3D<fmt> option
    @@
      ## Metadata ##
    -Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    +Author: Teng Long <dyroneteng@gmail.com>
=20=20=20=20=20
      ## Commit message ##
    -    ls-tree: add a --format=3D<fmt> option
    +    ls-tree.c: introduce "--format" option
=20=20=20=20=20
         Add a --format option to ls-tree. It has an existing default outpu=
t,
         and then --long and --name-only options to emit the default output
    @@ Commit message
=20=20=20=20=20
         The --format implementation is slower than the existing code, but =
this
         change does not cause any performance regressions. We'll leave the
    -    existing show_tree() unchanged, and only run show_tree_format() in=
 if
    +    existing show_tree() unchanged, and only run show_tree_fmt() in if
         a --format different than the hardcoded built-in ones correspondin=
g to
         the existing modes is provided.
=20=20=20=20=20
    -    "Slower" here can bee seen via the the following "hyperfine"
    -    command. This uses GIT_TEST_LS_TREE_FORMAT_BACKEND=3D<bool> to for=
ce the
    -    use of the new backend:
    -
    -        $ hyperfine -L env false,true -L f "-r,-r -l,-r --name-only,-r=
 --format=3D'%(objectname)'" 'GIT_TEST_LS_TREE_FORMAT_BACKEND=3D{env} ./git=
 -C ~/g/linux ls-tree {f} HEAD' -r 10
    -        Benchmark 1: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dfalse ./git -C =
~/g/linux ls-tree -r HEAD
    -          Time (mean =C2=B1 =CF=83):      86.1 ms =C2=B1   0.6 ms    [=
User: 65.2 ms, System: 20.9 ms]
    -          Range (min =E2=80=A6 max):    85.2 ms =E2=80=A6  87.5 ms    =
10 runs
    +    I.e. something like the "--long" output would be much slower with
    +    this, mainly due to how we need to allocate various things to do w=
ith
    +    quote.c instead of spewing the output directly to stdout.
=20=20=20=20=20
    -        Benchmark 2: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dtrue ./git -C ~=
/g/linux ls-tree -r HEAD
    -          Time (mean =C2=B1 =CF=83):     122.5 ms =C2=B1   0.6 ms    [=
User: 101.3 ms, System: 21.1 ms]
    -          Range (min =E2=80=A6 max):   121.8 ms =E2=80=A6 123.4 ms    =
10 runs
    +    The new option of '--format' comes from =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmasonn's
    +    idea and suggestion, this commit makes modifications in terms of t=
he
    +    original discussion on community [1].
=20=20=20=20=20
    -        Benchmark 3: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dfalse ./git -C =
~/g/linux ls-tree -r -l HEAD
    -          Time (mean =C2=B1 =CF=83):     277.7 ms =C2=B1   1.3 ms    [=
User: 234.6 ms, System: 43.0 ms]
    -          Range (min =E2=80=A6 max):   275.9 ms =E2=80=A6 279.7 ms    =
10 runs
    +    Here is the statistics about performance tests:
=20=20=20=20=20
    -        Benchmark 4: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dtrue ./git -C ~=
/g/linux ls-tree -r -l HEAD
    -          Time (mean =C2=B1 =CF=83):     332.8 ms =C2=B1   2.6 ms    [=
User: 282.0 ms, System: 50.7 ms]
    -          Range (min =E2=80=A6 max):   329.6 ms =E2=80=A6 338.2 ms    =
10 runs
    +    1. Default format (hitten the builtin formats):
=20=20=20=20=20
    -        Benchmark 5: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dfalse ./git -C =
~/g/linux ls-tree -r --name-only HEAD
    -          Time (mean =C2=B1 =CF=83):      71.8 ms =C2=B1   0.4 ms    [=
User: 54.1 ms, System: 17.6 ms]
    -          Range (min =E2=80=A6 max):    71.2 ms =E2=80=A6  72.5 ms    =
10 runs
    +        "git ls-tree <tree-ish>" vs "--format=3D'%(mode) %(type) %(obj=
ect)%x09%(file)'"
=20=20=20=20=20
    -        Benchmark 6: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dtrue ./git -C ~=
/g/linux ls-tree -r --name-only HEAD
    -          Time (mean =C2=B1 =CF=83):      86.6 ms =C2=B1   0.5 ms    [=
User: 65.7 ms, System: 20.7 ms]
    -          Range (min =E2=80=A6 max):    85.9 ms =E2=80=A6  87.4 ms    =
10 runs
    +        $hyperfine --warmup=3D10 "/opt/git/master/bin/git ls-tree -r H=
EAD"
    +        Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    +        Time (mean =C2=B1 =CF=83):     105.2 ms =C2=B1   3.3 ms    [Us=
er: 84.3 ms, System: 20.8 ms]
    +        Range (min =E2=80=A6 max):    99.2 ms =E2=80=A6 113.2 ms    28=
 runs
=20=20=20=20=20
    -        Benchmark 7: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dfalse ./git -C =
~/g/linux ls-tree -r --format=3D'%(objectname)' HEAD
    -          Time (mean =C2=B1 =CF=83):      85.8 ms =C2=B1   0.6 ms    [=
User: 66.2 ms, System: 19.5 ms]
    -          Range (min =E2=80=A6 max):    85.0 ms =E2=80=A6  86.9 ms    =
10 runs
    +        $hyperfine --warmup=3D10 "/opt/git/ls-tree-oid-only/bin/git ls=
-tree -r --format=3D'%(mode) %(type) %(object)%x09%(file)'  HEAD"
    +        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --fo=
rmat=3D'%(mode) %(type) %(object)%x09%(file)'  HEAD
    +        Time (mean =C2=B1 =CF=83):     106.4 ms =C2=B1   2.7 ms    [Us=
er: 86.1 ms, System: 20.2 ms]
    +        Range (min =E2=80=A6 max):   100.2 ms =E2=80=A6 110.5 ms    29=
 runs
=20=20=20=20=20
    -        Benchmark 8: GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dtrue ./git -C ~=
/g/linux ls-tree -r --format=3D'%(objectname)' HEAD
    -          Time (mean =C2=B1 =CF=83):      85.3 ms =C2=B1   0.2 ms    [=
User: 66.6 ms, System: 18.7 ms]
    -          Range (min =E2=80=A6 max):    85.0 ms =E2=80=A6  85.7 ms    =
10 runs
    +    2. Default format includes object size (hitten the builtin formats=
):
=20=20=20=20=20
    -        Summary
    -          'GIT_TEST_LS_TREE_FORMAT_BACKEND=3Dfalse ./git -C ~/g/linux =
ls-tree -r --name-only HEAD' ran
    -            1.19 =C2=B1 0.01 times faster than 'GIT_TEST_LS_TREE_FORMA=
T_BACKEND=3Dtrue ./git -C ~/g/linux ls-tree -r --format=3D'%(objectname)' H=
EAD'
    -            1.19 =C2=B1 0.01 times faster than 'GIT_TEST_LS_TREE_FORMA=
T_BACKEND=3Dfalse ./git -C ~/g/linux ls-tree -r --format=3D'%(objectname)' =
HEAD'
    -            1.20 =C2=B1 0.01 times faster than 'GIT_TEST_LS_TREE_FORMA=
T_BACKEND=3Dfalse ./git -C ~/g/linux ls-tree -r HEAD'
    -            1.21 =C2=B1 0.01 times faster than 'GIT_TEST_LS_TREE_FORMA=
T_BACKEND=3Dtrue ./git -C ~/g/linux ls-tree -r --name-only HEAD'
    -            1.71 =C2=B1 0.01 times faster than 'GIT_TEST_LS_TREE_FORMA=
T_BACKEND=3Dtrue ./git -C ~/g/linux ls-tree -r HEAD'
    -            3.87 =C2=B1 0.03 times faster than 'GIT_TEST_LS_TREE_FORMA=
T_BACKEND=3Dfalse ./git -C ~/g/linux ls-tree -r -l HEAD'
    -            4.64 =C2=B1 0.05 times faster than 'GIT_TEST_LS_TREE_FORMA=
T_BACKEND=3Dtrue ./git -C ~/g/linux ls-tree -r -l HEAD'
    +        "git ls-tree -l <tree-ish>" vs "--format=3D'%(mode) %(type) %(=
object) %(size:padded)%x09%(file)'"
=20=20=20=20=20
    -    I.e. something like the "--long" output would be much slower with
    -    this, mainly due to how we need to allocate various things to do w=
ith
    -    quote.c instead of spewing the output directly to stdout.
    +        $hyperfine --warmup=3D10 "/opt/git/master/bin/git ls-tree -r -=
l HEAD"
    +        Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    +        Time (mean =C2=B1 =CF=83):     335.1 ms =C2=B1   6.5 ms    [Us=
er: 304.6 ms, System: 30.4 ms]
    +        Range (min =E2=80=A6 max):   327.5 ms =E2=80=A6 348.4 ms    10=
 runs
=20=20=20=20=20
    -    But even a --format=3D'%(objectname)' is fast with the new backend=
, so
    -    this is viable as a replacement for adding new formats, and we'll =
pay
    -    for this added complexity as a one-off, and not again every time a=
 new
    -    format needs to be added. See [1] for an example of what it would
    -    otherwise take to add an --object-name flag.
    +        $hyperfine --warmup=3D10 "/opt/git/ls-tree-oid-only/bin/git ls=
-tree -r --format=3D'%(mode) %(type) %(object) %(size:padded)%x09%(file)'  =
HEAD"
    +        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --fo=
rmat=3D'%(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD
    +        Time (mean =C2=B1 =CF=83):     337.2 ms =C2=B1   8.2 ms    [Us=
er: 309.2 ms, System: 27.9 ms]
    +        Range (min =E2=80=A6 max):   328.8 ms =E2=80=A6 349.4 ms    10=
 runs
=20=20=20=20=20
    -    1. https://lore.kernel.org/git/2e449d1c792ff81da5f22c8bf65ed33c393=
d62f8.1639721750.git.dyroneteng@gmail.com/
    +    Links:
    +            [1] https://public-inbox.org/git/RFC-patch-6.7-eac299f06ff=
-20211217T131635Z-avarab@gmail.com/
=20=20=20=20=20
    -    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
    +    Signed-off-by: Teng Long <dyroneteng@gmail.com>
=20=20=20=20=20
    - ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static struct pathspec pathspec;
    - static int chomp_prefix;
    - static const char *ls_tree_prefix;
    + ## Documentation/git-ls-tree.txt ##
    +@@ Documentation/git-ls-tree.txt: SYNOPSIS
    + --------
    + [verse]
    + 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
    +-	    [--name-only] [--name-status] [--object-only] [--full-name] [--f=
ull-tree] [--abbrev[=3D<n>]]
    +-	    <tree-ish> [<path>...]
    ++	    [--name-only] [--name-status] [--object-only]
    ++	    [--full-name] [--full-tree] [--abbrev[=3D<n>]]
    ++	    [--format=3D<format>] <tree-ish> [<path>...]
=20=20=20=20=20=20
    -+/*
    -+ * The format equivalents that show_tree() is prepared to handle.
    -+ */
    -+static const char *ls_tree_format_d =3D "%(objectmode) %(objecttype) =
%(objectname)%x09%(path)";
    -+static const char *ls_tree_format_l =3D "%(objectmode) %(objecttype) =
%(objectname) %(objectsize:padded)%x09%(path)";
    -+static const char *ls_tree_format_n =3D "%(path)";
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-ls-tree.txt: OPTIONS
    + 	Do not limit the listing to the current working directory.
    + 	Implies --full-name.
    +=20
    ++--format=3D<format>::
    ++	A string that interpolates `%(fieldname)` from the result
    ++	being shown. It also interpolates `%%` to `%`, and
    ++	`%xx` where `xx` are hex digits interpolates to character
    ++	with hex code `xx`; for example `%00` interpolates to
    ++	`\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
    ++	When specified, `--format` cannot be combined with other
    ++	format-altering options, including `--long`, `--name-only`
    ++	and `--object-only`.
     +
    - static const  char * const ls_tree_usage[] =3D {
    - 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
    - 	NULL
    - };
    + [<path>...]::
    + 	When paths are given, show them (note that this isn't really raw
    + 	pathnames, but rather a list of patterns to match).  Otherwise
    +@@ Documentation/git-ls-tree.txt: OPTIONS
=20=20=20=20=20=20
    -+struct read_tree_ls_tree_data {
    -+	const char *format;
    -+	struct strbuf sb_scratch;
    -+	struct strbuf sb_tmp;
    -+};
    + Output Format
    + -------------
    ++
    ++Default format:
    ++
    +         <mode> SP <type> SP <object> TAB <file>
    +=20
    + This output format is compatible with what `--index-info --stdin` of
    +@@ Documentation/git-ls-tree.txt: quoted as explained for the configur=
ation variable `core.quotePath`
    + (see linkgit:git-config[1]).  Using `-z` the filename is output
    + verbatim and the line is terminated by a NUL byte.
    +=20
    ++Customized format:
     +
    ++It is possible to print in a custom format by using the `--format` op=
tion,
    ++which is able to interpolate different fields using a `%(fieldname)` =
notation.
    ++For example, if you want to only print the <object> and <file> fields=
 with a
    ++JSON style, executing with a specific "--format" like
    ++
    ++        git ls-tree --format=3D'{"object":"%(object)", "file":"%(file=
)"}' <tree-ish>
    ++
    ++The output format changes to:
    ++
    ++        {"object":"<object>", "file":"<file>"}
    ++
    ++FIELD NAMES
    ++-----------
    ++
    ++Various values from structured fields can be used to interpolate
    ++into the resulting output. For each outputing line, the following
    ++names can be used:
    ++
    ++mode::
    ++	The mode of the object.
    ++type::
    ++	The type of the object (`blob` or `tree`).
    ++object::
    ++	The name of the object.
    ++size[:padded]::
    ++	The size of the object ("-" if it's a tree).
    ++	It also supports a padded format of size with "%(size:padded)".
    ++file::
    ++	The filename of the object.
    ++
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
    +
    + ## builtin/ls-tree.c ##
    +@@ builtin/ls-tree.c: static unsigned int shown_fields;
    + #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by defa=
ult */
    + #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
    +=20
     +struct expand_ls_tree_data {
     +	unsigned mode;
     +	enum object_type type;
     +	const struct object_id *oid;
     +	const char *pathname;
    -+	const char *basebuf;
    -+	struct strbuf *sb_scratch;
    -+	struct strbuf *sb_tmp;
    ++	struct strbuf *base;
     +};
     +
    - static int show_recursive(const char *base, size_t baselen, const cha=
r *pathname)
    + static const  char * const ls_tree_usage[] =3D {
    + 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
    + 	NULL
    +@@ builtin/ls-tree.c: enum {
    +=20
    + static int cmdmode =3D MODE_UNSPECIFIED;
    +=20
    ++static const char *format;
    ++static const char *ls_tree_format_d =3D "%(objectmode) %(objecttype) =
%(objectname)%x09%(path)";
    ++static const char *ls_tree_format_l =3D "%(objectmode) %(objecttype) =
%(objectname) %(objectsize:padded)%x09%(path)";
    ++static const char *ls_tree_format_n =3D "%(path)";
    ++static const char *ls_tree_format_o =3D "%(objectname)";
    ++
    + static int parse_shown_fields(void)
      {
    - 	int i;
    -@@ builtin/ls-tree.c: static int show_recursive(const char *base, size=
_t baselen, const char *pathname
    - 	return 0;
    + 	if (cmdmode =3D=3D MODE_NAME_ONLY) {
    +@@ builtin/ls-tree.c: static int parse_shown_fields(void)
    + 	return 1;
      }
=20=20=20=20=20=20
    -+static void expand_objectsize(struct strbuf *sb,
    -+			      const struct object_id *oid,
    -+			      const enum object_type type,
    -+			      unsigned int padded)
    ++static void expand_objectsize(struct strbuf *sb, const struct object_=
id *oid,
    ++			      const enum object_type type, unsigned int padded)
     +{
     +	if (type =3D=3D OBJ_BLOB) {
     +		unsigned long size;
     +		if (oid_object_info(the_repository, oid, &size) < 0)
    -+			die(_("could not get object info about '%s'"), oid_to_hex(oid));
    ++			die(_("could not get object info about '%s'"),
    ++			    oid_to_hex(oid));
     +		if (padded)
     +			strbuf_addf(sb, "%7"PRIuMAX, (uintmax_t)size);
     +		else
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_=
t baselen, c
     +	}
     +}
     +
    -+static size_t expand_show_tree(struct strbuf *sb,
    -+			       const char *start,
    ++static size_t expand_show_tree(struct strbuf *sb, const char *start,
     +			       void *context)
     +{
     +	struct expand_ls_tree_data *data =3D context;
     +	const char *end;
     +	const char *p;
    -+	size_t len;
    ++	unsigned int errlen;
    ++	size_t len =3D strbuf_expand_literal_cb(sb, start, NULL);
     +
    -+	len =3D strbuf_expand_literal_cb(sb, start, NULL);
     +	if (len)
     +		return len;
    -+
     +	if (*start !=3D '(')
    -+		die(_("bad format as of '%s'"), start);
    ++		die(_("bad ls-tree format: as '%s'"), start);
    ++
     +	end =3D strchr(start + 1, ')');
     +	if (!end)
    -+		die(_("ls-tree format element '%s' does not end in ')'"),
    -+		    start);
    -+	len =3D end - start + 1;
    ++		die(_("bad ls-tree format: element '%s' does not end in ')'"), star=
t);
     +
    ++	len =3D end - start + 1;
     +	if (skip_prefix(start, "(objectmode)", &p)) {
     +		strbuf_addf(sb, "%06o", data->mode);
     +	} else if (skip_prefix(start, "(objecttype)", &p)) {
    @@ builtin/ls-tree.c: static int show_recursive(const char *base, size_=
t baselen, c
     +	} else if (skip_prefix(start, "(objectsize)", &p)) {
     +		expand_objectsize(sb, data->oid, data->type, 0);
     +	} else if (skip_prefix(start, "(objectname)", &p)) {
    -+		strbuf_addstr(sb, find_unique_abbrev(data->oid, abbrev));
    ++		strbuf_add_unique_abbrev(sb, data->oid, abbrev);
     +	} else if (skip_prefix(start, "(path)", &p)) {
    -+		const char *name =3D data->basebuf;
    ++		const char *name =3D data->base->buf;
     +		const char *prefix =3D chomp_prefix ? ls_tree_prefix : NULL;
    -+
    -+		if (prefix)
    -+			name =3D relative_path(name, prefix, data->sb_scratch);
    -+		quote_c_style(name, data->sb_tmp, NULL, 0);
    -+		strbuf_add(sb, data->sb_tmp->buf, data->sb_tmp->len);
    -+
    -+		strbuf_reset(data->sb_tmp);
    -+		/* The relative_path() function resets "scratch" */
    ++		struct strbuf quoted =3D STRBUF_INIT;
    ++		struct strbuf s =3D STRBUF_INIT;
    ++		strbuf_addstr(data->base, data->pathname);
    ++		name =3D relative_path(data->base->buf, prefix, &s);
    ++		quote_c_style(name, &quoted, NULL, 0);
    ++		strbuf_addbuf(sb, &quoted);
    ++		strbuf_release(&s);
    ++		strbuf_release(&quoted);
     +	} else {
    -+		unsigned int errlen =3D (unsigned long)len;
    -+		die(_("bad ls-tree format specifiec %%%.*s"), errlen, start);
    ++		errlen =3D (unsigned long)len;
    ++		die(_("bad ls-tree format: %%%.*s"), errlen, start);
     +	}
    -+
     +	return len;
     +}
     +
    - static int show_tree_init(enum object_type *type, struct strbuf *base,
    - 			  const char *pathname, unsigned mode, int *retval)
    + static int show_recursive(const char *base, size_t baselen,
    + 			  const char *pathname)
      {
    -@@ builtin/ls-tree.c: static int show_tree_init(enum object_type *type=
, struct strbuf *base,
    +@@ builtin/ls-tree.c: static int show_recursive(const char *base, size=
_t baselen,
      	return 0;
      }
=20=20=20=20=20=20
    +-static int show_default(const struct object_id *oid, enum object_type=
 type,
    +-			const char *pathname, unsigned mode,
    +-			struct strbuf *base)
     +static int show_tree_fmt(const struct object_id *oid, struct strbuf *=
base,
     +			 const char *pathname, unsigned mode, void *context)
    -+{
    -+	struct read_tree_ls_tree_data *data =3D context;
    -+	struct expand_ls_tree_data my_data =3D {
    + {
    +-	size_t baselen =3D base->len;
    ++	size_t baselen;
    ++	int recurse =3D 0;
    ++	struct strbuf line =3D STRBUF_INIT;
    ++	enum object_type type =3D object_type(mode);
    ++
    ++	struct expand_ls_tree_data data =3D {
     +		.mode =3D mode,
    -+		.type =3D OBJ_BLOB,
    ++		.type =3D type,
     +		.oid =3D oid,
     +		.pathname =3D pathname,
    -+		.sb_scratch =3D &data->sb_scratch,
    -+		.sb_tmp =3D &data->sb_tmp,
    ++		.base =3D base,
     +	};
    -+	struct strbuf sb =3D STRBUF_INIT;
    -+	int retval =3D 0;
    -+	size_t baselen;
     +
    -+	if (show_tree_init(&my_data.type, base, pathname, mode, &retval))
    -+		return retval;
    ++	if (type =3D=3D OBJ_TREE && show_recursive(base->buf, base->len, pat=
hname))
    ++		recurse =3D READ_TREE_RECURSIVE;
    ++	if (type =3D=3D OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
    ++		return recurse;
    ++	if (type =3D=3D OBJ_BLOB && (ls_options & LS_TREE_ONLY))
    ++		return 0;
     +
     +	baselen =3D base->len;
    -+	strbuf_addstr(base, pathname);
    -+	strbuf_reset(&sb);
    -+	my_data.basebuf =3D base->buf;
    -+
    -+	strbuf_expand(&sb, data->format, expand_show_tree, &my_data);
    -+	strbuf_addch(&sb, line_termination);
    -+	fwrite(sb.buf, sb.len, 1, stdout);
    ++	strbuf_expand(&line, format, expand_show_tree, &data);
    ++	strbuf_addch(&line, line_termination);
    ++	fwrite(line.buf, line.len, 1, stdout);
    ++	strbuf_release(&line);
     +	strbuf_setlen(base, baselen);
    -+
    -+	return retval;
    ++	return recurse;
     +}
     +
    - static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 		const char *pathname, unsigned mode, void *context)
    - {
    ++static int show_default(struct expand_ls_tree_data *data)
    ++{
    ++	size_t baselen =3D data->base->len;
    +=20
    + 	if (shown_fields & FIELD_SIZE) {
    + 		char size_text[24];
    +-		if (type =3D=3D OBJ_BLOB) {
    ++		if (data->type =3D=3D OBJ_BLOB) {
    + 			unsigned long size;
    +-			if (oid_object_info(the_repository, oid, &size) =3D=3D OBJ_BAD)
    ++			if (oid_object_info(the_repository, data->oid, &size) =3D=3D OBJ_B=
AD)
    + 				xsnprintf(size_text, sizeof(size_text), "BAD");
    + 			else
    + 				xsnprintf(size_text, sizeof(size_text),
    +@@ builtin/ls-tree.c: static int show_default(const struct object_id *=
oid, enum object_type type,
    + 		} else {
    + 			xsnprintf(size_text, sizeof(size_text), "-");
    + 		}
    +-		printf("%06o %s %s %7s\t", mode, type_name(type),
    +-		find_unique_abbrev(oid, abbrev), size_text);
    ++		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
    ++		find_unique_abbrev(data->oid, abbrev), size_text);
    + 	} else {
    +-		printf("%06o %s %s\t", mode, type_name(type),
    +-		find_unique_abbrev(oid, abbrev));
    ++		printf("%06o %s %s\t", data->mode, type_name(data->type),
    ++		find_unique_abbrev(data->oid, abbrev));
    + 	}
    +-	baselen =3D base->len;
    +-	strbuf_addstr(base, pathname);
    +-	write_name_quoted_relative(base->buf,
    ++	baselen =3D data->base->len;
    ++	strbuf_addstr(data->base, data->pathname);
    ++	write_name_quoted_relative(data->base->buf,
    + 				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
    + 				   line_termination);
    +-	strbuf_setlen(base, baselen);
    ++	strbuf_setlen(data->base, baselen);
    + 	return 1;
    + }
    +=20
    +@@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid=
, struct strbuf *base,
    + 	size_t baselen;
    + 	enum object_type type =3D object_type(mode);
    +=20
    ++	struct expand_ls_tree_data data =3D {
    ++		.mode =3D mode,
    ++		.type =3D type,
    ++		.oid =3D oid,
    ++		.pathname =3D pathname,
    ++		.base =3D base,
    ++	};
    ++
    + 	if (type =3D=3D OBJ_TREE && show_recursive(base->buf, base->len, pat=
hname))
    + 		recurse =3D READ_TREE_RECURSIVE;
    + 	if (type =3D=3D OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
    +@@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid=
, struct strbuf *base,
    + 	}
    +=20
    + 	if (shown_fields >=3D FIELD_DEFAULT)
    +-		show_default(oid, type, pathname, mode, base);
    ++		show_default(&data);
    +=20
    + 	return recurse;
    + }
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, con=
st char *prefix)
      	struct object_id oid;
      	struct tree *tree;
      	int i, full_tree =3D 0;
    -+	const char *implicit_format =3D NULL;
    -+	const char *format =3D NULL;
    -+	struct read_tree_ls_tree_data read_tree_cb_data =3D {
    -+		.sb_scratch =3D STRBUF_INIT,
    -+		.sb_tmp =3D STRBUF_INIT,
    -+	};
    ++	read_tree_fn_t fn =3D show_tree;
      	const struct option ls_tree_options[] =3D {
      		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
      			LS_TREE_ONLY),
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, cons=
t char *pref
      		OPT_BOOL(0, "full-tree", &full_tree,
      			 N_("list entire tree; not just current directory "
      			    "(implies --full-name)")),
    -+		OPT_STRING_F(0 , "format", &format, N_("format"),
    -+			     N_("format to use for the output"), PARSE_OPT_NONEG),
    ++		OPT_STRING_F(0, "format", &format, N_("format"),
    ++			     N_("format to use for the output"),
    ++			     PARSE_OPT_NONEG),
      		OPT__ABBREV(&abbrev),
      		OPT_END()
      	};
    -+	read_tree_fn_t fn =3D show_tree;
    -=20
    - 	git_config(git_default_config, NULL);
    - 	ls_tree_prefix =3D prefix;
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, con=
st char *prefix)
    - 	if ( (LS_TREE_ONLY|LS_RECURSIVE) =3D=3D
      	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
      		ls_options |=3D LS_SHOW_TREES;
    -+	if (ls_options & LS_NAME_ONLY)
    -+		implicit_format =3D ls_tree_format_n;
    -+	if (ls_options & LS_SHOW_SIZE)
    -+		implicit_format =3D ls_tree_format_l;
    -+
    -+	if (format && implicit_format)
    -+		usage_msg_opt(_("providing --format cannot be combined with other f=
ormat-altering options"),
    -+			      ls_tree_usage, ls_tree_options);
    -+	if (implicit_format)
    -+		format =3D implicit_format;
    -+	if (!format)
    -+		format =3D ls_tree_format_d;
=20=20=20=20=20=20
    ++	if (format && cmdmode)
    ++		usage_msg_opt(
    ++			_("--format can't be combined with other format-altering options"),
    ++			ls_tree_usage, ls_tree_options);
      	if (argc < 1)
      		usage_with_options(ls_tree_usage, ls_tree_options);
    + 	if (get_oid(argv[0], &oid))
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, con=
st char *prefix)
      	tree =3D parse_tree_indirect(&oid);
      	if (!tree)
      		die("not a tree object");
    +-	return !!read_tree(the_repository, tree,
    +-			   &pathspec, show_tree, NULL);
     +
     +	/*
     +	 * The generic show_tree_fmt() is slower than show_tree(), so
     +	 * take the fast path if possible.
     +	 */
    -+	if (format && (!strcmp(format, ls_tree_format_d) ||
    -+		       !strcmp(format, ls_tree_format_l) ||
    -+		       !strcmp(format, ls_tree_format_n)))
    ++	if (format &&
    ++	    (!strcmp(format, ls_tree_format_d) ||
    ++	     !strcmp(format, ls_tree_format_l) ||
    ++	     !strcmp(format, ls_tree_format_n) ||
    ++	     !strcmp(format, ls_tree_format_o)))
     +		fn =3D show_tree;
     +	else if (format)
     +		fn =3D show_tree_fmt;
    -+	/*
    -+	 * Allow forcing the show_tree_fmt(), to test that it can
    -+	 * handle the test suite.
    -+	 */
    -+	if (git_env_bool("GIT_TEST_LS_TREE_FORMAT_BACKEND", 0))
    -+		fn =3D show_tree_fmt;
     +
    -+	read_tree_cb_data.format =3D format;
    - 	return !!read_tree(the_repository, tree,
    --			   &pathspec, show_tree, NULL);
    -+			   &pathspec, fn, &read_tree_cb_data);
    ++	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
      }
=20=20=20=20=20
      ## t/t3105-ls-tree-format.sh (new) ##
    @@ t/t3105-ls-tree-format.sh (new)
     +. ./test-lib.sh
     +
     +test_expect_success 'ls-tree --format usage' '
    -+	test_expect_code 129 git ls-tree --format=3Dfmt -l &&
    -+	test_expect_code 129 git ls-tree --format=3Dfmt --name-only &&
    -+	test_expect_code 129 git ls-tree --format=3Dfmt --name-status
    ++	test_expect_code 129 git ls-tree --format=3Dfmt -l HEAD &&
    ++	test_expect_code 129 git ls-tree --format=3Dfmt --name-only HEAD &&
    ++	test_expect_code 129 git ls-tree --format=3Dfmt --name-status HEAD &&
    ++	test_expect_code 129 git ls-tree --format=3Dfmt --object-only HEAD
     +'
     +
     +test_expect_success 'setup' '
    @@ t/t3105-ls-tree-format.sh (new)
     +	test_ls_tree_format \
     +		"%(path)" \
     +		"--name-only"
    ++'
     +
    ++test_expect_success 'ls-tree --format=3D<object-only-like>' '
    ++	test_ls_tree_format \
    ++		"%(objectname)" \
    ++		"--object-only"
     +'
     +
     +test_done
