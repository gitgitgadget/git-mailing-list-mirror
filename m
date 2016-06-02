From: Eric Wong <e@80x24.org>
Subject: Re: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Thu, 2 Jun 2016 19:58:55 +0000
Message-ID: <20160602195855.GA17627@dcvr.yhbt.net>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527140104.11192-2-samuel.groot@grenoble-inp.org>
 <vpqeg8mi4wm.fsf@anie.imag.fr>
 <20160528233329.GA1132@dcvr.yhbt.net>
 <9535d962-5479-5a13-472e-cd558ef163e0@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:58:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8YlB-0000n0-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbcFBT6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:58:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56034 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbcFBT6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:58:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8A51FAB2;
	Thu,  2 Jun 2016 19:58:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9535d962-5479-5a13-472e-cd558ef163e0@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296232>

Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
> On 05/29/2016 01:33 AM, Eric Wong wrote:
> >Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> >>Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
> >>
> >>>Parsing and processing in send-email is done in the same loop.
> >>>
> >>>To make the code more maintainable, we create two subroutines:
> >>>- `parse_email` to separate header and body
> >>>- `parse_header` to retrieve data from header
> >>
> >>These routines are not specific to git send-email, nor to Git.
> >>
> >>Does it make sense to use an external library, like
> >>http://search.cpan.org/~rjbs/Email-Simple-2.210/lib/Email/Simple.pm ,
> >>either by depending on it, or by copying it in Git's source tree ?
> >
> >That might be overkill and increase installation/maintenance
> >burden.  Bundling it would probably be problematic to distros,
> >too.
> 
> We have 5 solutions here:
> 
>   1. Make a new dependence to Email::Simple.
> 
>   2. Bundle Email::Simple in Git's source tree.
> 
>   3. Use Email::Simple if installed, else use our library.
> 
>   4. Making our own email parser library.
> 
>   5. Duplicate parser loop as we did for our patch to implement
>      `--quote-email` as proposed in $gmane/295772 .
> 
> Obviously, option (5) is the easiest one for us, but it leaves refactoring
> for later, and option (1) is also easier but adds a new dependence which is
> not that good.

I would go with (5) for now and leave (4) for later (which
might just be moving the function to a new file).

> Since our project ends next week, we might not have enough time to finish
> developing a custom parser API so (4) is not a viable option for now but
> could be done in the future.
> 
> We could consider bundling Email::Simple as the best option, as it's
> developed since 2003 and might be safer to use than anything we could write
> in several weeks.

In an ideal world, (1) would be nice.  But (IMHO) git-send-email
should remain installable on non-ideal systems which do not
provide Email::Simple as a package.

(2) would probably be non-ideal for distro maintainers
(+Cc: Jonathan for opinions), and (3) is the most complex
and difficult-to-support.
