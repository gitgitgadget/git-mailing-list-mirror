From: Jeff King <peff@peff.net>
Subject: Re: Revert option for git add --patch
Date: Thu, 8 Nov 2012 10:15:03 -0500
Message-ID: <20121108151501.GB15560@sigill.intra.peff.net>
References: <EE89F0A1-1C07-4597-B654-035F657AD09F@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: Jonathon Mah <jmah@me.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:15:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWTpC-0004p4-SS
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 16:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab2KHPPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 10:15:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36334 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab2KHPPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 10:15:07 -0500
Received: (qmail 30072 invoked by uid 107); 8 Nov 2012 15:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 10:15:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 10:15:03 -0500
Content-Disposition: inline
In-Reply-To: <EE89F0A1-1C07-4597-B654-035F657AD09F@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209164>

On Thu, Nov 08, 2012 at 12:57:19AM -0800, Jonathon Mah wrote:

> I find myself performing similar actions to you: using git add -p to
> stage hunks, sometimes editing the staged patch; and keeping mental
> notes of things I wanted to revert, sometimes changing them in the
> editor in another window, and sometimes reverting them after the add
> session with git checkout -p).

Yeah, I often use a similar workflow. A related one is:

  (1) Make lots of unrelated changes in the working tree.

      $ hack hack hack

  (2) Pick out hunks for the first commit.

      $ git add -p

  (3) Put the rest of the changes aside.

      $ git stash -k

  (4) Test (and possibly tweak) the result, then commit.

      $ make test
      $ git commit -m "topic 1"

  (5) Bring back the stashed changes.

      $ git stash pop

  (6) If there are still interesting changes, goto step 2.

  (7) Otherwise, discard with "git reset --hard" or "git checkout -p".

I.e., iterating on the changes to put them into several different
commits (and achieving a clean, testable state before making each
commit).

The downside of these workflows is that you have to say "no" to hunks
multiple times (one per iteration) instead of just sorting them in a
single pass. This works OK in practice, but it might be nice to have a
tool that makes a single pass and lets you drop hunks into buckets
(topic 1 vs topic 2 vs discard), and then apply the buckets in order,
stopping to test, tweak, and commit after each one.

> The interactive staging-and-editing tool could be improved, but I'm
> not sure that tool should be called 'git add -p'. git add doesn't
> touch the working tree =E2=80=94 at least I hope not, because I would=
n't
> expect it.

Right. I think the idea of one-pass tool is a good one, but it should
not be called "git add -p".

-Peff
