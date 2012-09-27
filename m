From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: diff.context configuration gives default to -U
Date: Thu, 27 Sep 2012 10:40:26 -0700
Message-ID: <7vr4pnqs8l.fsf@alter.siamese.dyndns.org>
References: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com>
 <7vobl82u26.fsf@alter.siamese.dyndns.org>
 <C4993A4E-E443-4DB4-9DCA-20128CADDC6E@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Muizelaar <jmuizelaar@mozilla.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:40:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THI4l-0005nd-6Z
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab2I0Rka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:40:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861Ab2I0Rk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:40:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C30239C85;
	Thu, 27 Sep 2012 13:40:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k/LdHWQOh1o80E9Hc30ixMSLsfA=; b=NuKbXA
	gVZSMPZaEmCp//o8jOAbJArKAy3pWt3gvIAbKYfCdW8JQVe8OCrPmm42t29v+ZMA
	FLa1Kg2rQKUXPjgpBOzCj5AS51wIXl3o5EF+to82JHtAzqFARBrEG0KxTR1SGz7E
	4Z17AlEPq6YH/nJbaKSzOYhcRk7ZDxc4CjDks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=knaJWtLWHgYZbs+GbXwkA0N9Bo9Knjxg
	Kl5Q6wESJvrInvAqYiYSttyEzBjOvkcWIYtlhbcdETpNNhBHz5/FtmKgQRaBgI9X
	aCG/kJ9ORrqkm+r6TGNeGJmhRW1/WVvxVbuLCozqc7e+SpWR6d5IR3utYfKbj6tF
	XRn5is+SYTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B10189C84;
	Thu, 27 Sep 2012 13:40:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B58BB9C83; Thu, 27 Sep 2012
 13:40:27 -0400 (EDT)
In-Reply-To: <C4993A4E-E443-4DB4-9DCA-20128CADDC6E@mozilla.com> (Jeff
 Muizelaar's message of "Thu, 27 Sep 2012 11:04:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CDF1614-08CA-11E2-B632-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206497>

Jeff Muizelaar <jmuizelaar@mozilla.com> writes:

> Introduce a configuration variable diff.context that tells
> Porcelain commands to use a non-default number of context
> lines instead of 3 (the default).  With this variable, users
> do not have to keep repeating "git log -U8" from the command
> line; instead, it becomes sufficient to say "git config
> diff.context 8" just once.
>
> Signed-off-by: Jeff Muizelaar <jmuizelaar@mozilla.com>
> ---
>  Documentation/diff-config.txt |    4 +
>  diff.c                        |    9 +++-
>  t/t4060-diff-context.sh       |  127 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+), 1 deletions(-)
>  create mode 100755 t/t4060-diff-context.sh

Sigh, we don't have existing tests to check the number of context
lines given with -U option and we need to allocate a new test number
for it.  What is the gap between 4054 (the last one in the tests for
the diff family) and 4060 for?

> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 67a90a8..75ab8a5 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -56,6 +56,10 @@ diff.statGraphWidth::
>  	Limit the width of the graph part in --stat output. If set, applies
>  	to all commands generating --stat output except format-patch.
>  
> +diff.context::
> +	Generate diffs with <n> lines of context instead of the default of
> +	3. This value is overridden by the -U option.
> +
>  diff.external::
>  	If this config variable is set, diff generation is not
>  	performed using the internal diff machinery, but using the
> diff --git a/diff.c b/diff.c
> index 35d3f07..86e5f2a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -26,6 +26,7 @@ static int diff_detect_rename_default;
>  static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
> +static int diff_context_default = 3;
>  static const char *diff_word_regex_cfg;
>  static const char *external_diff_cmd_cfg;
>  int diff_auto_refresh_index = 1;
> @@ -141,6 +142,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_use_color_default = git_config_colorbool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "diff.context")) {
> +		diff_context_default = git_config_int(var, value);
> +		if (diff_context_default < 0)
> +			return -1;
> +		return 0;
> +	}
>  	if (!strcmp(var, "diff.renames")) {
>  		diff_detect_rename_default = git_config_rename(var, value);
>  		return 0;
> @@ -3170,7 +3177,7 @@ void diff_setup(struct diff_options *options)
>  	options->break_opt = -1;
>  	options->rename_limit = -1;
>  	options->dirstat_permille = diff_dirstat_permille_default;
> -	options->context = 3;
> +	options->context = diff_context_default;
>  	DIFF_OPT_SET(options, RENAME_EMPTY);
>  
>  	options->change = diff_change;

Thanks; looks sensible.

> diff --git a/t/t4060-diff-context.sh b/t/t4060-diff-context.sh
> new file mode 100755
> index 0000000..76fa3c3
> --- /dev/null
> +++ b/t/t4060-diff-context.sh
> @@ -0,0 +1,127 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Mozilla Foundation
> +#
> +
> +test_description='diff.context configuration'
> +
> +. ./test-lib.sh
> +
> +cat << EOF > x
> +firstline
> +b
> +c
> +d
> +e
> +f
> +preline
> +postline
> +i
> +j
> +k
> +l
> +m
> +n
> +EOF

I know ancient tests are written like this, but we are slowly trying
to migrate them to have these test-vector preparation inside
test_expect_success block, e.g.


	test_expect_success setup '
		cat >x <<-\EOF &&
                firstline
                b
                ...
                n
                EOF
		git add x &&
                git commit -m initial
	'

> +test_expect_success 'diff.context affects log' '
> +	git log -1 -p | grep -q -v firstline
> +	git config diff.context 8 &&
> +	git log -1 -p | grep -q firstline
> +'

Three points:

 - Please avoid "grep -q", which does not help people who ran tests
   (the output is hidden by default) and hurts people who want to
   debug tests.

 - Your test will ignore breakage from the first "log 1" output and
   goes on running "git config".  Make sure you got your && cascades
   right.

 - Because an error from the command on the upstream side of the
   pipe is ignored, we tend to prefer writing things like this:

	git log -n 1 -p >output &&
        grep -v firstline output &&
	...

> +cat > .git/config << EOF
> +[diff]
> +	context = no
> +EOF
> +test_expect_success 'config parsing' '
> +	git diff 2>&1 | grep -q "bad config value"
> +'

How does the "git diff" command exit?  That is far more important
than the actual error message, but being on the left side of the
pipe, the exit status from the command is not being tested.
