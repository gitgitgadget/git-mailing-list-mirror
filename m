From: Jeff King <peff@peff.net>
Subject: Re: Bug report
Date: Sat, 6 Oct 2012 09:31:46 -0400
Message-ID: <20121006133146.GD11712@sigill.intra.peff.net>
References: <506D122E.2050404@emsoftware.com>
 <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com>
 <506DB500.4010803@emsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: John Whitney <jjw@emsoftware.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 15:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKUU6-0005mi-Rv
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 15:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab2JFNbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 09:31:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42915 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab2JFNbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 09:31:50 -0400
Received: (qmail 6591 invoked by uid 107); 6 Oct 2012 13:32:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 09:32:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 09:31:46 -0400
Content-Disposition: inline
In-Reply-To: <506DB500.4010803@emsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207146>

On Thu, Oct 04, 2012 at 11:10:40AM -0500, John Whitney wrote:

> Thank you for your response. I do see the dilemma, but having
> no possible "unmodified" state is extremely inconvenient and,
> as shown, breaks basic git operations.

But you have asked for an impossible state. You have said "this file
cannot have CR when you check it in, because we erase them". And yet the
version of the file in HEAD has CRs in it. So it must appear modified
with respect to HEAD.  And the solution is to make a commit with the
normalized content.

You said in your test script:

  # Committing test.txt or clearing .gitattributes does clear
  # the "modified" status, but those options are undesirable

Why is the commit undesirable? You have decided that CRs will no longer
be tolerated in your repository (by setting .gitattributes). Now you
need to record that change in history with a commit that strips out the
CRs.

> I guess my thought is that if git doesn't allow CRs to be checked
> in, then it should strip the CRs when checking the file out, and
> consider that form (or both forms) as "unmodified". It just
> doesn't make sense to me that files are considered modified
> immediately after checkout.

It is not about having CRs in the working tree file. Those are now
considered uninteresting and stripped by git when comparing to the HEAD.
The problem is that what's in your _repository_ has CRs.

I wonder if this is a fundamental misunderstanding of how the CRLF
handling in git works. It is not "magically make me not care about line
endings anymore". It is "the canonical version in the repo is LF-only.
Strip anything coming into the repository to match that, and
(optionally) add CR to anything going out to the filesystem for my
convenience". But you need a flag day to update the in-repository
versions to the new scheme.

-Peff
