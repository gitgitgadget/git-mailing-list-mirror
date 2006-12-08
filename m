X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core.  Call with explicit path.
Date: Fri, 8 Dec 2006 11:37:18 -0800
Message-ID: <20061208193718.GA11906@soma>
References: <elc6g3$v1m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 19:37:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <elc6g3$v1m$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33728>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslXC-0001VT-Jr for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426158AbWLHThW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426162AbWLHThW
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:37:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47780 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1426158AbWLHThU
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 14:37:20 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id E40CB2DC034; Fri,  8 Dec 2006 11:37:18 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 11:37:18 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> 
> git-sh-setup isn't a 'normal' binary, in that it should be called by
> bash only and not run in a subshell. Therefore, it should not be installed
> in a executable directory, but rather in $prefix/share/git-core/

This seems to break existing hooks, or at least old repositories can
be stuck using an old version of git-sh-setup in those hooks.

You could to add GIT_datadir to PATH before invoking hooks for existing
ones to work, or write some sort of conversion script...

> ---
>  Makefile            |   10 ++++++++--
>  git-am.sh           |    2 +-
>  git-applymbox.sh    |    2 +-
>  git-applypatch.sh   |    2 +-
>  git-bisect.sh       |    2 +-
>  git-checkout.sh     |    2 +-
>  git-clean.sh        |    2 +-
>  git-commit.sh       |    2 +-
>  git-fetch.sh        |    2 +-
>  git-instaweb.sh     |    2 +-
>  git-lost-found.sh   |    2 +-
>  git-merge.sh        |    2 +-
>  git-pull.sh         |    2 +-
>  git-quiltimport.sh  |    2 +-
>  git-rebase.sh       |    2 +-
>  git-repack.sh       |    2 +-
>  git-request-pull.sh |    2 +-
>  git-reset.sh        |    2 +-
>  git-resolve.sh      |    2 +-
>  git-revert.sh       |    2 +-
>  git-tag.sh          |    2 +-
>  git-verify-tag.sh   |    2 +-
>  22 files changed, 29 insertions(+), 23 deletions(-)

You shoudl probably change these, too:

templates/hooks--pre-applypatch:. git-sh-setup
templates/hooks--applypatch-msg:. git-sh-setup

-- 
