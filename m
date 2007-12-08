From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add status.relativePaths config variable
Date: Sat, 8 Dec 2007 03:45:52 -0500
Message-ID: <20071208084552.GA5206@coredump.intra.peff.net>
References: <20071207165703.GA8889@sigill.intra.peff.net> <Pine.LNX.4.64.0712071853500.27959@racer.site> <4759996B.2000300@gmail.com> <20071207204937.GA20111@coredump.intra.peff.net> <20071207212607.GA11504@coredump.intra.peff.net> <7vejdxy70p.fsf@gitster.siamese.dyndns.org> <7vaboly6dv.fsf@gitster.siamese.dyndns.org> <20071208080238.GB4812@coredump.intra.peff.net> <7v63z9y5k2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0vKB-0005O9-SC
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbXLHIpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbXLHIpz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:45:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1154 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756008AbXLHIpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:45:55 -0500
Received: (qmail 17612 invoked by uid 111); 8 Dec 2007 08:45:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Dec 2007 03:45:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 03:45:52 -0500
Content-Disposition: inline
In-Reply-To: <7v63z9y5k2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67529>

On Sat, Dec 08, 2007 at 12:05:49AM -0800, Junio C Hamano wrote:

> >> index 225fb4d..63d50f2 100644
> >> --- a/wt-status.h
> >> +++ b/wt-status.h
> >> @@ -28,6 +28,7 @@ struct wt_status {
> >>  
> >>  int git_status_config(const char *var, const char *value);
> >>  int wt_status_use_color;
> >> +int wt_status_relative_paths;
> >>  void wt_status_prepare(struct wt_status *s);
> >>  void wt_status_print(struct wt_status *s);
> >
> > Shouldn't both of these ints be marked "extern"? I'm surprised it worked
> > at all (or perhaps the part of my brain that stores C linkage issues is
> > rotting?).
> 
> Yes, rotting very much.

Nope, there's still a little grey matter left. It is not technically
guaranteed by the standard to work, since the declaration in every
source file which includes wt-status.h is a "tentative definition."
Fortunately, the linker is nice enough to figure out what's going on as
long as only one is actually initialized. This is listed in C99 Section
J.5.11 as a "Common extension".

The Summit C FAQ mentions it as well:

  http://c-faq.com/decl/decldef.html

So "extern" is better, but apparently not required for any
linkers we care about. Note that omitting "extern" _is_ illegal in C++,
but fortunately we _really_ don't care about those linkers. :)

But at least I'm not totally crazy.

-Peff
