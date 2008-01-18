From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 21:13:00 -0500
Message-ID: <20080118021300.GR24004@spearce.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net> <20080117110132.GB12285@hashpling.org> <478F4CDC.2090703@viscovery.net> <7vbq7jkixg.fsf@gitster.siamese.dyndns.org> <7v63xrki29.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 03:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFgjl-0004sx-97
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 03:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbYARCNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 21:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYARCNI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 21:13:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36414 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbYARCNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 21:13:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFgiw-0002GX-Jm; Thu, 17 Jan 2008 21:12:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 65CB220FBAE; Thu, 17 Jan 2008 21:13:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v63xrki29.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70950>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The following patch seems to fix the issue for me, but this is
> > primarily meant for discussion, as I do not quite understand why
> > the same issue does not manifest itself when NO_MMAP is not
> > used.
> > ...
...
> What I do not quite understand is how this can be a new issue.

It isn't.  It is indeed a pretty old issue, as far as git issues go.
Its probably about as old as fast-import being accepted into your
tree is.
 
> The codepath to allow updating an existing branch shown above
> (i.e. "if it is not force and old is not NULL") uses the usual
> lookup_commit_reference_gently() interface to access b->sha1,
> and does not use gfi-aware gfi_unpack_entry() or anything
> magical, which means it would have passed the same codepath down
> to trigger the same issue.  IOW, even before this tightening of
> write_ref_sha1(), we already should have had the issue of not
> being to able to grab the object b->sha1 refers to out of the
> newly built packfile.
> 
> Is it just nobody seriously exercised the codepath yet, or is
> there a difference between these two calls that is more subtle
> than that?

I think the problem is nobody has tested fast-import updating an
existing ref while using NO_MMAP.  Or if they did, they didn't report
the problem as they didn't figure they needed fast-import that badly.

Updating an existing ref is not a common operation, but the test
suite does test for it.  So it must be the NO_MMAP configuration
is simply not being tested well enough.

-- 
Shawn.
