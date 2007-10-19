From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 22:15:29 -0400
Message-ID: <20071019021529.GX14735@spearce.org>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu> <20071019015715.GW14735@spearce.org> <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihOt-0007cv-Uh
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbXJSCPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759798AbXJSCPg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:15:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43026 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759541AbXJSCPf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:15:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IihOQ-00085H-Ps; Thu, 18 Oct 2007 22:15:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 64E9620FBAE; Thu, 18 Oct 2007 22:15:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7F18F52A-3D57-4510-B71B-69D43480126E@MIT.EDU>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61602>

Michael Witten <mfwitten@MIT.EDU> wrote:
> On 18 Oct 2007, at 9:57:15 PM, Shawn O. Pearce wrote:
> >Michael Witten <mfwitten@MIT.EDU> wrote:
> >>
> >>Seems like the shortcut would lose the history and confuse git.
> >
> >No.  It wouldn't.  The index has no knowledge of history of anything.
> 
> I mean to say, if only the index is changed,
> then git won't be informed about the necessary
> git-{add/rm}'s, as in the following (is this
> not so?):

git-add amounts to either inserting a new path->stat/sha1 entry
in the index, or updating an existing entry with new stat/sha1
information.

git-rm amounts to removing a path->stat/sha1 entry from the index.
It's just gone once the git-rm is completed.  As if it was never
there to begin with.

A git-commit (really git-write-tree but same difference to the
end-user) stores whatever is in the index as the gospel truth for
how that commit's files should appear.  No knowledge about add
or rm is necessary at this stage, we're just taking a copy of the
index and recording that for posterity.

So updating the index is all that is necessary to "remember" these
add and rm operations.  OK, well, you also need to actually make
a commit (and not orphan that commit) to have it really stay in
your project.  But its all really as simple as it seems.

-- 
Shawn.
