From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] commit: make default of "cleanup" option configurable
Date: Wed, 09 Jan 2013 16:17:05 -0800
Message-ID: <7vwqvl3n9a.fsf@alter.siamese.dyndns.org>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
 <1357760209-3407-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 01:17:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt5pq-0000X5-50
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 01:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248Ab3AJARJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 19:17:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932206Ab3AJARI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 19:17:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2DF5A672;
	Wed,  9 Jan 2013 19:17:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Entyz5VyeZW5raah0RVdPDJU6Q8=; b=vVOpiD
	5rS8qohvUubIgk0oMMJ7gtzVF/KkLuhFndN66hDP1BrcNrRiaXnS+S6i1PEPb+So
	wHagse/K8fjICtD6vAEWFihhBrrBSSla335hOsyX4NYJOBHA1mbFy5xGrI4nYNnZ
	REIx1MIkIcPiqIfS6Yz9GJh7VrQ+q/S8Y2aXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d8EtGLou3e78axQf0lSHN3nFEI3jXPnL
	bCE5elHIkk/LElXmxxccWPdkXa65s6ew/K8Twy1r56juSYB2eFRd4k+jPKVWrRTn
	V2zneVP7B5ebtmO20j7uKoSf0s5MqaHjGzJQNj1qiPXt8ARDXKWV8hN2UZnBhn4n
	h0R2hyr0PG8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5F7FA671;
	Wed,  9 Jan 2013 19:17:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D19AA66E; Wed,  9 Jan 2013
 19:17:07 -0500 (EST)
In-Reply-To: <1357760209-3407-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Wed, 9 Jan 2013 20:36:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 115DA7FE-5ABB-11E2-890F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213113>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The default of the "cleanup" option in "git commit"
> is not configurable. Users who don't want to use the
> default have to pass this option on every commit since
> there's no way to configure it. This commit introduces
> a new config option "commit.cleanup" which can be used
> to change the default of the "cleanup" option in
> "git commit".
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

Thanks.

> Changes in v2:
> - simplify implementation
> - mention configuration variable in documentation of "git commit --cleanup"
> - add an example usecase to documention of commit.cleanup configuration variable
> - add tests
>
>  Documentation/config.txt        |  7 ++++
>  Documentation/git-commit.txt    |  4 +-
>  builtin/commit.c                |  5 ++-
>  t/t7500/add-content-and-comment |  4 ++
>  t/t7502-commit.sh               | 84 +++++++++++++++++++++++++++++++++++++----
>  5 files changed, 95 insertions(+), 9 deletions(-)
>  create mode 100755 t/t7500/add-content-and-comment
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 53c4ca1..0452d56 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -917,6 +917,13 @@ column.tag::
>  	Specify whether to output tag listing in `git tag` in columns.
>  	See `column.ui` for details.
>  
> +commit.cleanup::
> +	This setting overrides the default of the `--cleanup` option in
> +	`git commit`. See linkgit:git-commit[1] for details. Changing the
> +	default can be useful if you want to use the comment character (#)
> +	consistently within your commit messages, in which case you would
> +	like to change the default to 'whitespace'.

When the documentation suggests to use 'whitespace', it would be
helpful to warn the readers that hints Git produces in '#'-commented
section need to be removed, if they are not ment to be kept (which
is 99.99% of the case).  Perhaps:

	This setting overrides the default of the `--cleanup` option
	in `git commit`. Changing the default can be useful when you
	always want to keep lines that begin with comment character
	`#` in your log message, in which case you would do `git
	config commit.cleanup whitespace` (note that you will have
	to remove the help lines that begin with '#' in the commit
	log template yourself, if you do this).

or something?

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 7bdb039..41b27da 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -179,7 +179,9 @@ OPTIONS
>  	only if the message is to be edited. Otherwise only whitespace
>  	removed. The 'verbatim' mode does not change message at all,
>  	'whitespace' removes just leading/trailing whitespace lines
> -	and 'strip' removes both whitespace and commentary.
> +	and 'strip' removes both whitespace and commentary. The default
> +	can be changed by the 'commit.cleanup' configuration variable
> +	(see linkgit:git-config[1]).

Nicely written.

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -103,7 +103,7 @@ static enum {
>  	CLEANUP_NONE,
>  	CLEANUP_ALL
>  } cleanup_mode;
> -static char *cleanup_arg;
> +static const char *cleanup_arg;
>  
>  static enum commit_whence whence;
>  static int use_editor = 1, include_status = 1;
> @@ -966,6 +966,7 @@ static const char *read_commit_message(const char *name)
>  	return out;
>  }
>  
> +
>  static int parse_and_validate_options(int argc, const char *argv[],
>  				      const struct option *options,
>  				      const char * const usage[],

Don't add an extra blank line, please.

> @@ -1320,6 +1321,8 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  		include_status = git_config_bool(k, v);
>  		return 0;
>  	}
> +	if (!strcmp(k, "commit.cleanup"))
> +		return git_config_string(&cleanup_arg, k, v);

Nice.

> diff --git a/t/t7500/add-content-and-comment b/t/t7500/add-content-and-comment
> new file mode 100755
> index 0000000..988f5e9
> --- /dev/null
> +++ b/t/t7500/add-content-and-comment
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +echo "commit message" >> "$1"
> +echo "# comment" >> "$1"
> +exit 0
> \ No newline at end of file

Have newline at end of file, please.

> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 1a5cb69..b1c7648 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -4,6 +4,15 @@ test_description='git commit porcelain-ish'
> +...
> +'
> +

Nicely done.

Thanks.
