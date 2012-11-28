From: Jeff King <peff@peff.net>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 23:07:39 -0500
Message-ID: <20121128040739.GA4115@sigill.intra.peff.net>
References: <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <20121128032337.GB1669@thyrsus.com>
 <20121128033009.GA3931@sigill.intra.peff.net>
 <20121128034700.GD1669@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 05:08:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYwJ-0002mt-MF
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 05:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031Ab2K1EHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 23:07:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58983 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab2K1EHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 23:07:42 -0500
Received: (qmail 2658 invoked by uid 107); 28 Nov 2012 04:08:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 23:08:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 23:07:39 -0500
Content-Disposition: inline
In-Reply-To: <20121128034700.GD1669@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210696>

On Tue, Nov 27, 2012 at 10:47:00PM -0500, Eric S. Raymond wrote:

> Jeff King <peff@peff.net>:
> > A much more compelling argument to me would be that you are doing some
> > bidirectional magic between git and svn, and you want to make make sure
> > that an svn->git->svn translation will result in the exact same bytes.
> > Then the argument is still "because SVN has it", but at least it is "and
> > we interoperate with it" and not simply chasing a cool but useless
> > feature.
> 
> Er, well, that *is* in fact the exact reason I want it.
> 
> I didn't put it exactly that way because I didn't expect anyone here
> to particularly care about round-tripping like that.  But remember 
> that I do a lot of stuff with repo surgery and conversion tools.

If that's what we really care about, then that opens up the
possibilities for how we store the data. An extension header in the
object might be convenient, but it opens up a lot of questions about
what git will do with such a header (e.g., would it be part of git-log
output?).

Felipe suggested using git-notes to add the metadata, which I think is a
reasonable first step. The git side of the code is already written, and
the concept is nicely modularized away from the core of git. Nobody has
to care about it but your importer, and anybody who wants to query it[1]
can do so by requesting the note.

-Peff

[1] And you do not have to limit yourself to timestamps, if there is
    other metadata about each commit you end up wanting to store for a
    clean bi-directional conversion.
