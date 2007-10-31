From: Erik Warendorph <erik@warendorph.org>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 20:29:01 +0100
Message-ID: <20071031192901.GA12832@localhost.localdomain>
References: <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org> <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org> <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org> <20071030193610.GA4442@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Oct 31 20:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InJZP-00051V-T3
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 20:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbXJaTt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 15:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbXJaTt3
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 15:49:29 -0400
Received: from lakepoint.domeneshop.no ([194.63.248.54]:52835 "EHLO
	lakepoint.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbXJaTt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 15:49:28 -0400
X-Greylist: delayed 1138 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2007 15:49:28 EDT
Received: from localhost ([195.1.76.68])
	(authenticated bits=0)
	by lakepoint.domeneshop.no (8.13.8/8.13.8) with ESMTP id l9VJT1jW002345;
	Wed, 31 Oct 2007 20:29:01 +0100
Content-Disposition: inline
In-Reply-To: <20071030193610.GA4442@efreet.light.src>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62855>

* Jan Hudec <bulb@ucw.cz> [2007-10-30 20:36:10 +0100]:
>
> On Tue, Oct 30, 2007 at 07:59:45 -0700, Linus Torvalds wrote:
> > > So, how should git deal with
> > >
> > > git://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> > > git://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> > > git://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git
> >
> > The way it has always cared. Git itself does no quoting what-so-ever
> > (except for the *argument* quoting etc that it needs).
> >
> > Now, the *transport* back-end may end up quoting it, of course, the same
> > way it may end up using some random protocol. The user shouldn't care
> > about the implementation details!
> >
> > In the case of the git transport, there is no quoting even by the
> > transport protocol. In the case of http, libcurl would hopefully quote for
> > us.
>
> So the three addresses will all be different, right?
>
> > > compared to
> > >
> > > http://repo.or.cz/linux-2.6/linux acpi-2.6/ibm-acpi-2.6.git
> > > http://repo.or.cz/linux-2.6/linux+acpi-2.6/ibm-acpi-2.6.git
> > > http://repo.or.cz/linux-2.6/linux%20acpi-2.6/ibm-acpi-2.6.git
> >
> > No difference, what-so-ever, that I can see. Git doesn't quote it.
>
> Yes. But the server will unquote it. ' ' should not have been there, but it's
> just passed through if it was. '+' is quoting for ' ' and '%20' is quoting
> for ' ' as well. Therefore all these three addresses are the *SAME*.
>
> Now the user expectation will be that when these are the same, the git://
> ones above will be as well. But they are not. This is not about following any
> RFC for sake of it, but about being consistent with ourselves.

I don't think the

  '+' is quoting for ' '

part is fully correct, at least not if you're talking about
"real RFC 2396 URLs" (not "Git URLs").  I might misunderstand
you here, but there has also been other postings suggesting
that plus should/could be used instead of space, implying that
people think that pluses are always transformed to spaces in
URLs.  But if I understand RFC 2396 correctly, this is *not*
the case.

RFC 2396 says that pluses are treated as "reserved" in the
*query* part of the URL (ie on the right side of the question
mark) -- here they *are* transformed to spaces, although the
RFC itself doesn't really say specifically what happens to
them.  In the path part, pluses are not "reserved", they are
simply a "pchar" along with "unreserved", "escaped" and a
couple of other characters.  There is nothing in the RFC
implying that pluses in the path part will be transformed into
spaces, and in my experience this does not happen in practice
either.

To recap:

  (In the examples below <...> is used to mean legal URLs,
  while "..." is used to mean "the literal characters in the
  URL" (more or less))

  * In the query part:

      '%20' = '+' = a literal space
      '%2B' =       a literal plus

    For example:

        <http://example.com/somescript?v=x%20y>
      = <http://example.com/somescript?v=x+y>
      = "http://example.com/somescript?v=x y"

        <http://example.com/somescript?v=x%2By>
      = "http://example.com/somescript?v=x+y"

  * In the path part:

      '%20' =       a literal space
      '%2B' = '+' = a literal plus

    For example:

        <http://example.com/x%20y.html>
      = "http://example.com/x y.html"

        <http://example.com/x%2By>
      = <http://example.com/x+y>
      = "http://example.com/x+y"

I'm not advocating that "Git URLs" necessarily should be made
fully RFC 2396 compliant (neither am I nitpicking just for the
sake of nitpicking), I'm just pointing out that if someone
*should* want to make "Git URLs" fully or more RFC 2396
compliant in some way for some reason, having pluses being
automatically transformed to spaces in the path part of the URL
does not follow the RFC (as far as I understand it).

-- 
Erik Warendorph <erik@warendorph.org>
