From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Thu, 13 Dec 2007 23:45:54 -0500
Message-ID: <20071214044554.GB10169@sigill.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net> <7vir348e0l.fsf@gitster.siamese.dyndns.org> <20071212092512.GB20799@coredump.intra.peff.net> <7vzlwevu2k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 05:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J32RP-0007Il-My
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 05:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762572AbXLNEp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 23:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762466AbXLNEp6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 23:45:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1843 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762331AbXLNEp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 23:45:57 -0500
Received: (qmail 19993 invoked by uid 111); 14 Dec 2007 04:45:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 13 Dec 2007 23:45:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2007 23:45:54 -0500
Content-Disposition: inline
In-Reply-To: <7vzlwevu2k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68219>

On Thu, Dec 13, 2007 at 07:22:43PM -0800, Junio C Hamano wrote:

> Sorry, you are right.
> 
> Perhaps pick a reasonably small but not insanely small value, like 16kB,
> forget about the atomicity issues for now, as an interim improvement
> patch?

I'm fine with that. We can probably go a bit higher than that. From my
limited testing[1]:

  Linux 2.6.18: ~128K
  Linux 2.6.23: huge? I tried ~350K and it worked fine
  Solaris: huge? I tried ~350K and it worked fine
  Freebsd 6.1: ~256K

So it seems that we could probably go with something more like 64K, and
then only truly pathological cases should trigger the behavior.

-Peff

[1] All numbers are approximate and determined experimentally with
something like:
  for i in `seq 1 $n`; do
    touch $long_filename-$i
  done
  ls * | wc
