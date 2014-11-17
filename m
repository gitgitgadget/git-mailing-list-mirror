From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is empty
Date: Mon, 17 Nov 2014 09:22:53 -0800
Message-ID: <xmqqy4r9yc5u.fsf@gitster.dls.corp.google.com>
References: <1416073760.9305.174.camel@homebase>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Mon Nov 17 18:23:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqQ10-0003QA-ES
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 18:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbaKQRW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 12:22:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752368AbaKQRW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 12:22:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6104D1E73A;
	Mon, 17 Nov 2014 12:22:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EHnNcmpziEw+EpWRRZZBH1veBSw=; b=TZHkon
	dkUmPnL+XehA5YPuV1GtQ13tgPbnxBxIN/OQemrFecgDihuKBTtW17Htjpp/U7Jj
	Jwtovxs5RyUs5N4TVeQurmo9wzE8NfQkar6q97sbRFbhRqjDvSirHtKEsbw8S3ER
	B+8KxCxX3763tFoSK7geN3TPnzHrS0Lc4a75g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AkkGQariLDh9JDfZZ80oRAKjSNrGbT91
	aBNAu+pKkuRpGPU3SV5gYytgeky5BGLxOMLi84qlQgy+k4AeXoNgjlb0iMT6xWdr
	sgvqj5uffcEm63G9WWwgJzRWhOw9fEenz5mKCkdVQslGbvdHt875Zbkm357ktU5E
	7lyLrXTsbzg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57E461E739;
	Mon, 17 Nov 2014 12:22:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B19451E738;
	Mon, 17 Nov 2014 12:22:56 -0500 (EST)
In-Reply-To: <1416073760.9305.174.camel@homebase> (Paul Smith's message of
	"Sat, 15 Nov 2014 12:49:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F09A628-6E7E-11E4-9AE3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Smith <paul@mad-scientist.net> writes:

> From 545c0d526eaa41f9306b567275a7d53799987482 Mon Sep 17 00:00:00 2001
> From: Paul Smith <paul@mad-scientist.net>
> Date: Fri, 14 Nov 2014 17:11:19 -0500
> Subject: [PATCH] git-new-workdir: Don't fail if the target directory is empty

Please do not paste these in your mail message body.  The first line
is there only so that the output looks like traditinal mbox format
(i.e. each of these act as a signal that a new message starts there
in the file), the other three are there only for rare cases in which
you want to override what your e-mail's headers say and is only used
when you are sending somebody else's patch.

> Also provide more error checking and clean up on failure.

As the body of the log message is supposed to be complete by itself,
not a continuation of a half-sentence started on the Subject:
(i.e. consider the subject line to be the title of an article you
are writing), starting it with "Also" is strange.

No need to resend only to correct the above, even though there may
be comments on the patch itself from me or others that may make you
want to reroll this patch, in which case I'd like to see these nits
gone.

Thanks.


> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> index 75e8b25..c402000 100755
> --- a/contrib/workdir/git-new-workdir
> +++ b/contrib/workdir/git-new-workdir
> @@ -10,6 +10,10 @@ die () {
>  	exit 128
>  }
>  
> +failed () {
> +	die "unable to create new workdir \"$new_workdir\"!"
> +}
> +
>  if test $# -lt 2 || test $# -gt 3
>  then
>  	usage "$0 <repository> <new_workdir> [<branch>]"
> @@ -48,35 +52,55 @@ then
>  		"a complete repository."
>  fi
>  
> -# don't recreate a workdir over an existing repository
> -if test -e "$new_workdir"
> +# make sure the links use full paths
> +git_dir=$(cd "$git_dir"; pwd)

With this change, the comment gets much harder to understand.  "What links?"
would be the reaction from those who are reading the patch.

> +
> +# don't recreate a workdir over an existing directory unless it's empty
> +if test -d "$new_workdir"
>  then
> -	die "destination directory '$new_workdir' already exists."
> +	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
> +	then
> +		die "destination directory '$new_workdir' is not empty."

I wonder if this check is portable for all platforms we care about,
but that is OK, as it should be so for the ones I think of and care
about ;-)

> +	fi
> +	was_existing=true
> +else
> +	mkdir -p "$new_workdir" || failed
> +	was_existing=false
>  fi
>  
> -# make sure the links use full paths
> -git_dir=$(cd "$git_dir"; pwd)
> +cleanup () {
> +	if $was_existing
> +	then
> +		rm -rf "$new_workdir"/* "$new_workdir"/.[!.] "$new_workdir"/.??*
> +	else
> +		rm -rf "$new_workdir"
> +	fi

The script chdirs around; did you turn $new_workdir into an absolute
path already, or given a relative $new_workdir this is attempting to
remove a hierarchy that is different from what you created?

> +}
> +siglist="0 1 2 15"
> +trap cleanup $siglist
>  
> -# create the workdir
> -mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
> +# create embedded directories
> +for x in logs
> +do
> +	mkdir -p "$new_workdir/.git/$x" || failed
> +done
>  
>  # create the links to the original repo.  explicitly exclude index, HEAD and
>  # logs/HEAD from the list since they are purely related to the current working
>  # directory, and should not be shared.
>  for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
>  do
> -	case $x in
> -	*/*)
> -		mkdir -p "$(dirname "$new_workdir/.git/$x")"
> -		;;
> -	esac

What's this removal about?  If $new_workdir/.git/logs does not
exist, would "ln -s $there/logs/refs $new_workdir/.git/logs/refs"
succeed without first creating $new_workdir/.git/logs directory?

> -	ln -s "$git_dir/$x" "$new_workdir/.git/$x"
> +	ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
>  done
>  
>  # now setup the workdir
> -cd "$new_workdir"
> +cd "$new_workdir" || failed
>  # copy the HEAD from the original repository as a default branch
> -cp "$git_dir/HEAD" .git/HEAD
> +cp "$git_dir/HEAD" .git/HEAD || failed
> +
> +# don't delete the new workdir on exit
> +trap - $siglist
> +
>  # checkout the branch (either the same as HEAD from the original repository, or
>  # the one that was asked for)
>  git checkout -f $branch
