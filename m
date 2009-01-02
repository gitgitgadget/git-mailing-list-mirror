From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] builtin-apply: prevent non-explicit permission
	changes
Date: Fri, 2 Jan 2009 12:35:14 -0500
Message-ID: <20090102173513.GA8109@coredump.intra.peff.net>
References: <20081230235357.GA12747@myhost> <7vwsdec6za.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 18:36:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LInx1-0000aD-Lu
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 18:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757140AbZABRfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 12:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbZABRfT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 12:35:19 -0500
Received: from peff.net ([208.65.91.99]:4952 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658AbZABRfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 12:35:18 -0500
Received: (qmail 11078 invoked by uid 111); 2 Jan 2009 17:35:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 02 Jan 2009 12:35:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jan 2009 12:35:15 -0500
Content-Disposition: inline
In-Reply-To: <7vwsdec6za.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104387>

On Fri, Jan 02, 2009 at 02:55:37AM -0800, Junio C Hamano wrote:

> A git patch that does not change the executable bit still records the mode
> on its "index" line.  "git apply" used to interpret this mode exactly the
> same way as it interprets the mode recorded on "new mode" line.  As the
> wish by the patch submitter to set the mode to the one recorded on the
> line.

Nit: I had to read that third sentence several times to make sense of
it, since it is not a complete sentence (I think s/line\. As/line: as/
might help).

> This changes the semantics of the mode recorded on the "index" line;
> instead of interpreting it as the submitter's wish to set the mode to the
> recorded value, it merely informs what the mode submitter happened to
> have, and the presense of the "index" line is taken as submitter's wish to
> keep whatever the mode is on the receiving end.

I have been following this thread but didn't have a chance to look
closely until now. I think this change is definitely the right thing, as
it follows the normal semantics for a patch (which are basically a
merge: "change the parts we changed, but leave everything else, even if
the other side changed it").

>  builtin-apply.c           |    4 ++-

The implementation looks good to me.

>  t/t4129-apply-samemode.sh |   62 ++++++++++++++++++++++++++++++++++++++++

And the tests make me feel warm and fuzzy. It is always nice to see
tests that aren't just "X was broken, and now it works" or "new feature
Y works" but "here is every case spelled out with its desired behavior."
I think those are the tests that really help keep us regression-proof.

-Peff
