From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] rebase: split the cherry-pick stuff
Date: Tue, 28 May 2013 15:24:16 -0700
Message-ID: <7vd2sayc8f.fsf@alter.siamese.dyndns.org>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
	<1369747757-10192-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 00:24:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhSJm-00054K-2C
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 00:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758784Ab3E1WYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 18:24:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757848Ab3E1WYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 18:24:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C8323BC7;
	Tue, 28 May 2013 22:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DNYCLA6v6tcEjahLMf9RbYWK6IY=; b=AnGfpb
	7BxkvRxjhEM1K4p2XFyCqXnz8XyId913Bvdsr7NsVnxyOpImEOPFNHV+Sno6UDEX
	wa5u9g+dhL07L5jOMiDPXwnbDOK2ssSG75xKZ2YejKGpIAlOJ2dc1M1TUHokaQSu
	NFGOMm11AtbBbJLZxFTqowTOFFBpujbaxnkYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dTztrlwgrKQQYgTX5FM07rClRykiLdsa
	+F6dNzGMnGKXYPxxWQaIKHVrNT6LXVCvqzHtOGLNqewRq/RvUqMQlUdcG2NL02Y6
	hRTQxlhRZKrBG7zfRFKo7JPTFu8+aI/nSNx7XwWpUNvnAOkRo484BVk+l2kI2zn/
	1Tx20kUaRBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9C5023BC6;
	Tue, 28 May 2013 22:24:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEAA023BC0;
	Tue, 28 May 2013 22:24:17 +0000 (UTC)
In-Reply-To: <1369747757-10192-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 08:29:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5605DB82-C7E5-11E2-92A0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225691>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> They do something completely different from 'git am', it belongs in a
> different file.

I would prefer to see it called --cherry-pick, not --cherry, as they
are different commands (the latter may be useful when deciding which
one to use the former).

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  .gitignore            |  1 +
>  Makefile              |  1 +
>  git-rebase--am.sh     | 65 ++++++++++++++++++++++-----------------------------
>  git-rebase--cherry.sh | 34 +++++++++++++++++++++++++++
>  git-rebase.sh         |  4 ++++
>  5 files changed, 68 insertions(+), 37 deletions(-)
>  create mode 100644 git-rebase--cherry.sh
>
> diff --git a/.gitignore b/.gitignore
> index 6669bf0..284fc8f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -113,6 +113,7 @@
>  /git-read-tree
>  /git-rebase
>  /git-rebase--am
> +/git-rebase--cherry
>  /git-rebase--interactive
>  /git-rebase--merge
>  /git-receive-pack
> diff --git a/Makefile b/Makefile
> index 0f931a2..a3cd4bc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -469,6 +469,7 @@ SCRIPT_SH += git-web--browse.sh
>  SCRIPT_LIB += git-mergetool--lib
>  SCRIPT_LIB += git-parse-remote
>  SCRIPT_LIB += git-rebase--am
> +SCRIPT_LIB += git-rebase--cherry
>  SCRIPT_LIB += git-rebase--interactive
>  SCRIPT_LIB += git-rebase--merge
>  SCRIPT_LIB += git-sh-setup
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index f84854f..ee1b1b9 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -19,52 +19,43 @@ esac
>  test -n "$rebase_root" && root_flag=--root
>  
>  ret=0
> +rm -f "$GIT_DIR/rebased-patches"
>  
> -		cat >&2 <<-EOF
> +git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> +	--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
> +	$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
> +ret=$?
>  
> +if test 0 != $ret
> +then
> +	rm -f "$GIT_DIR/rebased-patches"
> +	case "$head_name" in
> +	refs/heads/*)
> +		git checkout -q "$head_name"
> +		;;
> +	*)
> +		git checkout -q "$orig_head"
> +		;;
> +	esac
>  
> -		    $revisions
> +	cat >&2 <<-EOF
>  
> +	git encountered an error while preparing the patches to replay
> +	these revisions:
>  
> +	    $revisions
>  
> +	As a result, git cannot rebase them.
> +	EOF
> +	exit $?
>  fi
>  
> +git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
> +ret=$?
> +
> +rm -f "$GIT_DIR/rebased-patches"
> +
>  if test 0 != $ret
>  then
>  	test -d "$state_dir" && write_basic_state

OK, this part seems a straightforward reindentation of "else" side.

> diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
> new file mode 100644
> index 0000000..cbf80f9
> --- /dev/null
> +++ b/git-rebase--cherry.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Junio C Hamano.
> +#
> +
> +case "$action" in
> +continue)
> +	git am --resolved --resolvemsg="$resolvemsg" &&
> +	move_to_original_branch
> +	exit
> +	;;
> +skip)
> +	git am --skip --resolvemsg="$resolvemsg" &&
> +	move_to_original_branch
> +	exit
> +	;;
> +esac
> +
> +test -n "$rebase_root" && root_flag=--root

Hmm, do we want to duplicate this part between the two?  Perhaps it
will be unified in a later patch---I'll read on.

> +# we have to do this the hard way.  git format-patch completely squashes
> +# empty commits and even if it didn't the format doesn't really lend
> +# itself well to recording empty patches.  fortunately, cherry-pick
> +# makes this easy
> +git cherry-pick --allow-empty "$revisions"
> +ret=$?
> +
> +if test 0 != $ret
> +then
> +	test -d "$state_dir" && write_basic_state
> +	exit $ret
> +fi
> +
> +move_to_original_branch

OK.  This is the "then" side of the original, with clean-up phase
copied.

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2c692c3..2754985 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -379,6 +379,10 @@ elif test -n "$do_merge"
>  then
>  	type=merge
>  	state_dir="$merge_dir"
> +elif test -n "$keep_empty"
> +then
> +	type=cherry
> +	state_dir="$apply_dir"
>  else
>  	type=am
>  	state_dir="$apply_dir"
