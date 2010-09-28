From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: Qn about git pull and git fetch
Date: Tue, 28 Sep 2010 13:33:42 -0400
Message-ID: <9732E43E-124D-4145-A289-2E78F2277ACE@gernhardtsoftware.com>
References: <AANLkTi=-UU8X-7h8c4=UENRwNe+G2xGy54YhvWPnnY7y@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: suvayu ali <fatkasuvayu+linux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 19:33:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0e3z-00012H-4K
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 19:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0I1Rdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 13:33:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:34367 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab0I1Rdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 13:33:52 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 1F2801FFC6B6; Tue, 28 Sep 2010 17:33:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 581DE1FFC544;
	Tue, 28 Sep 2010 17:33:41 +0000 (UTC)
In-Reply-To: <AANLkTi=-UU8X-7h8c4=UENRwNe+G2xGy54YhvWPnnY7y@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157447>


On Sep 28, 2010, at 12:59 PM, suvayu ali wrote:

> If I have a remote tracking repository, and I do a `git pull
> origin master', the latest changes are merged into my currently
> checked out branch. But the references to the remote repo are not.

> This is not an inconvenience for me, just a little puzzling since the
> man page says git pull runs `git fetch' followed by `git mege'. Just
> out of curiosity, is there any reason for this choice?

`git pull origin master` does the following:
- `git fetch origin master` will fetch the master branch from remote
   origin into FETCH_HEAD
- `git merge` will then merge FETCH_HEAD into HEAD

It sounds like what you want is to get your branch as a tracking branch.
If you see the following in `git remote show origin`:

[...]
  Local branch configured for 'git pull':
    master merges with remote master
[...]

Then all you have to do is `git pull`.  It will update all tracking
branches for origin, then merge origin/master into master.  The command
`git pull origin master` is telling git to override whatever defaults it
has and merge the master branch from remote origin into your current HEAD.

Your branches should be set to track automatically but if they didn't for
some reason and are using v1.7.0 or newer, you can:

$ git branch --set-upstream master origin/next
Branch master set up to track remote branch next from origin.
$ git pull

If you're using git prior to v1.7.0, you can instead:

$ git config branch.master.remote origin
$ git config branch.master.merge refs/heads/master
$ git pull

(Note: You only have to use `git branch --set-upstream` or the `git
config ...` lines once, not before every pull.)

~~ Brian
