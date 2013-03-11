From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: add a newline at the end of pathless 'add
 [-u|-A]' warning
Date: Mon, 11 Mar 2013 09:06:46 -0700
Message-ID: <7v7gldc44p.fsf@alter.siamese.dyndns.org>
References: <vpqk3pefjs4.fsf@grenoble-inp.fr>
 <1362988893-27539-1-git-send-email-Matthieu.Moy@imag.fr>
 <1362988893-27539-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5Fy-0000Xx-RA
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab3CKQGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 12:06:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588Ab3CKQGt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 12:06:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF294B8F9;
	Mon, 11 Mar 2013 12:06:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m4bF6Hr0SX9jCEBQtVoQgCra8bM=; b=LLIi1l
	+2cPEWsqMdlwx4wi7HvLefDYj5m4a6AOsYr7fvqeSQ0Y7AAU4pNJww0YBHKzJyFD
	+ZAtAq4jUIWj4rTkplK8xBV9lhC2KWzJlbvNXjyin6OmpbNdT9XszfbxUIj5DO9l
	KuA8g1DdwTUTNLJAADFZW4ctVyNN2mo33M8Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XTX6cIX7veQUPkDenA3S8yiyV4v1HXwO
	th/jqR78mrajPEQQPeJKyvmftF11vl2NpukOGvKQ1rFQpLC5aecYAOVIYeAPPRtq
	OHWXKYezQ1CTfb+pAGjkf8wKP7pxA70dF1SYe6TrZz8tY5X2UcgR7rP0QHsxTzYY
	HAAUbOZ5zLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0DA0B8F8;
	Mon, 11 Mar 2013 12:06:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C655B8F7; Mon, 11 Mar 2013
 12:06:47 -0400 (EDT)
In-Reply-To: <1362988893-27539-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 11 Mar 2013 09:01:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD6EBE9C-8A65-11E2-A05A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217883>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> When the commands give an actual output (e.g. when ran with -v), the
> output is visually mixed with the warning. The newline makes the actual
> output more visible.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

It would have been easier to immediately understand what is going on
if you said "blank line" instead of "newline" ;-)

An obvious issues is what if user does not run with "-v" or if "-v"
produces no results.  We will be left with an extra blank line at
the end.

I suspect that the true reason why the warning does not stand out
and other output looks mixed in it may be because we only prefix the
first line with the "warning: " label.  In the longer term, I have a
feeling that we should be showing something like this instead:

    $ cd t && echo >>t0000*.sh && git add -u -v
    warning: The behavior of 'git add --update (or -u)' with no path ar...
    warning: subdirectory of the tree will change in Git 2.0 and should...
    warning: To add content for the whole tree, run:
    warning:
    warning:  git add --update :/
    warning:   (or git add -u :/)
    warning:
    warning: To restrict the command to the current directory, run:
    warning:
    warning:   git add --update .
    warning:   (or git add -u .)
    warning:
    warning: With the current Git version, the command is restricted to...
    add 't/t0000-basic.sh'

using a logic similar to what strbuf_add_commented_lines() and
strbuf_add_lines() use.

>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index ab1c9e8..620bf00 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -344,7 +344,7 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
>  		  "  git add %s .\n"
>  		  "  (or git add %s .)\n"
>  		  "\n"
> -		  "With the current Git version, the command is restricted to the current directory."),
> +		  "With the current Git version, the command is restricted to the current directory.\n"),
>  		option_name, short_name,
>  		option_name, short_name,
>  		option_name, short_name);
