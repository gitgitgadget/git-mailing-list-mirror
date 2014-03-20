From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] rev-parse --parseopt: option argument name hints
Date: Thu, 20 Mar 2014 11:38:17 -0700
Message-ID: <xmqqpplgyaud.fsf@gitster.dls.corp.google.com>
References: <532AA923.6030409@gmail.com>
	<1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 19:38:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQhrI-0004Rd-QT
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 19:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbaCTSiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 14:38:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933434AbaCTSiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 14:38:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C55F74743;
	Thu, 20 Mar 2014 14:38:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8EefaiZiwywC4XcmloRsJUTt3qc=; b=riXe7q
	GGwnVF/wHaGgBUh6dVOhQ/piNW4Rdibibt9K8o2N63eLXeGqlUUSgPfTBhSfzVDv
	Iu9FpoWg+AQyf3DN6oY84Kbe+peJ5Y8brM1/JfT/qQE4/cUHCQ3RzqCjt8f6AYQD
	MmZIpgB/PDTABTdCbWOoL+C8YV/vJNSUXNu9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u5Ikvc/6Kd1DC5BljaxyGRc+Xdbc+eJo
	XS9d1yFlrNyZ7TRY8/4OKw/i5jzkdULv0KHssMWBaH/l+cJGl/lF7dwNzqNN5qT/
	q+n163f6qD8bdwCKI4lY6b2CkQIA8A7qwnmsV2r+MkY+RsxN/Ze8LvR3Synki2US
	2tg9x15ZvFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 251A374735;
	Thu, 20 Mar 2014 14:38:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65A2774732;
	Thu, 20 Mar 2014 14:38:19 -0400 (EDT)
In-Reply-To: <1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com> (Ilya
	Bobyr's message of "Thu, 20 Mar 2014 01:44:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CECE0F32-B05E-11E3-A663-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244569>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> Built-in commands can specify names for option arguments when usage text
> is generated for a command.  sh based commands should be able to do the
> same.
>
> Option argument name hint is any text that comes after [*=?!] after the
> argument name up to the first whitespace.  Underscores are replaced with
> whitespace.  It is unlikely that an underscore would be useful in the
> hint text.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>  Changed according to the last comments.  Added "Usage text" paragraph in the
>  documentation and updated variable names.
>
>  Documentation/git-rev-parse.txt |   34 ++++++++++++++++++++++++++++++++--
>  builtin/rev-parse.c             |   17 ++++++++++++++++-
>  t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
>  3 files changed, 68 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 0d2cdcd..b8aabc9 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -284,13 +284,13 @@ Input Format
>  
>  'git rev-parse --parseopt' input format is fully text based. It has two parts,
>  separated by a line that contains only `--`. The lines before the separator
> -(should be more than one) are used for the usage.
> +(should be one or more) are used for the usage.
>  The lines after the separator describe the options.
>  
>  Each line of options has this format:
>  
>  ------------
> -<opt_spec><flags>* SP+ help LF
> +<opt_spec><flags>*<arg_hint>? SP+ help LF
>  ------------
>  
>  `<opt_spec>`::
> @@ -313,6 +313,12 @@ Each line of options has this format:
>  
>  	* Use `!` to not make the corresponding negated long option available.
>  
> +`<arg_hint>`::
> +	`<arg_hing>`, if specified, is used as a name of the argument in the
> +	help output, for options that take arguments. `<arg_hint>` is
> +	terminated by the first whitespace. When output the name is shown in
> +	angle braces.  Underscore symbols are replaced with spaces.

The last part is troubling (and sounds not very sane).  Do we do
such a munging anywhere else, or is it just here?  If the latter I'd
prefer not to see such a hack.

> @@ -333,6 +339,8 @@ h,help    show the help
>  
>  foo       some nifty option --foo
>  bar=      some cool option --bar with an argument
> +baz=arg   another cool option --baz with a named argument
> +qux?path  qux may take a path argument but has meaning by itself
>  
>    An option group Header
>  C?        option C with an optional argument"
> @@ -340,6 +348,28 @@ C?        option C with an optional argument"
>  eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
>  ------------
>  
> +
> +Usage text
> +~~~~~~~~~~
> +
> +When "$@" is "-h" or "--help" the above example would produce the following
> +usage text:

Sounds like a good idea to add this; all the above arguments inside
double quotes should be typeset `as-typed`, though.

> @@ -419,6 +420,20 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>  		o->value = &parsed;
>  		o->flags = PARSE_OPT_NOARG;
>  		o->callback = &parseopt_dump;
> +
> +		/* Possible argument name hint */
> +		end = s;
> +		while (s > sb.buf && strchr("*=?!", s[-1]) == NULL)
> +			--s;
> +		if (s != sb.buf && s != end) {
> +			char *a;
> +			o->argh = a = xmemdupz(s, end - s);
> +			while (a = strchr(a, '_'))
> +				*a = ' ';

... and without the "underscore" munging, we do not have to allocate
a new piece of memory, either.
