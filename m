From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Tue, 04 Mar 2014 11:22:43 -0800
Message-ID: <xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:22:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKuvY-0003i5-93
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 20:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbaCDTWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 14:22:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbaCDTWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 14:22:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12E5B71AE5;
	Tue,  4 Mar 2014 14:22:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3jM2+GTYdTmNZIWXTBNwETpabRo=; b=UPcfAv
	prqVEKGSqXJrAFplBuIzMB+nypEe/Nzk/T+h29JGcdMqW6Cr6HuJtXBvC39sBQGu
	GaMk3c/A8qI8k1IHsx2cWG30RAc5EvUXWzVfK2HCeXEMZquvBBSCeYbcxAI5/u+J
	LzjabvlllvnyP0rqWp8PHXCNMl2zM+XT4KKeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ENV5EKfooLhZKQQa+LzqSWt79J9aXDOF
	hNTPtx+B//bOZX2Br2LBbdzMgLNrcs7Dl/AoXgQDGdXzl199RYegB85BR/s2on8L
	m7oPyxBTl3XzEEHm+ZMR3ccdm4cQwM+f7+OEM+Nv+G1MgxF0dBx4SwvHUKsXagRW
	cTt/p+tpRMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F222071AE4;
	Tue,  4 Mar 2014 14:22:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3532C71ADF;
	Tue,  4 Mar 2014 14:22:47 -0500 (EST)
In-Reply-To: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com> (Ilya
	Bobyr's message of "Mon, 3 Mar 2014 02:32:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5EECA202-A3D2-11E3-88C3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243372>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> Built-in commands can specify names for option arguments, that are shown
> when usage text is generated for the command.  sh based commands should
> be able to do the same.
>
> Option argument name hint is any text that comes after [*=?!] after the
> argument name up to the first whitespace.  Underscores are replaced with
> whitespace.  It is unlikely that an underscore would be useful in the
> hint text.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>  Documentation/git-rev-parse.txt |   11 +++++++++--
>  builtin/rev-parse.c             |   17 ++++++++++++++++-
>  t/t1502-rev-parse-parseopt.sh   |   20 ++++++++++++++++++++
>  3 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 0d2cdcd..4cb6e02 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -284,13 +284,13 @@ Input Format
>  
>  'git rev-parse --parseopt' input format is fully text based. It has two parts,
>  separated by a line that contains only `--`. The lines before the separator
> -(should be more than one) are used for the usage.
> +(could be more than one) are used for the usage.

Good spotting.  I think the original author meant to say there
should be at least one line to serve as the usage string, so
updating it to "should be one or more" may be more accurate, but
"could be more than one" would also work.

>  The lines after the separator describe the options.
>  
>  Each line of options has this format:
>  
>  ------------
> -<opt_spec><flags>* SP+ help LF
> +<opt_spec><flags>*<argh>? SP+ help LF
>  ------------
>  
>  `<opt_spec>`::
> @@ -313,6 +313,12 @@ Each line of options has this format:
>  
>  	* Use `!` to not make the corresponding negated long option available.
>  
> +`<argh>`::
> +	`<argh>`, if specified, is used as a name of the argument, if the
> +	option takes an argument. `<argh>` is terminated by the first
> +	whitespace. Angle braces are added automatically.  Underscore symbols
> +	are replaced with spaces.

I had a hard time understanding this "Angle brackets are added
automatically" one (obviously nobody wants extra angle brackets
added around option arguments given by the user), until I looked at
the addition of the test to realize that this description is only
about how it appears in the help output.  The description needs to
be clarified to avoid confusion.

> @@ -333,6 +339,7 @@ h,help    show the help
>  
>  foo       some nifty option --foo
>  bar=      some cool option --bar with an argument
> +baz=arg   another cool option --baz with an argument named <arg>

It probably is better not to have " named <arg>" at the end here, as
that gives an apparent-but-false contradiction with the "Angle
brackets are added *automatically*" and confuse readers.  At least,
it confused _this_ reader.

After the "eval" in the existing example to parse the "$@" argument
list in this part of the documentation, it may be a good idea to say
something like:

	The above command, when "$@" is "--help", produces the
	following help output:

	... sample output here ...

to show the actual output.  That way, we can illustrate how input
"baz?arg description of baz" is turned into "--baz[=<arg>]" output
clearly (yes, I am suggesting to use '?' in the new example, not '='
whose usage is already shown in the existing example).

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index aaeb611..83a769e 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -395,9 +395,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
>  		usage[unb++] = strbuf_detach(&sb, NULL);
>  	}
>  
> -	/* parse: (<short>|<short>,<long>|<long>)[=?]? SP+ <help> */
> +	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
>  	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
>  		const char *s;
> +		const char *argh;

Let's spell that variable name out, e.g. arg_hint or something.

> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
> index 83b1300..bf0db05 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -18,6 +18,17 @@ An option group Header
>      -C[...]               option C with an optional argument
>      -d, --data[=...]      short and long option with an optional argument
>  
> +Argument hints
> +    -b <arg>              short option required argument
> +    --bar2 <arg>          long option required argument
> +    -e, --fuz <with spaces>
> +                          short and long option required argument
> +    -s[<some>]            short option optional argument
> +    --long[=<data>]       long option optional argument
> +    -g, --fluf[=<path>]   short and long option optional argument
> +    --longest <a very long argument hint>
> +                          a very long argument hint
> +
>  Extras
>      --extra1              line above used to cause a segfault but no longer does
>  
> @@ -39,6 +50,15 @@ b,baz     a short and long option
>  C?        option C with an optional argument
>  d,data?   short and long option with an optional argument
>  
> + Argument hints
> +b=arg     short option required argument
> +bar2=arg  long option required argument
> +e,fuz=with_spaces  short and long option required argument
> +s?some    short option optional argument
> +long?data long option optional argument
> +g,fluf?path     short and long option optional argument
> +longest=a_very_long_argument_hint  a very long argument hint
> +

Nice.

Thanks.
