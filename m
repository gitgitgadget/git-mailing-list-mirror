From: Jeff King <peff@peff.net>
Subject: Re: "git commit --amend --only --" nevertheless commits staged
 changes
Date: Tue, 10 Jul 2012 16:30:52 -0400
Message-ID: <20120710203052.GB23798@sigill.intra.peff.net>
References: <4FFC06C9.5050405@syntevo.com>
 <7vwr2bgyqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:31:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soh5t-0004MA-3I
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 22:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab2GJUa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 16:30:57 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56844
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab2GJUay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 16:30:54 -0400
Received: (qmail 2147 invoked by uid 107); 10 Jul 2012 20:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jul 2012 16:31:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2012 16:30:52 -0400
Content-Disposition: inline
In-Reply-To: <7vwr2bgyqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201276>

On Tue, Jul 10, 2012 at 01:14:32PM -0700, Junio C Hamano wrote:

> I do not think the combination with --amend, --only and no paths
> ever worked.  We rejected such a combination before 6a74642c5, which
> merely made us to accept the combination but I do not think the
> commit did anything to re-read the tree from the HEAD being amended
> to the index.
> 
> Something like this, but I haven't thought about what other things
> it may break.

Our emails just crossed. I came to the exact same conclusion, and just
wrote almost the exact same patch.

> -	if (!pathspec || !*pathspec) {
> +	if (!(only && amend) && (!pathspec || !*pathspec)) {

It is sufficient to check only "only" in the first part of your
conditional, as we disallow empty pathspecs with "-o". And even if we
didn't disallow it, this would do the right thing by trying to create a
partial commit with no changes (which would fail, of course, but is the
only sane thing for the prepare_index function to do; certainly doing an
as-is commit is simply wrong).

-Peff
