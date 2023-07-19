Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607FC0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 18:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGSSQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSSQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 14:16:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B611C
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 11:16:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b9de3e7fb1so38064935ad.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689790578; x=1690395378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWtDPiAoXv+hd94ePqrjR3xTnQbCr7ZMq4NvDxwYWH0=;
        b=dnadrghQGuNgaJjWjMXlgI0VCd462YqFYgIEA8eBR/D3b5xq/6WfBZZ3GaXTNGYcXO
         s6o+lZO4lKMjIAeBb5FqG42hRJAaqN+f83PCtuuwKgrIk0MdcsYlL5tSN4GbqysQ3lxf
         oj6DPp0JoHLQiYsbS4Q9h1BrMwzVIm1apFTBNd6aBrKhxTnzhkeSUgI1JzRDxnHKRSmF
         +iApDFlEJYPj6PNf6WC8oiVB2NqhlTxlVxazkInN2QR4lbOtDCDWYFLknzBgKNoLK2iZ
         9qHKaPxZ+bYrcI5WviQNXDbUQ1kMLz5O4ke/jUtFKFXWNwQ7+GaYZmKehCbEqplyDjRm
         sueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689790578; x=1690395378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWtDPiAoXv+hd94ePqrjR3xTnQbCr7ZMq4NvDxwYWH0=;
        b=XxJHvouAQeFv2cmFQAI8nEP9/hs/rywXkFlW977yM+0kTmf1eA5YdI17jxpE8Dwp0s
         MNU0qoP25aM2ttyrqW0aZ/xgyCLPvu+vISr8BAaSuZjBr/w44bvgrIFD/FAKmhy5B3rX
         /FvMpE/DsOFUb2lmfaSC6kODn0VzUISmlKApzs31BMV4yT5UG3FjB0dXPFbGzFD9gwP2
         /u2hrSnwOYWaW22CvKv7tAz1hi7g1meatH1JMBDUsaV4yGVBrsfbCqyniXC7islpnum7
         qISOKb21XOulUVQBLZH5tajD+qKtkhhE2bfZ4Zoba9X9lCozWTlgi53rAjd0KLulz1/3
         6nzQ==
X-Gm-Message-State: ABy/qLao69pN+aDaWyYVrIZ83yM9GSbEfk5Xm3jhKPux/qfWzOV1qzuy
        CK3fz75pUSHkwqS42/ER41Iczr/1E/zWTQ==
X-Google-Smtp-Source: APBJJlGyHTEbSQ6fbtLTtC/LIau1kEu1M3WFhGIlmtkiR4dfPeiYFZ9VOvDVHrZGMBVLmzavUqlrYQaXymk6gg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:ec88:b0:1b9:df8f:888c with SMTP
 id x8-20020a170902ec8800b001b9df8f888cmr25165plg.8.1689790578576; Wed, 19 Jul
 2023 11:16:18 -0700 (PDT)
Date:   Wed, 19 Jul 2023 11:16:16 -0700
In-Reply-To: <20230715160730.4046-1-andy.koppe@gmail.com>
Mime-Version: 1.0
References: <20230715103758.3862-1-andy.koppe@gmail.com> <20230715160730.4046-1-andy.koppe@gmail.com>
Message-ID: <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
From:   Glen Choo <chooglen@google.com>
To:     Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andy!

We picked up this series at Review Club. Reviewers will leave their
thoughts on the mailing list, but if you like, you can find the notes
at:

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit

Andy Koppe <andy.koppe@gmail.com> writes:

> This lists ref names in the same way as the %d decoration format, but
> allows all the otherwise fixed strings printed around the ref names to
> be customized, namely prefix, suffix, separator, the "tag:" annotation
> and the arrow used to show where HEAD points.
>
> Examples:
> - %(decorate) is equivalent to %d.
> - %(decorate:prefix=,suffix=) is equivalent to %D.
> - %(decorate:prefix=,suffix=,separator= ,tag=,arrow=->) produces a
>   space-separated list without wrapping, tag annotations or spaces
>   around the arrow.
> - %(decorate:prefix=[,suffix=],separator=%x2C,arrow=%x2C,tag=) produces
>   a comma-separated list enclosed in square brackets where the arrow is
>   replaced by a comma as well.

