From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v3] Sanity-check config variable names
Date: Fri, 28 Jan 2011 15:53:23 +0100
Message-ID: <20110128145323.GE1849@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz> <20110119141112.GD8034@fm.suse.cz> <20110120232232.GA9442@sigill.intra.peff.net> <20110121100212.GE19715@fm.suse.cz> <20110121102339.GG19715@fm.suse.cz> <20110121162318.GC21840@sigill.intra.peff.net> <20110127142815.GC6312@fm.suse.cz> <7voc72ge4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 15:53:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiphZ-0000JS-T8
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 15:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab1A1Ox0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 09:53:26 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54739 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab1A1OxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 09:53:25 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id ECC078A95F;
	Fri, 28 Jan 2011 15:53:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7voc72ge4j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165618>

On Thu 27-01-11 14:45:16, Junio C Hamano wrote:
> Libor Pechacek <lpechacek@suse.cz> writes:
> > Fixed the typo and return values from get_value and git_config_set_multivar.
> > We have changed git_config_parse_key to return negative values on error, but
> > forgot to negate the numbers when returning them as exit codes.
> 
> Earlier get_value() returned:
> 
>  -1: when it saw an uncompilable regexp (either in key or value);
>   0: when a value was available (under --all) or unique (without --all);
>   1: when the requested variable is missing; and
>   2: when the requested variable is multivalued under --all.

Fixed one part with the last change and broke the other one.  Thanks for
catching it.  The same return value for "invalid key" and "invalid regex" is OK
for me.

BTW is it OK to exit(-1);?  The return value of get_value() gets propagated to
the process exit status.  At the same time shell uses values >128 to indicate
that the process was terminated by a signal.

[...]
> When moving an existing code segment around like this, I would not mind to
> see style fixes thrown in to the patch, as long as the moved code is small
> enough.  Perhaps like this:

I've added the style fix into the patch.

[...]
> > +/* Auxiliary function to sanity-check and split the key into the section
> 
> 	/*
>        * Style. We write our multi-line comments
> 	 * like this.
>        */

Fixed.

> > +int git_config_parse_key(const char *key, char **store_key, int *baselen_)
[...]
> 
> Does it make sense for this function to be prepared to get called with
> NULL in store_key like this (and in the remainder of your patch)?

No, I wrote it unnecessarily generic.  Removed the excess code.  Thanks for
pointing it out.

[...]
> > +	test_must_fail git -c name=value config core.name
> >  '
> 
> Don't you want to make sure that your sanity check triggers in new tests?

Added a few tests after getting familiar with the test suite.

Libor
-- 
Libor Pechacek
SUSE L3 Team, Prague
