From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sat, 24 Oct 2009 20:41:41 -0700
Message-ID: <7v1vks2l8q.fsf@alter.siamese.dyndns.org>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 04:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1tzS-0002HI-GX
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 04:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZJYDlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 23:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666AbZJYDlr
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 23:41:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbZJYDlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 23:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE8CA848A9;
	Sat, 24 Oct 2009 23:41:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/8dtMp4P7qQOv0LLO7qdWXNUMk=; b=W6dRI6
	PQtzK1E0MAjTZqtyvUzMfcph1ZLLV8RyvMlHcCrxtAdlk3QbaitaXqePPw9tGb4B
	lCTIEsMagnFenFWJAlDk77WTVs7EKjjvDprde2/uq++PMi3paj07jKZK0TbKrVT1
	TEFv/Ibv+c5Ca9sgf6aFVP2Qr8r+jNMwIxmNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUubr0urltH7Yg++S8FK93Ustd7GmIef
	b/omvSN44Yk/G7OHzJwLyGLD5qzpEZr5vDt/aDCXfLKkv9SD4WZ8xni+MhxHR9y+
	+ANkMt3k8ZJzhdguJxfuQu5UzEsw6uvL5da312thQMB5Kj+bzA3emWK0hpbouAUX
	HDG1hFBEaz4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4543848A8;
	Sat, 24 Oct 2009 23:41:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2EF1E848A2; Sat, 24 Oct 2009
 23:41:42 -0400 (EDT)
In-Reply-To: <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat\, 24 Oct 2009 11\:31\:32 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 529B13B8-C118-11DE-8680-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131188>

This is the latter half of my review; please see

    From:	Junio C Hamano <gitster@pobox.com>
    Subject: Re: [PATCH] Use 'fast-forward' all over the place
    Date:	Sat, 24 Oct 2009 10:50:05 -0700
    Message-ID: <7v3a587kc2.fsf@alter.siamese.dyndns.org>

for the other half.

Felipe Contreras <felipe.contreras@gmail.com> writes:

> diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c

Ok.  We may want to consider moving this command to contrib/examples/ or
removing it, but that is a separate issue and can be done after we apply
this patch.

> diff --git a/builtin-fetch.c b/builtin-fetch.c
> @@ -269,7 +269,7 @@ static int update_local_ref(struct ref *ref,
>  		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
>  		strcat(quickref, "..");
>  		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
> -		r = s_update_ref("fast forward", ref, 1);
> +		r = s_update_ref("fast-forward", ref, 1);

This is creating a message in the reflog; I do not think we have any
script/program in-tree that relies on the exact wording of this one, so we
are probably safe ourselves, but I do not know about third-party scripts.

I'd be surprised if there are somebody who reads the reflog and acts
differently upon seeing that we fast-forwarded, but we'd never know until
we cook this in 'next' and see people complain.

The other hunk to this file is an end-user message from Porcelain, so it
should be Ok.

> diff --git a/builtin-merge.c b/builtin-merge.c
> diff --git a/builtin-push.c b/builtin-push.c
> @@ -159,7 +159,7 @@ static int do_push(const char *repo, int flags)
>  		error("failed to push some refs to '%s'", url[i]);
>  		if (nonfastforward && advice_push_nonfastforward) {
>  			printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
> -			       "Merge the remote changes before pushing again.  See the 'non-fast forward'\n"
> +			       "Merge the remote changes before pushing again.  See the 'non-fast-forward'\n"
>  			       "section of 'git push --help' for details.\n");
>  		}

Ok, except that I think we will be seeing merge conflicts with changes
that are pending for 1.7.0 with this hunk---I am not looking forward to
it, but I'll survive with help from rerere.

> diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
> diff --git a/builtin-remote.c b/builtin-remote.c
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
> diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-resolve.sh

Ok.

> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> @@ -315,8 +315,8 @@ generate_update_branch_email()
>  	# "remotes/" will be ignored as well.
>  
>  	# List all of the revisions that were removed by this update, in a
> -	# fast forward update, this list will be empty, because rev-list O
> -	# ^N is empty.  For a non fast forward, O ^N is the list of removed
> +	# fast-forward update, this list will be empty, because rev-list O
> +	# ^N is empty.  For a non fast-forward, O ^N is the list of removed

Wasn't non-fast-forward a single compound word of three?

> @@ -411,7 +411,7 @@ generate_update_branch_email()
>  	# revision because the base is effectively a random revision at this
>  	# point - the user will be interested in what this revision changed
>  	# - including the undoing of previous revisions in the case of
> -	# non-fast forward updates.
> +	# non-fast-forward updates.
>  	echo ""
>  	echo "Summary of changes:"
>  	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev

... like this hunk, that is.

> diff --git a/git-gui/lib/branch_create.tcl b/git-gui/lib/branch_create.tcl
> index 3817771..f1235c7 100644
> --- a/git-gui/lib/branch_create.tcl
> +++ b/git-gui/lib/branch_create.tcl
> @@ -77,7 +77,7 @@ constructor dialog {} {
>  		-variable @opt_merge
>  	pack $w.options.merge.no -side left
>  	radiobutton $w.options.merge.ff \
> -		-text [mc "Fast Forward Only"] \
> +		-text [mc "Fast-forward Only"] \
>  		-value ff \
>  		-variable @opt_merge
>  	pack $w.options.merge.ff -side left

Please leave git-gui out; (1) it is not managed by me and the patch should
be fed to Shawn separately, and (2) updating [mc] keystrings must need
matching updates to the translation file and the templates.

I also think this is a label string and the capitalization must be kept,
i.e. "Fast-Forward Only".

> diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
> diff --git a/git-pull.sh b/git-pull.sh
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> diff --git a/git-rebase.sh b/git-rebase.sh

Ok.

> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
> @@ -51,7 +51,7 @@ check_cache_at () {
>  }
>  
>  cat >bozbar-old <<\EOF
> -This is a sample file used in two-way fast forward merge
> +This is a sample file used in two-way fast-forward merge
>  tests.  Its second line ends with a magic word bozbar
>  which will be modified by the merged head to gnusto.
>  It has some extra lines so that external tools can

Doesn't changing this change the actual test blob used?  Do you know if
the test still passes when git is not broken?

The rest of the patches to t/ directory looked Ok.

> diff --git a/transport.c b/transport.c
> diff --git a/unpack-trees.c b/unpack-trees.c

Ok.

Thanks.
