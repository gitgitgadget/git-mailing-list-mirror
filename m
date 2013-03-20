From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 13:47:59 -0400
Message-ID: <20130320174759.GA29349@sigill.intra.peff.net>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <20130320164806.GA10752@sigill.intra.peff.net>
 <7vhak6f0w4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, spearce@spearce.org,
	git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:48:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIN7r-0000yG-5h
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab3CTRsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:48:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60297 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab3CTRsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:48:06 -0400
Received: (qmail 10252 invoked by uid 107); 20 Mar 2013 17:49:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 13:49:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 13:47:59 -0400
Content-Disposition: inline
In-Reply-To: <7vhak6f0w4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218629>

On Wed, Mar 20, 2013 at 10:15:39AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So maybe just run "git status >/dev/null"?
> 
> In the background?  How often would it run?  I do not think a single
> lockfile solves anything.  It may prevent simultaneous runs of two
> such "prime the well" processes, but the same user may be working in
> two separate repositories.

Yes, in the background (he invokes __git_recursive_stat already in the
background). I'd think you would want to run it whenever you enter a
repository.

> I do not see anything that prevents it from running in the same
> repository over and over again, either.  "prompt" is a bad place to
> do this kind of thing.

Yeah, I did not look closely at that. The commit message claims "When
entering a git working dir", but the implementation runs it on each
prompt invocation, which is awful. I think you'd want to check to use
rev-parse to see if you have changed into a new git repo, and only run
it once then.

Which is still gross, and I have no interest whatsoever in this feature.
I was just trying to be positive and constructive to the original
submission. :)

-Peff
