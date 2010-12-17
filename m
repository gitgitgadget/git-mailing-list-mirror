From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Fri, 17 Dec 2010 16:21:00 -0500
Message-ID: <20101217212100.GB11511@sigill.intra.peff.net>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101215130046.GB25647@sigill.intra.peff.net>
 <7vei9gi0y3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 22:21:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PThji-0000K7-B1
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 22:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab0LQVVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 16:21:05 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37391 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351Ab0LQVVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 16:21:03 -0500
Received: (qmail 10532 invoked by uid 111); 17 Dec 2010 21:21:01 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 17 Dec 2010 21:21:01 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Dec 2010 16:21:00 -0500
Content-Disposition: inline
In-Reply-To: <7vei9gi0y3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163892>

On Fri, Dec 17, 2010 at 12:44:36PM -0800, Junio C Hamano wrote:

> > All variables are case-insensitive. The config parser down-cases them,
> > so all code should treat tham as all-lowercase. However, we tend to
> > document them as camelCase for readability.
> 
> Careful.  The second level of three-level names is supposed to be usable
> for user defined names (e.g. names of branches and remotes) and I think
> the completion code should not downcase it.

Yeah, good point. It is not even "second level" in the parsing code,
though, since that code sees:

  [first "second"]
    third

and not

  first.second.third

IOW, the second one is ambiguous in the face of an internal dot.  So if
I had something like:

  [Foo "Bar.Baz"]
    Bleep = true

then "Foo" and "Bleep" are case-insensitive, but both "Bar" and "Baz"
are not. So in terms of dotted components, the rule is "the first and
last dotted components are case-insensitive, and middle ones are
case-sensitive". At least with respect to my simple test of calling "git
config x.y.z". I'm afraid if I look too deeply I might discover some
inconsistency. :)

-Peff
