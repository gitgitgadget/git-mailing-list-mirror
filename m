From: Adam Spiers <git@adamspiers.org>
Subject: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 19:03:33 +0000
Message-ID: <20131219190333.GE23496@pacific.linksys.moosehall>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 20:03:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtisy-0005mB-Mr
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 20:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab3LSTDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 14:03:39 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45727 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab3LSTDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 14:03:35 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id A85372E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 19:03:33 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20131219183645.GD23496@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239533>

On Thu, Dec 19, 2013 at 06:36:45PM +0000, Adam Spiers wrote:
> I wanted to be able to experiment with the TREESAME example given in
> the git-log(1) man page, so I built this script which recreates it:

[snipped]

> Would it be worth including this in (say) contrib/, and then referring
> to it from the man page, in case anyone else feels a similar urge?

Hmm, another related option would be to add a new test case which
tests that git log behaves in the way the man page says it does, in
this case.  Although to some extent this would duplicate what
t6012-rev-list-simplify.sh already tests.

I still don't understand a few things about history simplification:

1. The "--full-history without parent rewriting" correctly asserts
   that commit Q will be shown.  But AFAICS this contradicts the
   documented behaviour "Commits are included if they are not TREESAME
   to any parent" which is implied by "This mode differs from the
   default in one point:", because Q is TREESAME to P.

2. What difference does --dense ever make?  In all three of the modes
   described above it ("Default", "--full-history without parent
   rewriting", and "--full-history with parent rewriting"), walked
   commits are already included if they are not TREESAME to any
   parent.

3. Why is --sparse so called, given that it increases rather than
   decreases the number of commits shown?

I have to say I find this section of the man page really quite hard to
grok, partially due to the choice of "TREESAME" word.  I'm guessing
that this was used because it reflects the name of the constant used
in the code, but it does not help legibility of the man page at all.

I think it could help to add descriptions of the behaviour which are
less formal and more intuitive from a pragmatic real world point of
view.  For example:

    "Each commit walked will only be shown in the default output mode
     if it changed the given path(s) relative to *all* its parents.
     When walking the commit graph, if a merge didn't change the given
     path relative to at least one of its parents, then only one of
     those parents would be walked.  This reduces the number of
     commits shown, but pruning commit chains whose changes
     effectively died out during merges."

This sort of text could then be followed by the examples, for those
who want to check they understood it fully.

Hope this feedback is useful,

Adam
