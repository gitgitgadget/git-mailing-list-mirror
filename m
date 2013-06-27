From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] am: replace uses of --resolved with --continue
Date: Thu, 27 Jun 2013 09:33:46 +0100
Message-ID: <20130627083346.GB2232@serenity.lan>
References: <1372277201-29324-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Jun 27 10:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us7ed-0002pl-Di
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 10:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab3F0IeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 04:34:01 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:40310 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab3F0Id4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 04:33:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9B6CDCDA5B7;
	Thu, 27 Jun 2013 09:33:55 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yA1CI-hv9XeS; Thu, 27 Jun 2013 09:33:53 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A6C8CCDA610;
	Thu, 27 Jun 2013 09:33:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1372277201-29324-1-git-send-email-kevin@bracey.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229090>

On Wed, Jun 26, 2013 at 11:06:41PM +0300, Kevin Bracey wrote:
> git am was previously modified to provide --continue for consistency
> with rebase, merge etc, and the documentation changed to showing
> --continue as the primary form.
> 
> Complete the work by replacing remaining uses of --resolved by
> --continue, most notably in suggested command reminders.
> 
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>  Documentation/git-am.txt      | 4 ++--
>  Documentation/user-manual.txt | 2 +-
>  git-am.sh                     | 8 ++++----
>  t/t7512-status-help.sh        | 4 ++--
>  wt-status.c                   | 2 +-
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 5bbe7b6..54d8461 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -132,7 +132,7 @@ default.   You can use `--no-utf8` to override this.
>  --resolvemsg=<msg>::
>  	When a patch failure occurs, <msg> will be printed
>  	to the screen before exiting.  This overrides the
> -	standard message informing you to use `--resolved`
> +	standard message informing you to use `--continue`
>  	or `--skip` to handle the failure.  This is solely
>  	for internal use between 'git rebase' and 'git am'.
>  
> @@ -176,7 +176,7 @@ aborts in the middle.  You can recover from this in one of two ways:
>  
>  . hand resolve the conflict in the working directory, and update
>    the index file to bring it into a state that the patch should
> -  have produced.  Then run the command with the '--resolved' option.
> +  have produced.  Then run the command with the '--continue' option.

It isn't new in this patch, but there is an inconsistency in the quoting
of the options here.  In the previous hunk we use backticks but here it
uses SQs.

The documentation isn't at all consistent on this, but
backticks seem to be the preferred style (there are some false positives
in both counts but this gives a good indication):

 $ git grep "'--" -- Documentation/ | wc -l
 186
 $ git grep '`--' -- Documentation/ | wc -l
 487

>  The command refuses to process new mailboxes until the current
>  operation is finished, so if you decide to start over from scratch,
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index e831cc2..8218cf9 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1835,7 +1835,7 @@ Once the index is updated with the results of the conflict
>  resolution, instead of creating a new commit, just run
>  
>  -------------------------------------------------
> -$ git am --resolved
> +$ git am --continue
>  -------------------------------------------------
>  
>  and Git will create the commit for you and continue applying the
> diff --git a/git-am.sh b/git-am.sh
> index 9f44509..7ea40fe 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -6,7 +6,7 @@ SUBDIRECTORY_OK=Yes
>  OPTIONS_KEEPDASHDASH=
>  OPTIONS_SPEC="\
>  git am [options] [(<mbox>|<Maildir>)...]
> -git am [options] (--resolved | --skip | --abort)
> +git am [options] (--continue | --skip | --abort)
>  --
>  i,interactive   run interactively
>  b,binary*       (historical option -- no-op)
> @@ -102,7 +102,7 @@ stop_here_user_resolve () {
>  	    printf '%s\n' "$resolvemsg"
>  	    stop_here $1
>      fi
> -    eval_gettextln "When you have resolved this problem, run \"\$cmdline --resolved\".
> +    eval_gettextln "When you have resolved this problem, run \"\$cmdline --continue\".
>  If you prefer to skip this patch, run \"\$cmdline --skip\" instead.
>  To restore the original branch and stop patching, run \"\$cmdline --abort\"."
>  
> @@ -523,7 +523,7 @@ Use \"git am --abort\" to remove it.")"
>  		esac
>  	fi
>  
> -	# Make sure we are not given --skip, --resolved, nor --abort
> +	# Make sure we are not given --skip, --continue, nor --abort
>  	test "$skip$resolved$abort" = "" ||
>  		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
>  
> @@ -670,7 +670,7 @@ do
>  	#  - patch is the patch body.
>  	#
>  	# When we are resuming, these files are either already prepared
> -	# by the user, or the user can tell us to do so by --resolved flag.
> +	# by the user, or the user can tell us to do so by --continue flag.
>  	case "$resume" in
>  	'')
>  		if test -f "$dotest/rebasing"
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 4f09bec..bd8aab0 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -510,7 +510,7 @@ test_expect_success 'status in an am session: file already exists' '
>  	cat >expected <<-\EOF &&
>  	# On branch am_already_exists
>  	# You are in the middle of an am session.
> -	#   (fix conflicts and then run "git am --resolved")
> +	#   (fix conflicts and then run "git am --continue")
>  	#   (use "git am --skip" to skip this patch)
>  	#   (use "git am --abort" to restore the original branch)
>  	#
> @@ -532,7 +532,7 @@ test_expect_success 'status in an am session: file does not exist' '
>  	cat >expected <<-\EOF &&
>  	# On branch am_not_exists
>  	# You are in the middle of an am session.
> -	#   (fix conflicts and then run "git am --resolved")
> +	#   (fix conflicts and then run "git am --continue")
>  	#   (use "git am --skip" to skip this patch)
>  	#   (use "git am --abort" to restore the original branch)
>  	#
> diff --git a/wt-status.c b/wt-status.c
> index 438a40d..b191c65 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -826,7 +826,7 @@ static void show_am_in_progress(struct wt_status *s,
>  	if (advice_status_hints) {
>  		if (!state->am_empty_patch)
>  			status_printf_ln(s, color,
> -				_("  (fix conflicts and then run \"git am --resolved\")"));
> +				_("  (fix conflicts and then run \"git am --continue\")"));
>  		status_printf_ln(s, color,
>  			_("  (use \"git am --skip\" to skip this patch)"));
>  		status_printf_ln(s, color,
> -- 
> 1.8.3.rc0.28.g4b02ef5
