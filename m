From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 04:16:26 -0500
Message-ID: <20141212091625.GA9049@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <20141210091815.GA18372@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 10:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzML1-0007fl-E1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 10:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934513AbaLLJQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 04:16:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:52069 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933200AbaLLJQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 04:16:28 -0500
Received: (qmail 20974 invoked by uid 102); 12 Dec 2014 09:16:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 03:16:28 -0600
Received: (qmail 9801 invoked by uid 107); 12 Dec 2014 09:16:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 04:16:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 04:16:26 -0500
Content-Disposition: inline
In-Reply-To: <20141210091815.GA18372@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261345>

On Wed, Dec 10, 2014 at 01:18:15AM -0800, Jonathan Nieder wrote:

> > That seems like wishful thinking to me. Some subset of developers will
> > be happy reading the documentation in the header file, and will not
> > commonly run the tool. Therefore they will also not bother to examine
> > the output of the tool when making a change (either because they forget,
> > or because it is simply a hassle that they do not care about).
> 
> That is okay as long as enough people extract documentation to ensure
> the result is sane.

I have a guess that the "subset" I mentioned above is "most", but I
admit that is my intuition, not backed up by data.

> >                               The api-* files have slowly grown out of
> > date over the years, and I believe that is because they are too far
> > removed from the code people are actually touching.
> 
> I don't think they ever were very comprehensive or up to date.

Surely at least some of them were up to date when they were first
written? Take api-strbuf, for example. It started in dd613e6b, which
claims almost complete coverage. And then it slowly grew stale as
functions were added and not documented.

> As far as I understand, the api-* files are intended to be usually out
> of date.  Their main purpose is to explain the gist of how to use the
> API.  They were usually written way after the API was introduced (so
> they are behind already).  They are clearly written and as long as
> they mostly match the code, that is enough for them to be useful and
> educational.

I'm not sure any such thought as "intended to be out of date" went into
it. I think it was more "geez, these really need some documentation at
all". Out-of-date documentation can be dangerous and misleading, and is
one of the reasons I think it is a good idea to keep the documentation
closer to the code. It's not a silver bullet, but it helps make it more
obvious when both need to be updated.

> Then every few years or so, someone updates the file with the latest
> API changes, still with an eye to overall organization and readability
> of the document.

Again, look at api-strbuf.txt. The changes after the initial checkin are
almost entirely adding functions to the giant list. They are (hopefully)
added to the most appropriate spot, but that is also (again, hopefully)
done in the header file, too. I don't see any real effort towards
organization or readability.

Maybe I'm not understanding what you mean by organization or
readability. It seems to me like the api docs look like:

  some intro text and overall description

  some header (optional)

   - some-func

     description of some-func

   - some-func2

     description of some-func2


and I am proposing basically:

  /*
   * some intro text and overall description
   */

  /* some header (optional) */

  /* description of some-func */
  int some_func(...);

  /* description of some-func2 */
  int some_func2(...);

The readability and organization of those do not seem substantially
different to me.

> > I did drop some asciidoc-specific formatting from the main text (e.g.,
> > "+" lines for connecting blocks), which means that extracting the result
> > and running it through asciidoc won't work.
> 
> This unfortunately lost some structure (e.g., which paragraphs were
> part of the same bulleted list).  It would be more common to use a
> hanging indent:
> 
>  - The `buf` member is never NULL, so ...
>    string operations ...
>    by `strbuf_init()` ...
> 
>    Do not assume anything about what `buf` really is ...
>    ...
> 
>  - ...

Yeah, I think a hanging indent would be fine. I didn't actually spend
much effort on formatting. My point was to say "is this really so bad to
read inline?"

We could stick with asciidoc, too, but I really would like to keep the
barrier to writing documentation as low as possible, in order to
encourage it happening. I find that asciidoc syntax often ends up making
both writing and reading the source more tedious than it needs to be.

> >                                             I think it makes the actual
> > text much more readable, though. But we could do it the other way if
> > people really want to asciidoc it.
> 
> I also don't mind losing the asciidoc markup, especially given that it
> would be a pain to reconstruct and render.

I'm not sure it would be that hard if you can extract to text (which you
seem to want). But in the patch I posted (and the outline I showed
above), I chose to turn:

   foo::
      description of foo

into just:

   /* description of foo */
   void foo(void);

to avoid writers having to repeat themselves. But it does mean that the
extracted comments do not stand alone. You can either hack your own
parser (which is what doxygen does), or build something on top of a real
parser (there is cldoc, which uses libclang to extract comments next to
declarations).

That's why I suggested the possibility of punting on extraction
entirely, and just treating the header file as both the source and
finished document.

> My reaction at first glance is that this is trying to do something
> good but the current implementation is less readable than
> Documentation/technical/api-strbuf.txt.  Am I looking at a work in
> progress, or is this meant to be ready for application?  Which aspects
> would you be interested in comments on?

It was more "this is the direction I think we should go, and I will try
to implement a complete conversion to convince myself and others that I
am not forgetting any corner case". I probably should have given the
"outline" I gave above along with it.

I think the end result that I posted is still strictly better than what
we have currently, with the exception that I should have reformatted the
hanging indents. What is it that you don't like about it?

I'm not super interested in going back and forth over minor markup
issues if there are overall issues with the concept that might block it
from happening (just because they are tedious and time-consuming, and I
do not want to spend a lot of time formatting something that will get
thrown away). So please list your complaints in order of increasing
specificity. :)

-Peff
