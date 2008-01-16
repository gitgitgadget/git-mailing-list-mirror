From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Remove repo-config
Date: Wed, 16 Jan 2008 12:13:27 -0800
Message-ID: <7v7ii9plzs.fsf@gitster.siamese.dyndns.org>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:14:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFEeB-0002TP-Vg
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbYAPUNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYAPUNf
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:13:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYAPUNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 15:13:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D9944697;
	Wed, 16 Jan 2008 15:13:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E7AF4695;
	Wed, 16 Jan 2008 15:13:29 -0500 (EST)
In-Reply-To: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> (Dan
	McGee's message of "Tue, 15 Jan 2008 21:19:14 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70737>

Dan McGee <dpmcgee@gmail.com> writes:

> 'git config' has been used in place of 'git repo-config' for some time in
> the documentation and most of the tools, so remove traces of repo-config
> from the source.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

I'd agree with the deprecation.  We stopped advertising it long
time ago (1.5.0 I think).

> diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt

Let's defer the removal til post 1.5.4.

> diff --git a/Makefile b/Makefile

Likewise.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash

Likewise.

> diff --git a/contrib/examples/git-tag.sh b/contrib/examples/git-tag.sh
> index ae7c531..a3182df 100755
> --- a/contrib/examples/git-tag.sh
> +++ b/contrib/examples/git-tag.sh
> @@ -167,6 +167,7 @@ type=$(git cat-file -t $object) || exit 1
>  tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
>  
>  test -n "$username" ||
> +	#NOTE: 'git repo-config' has since been replaced by 'git config'
>  	username=$(git repo-config user.signingkey) ||
>  	username=$(expr "z$tagger" : 'z\(.*>\)')

Good.

> diff --git a/git.c b/git.c

Deferred.

> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh

Doing s/repo-config/config/ in test scripts is good.

> diff --git a/templates/hooks--update b/templates/hooks--update
> index bd93dd1..09a99ff 100644
> --- a/templates/hooks--update
> +++ b/templates/hooks--update
> @@ -37,9 +37,9 @@ if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
>  fi
>  
>  # --- Config
> -allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
> -allowdeletebranch=$(git-repo-config --bool hooks.allowdeletebranch)
> -allowdeletetag=$(git-repo-config --bool hooks.allowdeletetag)
> +allowunannotated=$(git config --bool hooks.allowunannotated)
> +allowdeletebranch=$(git config --bool hooks.allowdeletebranch)
> +allowdeletetag=$(git config --bool hooks.allowdeletetag)
>  
>  # check for no description
>  projectdesc=$(sed -e '1q' "$GIT_DIR/description")

Good.


> @@ -53,7 +53,7 @@ fi
>  if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
>  	newrev_type=delete
>  else
> -	newrev_type=$(git-cat-file -t $newrev)
> +	newrev_type=$(git cat-file -t $newrev)
>  fi
>  
>  case "$refname","$newrev_type" in

Good but does not belong to the topic.
