From: Mike Hommey <mh@glandium.org>
Subject: Re: Feature request: commit count in git-describe should use a
 different method
Date: Wed, 4 Nov 2015 14:50:18 +0900
Message-ID: <20151104055018.GA13077@glandium.org>
References: <CAH=MseKsTvcWxLcVE3hdcJd3aXbn1GZA4=9zEyoCSvYT4L=yPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Munn <robin.munn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 06:50:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztqxp-0006x6-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 06:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbbKDFu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 00:50:26 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:49112 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbbKDFuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 00:50:25 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <glandium@glandium.org>)
	id 1Ztqxe-0003kI-Iw; Wed, 04 Nov 2015 14:50:18 +0900
Content-Disposition: inline
In-Reply-To: <CAH=MseKsTvcWxLcVE3hdcJd3aXbn1GZA4=9zEyoCSvYT4L=yPQ@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280851>

On Wed, Nov 04, 2015 at 12:11:27PM +0700, Robin Munn wrote:
> Several people (including me) seem to expect git-describe's commit
> count to be calculated differently than how it's actually calculated.
> For example, see the following three Stack Overflow questions:
> 
> http://stackoverflow.com/questions/31852885/git-describe-inexplicable-commit-count
> http://stackoverflow.com/questions/33116182/can-i-change-how-git-describe-counts-commits
> http://stackoverflow.com/questions/13568372/commit-count-calculation-in-git-describe
> 
> The scenario that all three questions is asking about is the following:
> 
> 1) I'm working along on a branch whose most recent tag is v1.1,
> created 96 commits ago.
> 2) Someone else merges some work into master, and tags with v1.2. I
> want to incorporate their work into my own, so I merge master into my
> branch.
> 3) I now have a branch that is one commit "forward" from tag v1.2. I
> therefore expect git-describe to say "v1.2-1-g1234567". Instead, I get
> "v1.2-97-g1234567".
> 
> Now, git-describe is working precisely as documented here. The
> documentation describes the commit count as being "the number of
> commits which would be displayed by 'git log (tag commit)..(described
> commit)' " and that is indeed what I'm getting. If I do "git log
> v1.2..HEAD", there will be 97 log entries, because the latest commit
> that is an ancestor of both v1.2 and HEAD is where my branch was
> created from master 97 commits ago.
> 
> However, this is unexpected behavior for me. I was expecting to get a
> commit count of 1, not a commit count of 97. Instead of a count of all
> the commits since I forked from master 97 commits ago, I was expecting
> a count of all the commits since the tag that git-describe has picked
> as the latest tag. In other words, instead of the count to match "git
> log v1.2..HEAD", I was expecting the count to match "git log
> --ancestry-path v1.2..HEAD".

If your branch had been merged into v1.2, and you merged v1.2 back, then
you would have a lower count. One way to look at it is that the count
tells you how much your branch differs from the tag, and 97 is a more
realistic indicator of the amount of difference between the tag and your
branch head than 1 would be.

I, for one, would be confused if the count was 1.

Mike
