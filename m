Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66EC00140
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 00:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiG2ANL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2ANK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 20:13:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853CA56B9B
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 17:13:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z23so5770649eju.8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=BufxXIStDJ5K4Q7JTJXEDEIGQt7p9jQYXyDwQ3RvV08=;
        b=eIy2R6kyulGDzZVm5GJpzHMO2M2FGxzjkD869xQyF4ivxqHcf37/jeo3UrM0IZM8Wx
         e9T5UOXXAhnQKLgN8IK10LDNiLqRPcNp00HuGB2M15DeCPYgGD2WQ+JVeL//Q0+ItKex
         a4rOAS1IAgqvt8amlhKSdExX3THZK/Zb2r9nQrMRj1Uvsdmyi52vGLDDwCGvj1r8ilfl
         +YFbcZCyby4govMEpKR+tt9hWRacxJg3Us9LgpIWnYL+qqYREU9mS5sob68WuzEcCzCa
         kLZEakiOczD5L132xwvgBvgO0HHJ9JolxQRaYEgoqA28KwddMtxFwpvBzNVpttofibyl
         zCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=BufxXIStDJ5K4Q7JTJXEDEIGQt7p9jQYXyDwQ3RvV08=;
        b=TnZg9vlGsEXoyPrDuJtfC0Bh5jLqgzUMxsbZKNcapZo/5eTRErO20cS3hx1Xab+LJb
         izwMD3BZc5+lHV/SNWAtl0QZlQv3aLbaO91RawNYrK4krJeWX6bhlDFvX6UxkPBKWR/s
         O5x6vWhuiig/GdYUh8RU+Vpw7/x7c0FEdKsegi3uES0cVvYAVRVO0FG6eMTRqRZip3VL
         OAQjnhUBadjVqCfFMDAWUl+0gFcKyY9J+YWWgD+6UHj58f5sT0gwRcgGlJq5WrLrzQIY
         +zvq8+OLphDTG/dSJQG3JFUT1IuxntJ1m/rxgoDDv2farR76OWLMOkDkxLBxnnPUtkqf
         4Xsg==
X-Gm-Message-State: AJIora/ukEUUUX1z33ViBilC8VBc9dPZpK4Bt1USMdfSrJxT0lROHK/R
        2EVppHtKKgWSXFmR9CdPfLc=
X-Google-Smtp-Source: AGRyM1tEYVQ3MVqmZ9SiyuV1UYmpU7SSsY575qu7so1FvbAW7RnCMcm3IFeyLF6l+aKJzRQz5sOBYw==
X-Received: by 2002:a17:907:2c74:b0:72b:5ba7:d96f with SMTP id ib20-20020a1709072c7400b0072b5ba7d96fmr976902ejc.33.1659053586748;
        Thu, 28 Jul 2022 17:13:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ay15-20020a170906d28f00b00726dbb16b8dsm957229ejb.65.2022.07.28.17.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 17:13:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oHDcm-007Kum-W6;
        Fri, 29 Jul 2022 02:13:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7] submodule merge: update conflict error message
Date:   Fri, 29 Jul 2022 01:22:57 +0200
References: <20220726210020.3397249-1-calvinwan@google.com>
 <20220728211221.2913928-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220728211221.2913928-1-calvinwan@google.com>
Message-ID: <220729.86y1wcixnz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Calvin Wan wrote:

> For Elijah: Cleaned up the small nits and updated resolutions for
> those 4 cases we discussed.
>
> For =C3=86var: Apologies for misunderstanding your suggestions to make
> my messages easier for translators to work with. I have reformatted
> all of the messages to separate text vs formatting translations. Let
> me know if this is what you were expecting.

Let's take a look, and thanks for sticking with this...

