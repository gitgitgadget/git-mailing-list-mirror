From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is
 given
Date: Wed, 5 Aug 2009 17:17:00 -0400
Message-ID: <20090805211700.GA24697@coredump.intra.peff.net>
References: <20090805201937.GB9004@coredump.intra.peff.net>
 <20090805202326.GC23226@coredump.intra.peff.net>
 <7vhbwm0zcs.fsf@alter.siamese.dyndns.org>
 <20090805204835.GA24539@coredump.intra.peff.net>
 <7vws5ix9dz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnrG-0000AO-V6
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZHEVRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbZHEVRG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:17:06 -0400
Received: from peff.net ([208.65.91.99]:38707 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbZHEVRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:17:06 -0400
Received: (qmail 12961 invoked by uid 107); 5 Aug 2009 21:19:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 Aug 2009 17:19:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2009 17:17:00 -0400
Content-Disposition: inline
In-Reply-To: <7vws5ix9dz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124987>

On Wed, Aug 05, 2009 at 02:01:44PM -0700, Junio C Hamano wrote:

> What I meant was that I'd still want to see the non-verbose part of
> print_push_status(), while suppressing the progress report.  That would
> make mails coming from the cron job much more pleasant to read.
> 
> If you somehow can automatically squelch progress without -q for an
> unattended invocation (e.g. cron jobs), then I wouldn't need to pass -q
> and everything will be good.  But if I have to pass -q in order to squelch
> progress, I do not want that same -q to automatically also mean "no status
> output", which is what your 3/3 is about, if I am reading the patch
> correctly.  That's all.

Hmm. Doesn't that already work? pack-objects checks isatty(2) already
before outputting progress, which means it should be suppressed when run
via cron (the original poster is seeing it, though, which maybe means
some crons allocate a terminal?).

But it sounds like git already does what you want; this extra "-q" would
really be more about shutting up the ref status. If you really wanted to
control them separately (e.g., because your isatty check is not
reliable), then maybe it should be split into "--quiet" and
"--no-progress"?

-Peff
