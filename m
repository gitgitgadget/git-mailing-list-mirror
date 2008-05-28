From: Junio C Hamano <junio@pobox.com>
Subject: Re: [DOC-PATCH] Clarify description of <repository> argument to
 pull/fetch for naming remotes.
Date: Wed, 28 May 2008 12:21:01 -0700
Message-ID: <7vfxs2teua.fsf@gitster.siamese.dyndns.org>
References: <1211986774.9160.12.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "John J. Franey" <jjfraney@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 21:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1RDp-0006ou-JA
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 21:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbYE1TVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYE1TVM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 15:21:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbYE1TVK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 15:21:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A5DC5E43;
	Wed, 28 May 2008 15:21:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0ABB95E41; Wed, 28 May 2008 15:21:04 -0400 (EDT)
In-Reply-To: <1211986774.9160.12.camel@isidore.myhome.westell.com> (John J.
 Franey's message of "Wed, 28 May 2008 10:59:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 39661CB6-2CEB-11DD-8136-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83130>

"John J. Franey" <jjfraney@gmail.com> writes:

> Signed-off-by: John J. Franey <jjfraney@gmail.com>
> ---
>  Here is proposal for the git-fetch(1) and git-pull(1)
>  man pages.  As a newbie, I found the original a bit
>  too awkward to understand readily.  I hope this is
>  helpful.

While I do like making visual distinction to separate different things
into different sections as a general rule (unless each section ends up
with too little information), I think this is almost on the borderline.

>  Alter description of <repository> in OPTIONS section to
>  explicitly state that a 'remote name' is accepted.
>
>  Rewrite REMOTES section to more directly identify the
>  different kinds of remotes permitted.

I think you meant to place these two paragraphs in the commit log message,
so they should come before your Sign-off and three-dash lines.

>  Documentation/pull-fetch-param.txt |    4 ++-
>  Documentation/urls-remotes.txt     |   65 ++++++++++++++++++++---------------
>  2 files changed, 40 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index b6eb7fc..cbee369 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -1,6 +1,8 @@
>  <repository>::
>  	The "remote" repository that is the source of a fetch
> -	or pull operation.  See the section <<URLS,GIT URLS>> below.
> +	or pull operation.  This parameter can be either a URL
> +	(see the section <<URLS,GIT URLS>> below) or the name
> +	of a remote (see the section <<REMOTES,REMOTES>> below).

Ok, I often see this referred to as "short-hand" or "nickname", but you
chose to use "the name of a remote", which is more descriptive.

> diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
> index 5dd1f83..31e542d 100644
> --- a/Documentation/urls-remotes.txt
> +++ b/Documentation/urls-remotes.txt
> @@ -1,11 +1,21 @@
>  include::urls.txt[]
>  
> -REMOTES
> --------
> +REMOTES[[REMOTES]]
> +------------------
>  
> -In addition to the above, as a short-hand, the name of a
> -file in `$GIT_DIR/remotes` directory can be given; the
> -named file should be in the following format:
> +The name of one of the following can be used instead of a URL as <repository> argument:
> +
> +* a file in the `$GIT_DIR/remotes` directory,
> +* a remote in the git configuration file: `$GIT_DIR/config`, or
> +* a file in the `$GIT_DIR/branches` directory.

Ok.  However, because a remote configured in the configuration file takes
precedence (it is the youngest invention) over $GIT_DIR/remotes/ which in
turn takes precedence over $GIT_DIR/branches/, we probably would want to
move the bullet list and the sections around to talk about the config
first, then remotes, and then finally branches, in this document.

> +Named files in `$GIT_DIR/remotes`
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If <repository> is the name of a file in the `$GIT_DIR/remotes` directory,
> +the file should have the following format:

This also sounds somewhat awkward to me.  "If you do X, Y has to be Z" has
a funny connotation that "On the other hand, if you don't, Y does not have
to follow this rule", but that is not what is going on here.  We only want
to say "You could choose to do X, and here are the rules..."  So how
about...

        You can use a file in `$GIT_DIR/remotes/<remote>` to name the remote
        repository <remote>.  The file should be in the following format:

Same comment applies to other two sections.

> @@ -14,15 +24,16 @@ named file should be in the following format:
>  
>  ------------
>  
> -Then such a short-hand is specified in place of
> -<repository> without <refspec> parameters on the command
> -line, <refspec> specified on `Push:` lines or `Pull:`
> -lines are used for `git-push` and `git-fetch`/`git-pull`,
> -respectively.  Multiple `Push:` and `Pull:` lines may
> +`Push:` lines are used by `git-push` and
> +`Pull:` lines are used by `git-pull` and `git-fetch`.
> +Multiple `Push:` and `Pull:` lines may
>  be specified for additional branch mappings.

I see that the original has a typo "s/Then/When/".

The rewrite drops an important piece of information that these Push/Pull
lines take effect _only when_ the nickname (eh, "the name of the remote")
is given on the command line without explicit refspecs.

> +Named remote in configuration file
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If <repository> is the name of a remote entry in the git configuration file,
> +the entry might look like this:

Similarly...

        A `[remote "<remote>"]` section in the configuration file can be used to
        name the remote.  The section will look like this:

>  ------------
>  	[remote "<remote>"]

In addition...

        Similar to the `$GIT_DIR/remotes/<repository>` push/fetch give the
        default refspecs when none is given on the command line.

> +Note the use of `fetch` instead of `Pull:` (a distinction from the format described above).
> +See linkgit:git-remote[1] or linkgit:git-config[1] for details.

Iff you really need to stress mismatch, after reordering the sections, you
could point out that `$GIT_DIR/remotes` file uses "Pull" instead of more
natural "fetch", which is a historical accident.
 
