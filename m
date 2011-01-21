From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH] Sanity-ckeck config variable names
Date: Fri, 21 Jan 2011 11:02:12 +0100
Message-ID: <20110121100212.GE19715@fm.suse.cz>
References: <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz> <20110119141112.GD8034@fm.suse.cz> <20110120232232.GA9442@sigill.intra.peff.net> <20110121000629.GA7773@sigill.intra.peff.net> <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz> <20110119141112.GD8034@fm.suse.cz> <20110120232232.GA9442@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 11:02:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgDp0-00053D-Dh
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 11:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab1AUKCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 05:02:14 -0500
Received: from cantor.suse.de ([195.135.220.2]:37466 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab1AUKCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 05:02:13 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7DB2C8E8CC;
	Fri, 21 Jan 2011 11:02:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110121000629.GA7773@sigill.intra.peff.net> <20110120232232.GA9442@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165360>

On Thu 20-01-11 18:22:32, Jeff King wrote:
> > + * Returns 0 on success, 1 when there is an invalid character in the key and 2
> > + * if there is no section name in the key.
> 
> Please switch these to -1 and -2, as we generally use negative integers
> to indicate errors in library-ish function.

Done.

> Other than that, the code looks OK to me. However, it does cause
> t1300.85 to fail.

Thanks for catching it, added your changes to the patch and tested.  I didn't
notice the test suite. :)

On Thu 20-01-11 19:06:29, Jeff King wrote:
> Doesn't this hunk:
> 
> > @@ -168,10 +167,6 @@ static int get_value(const char *key_, const char *regex_)
> >       }
> >  
> >       key = xstrdup(key_);
> > -     for (tl=key+strlen(key)-1; tl >= key && *tl != '.'; --tl)
> > -             *tl = tolower(*tl);
> > -     for (tl=key; *tl && *tl != '.'; ++tl)
> > -             *tl = tolower(*tl);
> 
> Mean that regexp keys no longer get downcased properly? I.e.,
> 
>   git config Foo.value true
>   git config --get-regexp 'foo.*'
>   git config --get-regexp 'Foo.*'
> 
> used to work for both lookups, but now fails for the second one?

After thinking about it I added the code back.  More on it in the
"documentation fix" thread.

Thanks for your kind guidance.

Libor
-- 
Libor Pechacek
SUSE L3 Team, Prague
