From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update documentation for stripspace
Date: Sun, 11 Dec 2011 22:41:31 -0800
Message-ID: <7vy5ui5h0k.fsf@alter.siamese.dyndns.org>
References: <1323655158-5075-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:30:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1HL-0004d2-9h
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab1LLIaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:30:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab1LLIaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:30:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B22982896;
	Mon, 12 Dec 2011 03:30:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=qzauC0CT3r8K2rHrMSmtKT3Haow=; b=U86TQV5iYhVP/V3tcY5W
	+0Tfr8ZrSW9YDdCpdtSf4x+P+i/XJ4snPUyELypaCRpzhYzocBNwsCXeC0PJ7R5F
	238I3zSjvLYP890RK8ZL0bKQTJ42/Eq4UPRVkgky4GBlDNh3RIHku4+/1R4r15IK
	7CnfViovR/OaCLA5Uq3eJWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DSeTFJJh+9pAiZk8sQHV27eswwtWam9MY5KEzKvT+K01QQ
	2sb1cLVrow9GCWPhxS/r9/i2JorwJMFmYKewWi2Mz0hdhB+Ap07hE/rvZVizlEmY
	uUc1AsT3GR3mLEZj4PQ6qzewCG1OGIf87cDKTm77Gv/L60baIpULYrEtdFgSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A74342895;
	Mon, 12 Dec 2011 03:30:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 160292894; Mon, 12 Dec 2011
 03:30:20 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87944E34-249B-11E1-999D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186893>

Conrad Irwin <conrad.irwin@gmail.com> writes:

> Tell the user what this command is intended for, and expand the
> description of what it does.

Thanks.

> Stop referring to the input as <stream>, as this command reads the
> entire input into memory before processing it.

Which can change to stream, but calling it as input would not invalidate
the new wording, so "input" is fine. From the caller's point of view, the
current implementation (or streaming implementation) can read from an
unseekable input stream (i.e. pipe), so the original wording is equally
valid, by the way.

So in that sense, it does not make any difference either way to me (it is
not even worth rerolling this patch to only remove this part of the
change).

> Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
> ---
>  Documentation/git-stripspace.txt |   26 ++++++++++++++++++++------
>  builtin/stripspace.c             |    2 +-
>  2 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
> index b78f031..6667d25 100644
> --- a/Documentation/git-stripspace.txt
> +++ b/Documentation/git-stripspace.txt
> @@ -3,26 +3,40 @@ git-stripspace(1)
>  
>  NAME
>  ----
> -git-stripspace - Filter out empty lines
> +git-stripspace - Remove unnecessary whitespace
>  
>  
>  SYNOPSIS
>  --------
>  [verse]
> -'git stripspace' [-s | --strip-comments] < <stream>
> +'git stripspace' [-s | --strip-comments] < input
>  
>  DESCRIPTION
>  -----------
> -Remove multiple empty lines, and empty lines at beginning and end.
> +
> +Normalizes input in the manner used by 'git' for user-provided metadata such
> +as commit messages, notes, tags and branch descriptions.

The original says "remove" and new one says "normalize*s*". I think we
tend to say things in imperative mood (i.e. without the trailing "s").

I do not think 'user-provided metadata' is a good wording. This is just a
simple text clean-up filter and you can use it to clean your text files
that you mean to store in the repository as well.

> +When run with no arguments this:
> +
> +- removes trailing whitespace from all lines
> +- collapses multiple consecutive empty lines into one empty line
> +- removes blank lines from the beginning and end of the input
> +- ensures the last line ends with exactly one '\n'.

Thanks for a nicely written bulleted list. It clarifies what the command
does quite a bit.

The last one is a bit funny, though.

By definition, you cannot end the last line with more than one '\n' (upon
seeing the second '\n', you would realize immediately that the line you
saw was _not_ the last line). I think you meant the file does not end with
an incomplete line, i.e. "ensures the output does not end with an
incomplete line by adding '\n' at the end if needed".

> +In the case where the input consists entirely of whitespace characters, no
> +output will be produced.
> +
> +*NOTE*: This is intended for cleaning metadata, prefer the `--whitespace=fix`
> +mode of linkgit:git-apply[1] for correcting whitespace of patches or files in
> +the repository.

I can tell that these three lines were the _primary_ thing you wanted to
add with this patch, having never seen anybody got confused between the
whitespace breakage fix and text cleaning, I wonder if this is adding
clarity or giving users an impression that git can do too many things than
they can wrap their mind around and forcing them to wonder if they have to
learn everything git can do for them.

>  OPTIONS
>  -------
>  -s::
>  --strip-comments::
> -	In addition to empty lines, also strip lines starting with '#'.
> +	Also remove all lines starting with '#'.

With the resulting text (with the rules clarified with your above 4-bullet
points) of this manual page, can a user tell what the command does to this
input (I added line numbers, vertical bars and dollar signs to show where
the beginning and the end of lines are):

    1 | $
    2 |a b c$
    3 |$
    4 |# comment line$
    5 |$
    6 |d e f$
    
The original text at least allows the user to guess correctly, as it hints
that a comment line is treated pretty much like an empty line, and the
"consecutive empty lines are squashed into one" in your bulleted list
would mean that ll 3-5 will become a single blank line.

The new text however gives a wrong hint by saying "Also"; it can be read
as if all the rules in the bullted list are applied first to leave blank
lines at 3 and 5 and then comment line is removed from the result, which
would leave two blank lines in the result.

If I were touching this description, I probably would say something like
"Treat lines starting with a '#' as if they are empty lines".
