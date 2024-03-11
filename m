Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2453BB29
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161724; cv=none; b=jFNLc98nfGyRrI6fgHFHc8U8WuDgS3TVrBv8rvLGBo9Mm9ZqHEllbVksDAC4dFWEfaZPv7vySorSlz/Pij886ug+tKpv7FUiHVDn23mIomWTJP9E7lSmDi8CFbRatGJrLfWUdBmpgu1h/5bS5l21Qo+uJPZDa8aJ4/Clg/Vq7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161724; c=relaxed/simple;
	bh=8GSaqfSmQfqCOEQpaE+oQ+jqdASF0mZiQ4lExuEIeNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n63rg96RULnXMn0+wShsA7ZydTC9KiaknLEyulYPcyXEOd73KcghjNOi/w6NbYsPG6SGVBRtjl8XcD+obOQHKavV3wZG4vG8ceiTgvUdsKC9NuHGzQF1p22o5aA9YQzoc/BvaA2dTJoiGnoRDGLkNwHPFVkwq6gnyQTmgyNVE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b3VgYDkM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b3VgYDkM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8732A23FC2;
	Mon, 11 Mar 2024 08:55:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8GSaqfSmQfqCOEQpaE+oQ+jqdASF0mZiQ4lExu
	EIeNE=; b=b3VgYDkMTwpBS10I0NwPb3G9JiczCJ0Ts82uHs7XhtSN06ntIq2grj
	DqwjimIrVlLC1qu1V8q2KVuCTBCz4VmQg1vOc2/Oe+6fe483+gX+WloIYsfJvPRi
	fobuI2zKgtLEhytbBlv3fCe4n11l6L4VLQmUqt3o9vl1hpFGGPCtQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 80A7623FC1;
	Mon, 11 Mar 2024 08:55:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C9C823FC0;
	Mon, 11 Mar 2024 08:55:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  Ralph Seichter
 <github@seichter.de>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com> (Ralph
	Seichter via GitGitGadget's message of "Thu, 07 Mar 2024 15:15:39
	+0000")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
	<pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 05:55:16 -0700
Message-ID: <xmqqy1apudvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9CAEBDEE-DFA6-11EE-8134-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ralph Seichter <github@seichter.de>
>
> Introduce the ability to append comments to modifications
> made using git-config. Example usage:
>
>   git config --comment "changed via script" \
>     --add safe.directory /home/alice/repo.git
>
> based on the proposed patch, the output produced is:
>
>   [safe]
>     directory = /home/alice/repo.git #changed via script

For readability, you probably would want to have a SP before the
given string, i.e.,

	variable = "value" # message comes here

> * Motivation:
>
> The use case which triggered my submitting this patch is

These two lines should not be needed.  It is customary to just state
that the users need to be able to do X and adding feature Y is one
way to allow that, without such preamble.

> my need to distinguish between config entries made using
> automation and entries made by a human. Automation can
> add comments containing a URL pointing to explanations
> for the change made, avoiding questions from users as to
> why their config file was changed by a third party.
>
> * Design considerations and implementation details:
>
> The implementation ensures that a # character is always
> prepended to the provided comment string, and that the

It is unclear what happens when a user gives comment that already
has the comment introducer, e.g., --comment="# this is comment".

> comment text is appended as a suffix to the changed key-
> value-pair in the same line of text. Multiline comments
> are deliberately not supported, because their usefulness

"not supported" can take many shapes, ranging from "producing a
random result and may corrupt the resulting configuration file"
and "the second and subsequent lines are silently ignored", to
"results in an error, stops the command before doing anything".

> does not justifiy the possible problems they pose when
> it comes to removing ML comments later.

"justify"

>
> * Target audience:
>
> Regarding the intended consumers of the comments made:

The above two lines say the same thing and are unnecessary,
especially before a sentence that begins with "They are aimed at".

> They are aimed at humans who inspect or change their Git
> config using a pager or editor. Comments are not meant
> to be read or displayed by git-config at a later time.
>
> Signed-off-by: Ralph Seichter <github@seichter.de>
> ---
>     config: add --comment option to add a comment
>
>     config: add --comment option to add a comment
>      
>     Introduce the ability to append comments to modifications made using
> ...
>        displayed by git-config at a later time.

No need to repeat a wall of text below the three-dash line if they
do not give additional information on top of what is already in the
proposed commit log message.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index dff39093b5e..ee8cd251b24 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -9,9 +9,9 @@ git-config - Get and set repository or global options
>  SYNOPSIS
>  --------
>  [verse]
> -'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
> -'git config' [<file-option>] [--type=<type>] --add <name> <value>
> -'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
> +'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
> +'git config' [<file-option>] [--type=<type>] [--comment=<value>] --add <name> <value>
> +'git config' [<file-option>] [--type=<type>] [--comment=<value>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
>  'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
>  'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
>  'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<value-pattern>]

There is Patrick's proposal to revamp the UI of this command,

  https://lore.kernel.org/git/cover.1709724089.git.ps@pks.im/

which may make the above simpler (e.g., there won't be two lines
that talks about "set" commands, with and without "--add" option,
for example).  This topic may want to at least wait for the
conclusion of that design discussion, and possibly its
implementation.

> @@ -87,6 +87,10 @@ OPTIONS
>  	values.  This is the same as providing '^$' as the `value-pattern`
>  	in `--replace-all`.
>  
> +--comment::
> +	Append a comment to new or modified lines. A '#' character
> +	will be automatically prepended to the value.

Other options that take mandatory parameter are are described with
their parameter on the item heading line.  It may help to somehow
mention that the "appending" is done at the end on the same line.
Perhaps something along this line.

	--comment <message>::
		Append the _<message>_ at the end of the new or
		modified lines with the value.  A comment introducer
		` # ` is prepended to _<message>_ if it does not
		already have one.  The command errors out if given
		a _<message>_ that spans multiple lines.


> @@ -797,6 +799,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		usage_builtin_config();
>  	}
>  
> +	if (comment && !(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL))) {

This overly long line is both visually annoying and harder to
maintain.  If you can design a solution that makes it easier to read
a future patch that adds support of the comment option to more
actions (or removes it from an action), that would be great.
Otherwise, do at least:

	if (comment &&
	    !(actions & (...)) {

> +		error(_("--comment is only applicable to add/set/replace operations"));
> +		usage_builtin_config();
> +	}
> +

If I were doing this, I'd probably add this new block after the
fixed-value thing, as it is bad manners to add new code _before_
existing ones, as if your new invention were somehow more important
than all the others, when the order does not matter.  If there is a
valid technical reason (e.g., the new code modifies the state of the
program that affects the beahviour of the later and existing parts
of the code), the above comment of course does not apply.

>  	/* check usage of --fixed-value */
>  	if (fixed_value) {
>  		int allowed_usage = 0;


> @@ -880,7 +887,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		check_write();
>  		check_argc(argc, 2, 2);
>  		value = normalize_value(argv[0], argv[1], &default_kvi);
> -		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
> +		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], comment, value);

It is somewhat annoying that we have to see so much code churn to
add this new parameter X-<.  I notice that we are sending "comment"
to the underlying machinery without doing ANY sanity checking (like,
"ah, we got a message without the '#' prefix, so we should add '# '
in front of it before asking the API to add that comment string to
the value line").  We may also want to have a code that says:

    Yikes, this message has LF in it, but the underlying machinery
    does not check for it and end up corrupting the configuration
    file by creating

	[section]
		var = value #comment
	that spans on two lines

    when given

	LF='
	'
        git config --comment="comment${LF}that spans..." section.var value

or something.  The underlying machinery should be updated to die()
when given such a message instead of silently corrupting the
resulting file, but the front-end that receives the end-user input
should check for obviously problematic payload before bothering the
API with it.

> -	strbuf_addf(&sb, "%s\n", quote);
> +	if (comment)
> +		strbuf_addf(&sb, "%s #%s\n", quote, comment);
> +	else
> +		strbuf_addf(&sb, "%s\n", quote);

> diff --git a/config.h b/config.h
> index 5dba984f770..a85a8271696 100644
> --- a/config.h
> +++ b/config.h
> @@ -290,7 +290,7 @@ int git_config_pathname(const char **, const char *, const char *);
>  
>  int git_config_expiry_date(timestamp_t *, const char *, const char *);
>  int git_config_color(char *, const char *, const char *);
> -int git_config_set_in_file_gently(const char *, const char *, const char *);

The original was probably OK without naming these parameters of the
same type, as it is (arguably) obvious to have the filename first,
because that is what differenciates the "in-file" variant.  And then
key followed by value, because that is the usual "assignment" order
people would naturally expect.

But it was already on the borderline.  The idea is that we do not
have to (but still can) name the parameters in our function
declarations when it is obvious from their types what they are.
Addition of this comment thing will push us way over the line.

The same comment applies to many of the function declarations
touched by this patch.

If I were doing this patch, I'd have at least one clean-up patch
that updates this line to read:

    int git_config_set_in_file_gently(const char *filename, const char *key, const char *value);

And then write a separate patch to add the "--comment" feature.

I however have some suspicion that we might move away from "listing
many random parameters" style to "having only the essential
parameters, together with a single pointer to a structure that holds
the optional bits" style, especially when the UI revamp Patrick
proposed comes.  In the case of config API, <key, value> is the
essential bit in the write direction, and value-pattern restriction
and the bit that says key is an regexp would be in "the optional
bits" group.  This <comment> thing will also be in the latter class.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 31c38786870..daddaedd23c 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -69,13 +69,18 @@ test_expect_success 'replace with non-match (actually matching)' '
>  
>  cat > expect << EOF
>  [section]
> -	penguin = very blue
>  	Movie = BadPhysics
>  	UPPERCASE = true
> -	penguin = kingpin
> +	penguin = gentoo #Pygoscelis papua
> +	disposition = peckish #find fish
>  [Sections]
>  	WhatEver = Second
>  EOF
> +test_expect_success 'append comments' '
> +	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
> +	git config --comment="find fish" section.disposition peckish &&
> +	test_cmp expect .git/config
> +'

Add test for at least two more cases and show what should happen.

	--comment="# the user already has the pound"
	--comment="this is being ${LF} naughty to break configuration"

Thanks.
