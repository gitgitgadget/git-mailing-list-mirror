From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] read_loose_refs(): treat NULL_SHA1 loose
 references as broken
Date: Wed, 3 Jun 2015 05:09:03 -0400
Message-ID: <20150603090903.GE32000@peff.net>
References: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
 <1433260647-18181-4-git-send-email-mhagger@alum.mit.edu>
 <CAGZ79kZG95HB-siR_jMORPuqcL2J_YEwg0VPHE=8XN7gWD4JkA@mail.gmail.com>
 <556E1BBE.7000708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 03 11:09:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z04fk-0005JV-TZ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 11:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbbFCJJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 05:09:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:40305 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752960AbbFCJJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 05:09:06 -0400
Received: (qmail 16223 invoked by uid 102); 3 Jun 2015 09:09:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 04:09:06 -0500
Received: (qmail 17967 invoked by uid 107); 3 Jun 2015 09:09:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 05:09:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 05:09:03 -0400
Content-Disposition: inline
In-Reply-To: <556E1BBE.7000708@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270671>

On Tue, Jun 02, 2015 at 11:10:22PM +0200, Michael Haggerty wrote:

> >> +
> >> +                       if (!(flag & REF_ISBROKEN) && is_null_sha1(sha1)) {
> > 
> > Why do we do the extra check for !(flag & REF_ISBROKEN) here?
> 
> That was an attempt to avoid calling is_null_sha1() unnecessarily. I
> think I can make this go away and make the code clearer in general by
> restructuring the logic a little bit. I will do that in the next round.

If you get rid of the useless hashclr(), then this just becomes:

  if (!(flag & REF_ISBROKEN) && is_null_sha1(sha1))
	flag |= REF_ISBROKEN;

The reason for the initial check seems pretty obvious then (but it would
also be OK without it; is_null_sha1 is not that expensive).

-Peff
