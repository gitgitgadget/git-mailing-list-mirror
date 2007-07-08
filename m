From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make fetch-pack a builtin with an internal API
Date: Sun, 8 Jul 2007 19:12:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707081841160.6977@iabervon.org>
References: <Pine.LNX.4.64.0707081551120.6977@iabervon.org>
 <7vsl7yzfkg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 01:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7fvT-0001NM-9t
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 01:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXGHXMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 19:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbXGHXMT
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 19:12:19 -0400
Received: from iabervon.org ([66.92.72.58]:2327 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbXGHXMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 19:12:19 -0400
Received: (qmail 25213 invoked by uid 1000); 8 Jul 2007 23:12:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jul 2007 23:12:18 -0000
In-Reply-To: <7vsl7yzfkg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51934>

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > In addition to making fetch-pack a builtin, this allows it to be called 
> > directly from other built-in code without generating and parsing argument 
> > lists, which will be useful for builtin-fetch.
> >
> > Incidently, it makes git-fetch-pack not output lists of what it fetched 
> > when it fails.
> 
> That sounds sensible.
> 
> Hmmm.  incidentally it seems to do a bit more than that.
> 
> > @@ -663,15 +659,42 @@ static int fetch_pack_config(const char *var, const char *value)
> >  
> >  static struct lock_file lock;
> >  
> > -int main(int argc, char **argv)
> > +void setup_fetch_pack(const char *_uploadpack,
> > ...
> > +#if 0
> > +	git_config(fetch_pack_config);
> > +
> > +	if (0 <= transfer_unpack_limit)
> > +		unpack_limit = transfer_unpack_limit;
> > +	else if (0 <= fetch_unpack_limit)
> > +		unpack_limit = fetch_unpack_limit;
> > +#endif
> > +}
> 
> This has been moved elsewhere?  I do not see how the code now
> honors the configuration.

It's at the beginning of cmd_fetch_pack() for the case of running it from 
the command line, but it should probably also be an argument to 
setup_fetch_pack(). Got it added to my revisions, and I'll send out a new 
version once people have looked over this further.

	-Daniel
*This .sig left intentionally blank*
