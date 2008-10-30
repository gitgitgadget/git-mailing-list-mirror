From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch: Add an example on how to remove empty
 commits
Date: Thu, 30 Oct 2008 01:56:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810300151480.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1225326833-15210-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Oct 30 01:50:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvLjr-0007cN-5q
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 01:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYJ3AtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 20:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbYJ3AtD
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 20:49:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:39786 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751196AbYJ3AtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 20:49:01 -0400
Received: (qmail invoked by alias); 30 Oct 2008 00:48:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 30 Oct 2008 01:48:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/0QkJIeo/GUTng1c+WVpJ8iC/ofOhR04FcGo01U
	ZA23C5ux6XHWSU
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1225326833-15210-1-git-send-email-pasky@suse.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99442>

Hi,

On Wed, 29 Oct 2008, Petr Baudis wrote:

> +To remove commits that are empty (do not introduce any change):
> +
> +------------------------------------------------------------------------------
> +git rev-list HEAD | while read c; do [ -n "$(git diff-tree --root $c)" ] || echo $c; done > revs
> +
> +git filter-branch --commit-filter '
> +  if grep -q "$GIT_COMMIT" '"$(pwd)/"revs';
> +  then
> +    skip_commit "$@";
> +  else
> +    git commit-tree "$@";
> +  fi' HEAD

You would not need to use the temporary "revs" file by using something 
(totally untested, of course):

git filter-branch --commit-filter '
  if git diff-tree --exit-status -q "$GIT_COMMIT";
  then
    git commit-tree "$@";
  else
    skip_commit "$@";
  fi' HEAD

Of course, you could also mention that you could use

	git log --cherry-pick -p --pretty=format: ..<branch>@{1}

to verify that all skipped commits had empty diffs.  That one is also 
totally untested.

Ciao,
Dscho
