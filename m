From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Tue, 9 Dec 2014 15:00:58 -0500
Message-ID: <20141209200058.GA11481@peff.net>
References: <20141209174958.GA26167@peff.net>
 <54875462.3040305@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQy3-00037c-0f
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbaLIUBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:01:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:50665 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbaLIUBB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:01:01 -0500
Received: (qmail 17310 invoked by uid 102); 9 Dec 2014 20:01:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 14:01:00 -0600
Received: (qmail 3385 invoked by uid 107); 9 Dec 2014 20:01:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 15:01:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 15:00:58 -0500
Content-Disposition: inline
In-Reply-To: <54875462.3040305@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261151>

On Tue, Dec 09, 2014 at 08:58:26PM +0100, Johannes Sixt wrote:

> Am 09.12.2014 um 18:49 schrieb Jeff King:
> > +test_expect_success 'create repo with absurdly long refname' '
> > +	ref240=$_z40/$_z40/$_z40/$_z40/$_z40/$_z40
> > +	ref1440=$ref240/$ref240/$ref240/$ref240/$ref240/$ref240 &&
> > +	git init long &&
> > +	(
> > +		cd long &&
> > +		test_commit long &&
> > +		test_commit master &&
> > +		git update-ref refs/heads/$ref1440 long
> 
> Having this ref on the filesystem is going to fail on Windows, I presume
> (our limit is 260). Can we stuff it away as a packed ref right from the
> beginning? (And turn off reflogs, BTW.)

Yeah, after sending that, I wondered if it would cause problems.

I don't think it would be too hard to just cat it right into the
packed-refs file. The other option would be to try creating it, and set
a prereq to skip other tests if it fails.

-Peff
