From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 3/2] core.whitespace: documentation updates.
Date: Sat, 24 Nov 2007 15:22:57 -0500
Message-ID: <20071124202257.GC12864@fieldses.org>
References: <7v8x4os223.fsf@gitster.siamese.dyndns.org> <7v4pfcs20b.fsf@gitster.siamese.dyndns.org> <7v7ik7quc6.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 21:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw1Xe-0003bm-9q
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 21:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbXKXUXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbXKXUXO
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 15:23:14 -0500
Received: from mail.fieldses.org ([66.93.2.214]:50297 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbXKXUXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 15:23:13 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Iw1Wj-0004am-4E; Sat, 24 Nov 2007 15:22:57 -0500
Content-Disposition: inline
In-Reply-To: <7v7ik7quc6.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65961>

On Sat, Nov 24, 2007 at 12:09:13PM -0800, Junio C Hamano wrote:
> This adds description of core.whitespace to the manual page of git-config,
> and updates the stale description of whitespace handling in the manual
> page of git-apply.
> 
> Also demote "strip" to a synonym status for "fix" as the value of --whitespace
> option given to git-apply.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This is meant to conclude the "War on more than 8-SP indent" Bruce
>    started some time ago.  It is now configurable, and turned off by
>    default, so hopefully people outside the kernel circle would not mind.
> 
>    A possible addition to the repertoire of core.whitespace is to add
>    "cr-at-end", which would consider a line that ends with CR an error.
>    We redefine "trailing-space" not to complain to a line ending with
>    CRLF but otherwise does not have trailing whitespaces.  To be
>    compatible with the current behaviour, cr-at-end needs to be added to
>    the default set of errors to be detected, but it might be an
>    improvement if we stopped treating 'cr-at-end' as an error by
>    default.

I'd still prefer this to be a gitattributes thing rather than a config
variable[1].  Last time I raised this you said something to the effect
of "I think you're right, let's fix that before it's merged."  Would you
like me to work on that?

--b.

[1] A rehash of the argument: config variables vary depending on the
system (/etc/gitconfig), the user (~/.config), or the particular
repository ($GIT_DIR/config).  But you don't want the whitespace policy
to vary that way: all users and repositories should see the same
whitespace policy for a given project.  It's entirely possible, however,
that you might like the policy to vary depending on the file (Makefile
vs. main.py?).  And of course getting the policy versioned and
distributed to other repositories automatically is nice too.

> 
>  Documentation/config.txt    |   18 ++++++++++++++++--
>  Documentation/git-apply.txt |   35 +++++++++++++++++++++--------------
>  builtin-apply.c             |    2 +-
>  3 files changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index edf50cd..0e71137 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -293,6 +293,20 @@ core.pager::
>  	The command that git will use to paginate output.  Can be overridden
>  	with the `GIT_PAGER` environment variable.
>  
> +core.whitespace::
> +	A comma separated list of common whitespace problems to
> +	notice.  `git diff` will use `color.diff.whitespace` to
> +	highlight them, and `git apply --whitespace=error` will
> +	consider them as errors:
> ++
> +* `trailing-space` treats trailing whitespaces at the end of the line
> +  as an error (enabled by default).
> +* `space-before-tab` treats a space character that appears immediately
> +  before a tab character in the initial indent part of the line as an
> +  error (enabled by default).
> +* `indent-with-non-tab` treats a line that is indented with 8 or more
> +  space characters that can be replaced with tab characters.
> +
>  alias.*::
>  	Command aliases for the gitlink:git[1] command wrapper - e.g.
>  	after defining "alias.last = cat-file commit HEAD", the invocation
> @@ -378,8 +392,8 @@ color.diff.<slot>::
>  	which part of the patch to use the specified color, and is one
>  	of `plain` (context text), `meta` (metainformation), `frag`
>  	(hunk header), `old` (removed lines), `new` (added lines),
> -	`commit` (commit headers), or `whitespace` (highlighting dubious
> -	whitespace).  The values of these variables may be specified as
> +	`commit` (commit headers), or `whitespace` (highlighting
> +	whitespace errors). The values of these variables may be specified as
>  	in color.branch.<slot>.
>  
>  color.pager::
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index c1c54bf..bae3e7b 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse]
>  	  [--allow-binary-replacement | --binary] [--reject] [-z]
>  	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
> -	  [--whitespace=<nowarn|warn|error|error-all|strip>]
> +	  [--whitespace=<nowarn|warn|fix|error|error-all>]
>  	  [--exclude=PATH] [--verbose] [<patch>...]
>  
>  DESCRIPTION
> @@ -135,25 +135,32 @@ discouraged.
>  	be useful when importing patchsets, where you want to exclude certain
>  	files or directories.
>  
> ---whitespace=<option>::
> -	When applying a patch, detect a new or modified line
> -	that ends with trailing whitespaces (this includes a
> -	line that solely consists of whitespaces).  By default,
> -	the command outputs warning messages and applies the
> -	patch.
> -	When gitlink:git-apply[1] is used for statistics and not applying a
> -	patch, it defaults to `nowarn`.
> -	You can use different `<option>` to control this
> -	behavior:
> +--whitespace=<action>::
> +	When applying a patch, detect a new or modified line that has
> +	whitespace errors.  What are considered whitespace errors is
> +	controlled by `core.whitespace` configuration.  By default,
> +	trailing whitespaces (including lines that solely consist of
> +	whitespaces) and a space character that is immediately followed
> +	by a tab character inside the initial indent of the line are
> +	considered whitespace errors.
> ++
> +By default, the command outputs warning messages but applies the patch.
> +When gitlink:git-apply[1] is used for statistics and not applying a
> +patch, it defaults to `nowarn`.
> ++
> +You can use different `<action>` to control this
> +behavior:
>  +
>  * `nowarn` turns off the trailing whitespace warning.
>  * `warn` outputs warnings for a few such errors, but applies the
> -  patch (default).
> +  patch as-is (default).
> +* `fix` outputs warnings for a few such errors, and applies the
> +  patch after fixing them (`strip` is a synonym --- the tool
> +  used to consider only trailing whitespaces as errors, and the
> +  fix involved 'stripping' them, but modern gits do more).
>  * `error` outputs warnings for a few such errors, and refuses
>    to apply the patch.
>  * `error-all` is similar to `error` but shows all errors.
> -* `strip` outputs warnings for a few such errors, strips out the
> -  trailing whitespaces and applies the patch.
>  
>  --inaccurate-eof::
>  	Under certain circumstances, some versions of diff do not correctly
> diff --git a/builtin-apply.c b/builtin-apply.c
> index e04b493..57efcd5 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -45,7 +45,7 @@ static const char *fake_ancestor;
>  static int line_termination = '\n';
>  static unsigned long p_context = ULONG_MAX;
>  static const char apply_usage[] =
> -"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
> +"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|fix|error|error-all>] <patch>...";
>  
>  static enum ws_error_action {
>  	nowarn_ws_error,
> -- 
> 1.5.3.6.1991.ge56ac
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
