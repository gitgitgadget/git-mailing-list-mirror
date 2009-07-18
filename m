From: Jeff King <peff@peff.net>
Subject: Re: git silently ignores aliases of existing commands
Date: Sat, 18 Jul 2009 06:46:31 -0400
Message-ID: <20090718104631.GA27307@coredump.intra.peff.net>
References: <4A611CE1.3080709@pobox.com>
 <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
 <4A6176E6.4060708@pobox.com>
 <9b18b3110907180230p7fb432cdq56bfee794afc669e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael G Schwern <schwern@pobox.com>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 12:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS7RG-0005m9-C9
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 12:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbZGRKqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 06:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758131AbZGRKqj
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 06:46:39 -0400
Received: from peff.net ([208.65.91.99]:48186 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758129AbZGRKqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 06:46:38 -0400
Received: (qmail 31942 invoked by uid 107); 18 Jul 2009 10:48:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 18 Jul 2009 06:48:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Jul 2009 06:46:31 -0400
Content-Disposition: inline
In-Reply-To: <9b18b3110907180230p7fb432cdq56bfee794afc669e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123514>

On Sat, Jul 18, 2009 at 11:30:25AM +0200, demerphq wrote:

> Yeah it seems reasonable that if its going to be ignored it should not
> be silently ignored.

I agree that there should be a warning. However, it's hard to do with
the code structured as it is now; we don't know that a command exists
as an external command until we try to exec it. And if it succeeds, we
don't get to execute any more code.

It's certainly possible, but sadly it is more surgery than just

  if (alias_lookup(cmd))
    warn("you also have an alias defined");

> Especially given that the silentness effectively means there cant be
> any new git tools added without possible breakage of installed setups.

The silentness makes it harder to diagnose problems, but even with a
warning, we can break things by creating new commands. If you have an
alias "foo" and we ship "git-foo" in a newer version of git, your alias
will just stop working.

-Peff
