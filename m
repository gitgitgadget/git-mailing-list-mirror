From: Jeff King <peff@peff.net>
Subject: Re: co-authoring commits
Date: Fri, 19 Jun 2015 00:25:20 -0400
Message-ID: <20150619042519.GB26001@peff.net>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
 <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <20150617205931.GB24079@cloud>
 <xmqqegla57hl.fsf@gitster.dls.corp.google.com>
 <20150617222828.GB24438@cloud>
 <xmqq381q551o.fsf@gitster.dls.corp.google.com>
 <55833758.6010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, josh@joshtriplett.org,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 06:25:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5nrr-0003Qy-QW
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 06:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbbFSEZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 00:25:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:48601 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751357AbbFSEZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 00:25:22 -0400
Received: (qmail 21463 invoked by uid 102); 19 Jun 2015 04:25:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 23:25:22 -0500
Received: (qmail 11852 invoked by uid 107); 19 Jun 2015 04:25:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 00:25:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 00:25:20 -0400
Content-Disposition: inline
In-Reply-To: <55833758.6010000@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272100>

On Thu, Jun 18, 2015 at 11:25:44PM +0200, Jakub Nar=C4=99bski wrote:

> Author and committer include datetime in the contents of the
> field, which is used by Git for heuristics limiting walk. Coauthor
> would have the same date as author, isn't it? If, after long
> and involved discussion, we didn't add 'generation' field (for
> easier cutting history walking), what chance adding 'coauthor'
> has.

I don't think the two situations are comparable. I would (and did) argu=
e
that a "generation" field is a bad header to bake in because of what it
means (it is redundant with the graph structure).

Whereas "co-author" is not a fundamentally bad; it's just not something
we chose to support early on, and it would have to be added now.

> OTOH it would be nice to have support for .mailmap, and for
> grepping... but the former could conceivably be added to the trailer
> tool, the latter can be done with appropriate regexp in
> "git log --grep=3D...".

I don't think we munge trailers during "git log" pretty-printing at all
now, but it is certainly something we could add (including mailmap-ing
them).  That doesn't seem like much more work than showing the co-autho=
r
field, and it's a lot more generally applicable (you could mailmap
S-O-B, Reviewed-by, and so forth).

Similarly, something like "git shortlog" would have to learn about
multiple authors under the "co-author" scheme. But likewise, it would
not be much more work to teach it something like:

  git shortlog --field=3DReviewed-by

to handle an arbitrary trailer. And that is much more flexible.

> I wonder what would break if one used 'Name <e@mai.l>, Name <em@i.l>'
> as the author...

The "normal" parser we use for pretty-printing goes left-to-right and
will stop at the first ">", and show only the first author.

Older versions of git would then get the date wrong, complaining about
the ",". Newer versions parse the date from right-to-left to work aroun=
d
such bogosities (especially things like "<foo <bar>>") and so will pars=
e
back to the second ">".

=46sck will definitely complain about it.

-Peff
