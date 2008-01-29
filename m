From: Jeff King <peff@peff.net>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 17:51:23 -0500
Message-ID: <20080129225123.GB4586@coredump.intra.peff.net>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net> <alpine.LFD.1.00.0801300844170.28476@www.l.google.com> <20080129222007.GA3985@coredump.intra.peff.net> <7vfxwgmf87.fsf@gitster.siamese.dyndns.org> <20080129224558.GA4586@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJzJQ-0004xw-MO
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbYA2Wv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYA2Wv2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:51:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3125 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbYA2Wv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:51:27 -0500
Received: (qmail 11638 invoked by uid 111); 29 Jan 2008 22:51:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 29 Jan 2008 17:51:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2008 17:51:23 -0500
Content-Disposition: inline
In-Reply-To: <20080129224558.GA4586@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72011>

On Tue, Jan 29, 2008 at 05:45:58PM -0500, Jeff King wrote:

> > 	if (rename_dst_nr > rename_limit && rename_src_nr > rename_limit)
> > 		goto cleanup;
> 
> Hrm, yes, I think it can still overflow. (e.g., a 2 by 2^32-1
> situation). But changing it to || isn't right, either; you would

I think the correct solution is just:

  /* check for overflow of square */
  if (rename_dst_nr > ULONG_MAX / rename_src_nr)
          goto cleanup;

-Peff
