From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git merge bus error
Date: Tue, 19 Aug 2008 16:49:05 -0700
Message-ID: <20080819234905.GK24212@spearce.org>
References: <EA1ADBE3-C9A8-49DE-B135-62A46F2FD666@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lucas Carlson <lucas.carlson@me.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVaxn-00026E-Du
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 01:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbYHSXtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 19:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbYHSXtG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 19:49:06 -0400
Received: from george.spearce.org ([209.20.77.23]:49850 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYHSXtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 19:49:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5C01638375; Tue, 19 Aug 2008 23:49:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <EA1ADBE3-C9A8-49DE-B135-62A46F2FD666@me.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92939>

Lucas Carlson <lucas.carlson@me.com> wrote:
> /usr/local/bin/git-merge: line 438: 19000 Bus error               git- 
> merge-$strategy $common -- "$head_arg" "$@"
>
> I have tried every merge strategy there is. It ends up leaving a .git/ 
> index.lock file. I used git 1.5.6 and tried upgrading to 1.6.0. The only 
> thing 1.6.0 did was hide this bus error message but I assume it still bus 
> errors because there is a .git/index.lock file still.
>
> Unfortunately the source code is proprietary so I can not let you try it 
> on your own but let me know what I can run on my machine to help you guys 
> track down this bus error.

Build git with debugging symbols enabled and run git merge from
1.6.0 under gdb.  If it gets a bus error we'll at least get a stack
trace in gdb and can see where we were when the corruption killed us.
Its a start.

If `gdb git merge` doesn't come up with the corruption then it is
the git-merge-recursive backend.  Try running it from the libexec
directory (see git --exec-path) under gdb and passing into it as
arguments:

	$(git merge-base HEAD $branch) -- HEAD $branch

where $branch is what you were giving to git merge in the first
place.

Again, let us know what the trace is so we can at least narrow
down where the corruption killed it.  Once we know more than just
"it dies" we'll probably be able to ask more interesting questions
to help narrow it down.

-- 
Shawn.
