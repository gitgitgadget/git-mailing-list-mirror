From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] completion: complete "unstuck" `git push --recurse-submodules`
Date: Tue, 22 Jul 2014 13:23:25 -0700
Message-ID: <xmqqr41df8hu.fsf@gitster.dls.corp.google.com>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
	<8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:23:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9gbD-0000fj-98
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 22:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbaGVUXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 16:23:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57690 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756663AbaGVUXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 16:23:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A9C92CE2B;
	Tue, 22 Jul 2014 16:23:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uEYAo8c4ifriLn0Ouq76jwpl5BU=; b=eaXoFn
	31Vy97wKKrYqAZHEEemYlPo7lUkPeG9z01/ILx09xj2BE/03n06jKoAKxaoO6fAm
	XifvBtW3sJTXb+TsFuWVpEYMgjjtrK5np96TJl5HQB6S6jrECRiRZNtCXFyFT6zb
	5j1AfnJOxHL8iZpBtMNe+ptFoua2A7hqb3KdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+DFbtPd/miPFFE97MGycILcC2GMr4mc
	wV3nuu9E4pwygN9oI3HXM8d6OJAoKE71BVikqRsh4XWL8kyVr7EGVq6+qC7r+Dpz
	b0WX14sMEasy5unw5cXv8ANELTRaP+i+QlpzLOwx3vksWBJrW3+udx4FGO8eNeYV
	23azHZZQGaY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F6EA2CE2A;
	Tue, 22 Jul 2014 16:23:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DD5882CE20;
	Tue, 22 Jul 2014 16:23:26 -0400 (EDT)
In-Reply-To: <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
	(John Keeping's message of "Tue, 22 Jul 2014 19:24:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 09956FB2-11DE-11E4-8B19-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254035>

John Keeping <john@keeping.me.uk> writes:

> Since the argument to `--recurse-submodules` is mandatory, it does not
> need to be stuck to the option with `=`.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> Change since v1:
>     - Fix typo --recurse{_ => -}submodules
>     - Dropped previous patch 1/4 adding ";;" at the end of the "--repo" case
>
>  contrib/completion/git-completion.bash | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 7a6e1d7..bed3665 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1624,6 +1624,10 @@ __git_push_recurse_submodules="check on-demand"
>  _git_push ()
>  {
>  	case "$prev" in
> +	--recurse-submodules)
> +		__gitcomp "$__git_push_recurse_submodules"
> +		return
> +		;;
>  	--repo)
>  		__gitcomp_nl "$(__git_remotes)"
>  		return

If you mimick the order they are handled in the case on "$cur", it
would also let us sneak in the missing-optional ";;" to case/esac to
keep symmetry between the two ;-)

In other words, like this, perhaps?

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 019026e..b27f385 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1617,6 +1617,11 @@ _git_push ()
 	--repo)
 		__gitcomp_nl "$(__git_remotes)"
 		return
+		;;
+	--recurse-submodules)
+		__gitcomp "$__git_push_recurse_submodules"
+		return
+		;;
 	esac
 	case "$cur" in
 	--repo=*)
-- 
2.0.2-892-g223db29
