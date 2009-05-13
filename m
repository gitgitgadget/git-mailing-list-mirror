From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 13:12:26 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905131212000.2147@iabervon.org>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>  <200905121557.18542.Hugo.Mildenberger@namir.de>  <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>  <200905121900.00625.Hugo.Mildenberger@namir.de>  <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
  <20090512172452.GA32594@blimp.localdomain>  <7vws8l7w0d.fsf@alter.siamese.dyndns.org>  <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com>  <alpine.LNX.2.00.0905131109240.2147@iabervon.org>
 <81b0412b0905130909x2ad67407p53ad6f79966c1ea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1023349589-1242234746=:2147"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 19:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4I12-0004Sb-T8
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760126AbZEMRM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 13:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759645AbZEMRM0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:12:26 -0400
Received: from iabervon.org ([66.92.72.58]:46197 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758950AbZEMRMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 13:12:25 -0400
Received: (qmail 26298 invoked by uid 1000); 13 May 2009 17:12:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2009 17:12:26 -0000
In-Reply-To: <81b0412b0905130909x2ad67407p53ad6f79966c1ea3@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119069>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1023349589-1242234746=:2147
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 May 2009, Alex Riesen wrote:

> 2009/5/13 Daniel Barkalow <barkalow@iabervon.org>:
> > On Wed, 13 May 2009, Alex Riesen wrote:
> >> 2009/5/13 Junio C Hamano <gitster@pobox.com>:
> >>
> >> > If it is just informational use only, then it might make more sense to
> >> > drop this ugly "quoted \n" silently.  I dunno.
> >>
> >> That'd mean to loose the information completely. Which is just as bad
> >> as putting the LF in the url in the first place.
> >
> > Looking back at the original message, it looks like the user included a
> > newline in an argument to clone, and the fetch must have stripped it out
> > (or ignored it in some other fashion), because data was retrieved from a
> > repository that doesn't have a newline in its name.
> 
> _That_ looks like a bug to me. We should have asked exactly the name
> we were given, or notify the user about what we have used for the url
> if we have ignored user's input and decided to use something else.
> Patches follow.
> 
> > ... Most likely, the
> > newline should just be prohibited in the URL in the config file in the
> > first place, and we shouldn't be able to get to the point of writing a
> > FETCH_HEAD with that value.
> 
> What I cannot understand is what's wrong with url containing an LF?
> Especially if we can handle it, all the tools can handle it, and putting
> LF in a filename is a long-standing UNIX tradition.

The RFC for URLs (which we don't actually follow particularly much) 
doesn't permit whitespace. Protocols that use URLs directly generally use 
newlines as control characters. For example, an HTTP request for:

http://host/path/with
newline/in/it

would parse as a request for "http://host/path/with" with an invalid 
header line. Normally, to refer to a resource whose name contains a 
newline, the URL contains "%0A" instead.

Of course, our "url" config can contain some things that aren't URLs, but 
this particular case was of the form that's supposed to be a standard URL.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1023349589-1242234746=:2147--
