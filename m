From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Mon, 16 Apr 2012 23:42:49 +0200
Message-ID: <20120416214247.GA5606@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
 <20120416161431.GD13366@hmsreliant.think-freely.org>
 <7vvckzws73.fsf@alter.siamese.dyndns.org>
 <20120416165024.GF13366@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu0W-0002RM-Ks
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab2DPWCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:02:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46026 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755697Ab2DPWCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:02:38 -0400
Received: from [127.0.0.1] (p5B22C2B7.dip.t-dialin.net [91.34.194.183])
	by bsmtp.bon.at (Postfix) with ESMTP id 458F9130044;
	Tue, 17 Apr 2012 00:02:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120416165024.GF13366@hmsreliant.think-freely.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195703>

On Mon, Apr 16, 2012 at 12:50:24PM -0400, Neil Horman wrote:
> On Mon, Apr 16, 2012 at 09:35:12AM -0700, Junio C Hamano wrote:
> > Neil Horman <nhorman@tuxdriver.com> writes:
> > 
> > > On Sun, Apr 15, 2012 at 11:39:35AM +0200, Clemens Buchacher wrote:
> > > ...
> > >> > +test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
> > >> > +	git checkout master && {
> > >> > +		git cherry-pick --allow-empty empty-branch2
> > >> > +	}
> > >> > +'
> > >> > +
> > >> > +test_expect_success 'cherry pick with --keep-redundant-commits' '
> > >> > +	git checkout master && {
> > >> > +		git cherry-pick --keep-redundant-commits HEAD^
> > >> > +	}
> > >> > +'
> > >> 
> > >> And the expected result is that the HEAD commit is not removed, right?
> > >> You should check for that as well.
> > >> 
> > >> Also, please checkout empty-branch2^0 first, in order to make the test
> > >> independent of its predecessor.
> > >
> > > Not sure I follow what your saying here.  The expected result with both of these
> > > tests is that a new commit is created, referencing the current HEAD as the new
> > > HEAD's parent.
> > 
> > If the request were "checkout master^0 first" I would understand.  The
> > precondition for the second test will be different depending on the first
> > one succeeds or not.  Perhaps that is what Clemens meant?
> > 
> Perhaps, but if so, I'm still not sure how a checkout of empty-branch2^0 affects
> these tests at all, nor do I grok the relevance to ensuring that the HEAD commit
> wasn't removed (as AIUI, cherry pick never does that anyway).  Clement, can you
> clarify your thoughts here please?

It seems that I was implying a lot more than I realized. What I meant
was that master and empty-branch2 are equivalent for the purposes of
that test (empty-branch2^ also is a non-empty commit [*1*]), but while
master is a moving target, empty-branch2 is untouched. 

However, I just notice that empty-branch2 is also the root commit, so
maybe this will not work after all. But that should be easy to fix.

And now I am also wondering why we have two tests for cherry picking an
empty commit without --allow-empty (the one that you added and the one
that was there before). Is the non-ff part significant and if so, how?
And why don't we need to test fast-forward cherry-pick with
--allow-empty?
