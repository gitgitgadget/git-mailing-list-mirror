From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 19:25:05 +0200
Message-ID: <20071005172505.GE31413@uranus.ravnborg.org>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org> <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org> <20071005162139.GC31413@uranus.ravnborg.org> <20071005163517.GD20305@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Oct 05 19:23:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idqtt-0004FX-Tt
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 19:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbXJERXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 13:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757472AbXJERXg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 13:23:36 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:47372 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbXJERXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 13:23:35 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id EABBDE3101B;
	Fri,  5 Oct 2007 19:23:34 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id DEFC0580D2; Fri,  5 Oct 2007 19:25:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071005163517.GD20305@artemis.corp>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60117>

On Fri, Oct 05, 2007 at 06:35:17PM +0200, Pierre Habouzit wrote:
> On Fri, Oct 05, 2007 at 04:21:39PM +0000, Sam Ravnborg wrote:
> > On Fri, Oct 05, 2007 at 08:26:44AM -0700, Linus Torvalds wrote:
> > > 
> > > 
> > > On Fri, 5 Oct 2007, Pierre Habouzit wrote:
> > > >  
> > > > -	strbuf_grow(buf, len);
> > > > +	/* only grow if not in place */
> > > > +	if (strbuf_avail(buf) + buf->len < len)
> > > > +		strbuf_grow(buf, len - buf->len);
> > > 
> > > Umm. This is really ugly.
> > > 
> > > The whole point of strbuf's was that you shouldn't be doing your own 
> > > allocation decisions etc. So why do it?
> > > 
> > > Wouldn't it be much better to have a strbuf_make_room() interface that 
> > > just guarantees that there is enough room fo "len"? 
> > > 
> > > Otherwise, code like the above would seem to make the whole point of a 
> > > safer string interface rather pointless. The above code only makes sense 
> > > if you know how the strbuf's are internally done, so it should not exists 
> > > except as internal strbuf code. No?
> > 
> > Took a short look at strbuf.h after seeing the above code.
> > And I was suprised to see that all strbuf users were exposed to
> > the strbuf structure.
> > Following patch would at least make sure noone fiddle with strbuf internals.
> > Cut'n'paste - only for the example of it.
> > It simply moves strbuf declaration to the .c file where it rightfully belongs.
> 
>   you're looking at an antiquated version, please look at the one in
> current master on current next. In this one, what you can do or not do
> with the struct is explained
> 
> > git did not build with this change....
> 
>   Of course it doesn't! people want to have direct access to ->buf and
> ->len, and it's definitely OK.

Understood now - thanks for the clarification.

	Sam
