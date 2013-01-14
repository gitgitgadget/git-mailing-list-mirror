From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] config: Introduce diff.algorithm variable
Date: Mon, 14 Jan 2013 10:33:53 -0800
Message-ID: <7vwqvfbomm.fsf@alter.siamese.dyndns.org>
References: <cover.1358006339.git.mprivozn@redhat.com>
 <72370b372a56cc5bfaa9741eae62eae2854964b2.1358006339.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, trast@student.ethz.ch
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 19:34:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuorR-0003Qn-8Q
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 19:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504Ab3ANSd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 13:33:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757102Ab3ANSd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 13:33:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5183CFA0;
	Mon, 14 Jan 2013 13:33:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NrhnmjEFQY54VCUNZnOHOyPDk0A=; b=DLhRWX
	jAhla4kza8hqZ0xHEUTHDswH3gKG5NDguzAZZARqfJ/NEKHjNegyfp38skaBCSWN
	iTZHAmQUBnhQ9B7BeGTLi4WkjMTpW1FvKf8MJZalUuW8ZnZZFw3WMPlt3Et5czJ3
	2uKo/Inwcnuraiae1Ngg9eV440QLrcBP6v6Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=thTLb/FYsnOORfl7DjUHlfEOwiLlzyIA
	z6R9XwL+AWmC3PXUfnWhYYv/Xx6BeSBifEiQUTdhaYKwLmssTIQlezbI5lvPevz/
	GcUx5CqIRiSEHZj+BIzPJsPyaw6M/3J/IxDz6hmmFGu/RKYF5aVB09LDuBrOn11f
	zFhX9EIa1ss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA50DCF9F;
	Mon, 14 Jan 2013 13:33:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 020A3CF9E; Mon, 14 Jan 2013
 13:33:54 -0500 (EST)
In-Reply-To: <72370b372a56cc5bfaa9741eae62eae2854964b2.1358006339.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Sat, 12 Jan 2013 17:02:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F393C69C-5E78-11E2-B459-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213513>

Michal Privoznik <mprivozn@redhat.com> writes:

> Some users or projects prefer different algorithms over others, e.g.
> patience over myers or similar. However, specifying appropriate
> argument every time diff is to be used is impractical. Moreover,
> creating an alias doesn't play nicely with other tools based on diff
> (git-show for instance). Hence, a configuration variable which is able
> to set specific algorithm is needed. For now, these four values are
> accepted: 'myers' (which has the same effect as not setting the config
> variable at all), 'minimal', 'patience' and 'histogram'.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  Documentation/diff-config.txt          | 17 +++++++++++++++++
>  contrib/completion/git-completion.bash |  1 +
>  diff.c                                 | 23 +++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 4314ad0..be31276 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -155,3 +155,20 @@ diff.tool::
>  	"kompare".  Any other value is treated as a custom diff tool,
>  	and there must be a corresponding `difftool.<tool>.cmd`
>  	option.
> +
> +diff.algorithm::
> +	Choose a diff algorithm.  The variants are as follows:
> ++
> +--
> +`myers`;;
> +	The basic greedy diff algorithm.
> +`minimal`;;
> +	Spend extra time to make sure the smallest possible diff is
> +	produced.
> +`patience`;;
> +	Use "patience diff" algorithm when generating patches.
> +`histogram`;;
> +	This algorithm extends the patience algorithm to "support
> +	low-occurrence common elements".
> +--
> ++

Sounds sensible.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 383518c..33e25dc 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1839,6 +1839,7 @@ _git_config ()
>  		diff.suppressBlankEmpty
>  		diff.tool
>  		diff.wordRegex
> +		diff.algorithm
>  		difftool.
>  		difftool.prompt
>  		fetch.recurseSubmodules
> diff --git a/diff.c b/diff.c
> index 732d4c2..ddae5c4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -36,6 +36,7 @@ static int diff_no_prefix;
>  static int diff_stat_graph_width;
>  static int diff_dirstat_permille_default = 30;
>  static struct diff_options default_diff_options;
> +static long diff_algorithm = 0;

Please do not initialize a static explicitly to a zero and instead
let BSS do its thing.

>  static char diff_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_RESET,
> @@ -143,6 +144,20 @@ static int git_config_rename(const char *var, const char *value)
>  	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>  }
>  
> +static long parse_algorithm_value(const char *value)
> +{
> +	if (!value || !strcasecmp(value, "myers"))
> +		return 0;
> +	else if (!strcasecmp(value, "minimal"))
> +		return XDF_NEED_MINIMAL;
> +	else if (!strcasecmp(value, "patience"))
> +		return XDF_PATIENCE_DIFF;
> +	else if (!strcasecmp(value, "histogram"))
> +		return XDF_HISTOGRAM_DIFF;
> +	else
> +		return -1;
> +}
> +
>  /*
>   * These are to give UI layer defaults.
>   * The core-level commands such as git-diff-files should
> @@ -196,6 +211,13 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "diff.algorithm")) {
> +		diff_algorithm = parse_algorithm_value(value);
> +		if (diff_algorithm < 0)
> +			return -1;
> +		return 0;
> +	}
> +
>  	if (git_color_config(var, value, cb) < 0)
>  		return -1;
>  
> @@ -3213,6 +3235,7 @@ void diff_setup(struct diff_options *options)
>  	options->add_remove = diff_addremove;
>  	options->use_color = diff_use_color_default;
>  	options->detect_rename = diff_detect_rename_default;
> +	options->xdl_opts |= diff_algorithm;
>  
>  	if (diff_no_prefix) {
>  		options->a_prefix = options->b_prefix = "";
