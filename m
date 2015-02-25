From: Jeff King <peff@peff.net>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 25 Feb 2015 13:51:28 -0500
Message-ID: <20150225185128.GA16569@peff.net>
References: <54EDBEC2.8090107@peralex.com>
 <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
 <20150225143116.GA13567@peff.net>
 <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Noel Grandin <noel@peralex.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:51:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQh3X-0002A0-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 19:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbbBYSvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 13:51:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:53262 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753189AbbBYSvb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 13:51:31 -0500
Received: (qmail 7571 invoked by uid 102); 25 Feb 2015 18:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 12:51:30 -0600
Received: (qmail 17551 invoked by uid 107); 25 Feb 2015 18:51:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Feb 2015 13:51:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2015 13:51:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264402>

On Wed, Feb 25, 2015 at 10:33:53AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If it's an attribute of the file, and not the request, maybe
> > gitattributes would be a better fit. You can already do this with:
> >
> >   *.foo -diff
> >
> > in your .gitattributes file, though that _also_ marks the files as "not
> > for diffing", which may not be desired. There's not a separate "grep"
> > attribute, but I do not think it would be unreasonable to add one.
> 
> I have a vague recollection of having a discussion that started with
> something like this:
> 
>     "diff" is named as if it is only for "diff" for historical
>     reasons, but it is about "do we want to treat its raw contents
>     as text?"

Yes, I think we had this discussion, and agreed that is a reasonable
definition...

> I do not recall its conclusion, but it it were "Yes, that is what it
> means", then it might be reasonable to:
> 
>  - have "git grep" ignore paths marked with -diff by default
>    (perhaps "-a" option to disable, just like GNU)

...which led to 41b59bf (grep: respect diff attributes for binary-ness,
2012-02-02)...

>  - have "git grep" pay attention to diff.textconv and search in the
>    result of textconv filter.

..and 335ec3b (grep: allow to use textconv filters, 2013-05-10).

So I think _if_ using "diff" attributes is enough for this purpose, then
there is no code to be written. But if somebody wants to draw a
distinction between the uses (I want to diff "foo" files, but never see
them in grep) then we could introduce a "grep" attribute (with the
fallback being the value of the "diff" attribute for that path).

-Peff
