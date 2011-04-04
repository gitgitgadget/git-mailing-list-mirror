From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: Fix the commit-url config to be the base
	url, just like the url config
Date: Mon, 4 Apr 2011 15:54:42 -0700
Message-ID: <20110404225442.GA9307@dcvr.yhbt.net>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu> <1301944148-7950-2-git-send-email-asedeno@mit.edu> <20110404215227.GA4224@dcvr.yhbt.net> <F8E6CFA4-79F6-41AC-8266-09B3B46C8520@itasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	git@vger.kernel.org
To: James Y Knight <jknight@itasoftware.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 00:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6sfc-0003Qn-Ca
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 00:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802Ab1DDWyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 18:54:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50124 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148Ab1DDWyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 18:54:46 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAD21F749;
	Mon,  4 Apr 2011 22:54:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <F8E6CFA4-79F6-41AC-8266-09B3B46C8520@itasoftware.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170847>

James Y Knight <jknight@itasoftware.com> wrote:
> On Apr 4, 2011, at 5:52 PM, Eric Wong wrote:
> > $_commit_url is a user-specified parameter from the --commit-url switch.
> > If they want to override it it's the user's perogative.  It's not the
> > default and not commonly used.
> 
> In .git/config:
> 
> [svn-remote "svn"]
>         url = http://hostname/svnrepo/
>         commiturl = svn+ssh://hostname/svnrepo
>         branches = branches/*:refs/remotes/origin/*
>         fetch = trunk:refs/remotes/origin/master
> 
> The commiturl configuration is necessary so that the canonical URL is the http:// url (which can be used for read-only access), but if you want to commit, you have to use svn+ssh. This is a fairly common way of setting up access to an svn repository, so I'm surprised to be the first one to hit this issue.
> 
> Without the patch, you need:
>         commiturl = svn+ssh://hostname/svnrepo/trunk
> which of course then doesn't allow you to commit to other branches.

Originally --commit-url was only intended to be a command-line option
and for overriding specific cases and also for dealing with permission
mismatches (limited commit access to a branch, unlimited read access
to the repo).

Your patch breaks existing use cases, I think.

I think Junio's suggestion for a pushurl config which does what you
think commitUrl does would be what you're after...

Thanks


-- 
Eric Wong
