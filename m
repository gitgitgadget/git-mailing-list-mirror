From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Docs: Expand explanation of the use of + in git push
 refspecs.
Date: Tue, 24 Feb 2009 09:39:42 -0800
Message-ID: <7veixnhgyp.fsf@gitster.siamese.dyndns.org>
References: <20090219180258.2C7983360A6@rincewind>
 <20090224165105.0FAE53360A6@rincewind>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1He-0006zi-Tz
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951AbZBXRjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758798AbZBXRjv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:39:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757409AbZBXRju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:39:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1856F9C5C7;
	Tue, 24 Feb 2009 12:39:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6DE869C5BF; Tue,
 24 Feb 2009 12:39:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2243835E-029A-11DE-8905-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111322>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> This version incorporates comments from Junio and Sverre.
>
>  Documentation/git-push.txt |   36 +++++++++++++++++++++++++++++++-----
>  1 files changed, 31 insertions(+), 5 deletions(-)

Nice.

Looks much more readable than before, especially with a picture.

Thanks.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 7d1eced..2fae4fd 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -48,17 +48,19 @@ push. Arbitrary expressions cannot be used here, an actual ref must
>  be named. If `:`<dst> is omitted, the same ref as <src> will be
>  updated.
>  +
> -The object referenced by <src> is used to fast forward the ref <dst>
> -on the remote side. If the optional leading plus `{plus}` is used, the
> -remote ref is updated even if it does not result in a fast forward
> -update.
> +The object referenced by <src> is used to update the <dst> reference
> +on the remote side, but by default this is only allowed if the
> +update can fast forward <dst>.  By having the optional leading `{plus}`,
> +you can tell git to update the <dst> ref even when the update is not a
> +fast forward.  This does *not* attempt to merge <src> into <dst>.  See
> +EXAMPLES below for details.
>  +
>  `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
>  +
>  Pushing an empty <src> allows you to delete the <dst> ref from
>  the remote repository.
>  +
> -The special refspec `:` (or `+:` to allow non-fast forward updates)
> +The special refspec `:` (or `{plus}:` to allow non-fast forward updates)
>  directs git to push "matching" branches: for every branch that exists on
>  the local side, the remote side is updated if a branch of the same name
>  already exists on the remote side.  This is the default operation mode
> @@ -218,6 +220,30 @@ git push origin :experimental::
>  	Find a ref that matches `experimental` in the `origin` repository
>  	(e.g. `refs/heads/experimental`), and delete it.
>  
> +git push origin {plus}dev:master::
> +	Update the origin repository's master branch with the dev branch,
> +	allowing non-fast forward updates.  *This can leave unreferenced
> +	commits dangling in the origin repository.*  Consider the
> +	following situation, where a fast forward is not possible:
> ++
> +----
> +	    o---o---o---A---B  origin/master
> +	             \
> +	              X---Y---Z  dev
> +----
> ++
> +The above command would change the origin repository to
> ++
> +----
> +	              A---B  (unnamed branch)
> +	             /
> +	    o---o---o---X---Y---Z  master
> +----
> ++
> +Commits A and B would no longer belong to a branch with a symbolic name,
> +and so would be unreachable.  As such, these commits would be removed by
> +a `git gc` command on the origin repository.
> +
>  
>  Author
>  ------
> -- 
> 1.6.1.2.390.gba743
