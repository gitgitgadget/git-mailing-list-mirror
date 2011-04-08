From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 8 Apr 2011 17:32:01 -0400
Message-ID: <20110408213201.GA20348@sigill.intra.peff.net>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
 <1302274674-4231-1-git-send-email-asedeno@mit.edu>
 <7vmxk033ic.fsf@alter.siamese.dyndns.org>
 <20110408205437.GB16540@sigill.intra.peff.net>
 <7v4o6830cc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 23:32:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8JHn-0008OD-Rd
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 23:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926Ab1DHVcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 17:32:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56391
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518Ab1DHVcF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 17:32:05 -0400
Received: (qmail 5389 invoked by uid 107); 8 Apr 2011 21:32:52 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 17:32:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 17:32:01 -0400
Content-Disposition: inline
In-Reply-To: <7v4o6830cc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171165>

On Fri, Apr 08, 2011 at 02:22:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think format-patch is totally lacking in this type of quoting. If I
> > do:
> >
> >   $ git init
> >   $ git config user.name '<bogus> with "quotes"'
> >   $ echo contents >foo && git add . && git commit -m foo
> >   $ git format-patch --stdout --root
> >   ...
> >   From: bogus with "quotes <peff@peff.net>
> >
> > So some of my magic characters are just stripped, and some of them get
> > included, making the output bogus (the stripping of <> actually happens
> > within git, so the commit itself is missing them).
> 
> The output from format-patch is meant to be slurped into MUA, so I would
> say that they should show what a human user would type the name to
> Thunderbird or message.el or whatever, and it is MUA's respoinsibility to
> make it RFC comformant.  And that is why I mentioned that send-email
> may want to learn a new trick or two.

I disagree. Format-patch claims to make an mbox, so it should make one
that is valid (actually, the documentation is very wishy-washy about
whether it is an mbox; we say "formatted to resemble UNIX mailbox
format" at one point, and "print all commits...in mbox format" later).

But that is a philosophical distinction. What matters in practice is
what MUAs expect to get, and how they deal with it. I expect most MUAs
handle bare "." just fine, because it's fairly unambiguous. But try:

  git init repo && cd repo
  git config user.name 'Jeff "Peff" King' &&
  echo content >>file &&
  git add file &&
  git commit -m one

  git format-patch -1 --stdout >mbox

now open the result in your MUA. Mutt strips the quotes and I become
"Jeff Peff King".

-Peff
