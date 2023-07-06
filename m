Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345AEB64DC
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 16:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjGFQ6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjGFQ6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 12:58:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B033D1FC0
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 09:58:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E0B918C48A;
        Thu,  6 Jul 2023 12:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zmRVHAOCrgbiM3CuFrFDGmFfuZVyI5Bb12oaNN
        YM044=; b=jiS64viiD+JCy6GxE/B0eoKvyi1WTJsCNjqrXODCYMinu97q0U+TH1
        yUu/QNRFOzpTgxe5m2U8Jwg6JBSk2EQ9EkSbJJcfwdfKHB7ZDmYBGxz21AbynBay
        7cADy1texCHe9uGjfd0rXW9x2O8xFHsI/D2hAJ7Eh9e2gkrnbKixI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9489D18C489;
        Thu,  6 Jul 2023 12:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD98518C488;
        Thu,  6 Jul 2023 12:58:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Rene Scharfe <l.s.r@web.de>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: add new "describe" atom
References: <20230705175942.21090-1-five231003@gmail.com>
        <20230705175942.21090-2-five231003@gmail.com>
Date:   Thu, 06 Jul 2023 09:58:09 -0700
In-Reply-To: <20230705175942.21090-2-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Wed, 5 Jul 2023 23:27:11 +0530")
Message-ID: <xmqqbkgpdljy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49E32984-1C1E-11EE-90BB-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> +describe[:options]:: human-readable name, like
> +		     link-git:git-describe[1]; empty string for
> +		     undescribable commits. The `describe` string may be
> +		     followed by a colon and zero or more comma-separated
> +		     options. Descriptions can be inconsistent when tags
> +		     are added or removed at the same time.
> ++
> +** tags=<bool-value>: Instead of only considering annotated tags, consider
> +		      lightweight tags as well.
> +** abbrev=<number>: Instead of using the default number of hexadecimal digits
> +		    (which will vary according to the number of objects in the
> +		    repository with a default of 7) of the abbreviated
> +		    object name, use <number> digits, or as many digits as
> +		    needed to form a unique object name.
> +** match=<pattern>: Only consider tags matching the given `glob(7)` pattern,
> +		    excluding the "refs/tags/" prefix.
> +** exclude=<pattern>: Do not consider tags matching the given `glob(7)`
> +		      pattern,excluding the "refs/tags/" prefix.

You are missing a SP after the comma in "pattern,excluding" above.

The above description is slightly different from what "git describe
--help" has.  If they are described differently on purpose (e.g. you
may have made "%(describe:abbrev=0)" not to show only the closest
tag, unlike "git describe --abbrev=0"), the differences should be
spelled out more explicitly.  If the behaviours of the option here
and the corresponding one there are meant to be the same, then
either using exactly the same text, or a much abbreviated
description with a note referring to the option description of "git
describe", would help the readers better.  E.g.

    abbrev=<number>;; use at least <number> hexadecimal digits; see
    the corresponding option in linkgit:git-describe[1] for details.

which would make it clear that no behavioral differences are meant.

This new section becomes a part of an existing "labeled list"
(asciidoctor calls the construct "description list").  Starting the
new heading this patch adds with 'describe[:options]::' makes sense.
It is in line with the existing text.

I however think that the list of options is better done as a nested
description list.  Documentation/config/color.txt has an example you
can imitate.  See how slots of color.grep.<slot> are described
there.

  https://docs.asciidoctor.org/asciidoc/latest/lists/description/
  https://asciidoc-py.github.io/userguide.html#_labeled_lists

