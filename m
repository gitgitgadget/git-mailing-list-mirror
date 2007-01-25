From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: How to change merge message ("weenie commits")
Date: Thu, 25 Jan 2007 11:07:14 -0500
Message-ID: <20070125160714.GA6358@fieldses.org>
References: <17848.54065.631799.755255@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 17:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA78C-0001SM-B6
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbXAYQHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 11:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbXAYQHR
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:07:17 -0500
Received: from mail.fieldses.org ([66.93.2.214]:41146 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbXAYQHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:07:16 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HA786-0001rQ-IF; Thu, 25 Jan 2007 11:07:14 -0500
Content-Disposition: inline
In-Reply-To: <17848.54065.631799.755255@lisa.zopyra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37732>

On Thu, Jan 25, 2007 at 09:56:33AM -0600, Bill Lear wrote:
> I have developed a habit of using my SCM to provide local backup of my
> daily (hourly) work.  I often will work to a stopping point and commit
> my work, without any real coherence to the commit --- a sort of
> checkpoint.  These I call "weenie commits" because they are weenie-ish,
> unimportant in the larger scheme of things.
> 
> When developing with others, I would like to be able to work in this
> way, tidily keeping my stuff tucked away in my SCM system, and then
> when I am ready to share, to convey to my peers what they need to
> know about my work, and not the 10,000 weenie commit messages that
> may be associated with my work.
> 
> So, when I merge my topic branch onto master, for example, I'd like
> the commit message to be something more thoughtful than the
> "checkpoint 1", "checkpoint 2", "fix typo", "redo sort algorithm",
> etc., etc., and be more like a short set of release notes, a summary
> of what all has been accomplished.
> 
> Do others run into this and perhaps have a good solution?

I tend to do something vaguely like:

	git checkout -b dirtywork origin

Then make a bunch of commits as you describe above--poorly commented,
not necessarily logically split up, etc.--then when it's ready,

	git checkout -b cleanwork origin
	git diff cleanwork..dirtywork

Examine the diff, figure out which change should go logically first,
apply that one change and commit, and then again run

	git diff cleanwork..dirtywork

Repeat until the diff is empty (except maybe for a few improvements I
noticed as I went along).  Then finally

	git push publicrepo cleanwork:master
	git branch -D dirtywork

Or something like that.

--b.
