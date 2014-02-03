From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH 2/9] Teach reset the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 14:40:27 -0800
Message-ID: <xmqqd2j3ddlw.fsf@gitster.dls.corp.google.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
	<52CC3E16.4060909@web.de>
	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
	<52EFF25E.6080306@web.de> <52EFF2C5.3090705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 03 23:40:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASC0-0006hU-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 23:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbaBCWke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 17:40:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbaBCWkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 17:40:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC0E6690C2;
	Mon,  3 Feb 2014 17:40:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oi4QRc9w6xDlPblgFmrFC1S0wp0=; b=S+Bfxe
	gqJUtmV5btJiqHIW8LMFurZife98Ebk7RgtVQZ8SE8Fh6PKexlwPuOHYSs7Jnl/G
	tiehvYB/Yuf6VMpAlTHI7UsUGQjizUznRRfX+9ckfPThiADLTuZ0u+ETZa9VcM/h
	wktpHRaZtr8bJPy4jovI/ARLmmrh+JXUcQejQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qp/W3RI2YzNObY539Npbx176m+ybQQsT
	ODjuxaq9Gkz9SvRmxWEIw8rOs5ztS3MeZNW/FO3U+aeu7M1dr4pXjkue8TYBtwFd
	ytIDlGTezz7MZ50/L4/wZ1CkK623Sdqvhiq895oFZgAg8v51iTgHqf+bdlxSHk1m
	eyf84rEekIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80951690C1;
	Mon,  3 Feb 2014 17:40:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B4F9690BE;
	Mon,  3 Feb 2014 17:40:30 -0500 (EST)
In-Reply-To: <52EFF2C5.3090705@web.de> (Jens Lehmann's message of "Mon, 03 Feb
	2014 20:49:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F755646-8D24-11E3-8737-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241482>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This new option will allow the user to not only reset the work tree of
> the superproject but to also update the work tree of all initialized
> submodules (so they match the SHA-1 recorded in the superproject) when
> used together with --hard or --merge. But this commit only adds the

I agree that --soft and --mixed should not do anything.  I am not
sure why --keep should not do anything to submodule working trees
when asked to recurse, though.

> option without any functionality, that will be added to unpack_trees()
> in subsequent commits.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  Documentation/git-reset.txt |  4 ++++
>  builtin/reset.c             | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index f445cb3..8f833f4 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -94,6 +94,10 @@ OPTIONS
>  --quiet::
>  	Be quiet, only report errors.
>
> +include::recurse-submodules-update.txt[]
> ++
> +This option only makes sense together with `--hard` and `--merge` and is
> +ignored when used without these options.
>
>  EXAMPLES
>  --------
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 6004803..adf372e 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -20,6 +20,7 @@
>  #include "parse-options.h"
>  #include "unpack-trees.h"
>  #include "cache-tree.h"
> +#include "submodule.h"
>
>  static const char * const git_reset_usage[] = {
>  	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
> @@ -255,6 +256,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  {
>  	int reset_type = NONE, update_ref_status = 0, quiet = 0;
>  	int patch_mode = 0, unborn;
> +	const char *recurse_submodules_default = "off";
> +	int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  	const char *rev;
>  	unsigned char sha1[20];
>  	struct pathspec pathspec;
> @@ -270,13 +273,24 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  		OPT_SET_INT(0, "keep", &reset_type,
>  				N_("reset HEAD but keep local changes"), KEEP),
>  		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
> +		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
> +			"checkout", "control recursive updating of submodules",
> +			PARSE_OPT_OPTARG, option_parse_update_submodules },
> +		{ OPTION_STRING, 0, "recurse-submodules-default",
> +			&recurse_submodules_default, NULL,
> +			"default mode for recursion", PARSE_OPT_HIDDEN },
>  		OPT_END()
>  	};
>
> +	gitmodules_config();
>  	git_config(git_default_config, NULL);
>
>  	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
>  						PARSE_OPT_KEEP_DASHDASH);
> +	set_config_update_recurse_submodules(
> +		parse_update_recurse_submodules_arg("--recurse-submodules-default",
> +						    recurse_submodules_default),
> +		recurse_submodules);
>  	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
>
>  	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", sha1);
