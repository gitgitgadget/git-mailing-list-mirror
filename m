From: Theodore Tso <tytso@mit.edu>
Subject: Re: Optimizing repository speed
Date: Mon, 19 Feb 2007 10:14:10 -0500
Message-ID: <20070219151410.GG25490@thunk.org>
References: <17881.46642.843674.49482@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 16:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJADb-0006j7-OL
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 16:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbXBSPOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 10:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbXBSPOQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 10:14:16 -0500
Received: from thunk.org ([69.25.196.29]:43623 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbXBSPOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 10:14:15 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HJAIm-0006YB-NG; Mon, 19 Feb 2007 10:19:40 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HJADS-000553-Dh; Mon, 19 Feb 2007 10:14:10 -0500
Content-Disposition: inline
In-Reply-To: <17881.46642.843674.49482@lisa.zopyra.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40132>

On Mon, Feb 19, 2007 at 08:37:38AM -0600, Bill Lear wrote:
> As part of our conversion to git 1.5, I would like to ensure that
> our code repository does not get crufty and slow.  Currently, I have
> a cron job that runs each morning that does a 'git repack -a -d'.
> 
> I know there is 'git-gc', and it appears to do all sorts of good
> things.  Can I simply replace my call to 'git repack -d -a' with 'git
> gc', or is there anything else I might want to do?

git-gc is a strict superset of git repack -a -d.  Specifically, what
it does is:

git-pack-refs --prune
git-reflog expire --al 
git-repack -a -d -l
git-rerere gc

It will also through in a git-prune if you do add --prune to the
git-gc call, but you really don't want to run that out of a cron job.

Regards,

						- Ted
