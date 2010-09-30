From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/16] git-send-email cleanups
Date: Thu, 30 Sep 2010 10:52:18 -0400
Message-ID: <20100930145218.GB32728@sigill.intra.peff.net>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
 <18E0A903-D625-4C7A-A575-AC5C5EF448C9@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 16:52:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1KUl-0004Ak-Gv
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 16:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610Ab0I3OwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 10:52:21 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756412Ab0I3OwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 10:52:20 -0400
Received: (qmail 21583 invoked by uid 111); 30 Sep 2010 14:52:18 -0000
Received: from 129-79-255-204.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.204)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 30 Sep 2010 14:52:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Sep 2010 10:52:18 -0400
Content-Disposition: inline
In-Reply-To: <18E0A903-D625-4C7A-A575-AC5C5EF448C9@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157676>

On Thu, Sep 30, 2010 at 10:30:31AM -0400, Brian Gernhardt wrote:

> >  send-email: get_patch_subject doesn't need a prototype
> >  send-email: file_declares_8bit_cte doesn't need a prototype
> >  send-email: unique_email_list doesn't need a prototype
> >  send-email: cleanup_compose_files doesn't need a prototype
> 
> None of these subroutines strictly need the prototype, but it does
> allow Perl to warn us if we send incorrect arguments.  Why remove
> them?  Are they causing problems somewhere?

They don't necessarily do what you want:

  perl -e 'sub want_scalar($) { print "got $_[0]\n" }
           want_scalar("ok");
           my @a = qw(totally broken);
           want_scalar(@a);
  '

I get:

  got ok
  got 2

And using "sub want_list(@)" basically does nothing at all (you can pass
nothing, a scalar, or a list).

For more details, read:

 http://www.perlmonks.org/?node_id=861966

(If you're impatient, skip to the section "Problems with Regular
Prototypes").

-Peff
