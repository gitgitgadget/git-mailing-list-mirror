From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: test for git-svn prefixed globs
Date: Wed, 16 Dec 2015 21:28:11 +0000
Message-ID: <20151216212811.GA19884@dcvr.yhbt.net>
References: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
 <1450270869-29822-3-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:28:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9JcO-0004u0-P6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 22:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965766AbbLPV2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 16:28:13 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57317 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbbLPV2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 16:28:12 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357BA205F7;
	Wed, 16 Dec 2015 21:28:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1450270869-29822-3-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282592>

Thanks for this work.  Most things look fine with 1/2, comments
on 2/2 below...

Victor Leschuk <vleschuk@gmail.com> wrote:
> Add test for git-svn prefixed globs.

Why a separate patch?  Unless there's some documentation purpose
for a regression, usually tests and a feature should be added
atomically in the same commit.

> --- /dev/null
> +++ b/t/t9168-git-svn-prefixed-glob.sh
> @@ -0,0 +1,136 @@
> +#!/bin/sh
> +test_description='git svn globbing refspecs with prefixed globs'
> +. ./lib-git-svn.sh
> +
> +cat > expect.end <<EOF

We prefer redirects in new code to be in the form of ">foo" (no space)
(or ">>foo" for append).

It wasn't in the old tests, either, but Documentation/CodingGuidelines
favors this for new code.

> +the end
> +hi
> +start a new branch
> +initial
> +EOF

All the setup code be checked for errors with '&&' as well.

> +	test "`git rev-parse refs/remotes/tags/t_end~1`" = \
> +		"`git rev-parse refs/remotes/branches/b_start`" &&
> +	test "`git rev-parse refs/remotes/branches/b_start~2`" = \
> +		"`git rev-parse refs/remotes/trunk`" &&

And we prefer $(command) instead of `command` for nestability
as Documentation/CodingGuidelines suggests.

(yeah, most of the old tests don't follow the guidelines, but the
 guidelines also warn against fixup patches for them).

Thanks again.