I think giving the user this level of customization makes sense,
especially since we do this for other format options. Importantly, this
design also fits the existing conventions we have, so this looks like a
good proposal.

As a micro-nit: there's some useful context behind your chosen design in
[1]. It would have been useful to link to it in the `---` context, or
perhaps send this series as v3 and v4 to [1].

[1] https://lore.kernel.org/git/20230712110732.8274-1-andy.koppe@gmail.com/

> Add functions parse_decoration_option(), parse_decoration_options() and
> free_decoration_options() to help implement the format. Test it in
> t4205-log-pretty-formats.sh and document it in pretty-formats.txt.

This commit adds the new feature...

> Refactor format_decorations() to take a struct decoration_options
> argument specifying those strings, whereby NULL entries select the
> default. Avoid emitting color sequences for empty strings.

does some refactoring to support the new feature + existing use cases...

> Wrap tag annotations in separate color sequences from tag names, because
> otherwise tag names can end up uncolored when %w width formatting breaks
> lines between annotation and name. Amend t4207-log-decoration-colors.sh
> accordingly.

and fixes a bug with coloring that is easier to run into as a result of
the new feature.

As others have mentioned, I think this would be easier to follow as
separate commits. This commit isn't so big that the refactor needs to be
its own commit, though I don't feel strongly either way.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 3b71334459..c08aba15af 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -222,7 +222,22 @@ The placeholders are:
>  	linkgit:git-rev-list[1])
>  '%d':: ref names, like the --decorate option of linkgit:git-log[1]
>  '%D':: ref names without the " (", ")" wrapping.
> -'%(describe[:options])':: human-readable name, like
> +'%(decorate[:<options>])':: ref names with custom decorations.
> +			  The `decorate` string may be followed by a colon
> +			  and zero or more comma-separated options.
> +			  Option values may contain literal formatting codes.
> +			  These must be used for commas (`%x2C`) and closing
> +			  parentheses (`%x29`), due to their role in the option
> +			  syntax.

To make this easier to visualize, it would be useful to include the
examples from your commit message (%d, %D, etc.).

> +'%(describe[:<options>])':: human-readable name, like

Ah, adding the <> is a good fix. I think it doesn't warrant its own
patch, but it should be called out in the commit message.

