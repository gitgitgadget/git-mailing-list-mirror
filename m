From: Yann Dirson <ydirson@altern.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 21:39:13 +0100
Message-ID: <20070124203913.GD4083@nan92-1-81-57-214-146.fbx.proxad.net>
References: <17846.53626.895660.762096@lisa.zopyra.com> <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 21:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9oui-0005ZE-Tj
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbXAXUkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 15:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXAXUkF
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:40:05 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:60637 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549AbXAXUkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:40:04 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E30CF27F48;
	Wed, 24 Jan 2007 21:40:00 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id EFB921F07B; Wed, 24 Jan 2007 21:39:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37675>

On Tue, Jan 23, 2007 at 08:11:38PM -0800, Linus Torvalds wrote:
> Git *very* fundamentally tracks project state, not file state. Which means 
> that you very much can NOT try to "merge a file". It is a senseless 
> operation in git, and in fact, any SCM that allows it pretty much is 
> doomed to be a total piece of sh*t (*).

> (*) And I'm not saying that just because git doesn't do it. It's much 
> more fundamental than that. Once you start doing per-file branching and 
> merging, you've basically screwed yourself, and you'll never be able to 
> work on the project as a "whole project" any more - you no longer have a 
> well-defined history that actually is the history of the whole project.

In fact, I came some time ago on a workflow which could be seen as
quite similar to this issue.

The problem was about merging a new upstream release in a local
branch, when both branches had heavy changes.  Indeed this tree was
not using GIT but CVS, with upstream tarballs imported on a branch - I
just asked myself how it could be best handled with GIT, and could
only come to the conclusion that something in GIT was still missing.

What was particular about this tree, is that we are several people
working on it, namely developpers taking care of the app, and me as
build manager taking care of the build mechanics as well as kernel+OS.
So the task was logically divided: one dev would merge the app, and I
would merge everything else.  As you see, it's far from one-file
merges, but the problem is quite similar.


The idea which I came up with was inspired by the "partial merge"
feature in PRCS, which I had never used or even understood the purpose
before that date.

Basically, it was that if some set of files could be merged somewhat
independently from the rest, and we don't want to get GIT attempt to
merge them again when finally merging the whole, a commit of a partial
merge would somehow record that some files had already been merged.
And I happenned to think that it could be sufficient to create a
commit that would not be a merge commit itself (since it is not a
full-project merge), but which would instead reference "subcommits"
for the relevant parts of the tree that were merged during that
iteration.

I realize that solution would not really be perfect, as there is
always some coupling between the code and build stuff in a project.
And sometimes we could want to get finer granularity than the file
level.  But that's so far my best guess at finding a solution.

How would you handle such a situation ?

Best regards,
-- 
Yann.
