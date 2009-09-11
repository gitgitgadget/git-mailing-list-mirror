From: Jeff King <peff@peff.net>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 18:05:07 -0400
Message-ID: <20090911220506.GA27098@coredump.intra.peff.net>
References: <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
 <20090911164730.GA21536@coredump.intra.peff.net>
 <7viqfpw6tv.fsf@alter.siamese.dyndns.org>
 <7vvdjpuqgx.fsf@alter.siamese.dyndns.org>
 <20090911212938.GA26589@coredump.intra.peff.net>
 <7vr5uduotz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 00:05:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmEF5-0004Xv-UV
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 00:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046AbZIKWFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 18:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757044AbZIKWFJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 18:05:09 -0400
Received: from peff.net ([208.65.91.99]:57963 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756960AbZIKWFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 18:05:08 -0400
Received: (qmail 9461 invoked by uid 107); 11 Sep 2009 22:05:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 18:05:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 18:05:07 -0400
Content-Disposition: inline
In-Reply-To: <7vr5uduotz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128226>

On Fri, Sep 11, 2009 at 02:57:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think something like that needs to "belong" to the diff code itself. I
> > guess in the case of "diff", we could check all diff-related config at
> > diff setup time.
> 
> Not necessarily.  You do not want to care about color configuration if you are
> doing diff --raw for example.  The one that first uses the color variable
> should be able to notice the breakage, no?
> 
> > But what about something used in several places, like
> > core.quotepath?
> 
> Exactly the same way I checked what codepaths needed to fix for the
> autosetupmerge stuff.  core.quotepath internally sets quote_path_fully,
> and the sole user of quote_path_fully is sq_must_quote() which is only
> used by next_quote_pos().  So you can have your check very isolated.

I guess I'm just worried that in doing this for _every_ variable we are
going to run across cases where variables are used in several different
codepaths, and we are going to end up adding a large number of tests for
"is this thing valid". And if we forget one, it's going to cause us to
access some sentinel value that may cause a segfault.

But that is just my gut feeling. I haven't actually looked at doing a
full-scale conversion.

-Peff
