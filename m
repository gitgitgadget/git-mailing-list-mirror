From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 08 May 2007 20:16:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705082010230.24220@xanadu.home>
References: <4640FBDE.1000609@gmail.com>
 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 02:16:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZrF-0005z9-2J
	for gcvg-git@gmane.org; Wed, 09 May 2007 02:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967353AbXEIAQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 20:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934941AbXEIAQd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 20:16:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8570 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934142AbXEIAQc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 20:16:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ00BI2ZFIHOA0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 20:16:30 -0400 (EDT)
In-reply-to: <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46643>

On Tue, 8 May 2007, Junio C Hamano wrote:

> Dana How <danahow@gmail.com> writes:
> 
> > @@ -444,6 +446,10 @@ static unsigned long write_object(struct sha1file *f,
> >  				 * and we do not need to deltify it.
> >  				 */
> >  
> > +	/* differing core & pack compression when loose object -> must recompress */
> > +	if (!entry->in_pack && pack_compression_level != zlib_compression_level)
> > +		to_reuse = 0;
> > +	else
> 
> I am not sure if that is worth it, as you do not know if the
> loose object you are looking at were compressed with the current
> settings.

I was about to make the same comment.

> > diff --git a/cache.h b/cache.h
> > index 8e76152..2b3f359 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -283,6 +283,8 @@ extern int warn_ambiguous_refs;
> >  extern int shared_repository;
> >  extern const char *apply_default_whitespace;
> >  extern int zlib_compression_level;
> > +extern int core_compression_level;
> > +extern int core_compression_seen;
> 
> Could we somehow remove _seen?  Perhaps by initializing the
> _level to -1?

-1 is a valid value for compression.  Actually it is equivalent to 
Z_DEFAULT_COMPRESSION.

If we want the fallback logic to work, at some point we must remember if 
the current value is the default or if it is the result of an explicit 
config option.


Nicolas
