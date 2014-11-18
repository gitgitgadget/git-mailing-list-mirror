From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 16:16:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411181610070.2918-100000@iolanthe.rowland.org>
References: <xmqqa93ousme.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:17:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqq90-0004Wf-9B
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbaKRVQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:16:58 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38178 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932145AbaKRVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:16:58 -0500
Received: (qmail 17814 invoked by uid 2102); 18 Nov 2014 16:16:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Nov 2014 16:16:57 -0500
X-X-Sender: stern@iolanthe.rowland.org
In-Reply-To: <xmqqa93ousme.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Nov 2014, Junio C Hamano wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Tue, 18 Nov 2014, Jonathan Nieder wrote:
> >
> >> Alan Stern wrote:
> >> 
> >> > Tracking down regressions.  Bisection isn't perfect.  Suppose a
> >> > bisection run ends up saying that B is the first bad commit.  It's easy
> >> > enough to build B and test it, to verify that it really is bad.
> >> >
> >> > But to be sure that B introduced the fault, it would help to find the
> >> > latest commit that doesn't include B's changes -- that is, the latest
> >> > commit that B isn't reachable from (or the maximal elements in the set
> >> > of all such commits).
> >> 
> >> Isn't that B^ (or B^ and B^2, if B is a merge)?
> >
> > No.  Here's a simple example:
> >
> >             Y
> >            /
> >           /
> >          X--B
> >
> > In this diagram, X = B^.  But B isn't reachable from either X or Y, 
> > whereas it is reachable from one of X's children (namely Y).
> 
> Around here when we draw history horizontally we place parents on
> the left hand side and the children on the right hand side.  X is
> B's parent and does not include B's changes.  Y is not B's parent.
> Y is a child of X so it has all the imperfection of X inherited to
> it (except the ones that is fixed by Y itself), but there is no way
> it inherited the bug B introduced relative to X.
> 
> Why do you say B is reachable from Y?

I omitted a negation by mistake, sorry.  I meant to say: "But B isn't
reachable from either X or Y, and it isn't reachable from one of X's
children (namely Y)."

Thus, if B introduced a bug, that bug would not be present in Y.  But Y 
might be better for testing than X, because Y might fix some other 
problems that are present in X.

Alan Stern
