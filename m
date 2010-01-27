From: Jeff King <peff@peff.net>
Subject: Re: 3 question about how to use Git .
Date: Wed, 27 Jan 2010 04:52:54 -0500
Message-ID: <20100127095253.GC6262@coredump.intra.peff.net>
References: <e78dc7d71001270034k48e1a386p64e01eb8d6d1187a@mail.gmail.com>
 <e78dc7d71001270035p4e235f18o59029b93bea25d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: honglei junan <jhonglei@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na4aM-0001i6-SW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 10:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab0A0JxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 04:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103Ab0A0Jw7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 04:52:59 -0500
Received: from peff.net ([208.65.91.99]:45840 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039Ab0A0Jw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 04:52:58 -0500
Received: (qmail 4303 invoked by uid 107); 27 Jan 2010 09:52:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 27 Jan 2010 04:52:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2010 04:52:54 -0500
Content-Disposition: inline
In-Reply-To: <e78dc7d71001270035p4e235f18o59029b93bea25d4e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138122>

On Wed, Jan 27, 2010 at 04:35:53PM +0800, honglei junan wrote:

> hi,i have three questions seem not not appear in GitFaq,yet confuse me much :
> *) since I've already commit many patches before telling git my name
> and email,should i roll back and recommit all patches to make my name
> in repository?

You can use filter-branch to do it automatically. Something like:

  export BAD_EMAIL='The Wrong Email in Your Commits'
  export GOOD_NAME='Your Correct Name'
  export GOOD_EMAIL='Your Correct Email'
  git filter-branch --env-filter '
    if test "$GIT_COMMITTER_EMAIL" = "$BAD_EMAIL"; then
      GIT_COMMITTER_NAME=$GOOD_NAME
      GIT_COMMITTER_EMAIL=$GOOD_EMAIL
    fi
    if test "$GIT_AUTHOR_EMAIL" = "$BAD_EMAIL"; then
      GIT_AUTHOR_NAME=$GOOD_NAME
      GIT_AUTHOR_EMAIL=$GOOD_EMAIL
    fi
  '

which will rewrite just the commits with the problem.  Note that this
will rewrite the history of those commits. If you've shared the old ones
with others, they will see them as entirely new commits instead of
replacements.

> *) i create a new branch ms_port,and then commit several patches like,
>     commit 1->commit 2->commit 3->commit 4
> now i just want to change commit2,without change any others,how could
> i do it?since i only change the local repository,i think this should
> be allowed.

Try "git rebase -i commit1".

> *) when cloning a git repository,the network is broken down.How could
> i went on the clone process when the network being OK ?
> since the download speed is very low, i really don't want to remove
> all things and download them again.

Git doesn't currently support restartable clone. It's something that
would be nice to have, but there are some technical issues that make it
more difficult than simply starting where we left off (namely that the
pack that is being downloaded via the git protocol is generated on the
fly). You can find some previous discussions by searching the list for
"restartable clone".

-Peff
