From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Wed, 10 Jul 2013 07:16:52 -0400
Message-ID: <20130710111652.GE9724@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org>
 <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
 <CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com>
 <CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com>
 <CALkWK0k0xiNFaFmqL2t4ba2g+HSrQ8kU+W_HvnSMcMYY8VgJyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 13:17:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwsOR-0008ST-1L
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab3GJLQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:16:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:47602 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab3GJLQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:16:58 -0400
Received: (qmail 23922 invoked by uid 102); 10 Jul 2013 11:18:14 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:18:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:16:52 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0k0xiNFaFmqL2t4ba2g+HSrQ8kU+W_HvnSMcMYY8VgJyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230040>

On Mon, Jul 08, 2013 at 07:07:01PM +0530, Ramkumar Ramachandra wrote:

> > There's also syntax sharing. I don't think each command should have
> > its own syntax. f-e-r already has %(objectsize). If we plan to have a
> > common syntax, perhaps %(disk-size) should be %(objectsize:disk) or
> > something.
> 
> Ofcourse.  I didn't notice %(objectsize); %(objectsize[:disk]) is a
> fine suggestion.
> 
> > Adding formatting to cat-file --batch from scratch could be
> > another big chunk of code (that also comes with bugs, usually) and may
> > or may not be compatible with the common syntax because of some
> > oversight.
> 
> Oh, I'm proposing that Peff implements just %H and
> %(objectsize[:disk]) for _now_, because that's what he wants.  It
> should be a tiny 20-line parser that's easy to swap out.

I went with %(objectname), %(objectsize), and %(objectsize:disk). The
former match for-each-ref, and the latter extends it in a natural-ish
way (though it is arguable whether "foo:modifier" should mean "do
something with the foo value" or "this is like foo, but not quite"). In
the long run, I would like to see long names for each atom, with short
aliases (so "%H" and "%h" for "%(objectname) and "%(objectname:short)",
available everywhere).

But I think it is OK to start without the aliases, and then pick them up
as the implementations and interfaces are unified. IOW, it is OK to say
"cat-file has not learned about %H yet", and later add it; we cannot
teach it "%H" now and then change our minds later.

> > --batch-cols=... or --batch-disk-size would be simpler, but
> > we might never be able to remove that code.
> 
> Agreed.  The approach paints us into a design-corner, and must
> therefore be avoided.

I would say it is worth one of the other routes if it turned out to be
dramatically simpler. But having just done the work to add formats for
cat-file, it is really not too bad. It lacks some of the niceties of the
other formatters (e.g., colors), but again, we can always add them in
later as the implementations unify.

-Peff
