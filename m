From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/WIP 6/8] am: extract patch, message and authorship with
 git-mailinfo
Date: Wed, 27 May 2015 18:13:56 -0400
Message-ID: <20150527221356.GE23259@peff.net>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
 <1432733618-25629-7-git-send-email-pyokagan@gmail.com>
 <xmqqtwuxkaxh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 00:14:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjaO-0001wo-Cm
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbbE0WN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:13:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:36956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752008AbbE0WN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:13:59 -0400
Received: (qmail 17871 invoked by uid 102); 27 May 2015 22:13:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:13:59 -0500
Received: (qmail 11192 invoked by uid 107); 27 May 2015 22:14:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 18:14:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 18:13:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwuxkaxh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270110>

On Wed, May 27, 2015 at 01:44:26PM -0700, Junio C Hamano wrote:

> Paul Tan <pyokagan@gmail.com> writes:
> 
> > @@ -17,6 +34,10 @@ struct am_state {
> >  	struct strbuf dir;            /* state directory path */
> >  	int cur;                      /* current patch number */
> >  	int last;                     /* last patch number */
> > +	struct strbuf msg;            /* commit message */
> > +	struct strbuf author_name;    /* commit author's name */
> > +	struct strbuf author_email;   /* commit author's email */
> > +	struct strbuf author_date;    /* commit author's date */
> >  	int prec;                     /* number of digits in patch filename */
> >  };
> 
> I always get suspicious when structure fields are overly commented,
> wondering if it is a sign of naming fields poorly.  All of the above
> fields look quite self-explanatory and I am not sure if it is worth
> having these comments, spending efforts to type SP many times to
> align them and all.

Just my 2 cents, but I think that grouping and overhead comments can
often make things more obvious. For example:

  struct am_state {
	/* state directory path */
	struct strbuf dir;

	/*
	 * current and last patch numbers; are these 1-indexed
	 * or 0-indexed?
	 */
	int cur;
	int last;

	struct strbuf author_name;
	struct strbuf author_email;
	struct strbuf author_date;
	struct strbuf msg;

	/* number of digits in patch filename */
	int prec;
  }

Note that by grouping "cur" and "last", we can discuss them as a group,
and the overhead comment gives us room to mention their shared
properties (my indexing question is a real question, btw, whose answer I
think would be useful to mention in a comment).

Likewise, by grouping the "msg" strbuf with the author information, it
becomes much more clear that they are all about the commit metadata
(though I would not be opposed to a comment above the whole block,
either).

-Peff
