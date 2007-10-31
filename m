From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Get rid of cpio in git-clone (was: Re: cpio command
	not found)
Date: Wed, 31 Oct 2007 16:22:21 -0400
Message-ID: <20071031202220.GA13300@coredump.intra.peff.net>
References: <18216.31314.990545.518458@lisa.zopyra.com> <20071031133039.GA29065@diana.vm.bytemark.co.uk> <20071031140655.GA8802@gateway.home> <Pine.LNX.4.64.0710311420330.4362@racer.site> <20071031201425.GA29332@gateway.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Karl Hasselstr?m <kha@treskal.com>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Erik Mouw <mouw@nl.linux.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 21:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InK5H-0005JT-O1
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 21:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbXJaUWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbXJaUWY
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 16:22:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4212 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825AbXJaUWX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 16:22:23 -0400
Received: (qmail 22893 invoked by uid 111); 31 Oct 2007 20:22:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 31 Oct 2007 16:22:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2007 16:22:21 -0400
Content-Disposition: inline
In-Reply-To: <20071031201425.GA29332@gateway.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62863>

On Wed, Oct 31, 2007 at 09:14:25PM +0100, Erik Mouw wrote:

> > Patch, please?
> 
> Here you go.

Good, now we have something to critique. :)

> -		find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
> +		cp -Rp$l objects/ "$GIT_DIR/" || exit 1

cp -l isn't even close to portable. It's not in POSIX, and doesn't work
on (at least) Solaris.

I think Mike's patch (cpio if available, copy otherwise) is a reasonable
approach. If there are other methods (and I think cp -l is not
unreasonable for systems where it is supported and cpio is unavailable),
then perhaps it is worth trying them one by one and dropping back to
full copy if all fail.

-Peff
