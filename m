From: Jeff King <peff@peff.net>
Subject: Re: Keep original author with git merge --squash?
Date: Fri, 13 Feb 2015 14:55:28 -0500
Message-ID: <20150213195528.GA15107@peff.net>
References: <20150212092824.GA19626@peff.net>
 <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
 <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
 <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
 <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
 <xmqq4mqqrc70.fsf@gitster.dls.corp.google.com>
 <20150212225003.GA20763@peff.net>
 <xmqqwq3mogdm.fsf@gitster.dls.corp.google.com>
 <20150213071041.GA26775@peff.net>
 <xmqq1tltobgy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 20:55:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMMKu-0005L4-4s
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 20:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbbBMTzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 14:55:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:48828 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752071AbbBMTzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 14:55:31 -0500
Received: (qmail 2451 invoked by uid 102); 13 Feb 2015 19:55:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 13:55:31 -0600
Received: (qmail 4497 invoked by uid 107); 13 Feb 2015 19:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 14:55:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2015 14:55:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tltobgy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263826>

On Fri, Feb 13, 2015 at 11:30:53AM -0800, Junio C Hamano wrote:

> > This case collapses nicely if we make a slight tweak to your proposed
> > behavior (or maybe this is what you meant). If there are multiple
> > authors listed, we behave as if none was listed. That would leave the
> > authorship as it behaves today (with the author of the first commit) if
> > you do nothing, or you can override it by dropping all but one.
> 
> I actually was (and am still) wondering that "silently ignore all of
> them if there are multiple ones that contradict with each other" is
> a bad idea, and that was why the last item on the "possible
> alternatives" list was to error out and ask clarification.

Normally I like "error out and ask the user" as an approach to avoiding
mistakes, but I can think of two bad side effects:

  1. If we pre-populate the "# Author:" lines in "git merge --squash",
     then if I run "git commit" on the result and don't explicitly take
     an action to clean up those comment fields, I get an error.  That's
     kind of annoying.

  2. Dumping the user out of "git commit" with an error isn't very
     elegant. They may have put significant work into writing the commit
     message. It's saved there in COMMIT_EDITMSG, but what is the easy
     path to them repeating their action where they left off?

It seems like the potential for confusion comes from the same place as
my complaint (1) above: the implicit-ness of the "# Author:" lines (git
writes them, assumes you've looked at and manipulated them to your
liking, and then reads them back in).

What if there was a step required of the user to say "really, I want to
use this one"? Like converting s/Author/Set-Author/, or taking away the
"#" comment character (though that has its own confusions, as you noted
earlier).

-Peff
