From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Sun, 12 Oct 2008 21:23:11 -0400
Message-ID: <20081013012311.GE3768@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net> <48EB7D74.40302@viscovery.net> <20081007153543.GA26531@coredump.intra.peff.net> <7vabdaidwj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 03:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpCAg-0005l0-Ip
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 03:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYJMBXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 21:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYJMBXO
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 21:23:14 -0400
Received: from peff.net ([208.65.91.99]:3816 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884AbYJMBXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 21:23:14 -0400
Received: (qmail 5160 invoked by uid 111); 13 Oct 2008 01:23:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 12 Oct 2008 21:23:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Oct 2008 21:23:11 -0400
Content-Disposition: inline
In-Reply-To: <7vabdaidwj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98070>

On Sat, Oct 11, 2008 at 10:24:44PM -0700, Junio C Hamano wrote:

> >   echo '* diff=foo' >subdir/.gitattributes
> >   git config diff.foo.funcname some-regex
> > ...
> > In practice, this doesn't happen much, because funcname tends to follow
> > the file extension, as does binary-ness.
> 
> I find this a highly contrived example.  Is this ever be useful in
> practice?

Well, I was doing something like it. But after reading JSixt's messages,
I think I agree that I was probably abusing the attributes system.

> The logic behind the original behaviour was that the file ought to be
> "diff-able" if you are setting up funcname pattern because the funcname
> pattern only makes sense if you are doing the textual diff.  In other
> words, "should we do textual diff?" and "what funcname pattern should we
> use?" are _not_ orthogonal, as wanting to configure the latter does imply
> that you do want to see the change in the textual diff format.

Yeah, I don't think I can really disagree with that. I had some vague
notion that it opens the path for adding orthogonal options later. But
really, I'm not sure that any exist, since they are, by definition
related to the diff. Unless we want to have diff driver options for how
to do a binary diff.

> For the same rationale, if you have .textconv, I think it is natural for
> us to say that you do want to see the change in the textual diff format.
> So I'd agree that you can get rid of this .binary business by saying that
> having .textconv marks it diffable (IOW, I think your first alternative
> makes more sense).

OK. My re-rolled series will keep the assumption that a diff=* attribute
makes a file non-binary. However, I will still include the 'binary'
struct member in the diff driver, as it greatly simplifies the code. It
is trivial then to support "diff.*.binary" (which would default to
'false') if we feel like it.

-Peff
