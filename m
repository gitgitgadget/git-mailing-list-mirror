From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 18/19] Refactor git_remote_cvs to a more generic
 git_remote_helpers
Date: Fri, 30 Oct 2009 09:42:53 +0100
Message-ID: <200910300942.54101.johan@herland.net>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
 <1256839287-19016-19-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 09:43:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3n4Y-0004qn-7e
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 09:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525AbZJ3Imw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 04:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756500AbZJ3Imv
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 04:42:51 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51842 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756490AbZJ3Imv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 04:42:51 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSB000WHK7JB8C0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 30 Oct 2009 09:42:55 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSB006GNK7IR600@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 30 Oct 2009 09:42:55 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.30.82723
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <1256839287-19016-19-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131683>

On Thursday 29 October 2009, Sverre Rabbelier wrote:
> This in an effort to allow future remote helpers written in python to
> re-use the non-cvs-specific code.
> 
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---

[snip]

> diff --git a/git_remote_helpers/__init__.py
>  b/git_remote_helpers/__init__.py new file mode 100644
> index 0000000..38c7b5f
> --- /dev/null
> +++ b/git_remote_helpers/__init__.py
> @@ -0,0 +1,27 @@
> +#!/usr/bin/env python
> +
> +"""Support library package for git remote helpers.
> +
> +Git remote helpers are helper commands that interfaces with a non-git
> +repository to provide automatic import of non-git history into a Git
> +repository.
> +
> +This package provides the support library needed by these helpers..
> +The following modules are included:
> +
> +- cvs/cvs - Interaction with CVS repositories
> +
> +- cvs/symbol_cache - Local CVS symbol cache
> +
> +- cvs/changeset - Collect individual CVS revisions into commits
> +
> +- cvs/commit_states - Map Git commits to CVS states
> +
> +- cvs/revision_map - Map CVS revisions to various metainformation
> +
> +- git/git - Interaction with Git repositories

Since this is Python documentation within a package, I'd rather refer to the 
python modules as _modules_ and not files. I.e. please use '.' instead of 
'/':

+- cvs.cvs - Interaction with CVS repositories
+
+- cvs.symbol_cache - Local CVS symbol cache
+
+- cvs.changeset - Collect individual CVS revisions into commits
+
+- cvs.commit_states - Map Git commits to CVS states
+
+- cvs.revision_map - Map CVS revisions to various metainformation
+
+- git.git - Interaction with Git repositories


> +
> +- util - General utility functionality use by the other modules in
> +         this package, and also used directly by git-remote-cvs.

Probably you should drop the direct reference to git-remote-cvs.

> diff --git a/git_remote_cvs/util.py b/git_remote_helpers/util.py
> similarity index 100%
> rename from git_remote_cvs/util.py
> rename to git_remote_helpers/util.py
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 77ad23e..c7530aa 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -640,9 +640,9 @@ test -d ../templates/blt || {
> 
>  if test -z "$GIT_TEST_INSTALLED"
>  then
> -	GITPYTHONLIB="$(pwd)/../git_remote_cvs/build/lib"
> +	GITPYTHONLIB="$(pwd)/../git_remote_helpers/build/lib"
>  	export GITPYTHONLIB
> -	test -d ../git_remote_cvs/build || {
> +	test -d ../git_remote_helpers/build || {
>  		error "You haven't built git_remote_cvs yet, have you?"

Please also s/git_remote_cvs/git_remote_helpers/ in the error message.

Otherwise, it all looks good :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
