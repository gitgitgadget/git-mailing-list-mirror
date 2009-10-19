From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Mon, 19 Oct 2009 02:34:46 -0400
Message-ID: <20091019063446.GA1457@coredump.intra.peff.net>
References: <20091014222628.GK6115@genesis.frugalware.org>
 <20091014230434.GB29664@coredump.intra.peff.net>
 <20091019000900.GV6115@genesis.frugalware.org>
 <20091019043418.GD7170@coredump.intra.peff.net>
 <20091019050456.GA15706@coredump.intra.peff.net>
 <7vbpk4aqop.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:35:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzlpq-0007um-4u
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 08:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbZJSGep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 02:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbZJSGep
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 02:34:45 -0400
Received: from peff.net ([208.65.91.99]:58859 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649AbZJSGeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 02:34:44 -0400
Received: (qmail 15254 invoked by uid 107); 19 Oct 2009 06:38:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 02:38:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 02:34:46 -0400
Content-Disposition: inline
In-Reply-To: <7vbpk4aqop.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130660>

On Sun, Oct 18, 2009 at 10:38:46PM -0700, Junio C Hamano wrote:

> > -*NOTE*: Obviously, if you change anything else than the first character
> > -on lines beginning with a space or a minus, the patch will no longer
> > -apply.
> > +The intent of this option is to pick and choose lines of the diff to
> 
> I'd slightly prefer "patch" over "diff" in this context.

Sure, I have no problem with that.

> > +apply, or even to modify the contents of lines to be staged. There are
> > +three line types in a diff: addition lines (beginning with a plus),
> > +removal lines (beginning with a minus), and context lines (beginning
> > +with a space). In general, it should be safe to:
> > ++
> > +--
> > +* remove addition lines (don't stage the line)
> 
> This is more like "don't add the line", isn't it?  Also if this "+" line
> has corresponding "-" line (i.e. it is a "rewrite to this" line), removal
> of such a line would mean "instead of rewriting, remove it".

I was trying not to use "add" because we are already talking about
addition and removal in the patch itself, and I thought it made sense to
map those actions to what the user is conceptually doing (staging or not
staging). Of course, I used "remove" which has a similar problem (you
are removing the addition of the line to the index); probably "delete"
would have been better. So I am not sure I agree that using "add" is any
better than "stage", but I don't feel that strongly about it.

But beyond that, yes, you are right that removing a "+" line may have a
different conceptual meaning to the user depending on the surrounding
text. I wonder if such a "check-list" document really makes much sense,
given that using "-e" at all means you need to understand the patch
format and what makes sense (i.e., anybody who understands 'patch' knows
that you can't just delete context lines and expect it to apply).

> Obviously, the above patch is what "diff --cached" would show after such
> an "add -e", but this does _not_ touch anything in the work tree (which is
> correct; add is about moving changed contents to the index and it should
> fundamentally not affect work tree).  As a result, "diff" between the
> index and the work tree now would read like this:
> 
>     diff --git a/t-f b/t-f
>     index 17c3f0b..d68dd40 100644
>     --- a/t-f
>     +++ b/t-f
>     @@ -1,3 +1,4 @@
>      a
>     -e
>     +b
>     +c
>      d
> 
> IOW, your request to "add -e" was "I do not want to put the addition of
> 'c' in the index at this point (that is why you removed '+c')" and "I do
> not want to put the addition of 'b' in the index; I want 'e' instead (that
> is why you changed '+b' to '+e')".  After "add -e" granted both requests,
> what is left in the work tree can confuse the user.  The "not at this

Yeah, again, this comes down to understanding what you are doing:
applying a patch to the index. So it really requires that the user
understand what that means. Maybe instead of trying to enumerate cases
and their effects, we should just say sometihng like "this is a patch to
the index. While you can make arbitrary changes, keep in mind that (1)
your changes must apply to the content in the index, and (2) any new
changes you introduce in the patch will not be reflected in the working
tree".

-Peff