> diff --git a/ref-filter.c b/ref-filter.c
> index e0d03a9f8e..6ec647c81f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -5,6 +5,7 @@
>  #include "gpg-interface.h"
>  #include "hex.h"
>  #include "parse-options.h"
> +#include "run-command.h"
>  #include "refs.h"
>  #include "wildmatch.h"
>  #include "object-name.h"
> @@ -146,6 +147,7 @@ enum atom_type {
>  	ATOM_TAGGERDATE,
>  	ATOM_CREATOR,
>  	ATOM_CREATORDATE,
> +	ATOM_DESCRIBE,
>  	ATOM_SUBJECT,
>  	ATOM_BODY,
>  	ATOM_TRAILERS,
> @@ -215,6 +217,13 @@ static struct used_atom {
>  		struct email_option {
>  			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
>  		} email_option;
> +		struct {
> +			enum { D_BARE, D_TAGS, D_ABBREV, D_EXCLUDE,
> +			       D_MATCH } option;
> +			unsigned int tagbool;
> +			unsigned int length;

The name "tagbool" sounds strange, as we are not saying
"lengthint".

> +			char *pattern;
> +		} describe;

I am a bit confused by this structure, actually, as I cannot quite
guess from the data structure alone how you intend to use it.  Does
this give a good representation for the piece of data you are trying
to capture?

For example, %(describe:tags=no,abbrev=4) would become a single atom
with 0 in .tagbool and 4 in .length, but what does the .option
member get?

> @@ -462,6 +471,66 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
>  	return 0;
>  }
>  
> +static int parse_describe_option(const char *arg)
> +{
> +	if (!arg)
> +		return D_BARE;
> +	else if (starts_with(arg, "tags"))
> +		return D_TAGS;
> +	else if (starts_with(arg, "abbrev"))
> +		return D_ABBREV;
> +	else if(starts_with(arg, "exclude"))
> +		return D_EXCLUDE;
> +	else if (starts_with(arg, "match"))
> +		return D_MATCH;
> +	return -1;
> +}
> +
> +static int describe_atom_parser(struct ref_format *format UNUSED,
> +				struct used_atom *atom,
> +				const char *arg, struct strbuf *err)
> +{
> +	int opt = parse_describe_option(arg);
> +
> +	switch (opt) {
> +	case D_BARE:
> +		break;
> +	case D_TAGS:
> +		/*
> +		 * It is also possible to just use describe:tags, which
> +		 * is just treated as describe:tags=1
> +		 */
> +		if (skip_prefix(arg, "tags=", &arg)) {
> +			if (strtoul_ui(arg, 10, &atom->u.describe.tagbool))

This is not how you accept a Boolean.

"1", "0", "yes", "no", "true", "false", "on", "off" are all valid
values and you use git_parse_maybe_bool() to parse them.

> +				return strbuf_addf_ret(err, -1, _("boolean value "
> +						"expected describe:tags=%s"), arg);
> +
> +		} else {
> +			atom->u.describe.tagbool = 1;
> +		}
> +		break;
> +	case D_ABBREV:
> +		skip_prefix(arg, "abbrev=", &arg);
> +		if (strtoul_ui(arg, 10, &atom->u.describe.length))
> +			return strbuf_addf_ret(err, -1, _("positive value "
> +					       "expected describe:abbrev=%s"), arg);
> +		break;
> +	case D_EXCLUDE:
> +		skip_prefix(arg, "exclude=", &arg);
> +		atom->u.describe.pattern = xstrdup(arg);
> +		break;
> +	case D_MATCH:
> +		skip_prefix(arg, "match=", &arg);
> +		atom->u.describe.pattern = xstrdup(arg);
> +		break;
> +	default:
> +		return err_bad_arg(err, "describe", arg);
> +		break;
> +	}
> +	atom->u.describe.option = opt;
> +	return 0;
> +}

Even though the documentation patch we saw earlier said "may be
followed by a colon and zero or more comma-separated options", this
seems to expect only and exactly one option.  Indeed, if we run the
resulting git like "git for-each-ref --format='%(describe:tags=0,abbrev=4)'"
you will get complaints from this parser.

The implementation needs redesigning as the data structure is not
equipped to handle more than one options given at the same time, as
we saw earlier.

> @@ -664,6 +733,7 @@ static struct {
>  	[ATOM_TAGGERDATE] = { "taggerdate", SOURCE_OBJ, FIELD_TIME },
>  	[ATOM_CREATOR] = { "creator", SOURCE_OBJ },
>  	[ATOM_CREATORDATE] = { "creatordate", SOURCE_OBJ, FIELD_TIME },
> +	[ATOM_DESCRIBE] = { "describe", SOURCE_OBJ, FIELD_STR, describe_atom_parser },
>  	[ATOM_SUBJECT] = { "subject", SOURCE_OBJ, FIELD_STR, subject_atom_parser },
>  	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
>  	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
> @@ -1483,6 +1553,78 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
>  	}
>  }
>  
> +static void grab_describe_values(struct atom_value *val, int deref,
> +				 struct object *obj)
> +{
> +	struct commit *commit = (struct commit *)obj;
> +	int i;
> +
> +	for (i = 0; i < used_atom_cnt; i++) {
> +		struct used_atom *atom = &used_atom[i];
> +		const char *name = atom->name;
> +		struct atom_value *v = &val[i];
> +		int opt;
> +
> +		struct child_process cmd = CHILD_PROCESS_INIT;
> +		struct strbuf out = STRBUF_INIT;
> +		struct strbuf err = STRBUF_INIT;
> +
> +		if (!!deref != (*name == '*'))
> +			continue;
> +		if (deref)
> +			name++;
> +
> +		if (!skip_prefix(name, "describe", &name) ||
> +		    (*name && *name != ':'))
> +			    continue;

This looks overly expensive.  Why aren't we looking at the atom_type
and see if it is ATOM_DESCRIBE here?

> +		switch(opt) {
> +		case D_BARE:
> +			break;
> +		case D_TAGS:
> +			if (atom->u.describe.tagbool)
> +				strvec_push(&cmd.args, "--tags");
> +			else
> +				strvec_push(&cmd.args, "--no-tags");
> +			break;
> +		case D_ABBREV:
> +			strvec_pushf(&cmd.args, "--abbrev=%d",
> +				     atom->u.describe.length);
> +			break;
> +		case D_EXCLUDE:
> +			strvec_pushf(&cmd.args, "--exclude=%s",
> +				     atom->u.describe.pattern);
> +			break;
> +		case D_MATCH:
> +			strvec_pushf(&cmd.args, "--match=%s",
> +				     atom->u.describe.pattern);
> +			break;
> +		}

Again, it is apparent here that the atom takes only one option at most.

I'll stop here.

Thanks.
