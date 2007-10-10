From: David Brown <git@davidb.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Wed, 10 Oct 2007 08:48:31 -0700
Message-ID: <20071010154831.GA19226@old.davidb.org>
References: <20071010015545.GA17336@lapse.madduck.net> <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org> <20071010102528.GB20390@lapse.madduck.net> <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifdni-0000mW-13
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbXJJPsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbXJJPsh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:48:37 -0400
Received: from mail.davidb.org ([66.93.32.219]:38462 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639AbXJJPsg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 11:48:36 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IfdnT-00059Z-JU; Wed, 10 Oct 2007 08:48:31 -0700
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60512>

On Wed, Oct 10, 2007 at 08:25:15AM -0700, Linus Torvalds wrote:

>Yes, *some* SCM's have tried to do that. In particular, the ones that are 
>"patch-based" tend to think that patches are "identical" regardless of 
>where they are, and while re-ordering of them is a special event, it's not 
>somethign that changes the fundamental 'ID' of the patch.
>
>For example, I think the darcs "patch algebra" works that way.
>
>It's a really horrible model. Not only doesn't it scale, but it leads to 
>various very strange linkages between patches, and it fails the most 
>important part: it means that merges get different results just because 
>people are doing the same changes two different ways.

Actually, specifically darcs, different merges _always_ result in the same
data.  It's a fundamental part of is patch algebra.  No matter what order
you apply a given set of patches, even with conflicts and reordering, you
always get the same result, or no result.  Conflicts are "resolved" by
inserting conflict markers in the file, ordered by the patch ID.  It
doesn't matter which order you apply them in, you get the same markers.
Then there will be a merge patch which fixes the markers that someone could
apply, no matter what order the applied the previous patches.

Darcs breaks down in a few places, though.

   - The no result.  Sometimes, it just can't figure out how to reorder
     patches.  Even worse, occasionally, the implementation will fail to
     terminate try to figure this out.  There isn't much to do at this
     point, except manually apply the patch, hence generating a new patch
     ID.

   - It doesn't scale well.

The strange linkages between patches could be thought of as a feature,
since it is basically constraining the order that the patches can be
applied in.

There is a darcs-git project that tries to do the darcs things on top of
git.

Dave
