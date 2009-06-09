From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3 1/3] Introduce die_errno() that appends strerror(errno) to die()
Date: Tue, 9 Jun 2009 10:22:30 +0200
Message-ID: <200906091022.31738.trast@student.ethz.ch>
References: <cover.1244299302.git.trast@student.ethz.ch> <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch> <20090608220713.GB29942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDwbQ-0001fm-Dc
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452AbZFIIWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 04:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280AbZFIIWe
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:22:34 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:42630 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628AbZFIIWc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 04:22:32 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 10:22:18 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 10:22:18 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <20090608220713.GB29942@sigill.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 09 Jun 2009 08:22:18.0182 (UTC) FILETIME=[67171E60:01C9E8DB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121154>

Jeff King wrote:
> On Mon, Jun 08, 2009 at 11:02:18PM +0200, Thomas Rast wrote:
> 
> > +void die_errno(const char *fmt, ...)
> > +{
> > +	va_list params;
> > +	char fmt_with_err[1024];
> > +
> > +	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, strerror(errno));
> > +
> > +	va_start(params, fmt);
> > +	die_routine(fmt_with_err, params);
> > +	va_end(params);
> > +}
> 
> Aren't you assuming that strerror(errno) has no '%'-signs here, which is
> what kicked off the whole discussion?

True, of course.  Hrm.

So do we go back to v2 (for 1/3) and ask future callers to never use
custom formats with die_errno, or should I write a version that
doubles the % characters while tacking the error message onto the
format?

[It's a pity that it seems impossible to add an extra argument to the
va_args...]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
