From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] Fix cg-log and cg-status for non-GNU sed/sort
Date: Mon, 30 May 2005 01:49:11 +0200
Message-ID: <20050529234911.GZ1036@pasky.ji.cz>
References: <20050529231652.GX1036@pasky.ji.cz> <20050529234326.12407.qmail@web41203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 01:47:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXUc-0001Vk-Po
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVE2XtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVE2XtT
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:49:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37253 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261438AbVE2XtN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 19:49:13 -0400
Received: (qmail 32666 invoked by uid 2001); 29 May 2005 23:49:11 -0000
To: Mark Allen <mrallen1@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20050529234326.12407.qmail@web41203.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 01:43:26AM CEST, I got a letter
where Mark Allen <mrallen1@yahoo.com> told me that...
> --- Petr Baudis <pasky@ucw.cz> wrote:
> > Dear diary, on Mon, May 30, 2005 at 01:00:10AM CEST, I got a letter
> > where Mark Allen <mrallen1@yahoo.com> told me that...
> > > -                               pdate="$(showdate $date)"
> > > +                               pdate="$(date -u -r $date)"
> > 
> > Hmm, coudlnt' showdate be fixed instead then? And $date is not a file so
> > -r $date makes no sense to me - what am I missing?
> 
> There is no showdate(1) command on Darwin.  On Darwin, the date(1) command flags are

There's probably no showdate command at all. This is internal function
defined in cg-Xlib. ;-)

> -u (show UTC)
> -r seconds 
> 
> So `date -u -r $date` gives output like "Sun May 29 12:07:55 GMT 2005" instead of
> 1117336545

GNU date:

  -r, --reference=FILE      display the last modification time of FILE

> > > -                               echo; sed -re '
> > > -                                       /
> > *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
> > > -                                       /
> > *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/
> > > -                                       s/./    &/
> > > -                               '
> > > +                               echo; sed -e "/ *Signed-off-by:.*/s/
> > *Signed-off-by:.*/$colsignoff&$coldefault/" -e"/
> > > +*Acked-by:.*/s/ *Acked-by:.*/$colsignoff&$coldefault/" -e "s/./    &/"
> > > +
> > 
> > Is it necessary to take away the newlines? What is the real problem,
> > actually? Just the I flag?
> 
> Is it strictly necessary to take away the newlines? I don't know. To be honest, I didn't 
> experiment too much with alternate implementations. But the I flag in the sed script, 
> yes that is not understood by non-GNU sed. And the "-r" to sed itself is also
> problematic.

I think we don't really need -r anyway. Could you please try with the
'i' flag instead of 'I'? (The manpage is somewhat unclear on the
difference and portability.) Also, could you try if it works with the
newlines?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
