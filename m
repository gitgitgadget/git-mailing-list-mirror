From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 10:40:57 +0100
Message-ID: <20101207094057.GA6176@neumann>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Kyle <scott@appden.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 10:41:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPu2l-0001eU-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 10:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab0LGJlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 04:41:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:58808 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab0LGJlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 04:41:00 -0500
Received: from localhost6.localdomain6 (p5B13086E.dip0.t-ipconnect.de [91.19.8.110])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MF8TX-1PAI2j0ZFD-00GAhY; Tue, 07 Dec 2010 10:40:58 +0100
Content-Disposition: inline
In-Reply-To: <1291677763-55385-1-git-send-email-scott@appden.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:niClReUJ/ndlU1WiEsYz8LC6D6TSv7znm+wqFEOCsDW
 YwISzT1XXoOk/jP5ILMFONHFwR4q+tYe0H3KiZs6lXDn1n1B6h
 /JnbqAFcVzCLLA8g05SJa6WVU1I8F/JvJb7FWEO7/240J5ajmF
 Z02dPW8cGPjHeSWdwWR0csOy5GajSMGpdKvfJdIJ3iDntF7qk+
 uH4Uu4O6TA1CIOsxUjq+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163073>

Hi Scott,


On Mon, Dec 06, 2010 at 03:22:43PM -0800, Scott Kyle wrote:
> For those who often work on repositories with submodules, the dirty
> indicator for unstaged changes will almost always show because development
> is simultaneously happening on those submodules. The config option
> diff.ignoreSubmodules is not appropriate for this use because it has larger
> implications.
> 
> Signed-off-by: Scott Kyle <scott@appden.com>
> ---
>  contrib/completion/git-completion.bash |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 604fa79..539bcb1 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -37,7 +37,9 @@
>  #       value, unstaged (*) and staged (+) changes will be shown next
>  #       to the branch name.  You can configure this per-repository
>  #       with the bash.showDirtyState variable, which defaults to true
> -#       once GIT_PS1_SHOWDIRTYSTATE is enabled.
> +#       once GIT_PS1_SHOWDIRTYSTATE is enabled.  You can also set
> +#       GIT_PS1_IGNORESUBMODULES to a value that git diff understands
> +#       to adjust the behavior of the dirty state indicator.

git diff "understands" a lot of things, therefore I'd like to be a bit
more specific here by mentioning the --ignore-submodules= option:

+#       once GIT_PS1_SHOWDIRTYSTATE is enabled.  You can also set
+#       GIT_PS1_IGNORESUBMODULES to a value that git diff
+#       --ignore-submodules= understands to adjust the behavior of the
+#       dirty state indicator.

But it might be just me being unfamiliar with submodules.  Otherwise
it looks good and reasonable to me.

>  #
>  #       You can also see if currently something is stashed, by setting
>  #       GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
> @@ -286,7 +288,8 @@ __git_ps1 ()
>  		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
>  			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
>  				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
> -					git diff --no-ext-diff --quiet --exit-code || w="*"
> +					local ignore_submodules=${GIT_PS1_IGNORESUBMODULES+"--ignore-submodules=$GIT_PS1_IGNORESUBMODULES"}
> +					git diff $ignore_submodules --no-ext-diff --quiet --exit-code || w="*"
>  					if git rev-parse --quiet --verify HEAD >/dev/null; then
>  						git diff-index --cached --quiet HEAD -- || i="+"
>  					else
> -- 
> 1.7.3.3.574.g98527
> 
> 
