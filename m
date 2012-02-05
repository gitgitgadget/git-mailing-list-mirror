From: david@lang.hm
Subject: Re: Git performance results on a large repository
Date: Sat, 4 Feb 2012 20:30:55 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1202042026280.6541@asgard.lang.hm>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 05:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rttkk-0000wM-3e
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 05:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab2BEEa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 23:30:57 -0500
Received: from mail.lang.hm ([64.81.33.126]:52991 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab2BEEa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 23:30:57 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q154UtaG021634;
	Sat, 4 Feb 2012 20:30:55 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CB5074CF.3AD7A%joshua.redstone@fb.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189929>

On Fri, 3 Feb 2012, Joshua Redstone wrote:

> The test repo has 4 million commits, linear history and about 1.3 million
> files.  The size of the .git directory is about 15GB, and has been
> repacked with 'git repack -a -d -f --max-pack-size=10g --depth=100
> --window=250'.  This repack took about 2 days on a beefy machine (I.e.,
> lots of ram and flash).  The size of the index file is 191 MB.

This may be a silly thought, but what if instead of one pack file of your 
entire history (4 million commits) you create multiple packs (say every 
half million commits) and mark all but the most recent pack as .keep (so 
that they won't be modified by a repack)

that way things that only need to worry about recent history (blame, etc) 
will probably never have to go past the most recent pack file or two

I may be wrong, but I think that when git is looking for 'similar files' 
for delta compression, it limits it's search to the current pack, so this 
will also keep you from searching the entire project history.

David Lang
