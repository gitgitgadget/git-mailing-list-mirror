From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch: add a new commit-filter
 example
Date: Sat, 23 Feb 2008 11:45:28 -0800
Message-ID: <7vejb3319j.fsf@gitster.siamese.dyndns.org>
References: <20080223193058.GE31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 20:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT0KE-0007Z8-2Y
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 20:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbYBWTpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 14:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbYBWTpq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 14:45:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbYBWTpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 14:45:45 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE2D61926;
	Sat, 23 Feb 2008 14:45:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BC49D1925; Sat, 23 Feb 2008 14:45:37 -0500 (EST)
In-Reply-To: <20080223193058.GE31441@genesis.frugalware.org> (Miklos Vajna's
 message of "Sat, 23 Feb 2008 20:30:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74845>

Miklos Vajna <vmiklos@frugalware.org> writes:

> There is a commit-filter example already which skips commits but there is no
> example on how to edit commit messages.
>
> One can figure out this example by carefully reading the git-filter-branch and
> git-commit-tree documentation but I think it isn't trivial so this example is
> helpful.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> The lack of such an example was noticed by dvorak on IRC.
>
>  Documentation/git-filter-branch.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index e22dfa5..a035b9c 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -240,6 +240,12 @@ committed a merge between P1 and P2, it will be propagated properly
>  and all children of the merge will become merge commits with P1,P2
>  as their parents instead of the merge commit.
>  
> +To remove the 'git-svn-id' strings from commit messages in a repository created
> +by git-svn:

People who are not interested in git-svn at all may still want
to fix up their commit log messages, and I think starting a
paragraph with 'git-svn-blah' would risk them skipping it
without reading (I certainly would).  Probably we would want to
add a sentence before "To remove ...", like this:

	You can rewrite the commit log messages using `--commit-filter`.
	For example, `git-svn-id` strings in a repository created with
	`git-svn` can be cleaned up this way:

> +------------------------------------------------------------------------------
> +git filter-branch --commit-filter 'sed "/^git-svn-id:/d" |git commit-tree "$@"'
> +------------------------------------------------------------------------------

Please try to keep them a bit shorter for reviewing pleasure on
80-column terminals after your message was quoted once or
perhaps a few times.  The example is easier to read if you write
like this, I think:

----------------------------------------------------------------
git filter-branch --commit-filter '
	sed -e "/^git-svn-id:/d" | git commit-tree "$@"
'
----------------------------------------------------------------

I am not sure if git-svn people condone or encourage such
removals, though.
