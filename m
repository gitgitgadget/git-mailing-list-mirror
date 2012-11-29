From: Jeff King <peff@peff.net>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 29 Nov 2012 15:01:43 -0500
Message-ID: <20121129200143.GB22084@sigill.intra.peff.net>
References: <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
 <CABURp0pnGYykud1xDn5T+eszQGTrzKLTp6J_O7ZrWwVd-zKpkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 21:02:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeAJ7-0003B9-6N
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 21:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab2K2UBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 15:01:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab2K2UBp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 15:01:45 -0500
Received: (qmail 25990 invoked by uid 107); 29 Nov 2012 20:02:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Nov 2012 15:02:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2012 15:01:43 -0500
Content-Disposition: inline
In-Reply-To: <CABURp0pnGYykud1xDn5T+eszQGTrzKLTp6J_O7ZrWwVd-zKpkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210874>

On Thu, Nov 29, 2012 at 02:14:40PM -0500, Phil Hord wrote:

> > And if we were to add "committer-timestamp" and friends to support
> > negative timestamps anyway (because older tools will not support
> > them), supporting sub-second part might be something we want to
> > think about at the same time.
> 
> Posix-time is signed, but I suppose the git tools do not expect/allow
> a '-' character in the stream.  Has git considered the year-2038
> problem?

Yes. The timestamp is in base-10 ASCII, so there is no Y2038 problem in
the data format (it is up to the implementation to read it into a
sufficiently large time_t internally, of course[1]).

But negative timestamps are a different story. We use "unsigned long"
internally for timestamps, and fsck will complain about it.

-Peff

[1] We use "unsigned long", which means we are Y2038-fine on I32/LP64
    systems, but not on 32-bit or IL32/LLP64 systems. I do not use
    Windows, but my understanding is that LLP64 is the norm there, so it
    would eventually be a problem. But since we are unsigned, it is
    actually a Y2106 problem.
