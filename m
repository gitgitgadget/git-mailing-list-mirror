From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Distinguishing trivial and non-trivial merge commits
Date: Sun, 2 May 2010 17:03:05 -0400
Message-ID: <19421.59529.849850.968565@winooski.ccs.neu.edu>
References: <19419.1721.763210.679444@winooski.ccs.neu.edu>
	<20100502181854.GC16051@progeny.tock>
	<19421.54064.178345.489772@winooski.ccs.neu.edu>
	<20100502202943.GB16746@progeny.tock>
	<m31vdugj2t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 23:03:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8gJu-0001m1-Pz
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 23:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758730Ab0EBVDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 17:03:11 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:54117 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758712Ab0EBVDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 17:03:10 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O8gJd-00076i-Rt; Sun, 02 May 2010 17:03:05 -0400
In-Reply-To: <m31vdugj2t.fsf@localhost.localdomain>,
	<20100502202943.GB16746@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146202>

On May  2, Jakub Narebski wrote:
> 
> Well, the compact combined output is thought in such way that "git
> diff --cc" should be empty except for evil merges, when change comes
> from neither of parents.  See description of --cc format in
> git-diff(1) manpage.

Is there a way to convince `git diff' to show *only* these diffs?
Hopefully something that will also play with --stat...  Actually, I'm
fine with `git show' instead -- and it does show these things, but if
I add a --stat it shows all changed files again.


On May  2, Jonathan Nieder wrote:
> 
> diff --name-only follows exactly the example heuristic you
> described.  It still does not catch all manual merge resolutions[1].
> 
> Sometimes two branches introduce different changes to completely
> separate parts of a file.  This is not a conflict, and diff --cc
> will correctly report the merge as trivial (whereas diff --name-only
> does not pay enough attention to do the same).

Good -- the first paragraph is what I thought it would do, the second
makes it even better.  Perhaps it would be nice to show such manual
reoslutions from one parent, but I think that that certainly qualifies
as stuff that is much less interesting than work that was done to
combine content inside a file, or one of those evil merges.  (Since
it's a notification script -- so I really want it to highlight only
"real" work that was done.)


> On the other hand, sometimes two branches introduce conflicting
> changes, but the correct resolution for each conflict hunk is to
> pick one as winner.  Though simple, this can be error-prone, because
> rejecting one change from branch A might end up breaking another
> change that was accepted from the same branch.  diff --cc examines
> only the selected revision and its parents and for all it knows,
> this is just another trivial merge.

To translate the "danger" here, I think that if one person commits
some changed files, another one does a merge with the earlier content
and essentially re-commits all previous versions -- undoing this
commit -- IIUC, then in this case my strategy wouldn't show anything.
I think that what I do would work "well enough", since such things
would be rare to do (eg, it makes more sense to merge first, then
another commit that undoes the changes), and in any case there's also
the overall push diff, and those changes would show up there.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
