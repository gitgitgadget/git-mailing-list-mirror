From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check-ignore: Add option to ignore index contents
Date: Thu, 29 Aug 2013 17:57:28 -0700
Message-ID: <7vob8gj8qv.fsf@alter.siamese.dyndns.org>
References: <20130829224652.GA13621@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Spiers <git@adamspiers.org>
To: Dave Williams <dave@opensourcesolutions.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 30 02:57:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFD1w-00031V-Hg
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 02:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab3H3A5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 20:57:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3H3A5e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 20:57:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5779633B65;
	Fri, 30 Aug 2013 00:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VqucbwJ1fnv4eyQQA7Hcjt36YKY=; b=o6Jwhx
	V+nMKnGQfU/mSVXNIpT1RtizuphECxBWJrYCoQBxYqn7pa2iYRebGg3wqur9DBdO
	9mHIyxmsBRsyzyD+fylOuCYYW2nPkNdZTUSLIpisSZCCy5vPYSyBsZhstud6wMF0
	SU/KPvBEGLlzLr1lmM5HBkcrwqFLEAZuRbY/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J33zgEFFhE6E0NRC6gkwQrhU63eKJOEu
	xY3gKD801HKgIbRWtCWUWUODDx9CwdzFVirJ93YwpM1Q2xin58Wd3EMRlK//rNkk
	byHGiE2FQO/Pr/7CdaJ3/1Cg+J7nwzQ43pWCbnDyL3y90UgSVqKfa575tiFfWDbH
	REzOxAx35es=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A72C33B64;
	Fri, 30 Aug 2013 00:57:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57BE933B63;
	Fri, 30 Aug 2013 00:57:30 +0000 (UTC)
In-Reply-To: <20130829224652.GA13621@opensourcesolutions.co.uk> (Dave
	Williams's message of "Thu, 29 Aug 2013 23:46:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2590DCFE-110F-11E3-BA65-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233384>

Dave Williams <dave@opensourcesolutions.co.uk> writes:

> check-ignore currently shows how .gitignore rules would treat untracked
> paths. Tracked paths do not generate useful output.  This prevents
> debugging of why a path became tracked unexpectedly unless that path is
> first removed from the index with git rm --cached <path>
>
> This option (-i, --ignore-index) simply by-passes the check for the path
> being in the index and hence allows tracked path to be checked too.
>
> Whilst this behaviour deviates from the characteristics of git add and
> git status its use case is unlikely to cause any user confusion.
>
> Signed-off-by: Dave Williams <dave@opensourcesolutions.co.uk>
> ---
>  Documentation/git-check-ignore.txt |  6 ++++++
>  builtin/check-ignore.c             | 10 +++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index d2df487..bb878ff 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -45,6 +45,12 @@ OPTIONS
>  	not be possible to distinguish between paths which match a
>  	pattern and those which don't.
>  
> +-i, --ignore-index::
> +	Don't look in the index when undertaking the checks. This means
> +	the results deviate from those seen by git add and git status
> +	but is useful when understanding why a path became tracked by
> +	e.g. git add . and was not ignored as expected by the rules.

Please think twice after you write "This means", "What this means
is", etc. to see if you can get rid of sentence before that, which
needed such clarification.  If the sentence can stand on its own,
and what follows "This means" is also useful information, then it is
a sign that "What this means is" is better rephrased as "Note that".

Also, I think `git add .` should be quoted to make it clear where
the sample command begins and ends.  Using a pair of `` would be the
most appropriate here.

>  OUTPUT
>  ------
>  
> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index 4a8fc70..c8f6ae1 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -5,7 +5,7 @@
>  #include "pathspec.h"
>  #include "parse-options.h"
>  
> -static int quiet, verbose, stdin_paths, show_non_matching;
> +static int quiet, verbose, stdin_paths, show_non_matching, ignore_index;
>  static const char * const check_ignore_usage[] = {
>  "git check-ignore [options] pathname...",
>  "git check-ignore [options] --stdin < <list-of-paths>",
> @@ -24,6 +24,8 @@ static const struct option check_ignore_options[] = {
>  		    N_("input paths are terminated by a null character")),
>  	OPT_BOOLEAN('n', "non-matching", &show_non_matching,
>  		    N_("show non-matching input paths")),
> +	OPT_BOOLEAN('i', "ignore-index", &ignore_index,
> +		    N_("ignore index when checking")),
>  	OPT_END()
>  };
>  
> @@ -82,7 +84,9 @@ static int check_ignore(struct dir_struct *dir,
>  	 * should not be ignored, in order to be consistent with
>  	 * 'git status', 'git add' etc.
>  	 */
> -	seen = find_pathspecs_matching_against_index(pathspec);
> +	if (!ignore_index) {
> +		seen = find_pathspecs_matching_against_index(pathspec);
> +	}
>  	for (i = 0; pathspec[i]; i++) {
>  		path = pathspec[i];
>  		full_path = prefix_path(prefix, prefix
> @@ -90,7 +94,7 @@ static int check_ignore(struct dir_struct *dir,
>  		full_path = check_path_for_gitlink(full_path);
>  		die_if_path_beyond_symlink(full_path, prefix);
>  		exclude = NULL;
> -		if (!seen[i]) {
> +		if (ignore_index || !seen[i]) {
>  			exclude = last_exclude_matching(dir, full_path, &dtype);
>  		}
>  		if (!quiet && (exclude || show_non_matching))

Hmph, if ignoring what is in the index is what the new feature wants
to do, why does it even need to touch check_ignore() function at all
and add a global variable ignore_index to keep track of that state?

Isn't it sufficient to skip the call to read_cache() when that
option is given?

You would need to add tests for this, too.

Thanks.
