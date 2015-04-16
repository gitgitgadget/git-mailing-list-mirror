From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 11:55:58 -0400
Message-ID: <20150416155558.GA10390@peff.net>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
 <xmqqsic0hyk4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 17:56:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yim9A-000551-N1
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbbDPP4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 11:56:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:46276 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750851AbbDPP4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:56:01 -0400
Received: (qmail 7090 invoked by uid 102); 16 Apr 2015 15:56:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 10:56:01 -0500
Received: (qmail 25993 invoked by uid 107); 16 Apr 2015 15:56:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 11:56:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 11:55:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsic0hyk4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267301>

On Thu, Apr 16, 2015 at 08:39:55AM -0700, Junio C Hamano wrote:

> >  test_expect_success 'status untracked directory with --ignored' '
> >  	echo "ignored" >.gitignore &&
> > +	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
> > +	mv .gitignore.new .gitignore &&
> 
> Is this "write literal in \xHEX on the replacement side of sed
> substitution" potable?  In any case, replacing the above three with
> something like:
> 
> 	printf "<bom>ignored\n" >.gitignore
> 
> may be more sensible, no?

I'm not sure about sed, but I agree it is suspect. And note that printf
with hex codes is not portable, either You have to use octal:

  printf '\357\273\277ignored\n' >.gitignore

Also, as a nit, I'd much rather see this in its own test rather than
crammed into another test_expect_success. It's much easier to diagnose
failures if the test description mentions the goal, and it is not tied
up with testing other parts that might fail.

-Peff
