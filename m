From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/2] log: add "--no-show-signature" command line
 option
Date: Fri, 27 May 2016 13:48:08 -0400
Message-ID: <20160527174807.GA1614@sigill.intra.peff.net>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
 <20160526130647.27001-3-mehul.jain2029@gmail.com>
 <20160526163241.GC18210@sigill.intra.peff.net>
 <xmqqiny0wx8m.fsf@gitster.mtv.corp.google.com>
 <CA+DCAeTnkTRnmscduio1-buKd2gNcaScYkLY7YfEQ+_Cm=Z28Q@mail.gmail.com>
 <xmqq4m9js8qb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 19:48:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Lrr-0004Cl-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbcE0RsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:48:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:45329 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932320AbcE0RsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:48:11 -0400
Received: (qmail 4673 invoked by uid 102); 27 May 2016 17:48:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 13:48:10 -0400
Received: (qmail 30792 invoked by uid 107); 27 May 2016 17:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 13:48:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2016 13:48:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4m9js8qb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295777>

On Fri, May 27, 2016 at 10:37:16AM -0700, Junio C Hamano wrote:

> Mehul Jain <mehul.jain2029@gmail.com> writes:
> 
> > On Thu, May 26, 2016 at 10:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> The only reason why teaching the "--no-show-signature" option to
> >> these commands is a good idea is because it would help people who
> >> create an alias with "--show-sig" in early part of the command line,
> >> e.g.
> >>
> >>         [alias] fp = format-patch --show-signature
> >>
> >> by allowing them to countermand with --no-show-signature, i.e.
> >>
> >>         $ git fp --no-show-signature ...
> >> ...
> >
> > Just out of curiosity, I was thinking that we might be able to teach
> > "--no-show-signature" option only to git-show, git-log, git-whatchanged
> > and git-reflog.
> 
> Yeah, I know it is possible with extra code, but I do not think of a
> good reason why it is necessary.

Not only "not necessary" but "actively worse" in my opinion. We have
--show-signature in revision.c, and that is reason enough to have
--no-show-signature, in case anybody would want to countermand an
earlier request (whether from config that is soon to exist, or from a
previous --show-signature on the command line), or just because somebody
feels like making sure git is doing what they want without bothering to
check the defaults.

We add the "--no-" form by default for all of our bools parsed by
parse-options. The only reason it is not already here is that this
option parsing predates our use of parse-options, and nobody had
bothered to go back and add it. But doing so is a win simply for
consistency if nothing else, IMHO.

I actually think it would be nice to convert all of handle_revision_opt
to parse-options, but that's a non-trivial task. And I certainly
wouldn't want it to hold up this otherwise simple topic.

-Peff
