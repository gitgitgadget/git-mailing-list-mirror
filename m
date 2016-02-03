From: Jeff King <peff@peff.net>
Subject: Re: git object-count differs between clones
Date: Tue, 2 Feb 2016 23:34:12 -0500
Message-ID: <20160203043411.GB21561@sigill.intra.peff.net>
References: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com>
 <vpq7finm6v8.fsf@anie.imag.fr>
 <203317792.714602.1454430077194.JavaMail.zimbra@xes-inc.com>
 <20160202165246.GA17822@sigill.intra.peff.net>
 <1978336183.727736.1454433728105.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Andrew Martin <amartin@xes-inc.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 05:34:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQp9c-0005Eb-8S
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 05:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbcBCEeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 23:34:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:36538 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755456AbcBCEeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 23:34:14 -0500
Received: (qmail 32009 invoked by uid 102); 3 Feb 2016 04:34:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 23:34:14 -0500
Received: (qmail 20987 invoked by uid 107); 3 Feb 2016 04:34:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Feb 2016 23:34:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2016 23:34:12 -0500
Content-Disposition: inline
In-Reply-To: <1978336183.727736.1454433728105.JavaMail.zimbra@xes-inc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285329>

On Tue, Feb 02, 2016 at 11:22:08AM -0600, Andrew Martin wrote:

> Thanks for the clarification. I now ran "git repack -A" followed by 
> "git gc --prune=now", however I am still seeing the same number of objects. What
> else can I try to successfully mark these and unreachable and garbage collect them?

That should clear out any unreachable objects. Are we sure that the
objects in question are, in fact, unreachable?

Try:

  git rev-list --objects --all --reflog | wc -l

which should give a count of reachable objects. I'd expect that to line
up with that "git count-objects -v" reports after having run your gc
above.

In your original email, the discrepancy was between your "original"
repository and the one that had round-tripped to a clone. Is it possible
there are refs in the original that did not get pushed? Try comparing
"git for-each-ref" in each repository.

We also consider objects in the index to be reachable for packing. Could
your original perhaps have some uncommitted objects mentioned in the
index?

-Peff
