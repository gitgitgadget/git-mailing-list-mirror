From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Teach about submodules
Date: Mon, 11 Apr 2011 12:53:55 -0700
Message-ID: <7v62qkwomk.fsf@alter.siamese.dyndns.org>
References: <1302321570-85987-1-git-send-email-me@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 21:54:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9NBf-0004ur-DB
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 21:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab1DKTyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 15:54:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab1DKTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 15:54:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79E565D88;
	Mon, 11 Apr 2011 15:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5J2yML1PYuneT1TnvehzULDfAtI=; b=lSE0kT
	NA5kfux+dRihMyZ1jxxt97cxQDyAGUaUnvzkyVh5a2NF62C1ZMfyUbjO9GJEfa//
	ceo6Y12biMWpgywrV0wkH/z3lC0bUfnQw07r9esln6lvKiBWO5IkvRkv7LXqpBhR
	3hrVbyjUsfd8CH1YfaMS7yUEyT6cWg+F4GZ2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NLNHBhUZ/gZicrSaSk79AaWJERyIw5FB
	+j9GEY7NrpMZ6am6v1LY0kzEoGSiNtcf60pdN4BQz95JUnntGByUXzyDaIOGxcLe
	HLGWJgTsbT28rsDtOEKD+BngI6XhrvawgTTWaTjou9OsZcizk3f8XibeVtlt2roX
	FN9LQXDihHU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 499785D87;
	Mon, 11 Apr 2011 15:55:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2AA845D83; Mon, 11 Apr 2011
 15:55:54 -0400 (EDT)
In-Reply-To: <1302321570-85987-1-git-send-email-me@JonathonMah.com> (Jonathon
 Mah's message of "Fri, 8 Apr 2011 20:59:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B801CB1E-6475-11E0-B5BE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171351>

Jonathon Mah <me@JonathonMah.com> writes:

> Mergetool mildly clobbered submodules, attempting to move and copy their
> directories. It now recognizes submodules and offers a resolution:
> Submodule merge conflict for 'Shared':
>   {local}: commit ad9f12e3e6205381bf2163a793d1e596a9e211d0
>   {remote}: commit f5893fb70ec5646efcd9aa643c5136753ac89253
> Use (l)ocal or (r)emote, or (a)bort?

I was confused when I first read the first sentence, because "when/under
what condition" was missing.  I also suspect that we don't even have to
say "mildly".  The reviewers can judge the severity themselves.

When you can, please make the statement of the problem and the description
of the solution into separate paragraphs.  It also makes it easier to read
if you indent illustration (e.g. sample transcript) from your description.

Perhaps like this:

    When a merge in the superproject results in conflict at a submodule,
    mergetool used to mildly clobber submodules, attempting to move and
    copy their directories.

    Recognize submodules and offer a resolution instead:

      Submodule merge conflict for 'Shared':
        {local}: commit ad9f12e3e6205381bf2163a793d1e596a9e211d0
        {remote}: commit f5893fb70ec5646efcd9aa643c5136753ac89253
      Use (l)ocal or (r)emote, or (a)bort?

> Selecting a commit will stage it, but not update the submodule (as it
> would had there been no conflict). Type changes are also supported,
> should the path be a submodule on one side, and a file on the other.
>
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ...
> +resolve_submodule_merge () {
> +    while true; do
> +	printf "Use (l)ocal or (r)emote, or (a)bort? "
> +	read ans
> +	case "$ans" in
> +	    [lL]*)
> +		local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
> +		if is_submodule "$local_mode"; then
> +		    stage_submodule "$MERGED" $(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')

If the version we had checked out and merging into has a submodule at the
path, use that.  This part of the logic seem sensible.

Don't you already have local_mode from the caller here?  For that matter,
don't you also have access to local_sha1 the caller already has computed?

> +		else
> +		    git checkout-index -f --stage=2 -- "$MERGED"
> +		    git add -- "$MERGED"

If what we had is not a submodule, then do a checkout-index.  Here you
assume that we _must_ have a stage #2 entry, but is that always the case?

Can we be in delete/modify conflict, where we had a submodule at the
common ancestor, we removed the submodule while the other branch modified
it?  What does this "else" clause do in such a case?

The same comment applies symmetrically to the "remote" case, of course.

> +stage_submodule () {
> +    path="$1"
> +    submodule_sha1="$2"
> +
> +    submodule_basename=$(basename "$path")
> +    tree_with_module=$(echo "160000 commit $submodule_sha1	\"$submodule_basename\"" | git mktree --missing 2>/dev/null)
> +    if test -z "$tree_with_module" ; then
> +	echo "$path: unable to stage commit $sha1"
> +	return 1
> +    fi
> +    git checkout $tree_with_module -- "$path"

Are you looking for "git update-index --cacheinfo 160000 $sha1 $name"
here, or is there something deeper going on?

If not, please don't use the "primarily for debugging and hacking" command
mktree for something like this to create a garbage tree object.

>  checkout_staged_file () {
>      tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
>  
> +    if is_submodule "$local_mode" || is_submodule "$remote_mode"; then
> +	echo "Submodule merge conflict for '$MERGED':"
> +	local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
> +	remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
> +	describe_file "$local_mode" "local" "$local_sha1"
> +	describe_file "$remote_mode" "remote" "$remote_sha1"
> +	resolve_submodule_merge
> +	return

I really hate these repeated "awk" invocations, here and then inside the
callee.  As the script seems to use these as global variables, the callee
shouldn't have to recompute local/remote-mode/sha1, no?

Thanks.
