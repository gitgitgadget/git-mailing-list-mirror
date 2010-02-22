From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-am: Add command line parameter `--keep-cr`
 passing it to git-mailsplit.
Date: Mon, 22 Feb 2010 13:10:59 -0800
Message-ID: <7v635p9dss.fsf@alter.siamese.dyndns.org>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
 <20100213171127.GB14754@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:11:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjfYq-0000Od-Eh
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 22:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab0BVVLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 16:11:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab0BVVLP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 16:11:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B48F9CCA1;
	Mon, 22 Feb 2010 16:11:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cL7NnKqsn/Cr/LAFBHICGDZld3o=; b=UCCZId
	UWZ+hvoMEwEdf61J6eE45tJo48HNPzqBawf5JhOpUT4b3H1ES3VGKQ+dEveajdPD
	wzFQurNfzFomnk2B5cDu5SWrjGI5pfYQUQ3xGRCubMX+yh1CHDCFTudHxXo8Yb1v
	3DPY0tEzFRbQS0CZmUHyE+WhceZwbQfk7uN3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QHIdALuFbvOuT8mlkWW/HTeTZ0KhSxAj
	PRlsnXUJT/JjXChRw/zkQS7i/ONFkwZCRywTx4j5uzT+P+cNBwYyx9J8LeB/s9xi
	h7mWSSHO8vQ4Jot2hhovhgK1RBa7Q7LdjiNnntZVtB31Ku+4ivPvMasfQrgqRVxU
	BAalcHEw6/Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F22549CCA0;
	Mon, 22 Feb 2010 16:11:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A65739CC9B; Mon, 22 Feb
 2010 16:11:01 -0500 (EST)
In-Reply-To: <20100213171127.GB14754@scotty.home> (Stefan-W. Hahn's message
 of "Sat\, 13 Feb 2010 18\:11\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC9C162A-1FF6-11DF-A0B0-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140715>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> The behaviour of git-mailsplit, which is called from git-am for
> patches in mbox format, has been changed in commit c2ca1d79. The new
> default behaviour will remove `\r` from line endings with `\r\n`.

This might offend people who caused c2ca1d7 (Allow mailsplit (and hence
git-am) to handle mails with CRLF line-endings, 2009-08-04) to come into
existence in the first place, as their argument was that "git am" not
reading from the output from their MUA's save-as (Thunderbird I think it
was but I may be mistaken) was a _bug_.  I personally didn't like that
bugfix very much and we could have added --strip-cr to help them back
then, but that is not what happened.

Perhaps this would be a more agreeable description of the backstory?

    c2ca1d7 (Allow mailsplit (and hence git-am) to handle mails with CRLF
    line-endings, 2009-08-04) fixed "git mailsplit" to help people with
    MUA whose output from save-as command uses CRLF as line terminators by
    stripping CR at the end of lines.

    However, when you know you are feeding output from "git format-patch"
    directly to "git am", and especially when your contents have CR at the
    end of line, such stripping is undesirable.  To help such a use case,
    teach --keep-cr option to "git am" and pass that to "git mailinfo".

> This patch adds the command line parameter `--keep-cr` for git-am and
> the configuration `am.keepcr`.

If one sets am.keepcr (because he regularly runs format-patch piped to am
by hand), but occasionally wants to apply an e-mailed patch out of his MUA
that happens to write things out with CRLF, how would one do so, without
touching the configuration (and not forgetting to revert the change after
doing so)?

As a general rule, if you introduce a new configuration, you need to make
sure that the configuration can be overriden per invocation if necessary,
and it is usually done from the command line, i.e. "--no-keep-cr".

I have to warn you that it would be a lot more work that needs careful
thinking than adding a command line option alone, so you may want to split
this [PATCH 2/3] into two, one to add command line option, and the other
to add configuration.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4c36aa9..aa452f3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -550,6 +550,12 @@ it will be treated as a shell command.  For example, defining
>  executed from the top-level directory of a repository, which may
>  not necessarily be the current directory.
>  
> +am.keepcr::
> +	If true, git-am will call git-mailsplit for patches in mbox format 
> +	with parameter '--keep-cr'. In this case git-mailsplit will
> +	not remove `\r` from lines ending with `\r\n`. 

Hence you would need something like:

    s/$/  Can be overriden by giving --no-keep-cr from the command line./

Also Documentation/git-am.txt would need something like:

--keep-cr::
--no-keep-cr::
	With --keep-cr, call git-mailsplit with the same option, to
        prevent it from stripping CR at the end of lines.  `am.keepcr`
        configuration variable can be used to specify the default
	behaviour.  --no-keep-cr is useful to override `am.keepcr`.

> diff --git a/git-am.sh b/git-am.sh
> index c8b9cbb..3057a83 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -347,6 +353,8 @@ do
>  		allow_rerere_autoupdate="$1" ;;
>  	-q|--quiet)
>  		GIT_QUIET=t ;;
> +	--keep-cr)
> +		keepcr=t ;;
>  	--)
>  		shift; break ;;
>  	*)

And you obviously need to have "--no-keep-cr" here...

> @@ -452,6 +460,7 @@ else
>  	echo "$sign" >"$dotest/sign"
>  	echo "$utf8" >"$dotest/utf8"
>  	echo "$keep" >"$dotest/keep"
> +	echo "$keepcr" >"$dotest/keepcr"
>  	echo "$scissors" >"$dotest/scissors"
>  	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
>  	echo "$GIT_QUIET" >"$dotest/quiet"
> @@ -495,6 +504,10 @@ if test "$(cat "$dotest/keep")" = t
>  then
>  	keep=-k
>  fi
> +if test "$(cat "$dotest/keepcr")" = t
> +then
> +	keepcr=--keep-cr
> +fi

Also you may have to set keepcr to --no-keep-cr or something (I won't do
the necessary thinking for you while writing this message), to deal with a
case where:

 - The user has am.keepcr set to true;

 - This particular invocation was made with --no-keep-cr from the command
   line;

 - It stopped due to unappliable patch in the series and $dotest/keepcr
   became empty;

 - The user dealt with the stoppage and restarted the command; we read
   empty from $dotest/keepcr.

If I am reading your patch correctly, I think the restarted command will
use keepcr=t that was set by reading from the configuration at the
beginning?
