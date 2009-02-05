From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Thu, 05 Feb 2009 09:43:14 -0800
Message-ID: <7vskmseq4t.fsf@gitster.siamese.dyndns.org>
References: <cover.1233855372u.git.johannes.schindelin@gmx.de>
 <26931410834b5297493543e2a1cb75c3b6bf008a.1233855372u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8HS-0002fZ-RF
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbZBERnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbZBERnV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:43:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbZBERnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:43:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C7DC979CA;
	Thu,  5 Feb 2009 12:43:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2F86F979C9; Thu,
  5 Feb 2009 12:43:16 -0500 (EST)
In-Reply-To: <26931410834b5297493543e2a1cb75c3b6bf008a.1233855372u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu, 5 Feb 2009 18:37:59 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A676ED0-F3AC-11DD-850C-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108590>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> At the end of filter-branch in a non-bare repository, the work tree is
> updated with "read-tree -m -u HEAD", to carry the change forward in case
> the current branch was rewritten.  In order to avoid losing any local
> change during this step, filter-branch refuses to work when there are
> local changes in the work tree.
>
> This "read-tree -m -u HEAD" operation does not affect what commit is
> checked out in a submodule (iow, it does not touch .git/HEAD in a
> submodule checkout), and checking if there is any local change to the
> submodule is not useful.
>
> Staged submodules _are_ considered to be 'dirty', however,  as the
> "read-tree -m -u HEAD" could result in loss of staged information
> otherwise.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks.  I still have one question.

By the last paragraph, do you mean "diff-index --cached" should be run
without --ignore-submodules?  That does not seem to match the text of the
patch.

> ---
>  git-filter-branch.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index b75d0ba..9ffa655 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -108,8 +108,8 @@ OPTIONS_SPEC=
>  . git-sh-setup
>  
>  if [ "$(is_bare_repository)" = false ]; then
> -	git diff-files --quiet &&
> -	git diff-index --cached --quiet HEAD -- ||
> +	git diff-files --ignore-submodules --quiet &&
> +	git diff-index --ignore-submodules --cached --quiet HEAD -- ||
>  	die "Cannot rewrite branch(es) with a dirty working directory."
>  fi
>  
> -- 
> 1.6.1.1.598.g140d5
