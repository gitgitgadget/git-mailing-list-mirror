From: Jeff King <peff@peff.net>
Subject: Re: [RFC] use typechange as rename source
Date: Sat, 1 Dec 2007 01:17:48 -0500
Message-ID: <20071201061748.GA2606@coredump.intra.peff.net>
References: <7vhcj36j6e.fsf@gitster.siamese.dyndns.org> <7v8x4f6iyu.fsf@gitster.siamese.dyndns.org> <20071121171235.GA32233@sigill.intra.peff.net> <7vir3l2a1i.fsf@gitster.siamese.dyndns.org> <20071129141452.GA32670@coredump.intra.peff.net> <7vmyswsfl6.fsf@gitster.siamese.dyndns.org> <20071130015716.GA15224@coredump.intra.peff.net> <7vsl2n87jr.fsf@gitster.siamese.dyndns.org> <20071201043407.GD30725@coredump.intra.peff.net> <7vhcj36j6e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 07:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyLg2-0002bY-3b
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 07:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbXLAGRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 01:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbXLAGRv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 01:17:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4982 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbXLAGRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 01:17:50 -0500
Received: (qmail 14269 invoked by uid 111); 1 Dec 2007 06:17:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Dec 2007 01:17:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2007 01:17:48 -0500
Content-Disposition: inline
In-Reply-To: <7v8x4f6iyu.fsf@gitster.siamese.dyndns.org> <7vhcj36j6e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66701>

On Fri, Nov 30, 2007 at 10:08:41PM -0800, Junio C Hamano wrote:

> I think it does make a difference, if you have a cross rename that
> swaps:
> 
> 	$ ls -F foo bar
>         bar	foo@
>         $ mv foo tmp; mv bar foo; mv tmp bar
>         $ ls -F foo bar
>         bar@	foo

OK, I see now what you were saying before. Yes, we do want them actually
broken, and my initial patch is not right in that sense.

> > -	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
> > -		return 0; /* leave symlink rename alone */
> > +	if (object_type(src->mode) != object_type(dst->mode))
> > +		return 1; /* even their types are different */
> 
> Oops, this part is wrong.  It should be checking ISREG and stuff.

OK, good. I was sitting there puzzling over what in the world this
change meant.

-Peff
