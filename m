From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Documentation fixes in git-config
Date: Thu, 1 Mar 2012 04:08:28 -0500
Message-ID: <20120301090828.GA16033@sigill.intra.peff.net>
References: <20110108144644.GA11019@localhost.suse.cz>
 <20110111055922.GD10094@sigill.intra.peff.net>
 <20110119100105.GB8034@fm.suse.cz>
 <20110119141401.GE8034@fm.suse.cz>
 <20110121002716.GC9442@sigill.intra.peff.net>
 <20110121102048.GF19715@fm.suse.cz>
 <20110121102537.GH19715@fm.suse.cz>
 <20120301081941.GA31079@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:08:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S320F-0004k6-CL
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 10:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758744Ab2CAJIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 04:08:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33994
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965066Ab2CAJIb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 04:08:31 -0500
Received: (qmail 2608 invoked by uid 107); 1 Mar 2012 09:08:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Mar 2012 04:08:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2012 04:08:28 -0500
Content-Disposition: inline
In-Reply-To: <20120301081941.GA31079@fm.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191909>

On Thu, Mar 01, 2012 at 09:19:42AM +0100, Libor Pechacek wrote:

> Variable names must start with an alphabetic character, regexp config key
> matching has its limits.
> [...]
> This patch has fallen through the cracks, therefore I re-send it.  Previous
> discussion about this patch is at http://www.spinics.net/lists/git/msg149593.html.
> The only change I've done since version 2 of this patch is replacing
> apostrophes with backticks in the first hunk.

Wow, it's been a while. :)

Generally it looks OK to me, but I have two comments:

>  Syntax
>  ~~~~~~
> @@ -54,9 +55,10 @@ All the other lines (and the remainder of the line after the section
>  header) are recognized as setting variables, in the form
>  'name = value'.  If there is no equal sign on the line, the entire line
>  is taken as 'name' and the variable is recognized as boolean "true".
> -The variable names are case-insensitive and only alphanumeric
> -characters and `-` are allowed.  There can be more than one value
> -for a given variable; we say then that variable is multivalued.
> +The variable names are case-insensitive, allow only alphanumeric characters
> +and `-`, and must start with an alphabetic character.  There can be more
> +than one value for a given variable; we say then that variable is
> +multivalued.

Not an error you introduced, but should it be "...we say then that _the_
variable is multivalued".

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index aa8303b..a54fee8 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -85,8 +85,13 @@ OPTIONS
>  	is not exactly one.
>  
>  --get-regexp::
> -	Like --get-all, but interprets the name as a regular expression.
> -	Also outputs the key names.
> +	Like --get-all, but interprets the name as a regular expression and
> +	writes out the key names.  Regular expression matching is currently
> +	case-sensitive and done against a canonicalized version of the key
> +	in which section and variable names are lowercased, but subsection
> +	names are not.  Regular expressions are partially lower-cased
> +	before matching (everything before the first dot and after the last
> +	dot), which makes things like "Core.*' work.

I know I ack'ed this last time around, but reading it fresh, I think we
are probably better off to just not mention the down-casing at all. It's
just confusing, and people shouldn't depend on it. They should know that
they are comparing against the canonical name, and should use lowercase
in their regex. I.e., just cut out the last sentence from there.

-Peff
