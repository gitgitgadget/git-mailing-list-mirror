From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow branch names that end with ".lock"
Date: Thu, 7 May 2009 18:01:10 -0700
Message-ID: <20090508010110.GW30527@spearce.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org> <1241708714-20326-2-git-send-email-spearce@spearce.org> <200905080102.44053.robin.rosenberg@dewire.com> <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain> <7vprekbfik.fsf@alter.siamese.dyndns.org> <7viqkcbenb.fsf_-_@alter.siamese.dyndns.org> <20090508005417.GV30527@spearce.org> <7veiv0bee2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 03:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2ESw-0000mN-7J
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 03:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbZEHBBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 21:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755584AbZEHBBK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 21:01:10 -0400
Received: from george.spearce.org ([209.20.77.23]:47826 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbZEHBBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 21:01:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 31292381D0; Fri,  8 May 2009 01:01:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7veiv0bee2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118553>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> A project policy for naming branches could be to use a dot as a word
> >> separator (instead of '-' which is often done by existing projects), and
> >> "fix.vm.lock" could be a very valid name for a branch to address a VM
> >> locking issues.
> >
> > I think we sent the same patch... except...
> >
> >>  git-gui/lib/index.tcl                    |    2 +-
> >
> > Don't do that.  I'll patch git-gui and send you a pull request.
> 
> Why not?  I never commit my "how about this" weatherbaloon patches
> directly ;-)

I know.  I was saying, "don't patch git-gui in the same commit
as git.git".  I would have spun that as two different commits.

> If you found that ours match identically except for that one line, that is
> a very good indication.  I didn't check.

Here's `git diff yours mine`, we were really close:

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 31e1141..982984f 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -4,7 +4,7 @@ lockfile API
 The lockfile API serves two purposes:
 
 * Mutual exclusion.  When we write out a new index file, first
-  we create a new "lock" file `$GIT_DIR/index..lck`, write the new
+  we create a new file `$GIT_DIR/index..lck`, write the new
   contents into it, and rename it to the final destination
   `$GIT_DIR/index`.  We try to create the `$GIT_DIR/index..lck`
   file with O_EXCL so that we can notice and fail when somebody

ACK, I like your version better than mine.

diff --git a/refs.c b/refs.c
index 03aded9..b4ca305 100644
--- a/refs.c
+++ b/refs.c
@@ -742,8 +742,6 @@ int check_ref_format(const char *ref)
 				return CHECK_REF_FORMAT_ERROR;
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
-			if (has_extension(ref, "..lck"))
-				return CHECK_REF_FORMAT_ERROR;
 			return ret;
 		}
 	}

NAK, I like how I removed this block.  It can't happen anymore,
the no ".." in name earlier should have caught the condition.

-- 
Shawn.