>
>  merge-ort.c                 | 112 ++++++++++++++++++++++++++++++++++--
>  t/t6437-submodule-merge.sh  |  78 +++++++++++++++++++++++--
>  t/t7402-submodule-rebase.sh |   9 ++-
>  3 files changed, 185 insertions(+), 14 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 01f150ef3b..4302e900ee 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -387,6 +387,9 @@ struct merge_options_internal {
>=20=20
>  	/* call_depth: recursion level counter for merging merge bases */
>  	int call_depth;
> +
> +	/* field that holds submodule conflict information */
> +	struct string_list conflicted_submodules;
>  };
>=20=20
>  struct version_info {
> @@ -517,6 +520,7 @@ enum conflict_and_info_types {
>  	CONFLICT_SUBMODULE_NOT_INITIALIZED,
>  	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
>  	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
> +	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
>=20=20
>  	/* Keep this entry _last_ in the list */
>  	NB_CONFLICT_TYPES,
> @@ -570,6 +574,8 @@ static const char *type_short_descriptions[] =3D {
>  		"CONFLICT (submodule history not available)",
>  	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =3D
>  		"CONFLICT (submodule may have rewinds)",
> +	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =3D
> +		"CONFLICT (submodule no merge base)"
>  };
>=20=20
>  struct logical_conflict_info {
> @@ -686,6 +692,8 @@ static void clear_or_reinit_internal_opts(struct merg=
e_options_internal *opti,
>=20=20
>  	mem_pool_discard(&opti->pool, 0);
>=20=20
> +	string_list_clear(&opti->conflicted_submodules, 1);
> +
>  	/* Clean out callback_data as well. */
>  	FREE_AND_NULL(renames->callback_data);
>  	renames->callback_data_nr =3D renames->callback_data_alloc =3D 0;
> @@ -1744,26 +1752,40 @@ static int merge_submodule(struct merge_options *=
opt,
>=20=20
>  	int i;
>  	int search =3D !opt->priv->call_depth;
> +	int sub_initialized =3D 1;
>=20=20
>  	/* store fallback answer in result in case we fail */
>  	oidcpy(result, opt->priv->call_depth ? o : a);
>=20=20
>  	/* we can not handle deletion conflicts */
> -	if (is_null_oid(o))
> -		return 0;
>  	if (is_null_oid(a))
> -		return 0;
> +		BUG("submodule deleted on one side; this should be handled outside of =
merge_submodule()");=20
>  	if (is_null_oid(b))
> -		return 0;
> +		BUG("submodule deleted on one side; this should be handled outside of =
merge_submodule()");
>=20=20
> -	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
> +	if ((sub_initialized =3D repo_submodule_init(&subrepo,
> +									opt->repo, path, null_oid()))) {
>  		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
>  			 path, NULL, NULL, NULL,
>  			 _("Failed to merge submodule %s (not checked out)"),
>  			 path);
> +		/*
> +		 * NEEDSWORK: Since the steps to resolve this error are
> +		 * more involved than what is currently in=20
> +		 * print_submodule_conflict_suggestion(), we return
> +		 * immediately rather than generating an error message
> +		 */
>  		return 0;
>  	}
>=20=20
> +	if (is_null_oid(o)) {
> +		path_msg(opt, CONFLICT_SUBMODULE_NULL_MERGE_BASE, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("Failed to merge submodule %s (no merge base)"),
> +			 path);
> +		goto cleanup;
> +	}
> +
>  	if (!(commit_o =3D lookup_commit_reference(&subrepo, o)) ||
>  	    !(commit_a =3D lookup_commit_reference(&subrepo, a)) ||
>  	    !(commit_b =3D lookup_commit_reference(&subrepo, b))) {
> @@ -1849,7 +1871,15 @@ static int merge_submodule(struct merge_options *o=
pt,
>=20=20
>  	object_array_clear(&merges);
>  cleanup:
> -	repo_clear(&subrepo);
> +	if (!opt->priv->call_depth && !ret) {
> +		struct string_list *csub =3D &opt->priv->conflicted_submodules;
> +
> +		string_list_append(csub, path)->util =3D
> +				xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV));

FWIW (since you may have changed this due to my comment) I meant (but
maybe didn't make clear enough) in
https://lore.kernel.org/git/220727.86ilnilxfv.gmgdl@evledraar.gmail.com/
that just getting rid of the "util" variable could trivially be done, so:

	struct string_list *csub =3D &opt->priv->conflicted_submodules;
	const char *abbrev;

	abbrev =3D repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);

	string_list_append(csub, path)->util =3D xstrdup(abbrev);

What you have here is also just fine, but in case you traded the line
variable for line wrapping I think it's just fine (and actually
preferable) to just make an intermediate variable to avoid this sort of
line wrapping.

Anyway, just clarifying...

> +static void print_submodule_conflict_suggestion(struct string_list *csub=
) {
> +	if (csub->nr > 0) {

Since the entire body of the function is guarded by this maybe avoid the
indentation and:

	if (!csub->nr)
		return;


> +		struct string_list_item *item;
> +		struct strbuf msg =3D STRBUF_INIT;
> +		struct strbuf tmp =3D STRBUF_INIT;
> +
> +		strbuf_addf(&tmp, _("Recursive merging with submodules currently only =
supports trivial cases."));
> +		strbuf_addf(&msg, "%s\n", tmp.buf);
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, _("Please manually handle the merging of each confli=
cted submodule."));
> +		strbuf_addf(&msg, "%s\n", tmp.buf);
> +		strbuf_release(&tmp);
> +
> +		strbuf_addf(&tmp, _("This can be accomplished with the following steps=
:"));
> +		strbuf_addf(&msg, "%s\n", tmp.buf);
> +		strbuf_release(&tmp);

This was *almost* correct in your v6, i.e.:

	printf(_("Recursive merging with submodules currently only supports trivia=
l cases.\n"
		 "Please manually handle the merging of each conflicted submodule.\n"
		 "This can be accomplished with the following steps:\n"));

What I meant with "We can add \n\n unconditionally, no need to put it in
the translation." in
https://lore.kernel.org/git/220727.86ilnilxfv.gmgdl@evledraar.gmail.com/
is that you should avoid adding formatting to translations themselves if
possible.

i.e. what we're translating here is a full paragraph, so to a translator
it doesn't matter if it ends with ":\n" or ":", so we can add the last
"\n" unconditionalyl.

But we should *not* add the \n's within a single paragraph
unconditionally, a translator needs to be able to translate that entire
string.

Different languages split sentences differently, and different
conventions in different languages & SVO v.s. OVS or wahtever (see
https://en.wikipedia.org/wiki/Word_order) means that your last sentence
might need to come first in some languages.

So I think this should just be:

	printf(_("Recursive merging with submodules currently only supports trivia=
l cases.\n"
		 "Please manually handle the merging of each conflicted submodule.\n"
		 "This can be accomplished with the following steps:"));
	putchar('\n');

I.e. the "\n" within the pargraph are imporant, and translators need to
be able to amend those, and perhaps some languages will have 2x, some 4x
or whatever.

Whereas the "\n" at the end is something we can always add, because it's
just a matter of how we're interpolating the paragraph into other output
(think *nix terminal v.s. say HTML, just as an example).

> +
> +		for_each_string_list_item(item, csub) {
> +			const char *abbrev=3D item->util;
> +			/*
> +			 * TRANSLATORS: This is a line of advice to resolve a merge conflict
> +			 * in a submodule. The second argument is the abbreviated id of the
> +			 * commit that needs to be merged.
> +			 * E.g. - go to submodule (sub), and either merge commit abc1234"
> +			 */
> +			strbuf_addf(&tmp, _("go to submodule (%s), and either merge commit %s=
"),
> +													item->string, abbrev);

...

> +			strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +			strbuf_addf(&msg, "\n");
> +			strbuf_release(&tmp);
> +			strbuf_addf(&tmp, _("or update to an existing commit which has merged=
 those changes"));
> +			strbuf_addf(&msg, _("   %s"), tmp.buf);
> +			strbuf_addf(&msg, "\n");
> +			strbuf_release(&tmp);

Similarly this is worse, because we're now splitting up up a single
sentence or paragraph into multiple translations.

FWIW I meant that you could write some helper function that would do
something like this (in Perl, too lazy to write C now):

	perl -wE '
		my @lines =3D split /\n/, $ARGV[0];
		for (my $i =3D 0; $i < @lines; $i++) {
			my $pfx =3D !$i ? "- " : "  "; say "$pfx$lines[$i]";
	}' "$(printf "some multi\nline paragraph\nhere")"
	- some multi
	  line paragraph
	  here

I.e. the translator would see:

	_("some multi\nline paragraph\nhere")

Which would allow them to insert any amount of newlines, but you'd just
have a utility function that:

 * Splits those lines by \n
 * Formats the first line by _("- %s\n")
 * Formats subsequent lines with _("  %s\n")=20
 * The %s in those is a _()'d string.

I.e. what's happening at the bottom of show_ambiguous_object(). It's:

 * A relatively small amount of programming,
 * Lets translators focus only on these formatting questions for the
   translations that do the magic formatting, and those only need to be
   changed for RTL languages.

   I.e. German and English whill both want "- %s\n", but e.g. Hebrew
   will want "%s -\n".

 * Makes the code easier to read, because instead of adding formatting conc=
erns to every string, you'd just:

	strbuf_addstr(&buf, add_fmt_list_item(i, _("blah bla\nblah blah\nblah.)));

> +		strbuf_release(&tmp);

When you use the strbuf API you should strbuf_reset() within a single
scope if you want to "clear" it, not strbuf_release().

The strbuf_release() also works, but then it's a malloc()/free(), each
time, with strbuf_reset() we don't free() it, we just set the len to
zero, and the content to "\0", but remember how long it was ("alloc" in
strbuf.h).

You then only do the strbuf_release() at the very end.
