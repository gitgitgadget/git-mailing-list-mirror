From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Introduce diff.algorithm variable
Date: Fri, 09 Mar 2012 10:40:14 -0800
Message-ID: <7vmx7p62k1.fsf@alter.siamese.dyndns.org>
References: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, peff@peff.net,
	Lawrence.Holding@cubic.com
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 19:40:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S64jo-0004pk-0D
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 19:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758619Ab2CISkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 13:40:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758549Ab2CISkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 13:40:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D04A35430;
	Fri,  9 Mar 2012 13:40:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=czfIcUWelwNS7MBoNXizAjvBnGY=; b=iLpUMN
	uuf30nn2AhOofL+uzY8yqWd7yCl8aZskANdQA5E6G3fYicgmANqTO4AtS5Qgn8TR
	RJcNMws+p6jldvBJgv5CQ3gVHZfiO4I0yfomRusiJ2zKLxQvHeibpwL6Hn+3XPBd
	HIY4VGve2N4H9BJWnnVYOPwAFjW2/HjAjDbFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XwZSdnMfLhHdD5YxSq9vqI34XvjqRzj1
	44qHGawJN7o0Q6OaLBBNX0itDSqShUg0ux/80WcgzN+oOduAawRHTovoX1Gj72cy
	8uk511uxubGAo59yRo7aAsxzpxQNFxn350Op9CjEh5XXPrr3sjItkbFePIfTIJMu
	apYc6Q4Gfhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5F46542F;
	Fri,  9 Mar 2012 13:40:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09C71542E; Fri,  9 Mar 2012
 13:40:15 -0500 (EST)
In-Reply-To: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Fri, 9 Mar 2012 14:48:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5038DC4A-6A17-11E1-BCD9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192732>

Michal Privoznik <mprivozn@redhat.com> writes:

> Some users have preference over various diff algorithms. However,
> now they are forced to use appropriate argument every time they
> run git-diff and tools using it. This is impractical. Therefore
> create new variable which can set preferred algorithm. Of course,

We tend to prefer avoiding these subjective and judgemental words
like "forced" and "impractical" when the paragraph conveys the same
reasoning even when they are toned down.

> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 6aa1be0..1047e81 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -1,3 +1,24 @@
> +diff.algorithm::
> +    Choose a diff algorithm.  The variants are as follows:

In order to avoid confusing users, we may want to mention that it is
deliberate that this configuration does not apply to plumbing
commands.

It may make sense to drop the enumeration of "The variants are...",
and say that it can take the values valid for the "--diff-algorithm"
parameter to the "diff" family of commands.  We do not have to worry
about keeping two enumerations in sync if we did so.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 7d4566f..4e8bc5b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -55,6 +55,29 @@ endif::git-format-patch[]
>  --histogram::
>  	Generate a diff using the "histogram diff" algorithm.
>  
> +--diff-algorithm={histogram|myers|minimal|patience}::
> +    Choose a diff algorithm. The defaults are controlled
> +    by the `diff.algorithm` configuration variable

s/$/ for the Porcelain commands/; perhaps?

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index fba076d..d54f3a3 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1299,6 +1299,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--raw
>  			--dirstat --dirstat= --dirstat-by-file
>  			--dirstat-by-file= --cumulative
> +			--diff-algorithm=
>  "

So this helps me when I do "git diff --diff-al<TAB>" and expands it
to "git diff --diff-algorithm=" and then...

>  _git_diff ()
> @@ -1306,6 +1307,10 @@ _git_diff ()
>  	__git_has_doubledash && return
>  
>  	case "$cur" in
> +	--diff-algorithm=*)
> +		__gitcomp "myers histogram minimal patience"
> +		return
> +		;;

... when typing <TAB> again, this helps me by reminding what choices
are available.  Is that the idea?  Nice.

But I see you repeated this four-element list three times.  Can't we
do it in just one place?

> diff --git a/diff.c b/diff.c
> index 377ec1e..f5c965b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -34,6 +34,7 @@ static int diff_no_prefix;
>  static int diff_stat_graph_width;
>  static int diff_dirstat_permille_default = 30;
>  static struct diff_options default_diff_options;
> +static int diff_algorithm = 0;

Please let BSS take care of this initialization by omitting " = 0".

> @@ -169,6 +184,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  	if (!strcmp(var, "diff.ignoresubmodules"))
>  		handle_ignore_submodules_arg(&default_diff_options, value);
>  
> +	if (!strcmp(var, "diff.algorithm")) {
> +		if ((diff_algorithm = diff_algorithm_parse(value)) < 0)
> +			die("bad diff.algorithm value: %s", value);

I am not sure if this is a good idea.  What happens when Git 2.0
adds a new algorithm, the user names it in ~/.gitconfig, and an
older version of Git sees this value?  Do you force the user to
modify ~/.gitconfig to use one of the older ones?

It might be more friendly to just warn and use the default.

> @@ -3250,6 +3271,9 @@ int diff_setup_done(struct diff_options *options)
>  		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
>  	}
>  
> +	/* set diff algorithm */
> +	options->xdl_opts |= diff_algorithm;
> +
>  	return 0;
>  }
>  
> @@ -3528,6 +3552,17 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		DIFF_XDL_SET(options, PATIENCE_DIFF);
>  	else if (!strcmp(arg, "--histogram"))
>  		DIFF_XDL_SET(options, HISTOGRAM_DIFF);
> +	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
> +		int alg = diff_algorithm_parse(optarg);
> +		if (alg < 0)
> +			die("unknown algorithm: %s", optarg);
> +		DIFF_XDL_CLR(options, NEED_MINIMAL);
> +		DIFF_XDL_CLR(options, HISTOGRAM_DIFF);
> +		DIFF_XDL_CLR(options, PATIENCE_DIFF);
> +		options->xdl_opts |= alg;
> +		return argcount;
> +	}
> +

The last two hunks gives me a queasy feeling for some reason.  I
think I recently saw a patch to clean up this area to clarify that
PATIENCE/HISTOGRAM are not independent option bits (but I cannot
remember where) and we probably should use the approach taken by
that patch.

Other than that, both the design and the implementation seems to be
done reasonably competently.  Don't we want to add tests for this?
