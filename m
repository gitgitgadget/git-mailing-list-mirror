From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Do not send "want" lines for complete objects
Date: Fri, 21 Oct 2005 11:44:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510211139590.25300@iabervon.org>
References: <Pine.LNX.4.63.0510200004290.7689@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmp5xfwu.fsf@assigned-by-dhcp.cox.net> <7vwtk9vvhg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510200351260.26594@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0510200559540.3394@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510201630000.25300@iabervon.org>
 <Pine.LNX.4.63.0510210114370.10503@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 17:48:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESz4j-0005ca-EO
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 17:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVJUPoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 11:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVJUPoy
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 11:44:54 -0400
Received: from iabervon.org ([66.92.72.58]:42765 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964991AbVJUPox (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 11:44:53 -0400
Received: (qmail 19199 invoked by uid 1000); 21 Oct 2005 11:44:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2005 11:44:14 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510210114370.10503@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10437>

On Fri, 21 Oct 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 20 Oct 2005, Daniel Barkalow wrote:
> 
> > On Thu, 20 Oct 2005, Johannes Schindelin wrote:
> > 
> > > Hi,
> > > 
> > > > > +		    ((o = parse_object(remote)) != NULL) &&
> > > > > +		    (o->flags & COMPLETE) &&
> > > 
> > > I just realized that parse_object() always reads the file, then does a 
> > > lookup (which makes the above code work), and then parses the file. It 
> > > always does all of these steps, even if the object was already parsed. Any 
> > > reason for this?
> > 
> > I'm lazy and haven't sent in a patch to clean that up. There's no reason 
> > it couldn't check whether the value it gets is already parsed.
> 
> Actually, you don't have to... Junio already replaced parse_object() by 
> lookup_object() in this case.

It often gets used in cases where it isn't completely obvious that the 
object has already been parsed; this is the second place that it's been 
replaced.

> I did not use it originally, because lines 24-25 of commit.h say
> 
> 	/** Internal only **/
> 	struct object *lookup_object(const unsigned char *sha1);
> 
> Is this obsolete?

I'd intended it to be internal, for use by things like lookup_tree(), but 
I suppose that it could be used more generally, if it got a comment that 
says that, unlike lookup_tree() and such, it returns NULL if the object 
has not already been read (because it doesn't know how to create it).

	-Daniel
*This .sig left intentionally blank*
