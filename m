From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch] Documentation: enhanced "git for CVS users" doc about shared repositories
Date: Mon, 05 Nov 2007 15:52:28 -0800
Message-ID: <7v8x5cmern.fsf@gitster.siamese.dyndns.org>
References: <472F99F8.4010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBkN-0004m1-GP
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbXKEXwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755039AbXKEXwf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:52:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37722 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbXKEXwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:52:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 93D042F9;
	Mon,  5 Nov 2007 18:52:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E825892551;
	Mon,  5 Nov 2007 18:52:52 -0500 (EST)
In-Reply-To: <472F99F8.4010904@gmail.com> (Francesco Pretto's message of "Mon,
	05 Nov 2007 23:32:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63591>

Francesco Pretto <ceztkoml@gmail.com> writes:

> More detailed instructions on how to set up shared repositories.
> Added a reference to "git for CVS users" doc in git-init manual.
>
> Signed-off-by: Francesco Pretto <ceztkoml@gmail.com>
> ---
>  Documentation/cvs-migration.txt |   72 ++++++++++++++++++++++++++++++--------
>  Documentation/git-init.txt      |    7 ++++
>  2 files changed, 64 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
> index 3b6b494..c92ed49 100644
> --- a/Documentation/cvs-migration.txt
> +++ b/Documentation/cvs-migration.txt
> @@ -13,12 +13,12 @@ link:tutorial.html[tutorial introduction to git] should be sufficient.
>  Developing against a shared repository
>  --------------------------------------
>  
> -Suppose a shared repository is set up in /pub/repo.git on the host
> +Suppose a shared repository is set up in /pub/scm/repo.git on the host
>  foo.com.  Then as an individual committer you can clone the shared
>  repository over ssh with:
>  
>  ------------------------------------------------
> -$ git clone foo.com:/pub/repo.git/ my-project
> +$ git clone foo.com:/pub/scm/repo.git/ my-project
>  $ cd my-project
>  ------------------------------------------------

This part seems an unnecessary change.

> @@ -68,37 +68,79 @@ other than `master`.
>  Setting Up a Shared Repository
>  ------------------------------
>  
> -We assume you have already created a git repository for your project,
> -possibly created from scratch or from a tarball (see the
> -link:tutorial.html[tutorial]), or imported from an already existing CVS
> -repository (see the next section).
> +We assume you have admin privilege on the remote machine. Moreover, we assume
> +you have already created a git repository for your project, possibly created
> +from scratch or from a tarball (see the link:tutorial.html[tutorial]),or
> +imported  from an already existing CVS repository (see the next section).

Don't assume the "admin privilege" part, as you do not have to.

You are newly hired to work on project-X, and the sysadm throws
you into projectx group.  Thesysadm further prepares a directory
'/pub/project-X' and makes it mode 2775 (aka ug=rwx,o=rx,g+s).

Do you want to create a new repository for projext-X group's
use?  You do:

	$ cd /pub/project-X
        $ GIT_DIR=mine.git git init --shared

and you now have a usable /pub/project-X/mine.git repository for
project members.  I do not think you would need any chmod/chgrp
after this step.

> +First, let's create a common directory for all the projects you'll want to
> +track with git:
> +
> +-----------------------------------------------
> +$ mkdir -p /pub/scm
> +-----------------------------------------------

An organization may use different SCM depending on the projects'
needs, and there is no reason members of projects A and B should
be in the same group 'git' while having members of project C in
group 'hg' only because A and B happen to use git.  It would
make more sense to either (1) make members of all three projects
belong to 'src' group, or (2) make three groups, one for each
project.

IOW, I do not think the above is a good suggestion.

Also with the "create new --shared repository for the project in
a group's directory that has mode 2755" approach, I do not think
there is any need to muck with umask either.
