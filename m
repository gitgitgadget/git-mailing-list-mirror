From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sat, 26 Nov 2011 18:51:35 -0500
Message-ID: <20111126235135.GA7606@sigill.intra.peff.net>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
 <20111126225519.GA29482@sigill.intra.peff.net>
 <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
 <20111126233133.GA31129@sigill.intra.peff.net>
 <CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 00:51:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUS23-0000Dj-9Y
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 00:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab1KZXvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 18:51:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53545
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab1KZXvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 18:51:37 -0500
Received: (qmail 8897 invoked by uid 107); 26 Nov 2011 23:58:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Nov 2011 18:58:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Nov 2011 18:51:35 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185962>

On Sat, Nov 26, 2011 at 03:47:09PM -0800, Junio C Hamano wrote:

> > My point is to make it available, give it safe
> > semantics by default, and let people who are running daemon-like service
> > (i.e., where the admin controls the daemon and arbitrary users can't
> > write into the hooks directory) use it by setting an environment
> > variable, rather than patching git.
> 
> I think we re on the same page on that point, and this thread is to find
> such a safe default and safe semantics when enabled.
> 
> Unfortunately neither your "trusted" switch nor check the gid of repository
> is that safe thing (sane default part is easy; do not allow it by default).

Sorry, why is the trusted switch not a sane thing? By turning it on, you
are saying "it's OK to run arbitrary code from the repo as the current
user". It's _exactly_ what some people are going to want to do[1],
regardless of any other heuristics.

Sure, maybe it's giving people rope to hang themselves with, but I don't
see a problem with that as long as the issues are clearly laid out in
the documentation.

-Peff

[1] An alternate and even more flexible form is to not just say "it's OK
to run hooks", but to say "run this particular hook as a
pre-upload-hook" without any regard for what's in $GIT_DIR/hooks. It is
a superset of the other form, because of course the hook you tell it
to run can be "sh $GIT_DIR/hooks/pre-upload-pack".
