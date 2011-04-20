From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git add: notice removal of tracked paths by default
Date: Wed, 20 Apr 2011 01:57:58 -0400
Message-ID: <20110420055758.GC28597@sigill.intra.peff.net>
References: <7v1v0y59tv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 07:58:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCQQR-00066G-0i
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 07:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1DTF6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 01:58:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58687
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab1DTF6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 01:58:00 -0400
Received: (qmail 16306 invoked by uid 107); 20 Apr 2011 05:58:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 01:58:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 01:57:58 -0400
Content-Disposition: inline
In-Reply-To: <7v1v0y59tv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171841>

On Tue, Apr 19, 2011 at 12:18:20PM -0700, Junio C Hamano wrote:

> Make "git add" to pretend as if "-A" is given when there is a pathspec on
> the command line.  "git add" without any argument continues to be a no-op.

I like your proposed semantics much better. I remember many times early
on with git cursing the current behavior, until I finally trained myself
to do "git add -A".

>  This might not be such a good idea, and I do not have a strong opinion
>  for this change, but merely a weatherbaloon.
> 
>  Having "git add ." notice removals might lead to mistakes ("oh, I only
>  meant to record additions, and didn't want to record the removals"), but
>  at the same time, leaving it not notice removals would lead to mistakes
>  by the other people ("I added, removed and edited different paths, but
>  why only removals are ignored?").

I suspect most people will want the new semantics, because no matter
what your overall workflow, it is generally going to be some variant of:

  1. hack hack hack
  2. tell git about changes

And you don't really care about deletions versus modifications, you just
want them all added. But you probably _do_ care about additions versus
modififications, since step 1 often involves creating cruft that should
remain untracked (whereas it very rarely involves _deleting_ precious
files). And that's why we have "add -u", which should not go away.

My biggest worry would be people saying "eh? Add removes my files? That
makes no sense!" But we more or less already have that with "add -u",
and I think people have learned to accept that it is about "add the
current state to the index" and not "add files to git".

-Peff
