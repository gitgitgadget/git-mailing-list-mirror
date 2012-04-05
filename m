From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Thu, 5 Apr 2012 09:13:01 -0400
Message-ID: <20120405131301.GB10293@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <vpqty12h995.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 05 15:13:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFmVL-0001BV-WF
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 15:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab2DENNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 09:13:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48853
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab2DENNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 09:13:05 -0400
Received: (qmail 23428 invoked by uid 107); 5 Apr 2012 13:13:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 09:13:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 09:13:01 -0400
Content-Disposition: inline
In-Reply-To: <vpqty12h995.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194772>

On Mon, Apr 02, 2012 at 09:40:22AM +0200, Matthieu Moy wrote:

> For the others, they already have to learn about the "upstream"
> semantics. And making argumentless "git pull" and "git push" purposely
> asymetric to make it simple for the user sounds like an oxymoron to me.

We can make the operations technically symmetric in terms of the actual
sources and destinations from which commits are moved, but they are not
necessarily symmetric in the user's workflow.

Let's imagine I have a branch "topic" that has an upstream of
"origin/master". You are arguing that "git pull" moves commits from
"origin/master" onto "topic", and therefore "git push" should move
commits from "topic" onto "origin/master". That is symmetric at a low
level.

But what does it mean to me as a user? Those operations may not be
symmetric in my workflow if the branches have special meaning. For a
project using a topic-branch workflow, it is not big deal to move
commits from master onto a topic branch. But it _is_ a big deal to move
commits from a topic branch onto master, because that has social
implications within the project (e.g., saying "this topic is ready for
prime-time").

So yeah, the low-level symmetry provides one nice way of explaining
those commands when the symmetry is helpful to your workflow. But I'm
concerned about the cases where what the user wants _isn't_ symmetric.
When they say "git push" because they want to publish their topic
branch, and it does an embarrassing and difficult-to-revert thing to the
public master branch. Telling them "ah, but you should have seen that
pull and push are symmetric! It all makes sense!" is going to be small
consolation.

Fundamentally I am less concerned about explainibility and more about
safety when somebody has not even gotten to the point of having the
thing explained.

> The discussion seems to focuse on 'let's make "git push" easy to
> explain', but I think the right thing to do is to make _Git_ easy to
> explain. With "push.default = current", we'll have a hard time
> explaining how "git pull" works.

Do we have a hard time explaining how "git pull" works now?

-Peff
