From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn not working when parent of cloned dir requires auth
Date: Mon, 8 Dec 2008 15:20:06 -0800
Message-ID: <20081208232006.GA21675@hand.yhbt.net>
References: <20081208205418.GA16418@cetel-004-xx6.admin.gatech.edu> <7v4p1e73tt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
X-From: git-owner@vger.kernel.org Tue Dec 09 00:21:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9pPw-0001LO-Aq
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 00:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYLHXUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 18:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbYLHXUJ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 18:20:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60682 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbYLHXUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 18:20:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 552142DC01A;
	Mon,  8 Dec 2008 23:20:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v4p1e73tt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102590>

Junio C Hamano <gitster@pobox.com> wrote:
> "D. Stuart Freeman" <stuart.freeman@et.gatech.edu> writes:
> 
> > I'm trying to
> > 'git svn clone https://mware.ucdavis.edu/svn/ucd-sakai/gradebook-gwt -s'
> > that repo is setup to allow anonymous reading of that directory tree, but
> > git-svn prompts me for a password.  I think git-svn is traversing up the
> > directory tree and encountering a directory that needs authn, can I prevent
> > it from doing that?
> 
> That sounds suspiciously similar to what I observed long time ago:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/46361/focus=46558
> 
> And $gmane/47151 in the thread, aka dc43166 (git-svn: don't minimize-url
> when doing an init that tracks multiple paths, 2007-05-19), supposed to
> have fixed it.

There are some other auth issues that I'm not sure ever got resolved.
The SVN path->branch mapping code is a mess and has needed a rework for
a while...  And I've gotten sick again this weekend.  Tis the season...

Stuart:

For now, running the old style one-connection per-remote config
may be the easiest way to go:

------------ in your .git/config: ---------
[svn-remote "svn"]
        url = https://mware.ucdavis.edu/svn/ucd-sakai/gradebook-gwt/trunk
        fetch = :refs/remotes/trunk
[svn-remote "bloatedGxtAndVanilla"]
        url = https://mware.ucdavis.edu/svn/ucd-sakai/gradebook-gwt/branches/bloatedGxtAndVanilla
        fetch = :refs/remotes/bloatedGxtAndVanilla
[svn-remote "pre-GXT"]
        url = https://mware.ucdavis.edu/svn/ucd-sakai/gradebook-gwt/branches/pre-GXT
        fetch = :refs/remotes/pre-GXT
-------------------------------------------

Then run "git-svn fetch -i $SVN_REMOTE" for each svn-remote

-- 
Eric Wong
