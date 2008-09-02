From: Yann Dirson <ydirson@altern.org>
Subject: Re: diffcore and directory renames
Date: Tue, 2 Sep 2008 22:48:02 +0200
Message-ID: <20080902204802.GS4985@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20080901213904.GP4985@nan92-1-81-57-214-146.fbx.proxad.net> <7vfxojtr9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaco3-00026Q-DV
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbYIBUru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYIBUru
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:47:50 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:51382 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbYIBUrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:47:49 -0400
Received: from smtp5-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 87CC81C7333;
	Tue,  2 Sep 2008 22:47:47 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E98A41C72FA;
	Tue,  2 Sep 2008 22:47:44 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id DF7811F0C1; Tue,  2 Sep 2008 22:48:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94711>

On Mon, Sep 01, 2008 at 03:50:22PM -0700, Junio C Hamano wrote:
> Yes, I've hinted here number of times that rename detection could notice
> the fact that neighbouring paths are migrating to the same directory and
> boost similarity scores of leftover paths that did not otherwise made the
> threshold in such a situation.

Wow, that's a great idea I did not think about :)

> I am glad to see finally somebody got interested ;-)

I am glad we're on the same side :)

> > $ ./git-diff-tree 0f1027 -M
> > 0f1027e1aceb4bc5fa682776ab9f72935e2cd1b3
> > :040000 040000 6f6159f0245784352414ff38ffb68bae80f30bd6 6f6159f0245784352414ff38ffb68bae80f30bd6 R100   ppc     moved
> 
> Yes, diff-tree can show this, and you should be able to teach diff-index
> with a clean cache-tree to do similar, but this only applies to the
> non-recursive 100% rename at the toplevel, which is too narrow a special
> case to be interesting at all.  We perhaps further could run the
> similarity comparison on the raw tree objects if we wanted to so that you
> can find inexact matches, but I think it is going in the wrong direction.

Agreed.

> The thing is, diffcore is designed to be a general mechanism to unify
> comparisons on two arbitrary sets of files, be they from tree-vs-tree,
> tree-vs-index, tree-vs-worktree, or index-vs-worktree.  The machinery
> should be able to operate on any two sets of files in the same way and
> produce more-or-less the same results.  It is Ok for callers to give extra
> hints, when available, to speed up the computation, but the core of the
> algorithm should not depend on the presense of such hints to deduce the
> renames.

My idea was rather to just see tree/index/worktree as just 3
specialized forms of a single "abstract tree" of some sort,
effectively unifying things.

But anyway afterwards I thought that there may be something for me to
learn in how --find-copies-harder gets its information for
non-modified sources of copies -- I'll have a look at that.


> So please aim to make the hint-less case, "diff-files --no-index", produce
> a sensible result.  That should be the first step.

OK.

Best regards,
-- 
Yann
