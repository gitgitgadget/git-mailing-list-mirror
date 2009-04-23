From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] remote.c: silently tolerate single-level keys like remote.default
Date: Thu, 23 Apr 2009 20:37:26 +0200
Message-ID: <200904232037.27095.j6t@kdbg.org>
References: <1240494546-25775-1-git-send-email-j6t@kdbg.org> <20090423164008.GA26346@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:39:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3pj-0002qq-94
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369AbZDWShd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756685AbZDWShc
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:37:32 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56461 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755195AbZDWShc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:37:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9611E2C4020;
	Thu, 23 Apr 2009 20:37:27 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 92F8D3B3F7;
	Thu, 23 Apr 2009 20:37:27 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090423164008.GA26346@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117360>

On Donnerstag, 23. April 2009, Jeff King wrote:
> On Thu, Apr 23, 2009 at 03:49:05PM +0200, Johannes Sixt wrote:
> > Typos in configuration keys usually do not hurt because they never match
> > in look-ups. But this case is different: it does match, but it does not
> > have the expected format. With this patch this situation is treated more
> > like a typo.
>
> I definitely think causing the command to fail is bad, but should we
> perhaps still warn the user? I know that we can't catch _every_ typo in
> the config, but if there is something obviously wrong that we've
> detected, it is nice to let the user know.
>
> > -		return error("Config with no key for remote %s", name);
> > +		return 0;
>
> IOW,
>
>   + warn("Config with no key for remote %s", name);
>   + return 0;

I don't like this. This would warn in a number of situations where it's not 
obvious that remotes are involved, for example in 'git status'.

Also observe (and I forgot to mention that in the commit message) that this 
same exit

   if (!subkey)
        return 0;

is also taken for url.foo and branch.foo configurations a few lines above this 
change.

-- Hannes
