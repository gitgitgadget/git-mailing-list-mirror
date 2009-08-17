From: Jeff King <peff@peff.net>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 02:31:43 -0400
Message-ID: <20090817063143.GB27530@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 08:31:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcvl2-0001CV-Dy
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 08:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbZHQGbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 02:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbZHQGbn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:31:43 -0400
Received: from peff.net ([208.65.91.99]:44018 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbZHQGbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:31:43 -0400
Received: (qmail 28709 invoked by uid 107); 17 Aug 2009 06:31:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 17 Aug 2009 02:31:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Aug 2009 02:31:43 -0400
Content-Disposition: inline
In-Reply-To: <7vmy5z603d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126126>

On Sun, Aug 16, 2009 at 12:16:22PM -0700, Junio C Hamano wrote:

>  (2) IIRC, "git gc --auto" runs "repack -A".  What is its effect with
>      respect to this dependency between object stores?  I suspect it would
>      also break the dependency, but if so, is it a good thing?  Perhaps
>      should we change it to use a version that keeps the dependency
>      instead?

No, it actually runs "repack -d -l -A", which behaves fine. I even
tested it to make sure.

BTW, the "gc.auto" setting is really annoying at low levels (I set
gc.auto to 1 for testing). For efficiency, it looks at only one
hashed object directory, and then assumes the other 255 contain roughly
the same number of objects. But you get bad sampling error when you have
fewer than 256 objects. I don't think it is worth caring about, though.
It doesn't seem very sane to set gc.auto to something so low.

-Peff
