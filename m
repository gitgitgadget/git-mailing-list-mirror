From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 21:17:35 -0400
Message-ID: <20140712011735.GB17349@sigill.intra.peff.net>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
 <1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
 <20140711174628.GC7856@sigill.intra.peff.net>
 <xmqqmwcf36jy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 03:18:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5lww-00070J-3z
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 03:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbaGLBRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 21:17:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:60546 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751927AbaGLBRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 21:17:37 -0400
Received: (qmail 8272 invoked by uid 102); 12 Jul 2014 01:17:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 20:17:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 21:17:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwcf36jy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253374>

On Fri, Jul 11, 2014 at 02:54:25PM -0700, Junio C Hamano wrote:

> > Yeah, we're quite inconsistent there. In some cases we silently ignore
> > something unknown (e.g., a color.diff.* slot that we do not understand),
> > but in most cases if it is a config key we understand but a value we do
> > not, we complain and die.
> 
> Hm, that's bad---we've become less and less careful over time,
> perhaps?

I don't think so. I think we've always been not-very-lenient with
parsing values. Two examples:

  1. We sometimes extend a boolean variable to take additional values
     (like "auto" or "always"). Older gits will see those values and say
     "not a boolean, and also not a number" and barf.
     branch.autosetupmerge is an example of this (it learned "always" in
     9ed36cf.

  2. The parser for colors translates things like "bold" into ANSI
     codes. If it doesn't understand a keyword, it dies. If we add new
     color names or attributes, they will cause older git to die.

     There are many cases like this. Pretty much any enumerated value
     (like branch.autosetuprebase, for example) will face this whenever
     we add new possible values.

So I do not think we have ever had a rule, but if we did, it is probably
"silently ignore unknown keys, complain on unknown values". Which makes
warning on tag.sort unlike most of the rest of the code.

I do not mind it, though (I am one of the people it is most likely to
help :) ).  Just giving some context.

-Peff
