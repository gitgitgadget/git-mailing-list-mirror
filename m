From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
	Monotone)
Date: Thu, 31 Jul 2008 13:18:55 -0700
Message-ID: <20080731201855.GB24631@spearce.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 22:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOecv-0002G6-Ol
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 22:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbYGaUS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbYGaUS4
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 16:18:56 -0400
Received: from george.spearce.org ([209.20.77.23]:47929 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYGaUSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 16:18:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5C7AB383A4; Thu, 31 Jul 2008 20:18:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90978>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> Oh, and to make sure I'm not lying I actually did test this, but I also 
> noticed that "git clone" no longer marks the initial pack-file with 
> "keep", so it looks like "git gc" will then break the link. That's sad. I 
> wonder when that changed, or maybe I'm just confused and it never did.

It was a bug in git-clone that we were recording the .keep file on
initial clone.  We left the lock file in place after the fetch pack
call was done, but didn't remove it after the refs were updated.

If we want to go back to .keep'ing the original pack creating
during clone it probably should be threshold based.  For many
smaller projects with only a 25M pack (or less) there is no point
in .keep'ing that first pack.  For larger projects where the pack
is over a few hundred megabytes, then yea, maybe there is value
in .keep'ing it during clone.

-- 
Shawn.
