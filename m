From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 2/4] config: drop file pointer validity check in
 get_next_char()
Date: Thu, 28 Feb 2013 01:54:32 +0100
Message-ID: <20130228005432.GA23046@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226194023.GC22756@sandbox-ub>
 <20130226200556.GB13830@sigill.intra.peff.net>
 <20130227075257.GA4685@sandbox-ub>
 <20130228004137.GA12948@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:55:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UArm5-0003pD-1n
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 01:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab3B1Ayk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 19:54:40 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:40727 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab3B1Ayj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 19:54:39 -0500
X-Greylist: delayed 105084 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2013 19:54:39 EST
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UArlY-0007aa-Iq; Thu, 28 Feb 2013 01:54:32 +0100
Content-Disposition: inline
In-Reply-To: <20130228004137.GA12948@sandbox-ub>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217232>

On Thu, Feb 28, 2013 at 01:41:47AM +0100, Heiko Voigt wrote:
> On Wed, Feb 27, 2013 at 08:52:57AM +0100, Heiko Voigt wrote:
> > On Tue, Feb 26, 2013 at 03:05:56PM -0500, Jeff King wrote:
> > > On Tue, Feb 26, 2013 at 08:40:23PM +0100, Heiko Voigt wrote:
> > > 
> > > > The only location where cf is set in this file is in do_config_from().
> > > > This function has only one callsite which is config_from_file(). In
> > > > config_from_file() its ensured that the f member is set to non-zero.
> > > 
> > > Makes sense, although...
> > > 
> > > > -	if (cf && ((f = cf->f) != NULL)) {
> > > > +	if (cf) {
> > > > +		FILE *f = cf->f;
> > > 
> > > Couldn't we say the same thing about "cf" here (i.e., that it would
> > > never be NULL)? Can we just get rid of this conditional entirely?
> > 
> > That might be true. I will look into it. Just wanted to get rid of an
> > extra callback in my series.
> 
> I had a look and it might be true that cf will never be NULL in a code
> path. Nevertheless its much harder to verify by looking at the code
> since its a global variable. get_next_char() is called from all over the
> place and I would have to look at all the code paths. As far as I know
> static global variables are always initialized to zero so its safe to
> check even if has not yet been explicitly initialized.
> 
> The statement if cf is not NULL all members will be initialized is much
> simpler to verify since its just one place now and two places after this
> series.

To add some empirical information: I just ran the testsuite without the
conditional and it still passes. To me it only make sense to start the
parsing with cf initialized. But I am not familiar enough with the code
to judge whether it is safe to assume this.

Cheers Heiko
