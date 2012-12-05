From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Wed, 5 Dec 2012 02:30:56 -0500
Message-ID: <20121205073055.GA5776@sigill.intra.peff.net>
References: <201212021417.25525.tboegi@web.de>
 <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
 <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com>
 <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
 <CACsJy8BtX9fMkGDoVGKzgz7SSinbt0561B1ZKHu6fs+n8ewKGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tg9Rs-0001KD-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 08:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab2LEHa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 02:30:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59090 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab2LEHa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 02:30:58 -0500
Received: (qmail 16559 invoked by uid 107); 5 Dec 2012 07:31:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Dec 2012 02:31:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2012 02:30:56 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BtX9fMkGDoVGKzgz7SSinbt0561B1ZKHu6fs+n8ewKGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211111>

On Wed, Dec 05, 2012 at 12:43:30PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Dec 5, 2012 at 2:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Or a project commit hook?
> >
> > Surely.  It is OK to have "cd t && make test-lint" in your
> > pre-commit hook.
> 
> No, what I meant is a shared pre-commit script that all git devs are
> encouraged (or forced) to install so bugs are found locally rather
> than after patches are sent to you. The hook content does not really
> matter.

I think that is orthogonal. You would want to implement the guts of such
a hook outside the hook itself, so that it could be run at arbitrary
times. So even if we want such a hook, the development should probably
look like:

  1. Implement checks in t/Makefile, triggered by "make test-lint" or
     similar.

  2. Run "make test-lint" in a hook.

I do not use such a hook myself, but I do run "test-lint" as part of my
"make test", and I "make test" each series I send (and if the series has
non-trivial refactoring, each individual patch of the series to catch
breakages that come and go during refactoring). But I decide when to run
those checks, not a hook.

Anyway, I do think a "shell portability lint" would be a great addition
to "test-lint", but I am slightly skeptical that it will be easy to
write a good one that does not have false positives. Still, there may be
some low-hanging fruit. I have not looked carefully at Torsten's patch
yet.

-Peff
