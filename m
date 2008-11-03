From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Mon, 3 Nov 2008 01:56:37 -0500
Message-ID: <20081103065636.GB10772@coredump.intra.peff.net>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:59:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwtPb-0001i1-0H
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbYKCG4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 01:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbYKCG4k
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 01:56:40 -0500
Received: from peff.net ([208.65.91.99]:2529 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbYKCG4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 01:56:39 -0500
Received: (qmail 29147 invoked by uid 111); 3 Nov 2008 06:56:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Nov 2008 01:56:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2008 01:56:37 -0500
Content-Disposition: inline
In-Reply-To: <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99906>

On Sun, Nov 02, 2008 at 02:27:57PM -0800, Junio C Hamano wrote:

> >> +  * 'git push --matching' does what 'git push' does today (without
> >> +    explicit configuration)
> >
> > I think this is reasonable even without other changes, just to override
> > any configuration.
> 
> I don't.  Can't you say "git push $there HEAD" these days?  I vaguely
> recall that there is a way to configure push that way for people too lazy
> to type "origin HEAD" after "git push".

I think you are reading more into my statement than I intended. I meant
that adding an explicit --matching was reasonable, _even if it matches
the default_. I can think of two reasons:

 1. Even if it is a no-op, it is more explicit for showing newbies what
    is going on. And it also means that _if_ we wanted to introduce
    new behavior or configurability, we will have already had
    "--matching" for some time. So it will be safe(r) at that point to
    immediately start saying "--matching" in your scripts to specify the
    behavior you want, without as much worry about confusing an older
    version.

 2. Even today, the behavior of push can be modified with configuration
    in remote.*.mirror. I would expect "git push --matching" to override
    this. Though perhaps that is too confusing a behavior, as mirroring
    does more than just ref selection, including force-updating.

So my statement was not anything about "git push $there HEAD", but just
that adding "--matching" was reasonable.

> I think I was neutral in the discussion that led to the removal of
> "git-export", but the rationale IIRC was exactly because "git-export" can
> be done by simply piping "git-tar" to tar.  On the other hand, if all you
> had was "export" and you wanted to create a release tar/zip ball, you have
> to first create a (potentially huge) hierarchy in the filesystem only to
> archive it.  This change needs to defend that the benefit of being able to
> create a new non-git checkout elsewhere on the filesystem far outweighs
> the downside of addition of another command (i.e. "eek, why does git have
> that many commands" from new people).

I think the complaint is just that it is awkward to have to pipe to tar
(and harder to check error status), when "export to directory" is a
reasonably common request.

If the concern is about another command, then perhaps rather than "git
export" it would be simpler to have "git archive --format=dir" as a
convenience (and it could even use the checkout-index optimization in
the local case, rather than generating a tar).

-Peff