>  /*
>   * The caller makes sure there is no funny color before calling.
> - * format_decorations_extended makes sure the same after return.
> + * format_decorations ensures the same after return.
>   */
> -void format_decorations_extended(struct strbuf *sb,
> +void format_decorations(struct strbuf *sb,
>  			const struct commit *commit,
>  			int use_color,
> -			const char *prefix,
> -			const char *separator,
> -			const char *suffix)
> +			const struct decoration_options *opts)
>  {
> -	const struct name_decoration *decoration;
> -	const struct name_decoration *current_and_HEAD;
> -	const char *color_commit =
> -		diff_get_color(use_color, DIFF_COMMIT);
> -	const char *color_reset =
> -		decorate_get_color(use_color, DECORATION_NONE);
> +	const char *color_commit, *color_reset;
> +	const char *prefix, *suffix, *separator, *arrow, *tag;
> +
> +	const struct name_decoration *current_and_HEAD;
> +	const struct name_decoration *decoration =
> +		get_name_decoration(&commit->object);
>  
> -	decoration = get_name_decoration(&commit->object);
>  	if (!decoration)
>  		return;
>  
> +	color_commit = diff_get_color(use_color, DIFF_COMMIT);
> +	color_reset = decorate_get_color(use_color, DECORATION_NONE);

I'm guessing that you shuffled these lines to make use of an early
return? If so, both versions are not different enough to warrant the
churn IMO. It would be worth pointing out the reshuffling in the commit
message, especially if you had another rationale in mind.

> +	prefix = (opts && opts->prefix) ? opts->prefix : " (";
> +	suffix = (opts && opts->suffix) ? opts->suffix : ")";
> +	separator = (opts && opts->separator) ? opts->separator : ", ";
> +	arrow = (opts && opts->arrow) ? opts->arrow : " -> ";
> +	tag = (opts && opts->tag) ? opts->tag : "tag: ";

So NULL means "use the default"...

> +struct decoration_options {
> +	char *prefix;
> +	char *suffix;
> +	char *separator;
> +	char *arrow;
> +	char *tag;
> +};
> +
>  int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
>  int log_tree_diff_flush(struct rev_info *);
>  int log_tree_commit(struct rev_info *, struct commit *);
>  void show_log(struct rev_info *opt);
> -void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
> -			     int use_color,
> -			     const char *prefix,
> -			     const char *separator,
> -			     const char *suffix);
> -#define format_decorations(strbuf, commit, color) \
> -			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
> +void format_decorations(struct strbuf *sb, const struct commit *commit,
> +			int use_color, const struct decoration_options *opts);

Which lets us unify these two functions. Makes sense.

> +static int parse_decoration_option(const char **arg,
> +				   const char *name,
> +				   char **opt)
> +{
> +	const char *argval;
> +	size_t arglen;
> +
> +	if (match_placeholder_arg_value(*arg, name, arg, &argval, &arglen)) {
> +		char *val = xstrndup(argval, arglen);
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		strbuf_expand(&sb, val, strbuf_expand_literal_cb, NULL);

strbuf_expand() got removed in 'master' recently, so this should be
rebased.

>  static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  				const char *placeholder,
>  				void *context)
> @@ -1526,10 +1566,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  		strbuf_addstr(sb, get_revision_mark(NULL, commit));
>  		return 1;
>  	case 'd':
> -		format_decorations(sb, commit, c->auto_color);
> +		format_decorations(sb, commit, c->auto_color, NULL);
>  		return 1;
>  	case 'D':
> -		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
> +		format_decorations(sb, commit, c->auto_color,
> +				   &(struct decoration_options){"", ""});

I don't remember if C99 lets you name .prefix and .suffix here, but if
so, it would be good to name them. Otherwise it's easy to get the order
wrong, e.g. if someone reorders the fields in struct decoration_options.

> +test_expect_success 'pretty format %decorate' '
> +	git checkout -b foo &&
> +	git commit --allow-empty -m "new commit" &&
> +	git tag bar &&
> +	git branch qux &&
> +	echo " (HEAD -> foo, tag: bar, qux)" >expect1 &&
> +	git log --format="%(decorate)" -1 >actual1 &&
> +	test_cmp expect1 actual1 &&
> +	echo "HEAD -> foo, tag: bar, qux" >expect2 &&
> +	git log --format="%(decorate:prefix=,suffix=)" -1 >actual2 &&
> +	test_cmp expect2 actual2 &&
> +	echo "HEAD->foo bar qux" >expect3 &&
> +	git log --format="%(decorate:prefix=,suffix=,separator= ,arrow=->,tag=)" \
> +		-1 >actual3 &&
> +	test_cmp expect3 actual3 &&
> +	echo "[HEAD,foo,bar,qux]" >expect4 &&
> +	git log --format="%(decorate:prefix=[,suffix=],separator=%x2C,arrow=%x2C,tag=)" \
> +		-1 >actual4 &&
> +	test_cmp expect4 actual4
> +'
> +

It would be useful to get some "bad" inputs to %(decorate:) to check
that we handle them correctly, especially since it's implemented with
while() loops.

Overall, I thought this patch looks really good. Thanks!
