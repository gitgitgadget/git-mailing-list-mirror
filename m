From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH] Documentation fixes in git-config
Date: Fri, 21 Jan 2011 11:20:48 +0100
Message-ID: <20110121102048.GF19715@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz> <20110119141401.GE8034@fm.suse.cz> <20110121002716.GC9442@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 11:21:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgE6z-0006Uf-B1
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 11:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab1AUKUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 05:20:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:38155 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab1AUKUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 05:20:49 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A94108E8CC;
	Fri, 21 Jan 2011 11:20:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110121002716.GC9442@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165432>

On Thu 20-01-11 19:27:16, Jeff King wrote:
> The intent of the change looks fine, but your sentence doesn't quite
> parse to me (to be fair, the problem is in the one you are replacing,
> but adding the third clause makes it even more confusing). How about:
> 
>   The variables names are case-insensitive, allow only alphanumeric
>   characters and '-', and must start with an alphabetic character.

I like that very much.  The original sentence sounded a little bit artificial
to me, and after my amendments it felt like a collapsed list of items.  This is
far more natural, thanks for help.

> >  --get-regexp::
> >  	Like --get-all, but interprets the name as a regular expression.
> > -	Also outputs the key names.
> > +	Regular expression matching is case sensitive in all parts of the key,
> > +	therefore make sure your pattern matches lower case letters in section
> > +	and variable names.  Also outputs the key names.
> 
> That is only true because of the breakage in your first patch. Without
> your patch, both of these work:
> 
>   git config --get-regexp 'Foo.*'
>   git config --get-regexp 'foo.*'
>
> That being said, the downcasing is extremely naive for regexps, and you
> should try to match the canonical name. The current downcasing behavior
> should probably stay for historical reasons, but is not well thought-out
> (it may even be accidental). Perhaps we should therefore explain it in
> those terms:
> 
>   Regular expression matching is case-sensitive and done against a
>   canonicalized version of the key in which section and variable names
>   are lowercased, but subsection names are not. For historical reasons,
>   some simple regular expressions are lower-cased before matching
>   (everything before the first dot and after the last dot), which makes
>   things like "Core.*' work.
> 
> I dunno. Maybe we should just declare "Core.*' to be broken, and anybody
> who was relying on it is wrong.

After thinking about it more, I realized that the goal is to have a "mixed
case-sensitivity" regexp matching.  The case sensitivity if of course
determined by the part of the key which is being processed, and not the pattern
itself.  That probably means changes in the regexp mathing sengine.

Declaring patterns like 'Core.*' invalid would be a step back in my opinion.

Therefore I've added the regexp lowercasing code back and documented the
limitation.  I believe it's fair to the users.

Updated patches will follow in a while.

Libor
-- 
Libor Pechacek
SUSE L3 Team, Prague
