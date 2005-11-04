From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: binary safe?
Date: Sat, 5 Nov 2005 10:22:29 +1300
Message-ID: <46a038f90511041322x1d9f7a50ndafe724c2e8d368b@mail.gmail.com>
References: <86br115r0z.fsf@blue.stonehenge.com>
	 <7v7jbpbb3l.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511031500p3d6ed433s6efe3f5a5e60bcf8@mail.gmail.com>
	 <20051104165419.GA12145@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 22:23:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY91C-0006Td-6O
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 22:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVKDVWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 16:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVKDVWb
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 16:22:31 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:6767 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750903AbVKDVWa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 16:22:30 -0500
Received: by zproxy.gmail.com with SMTP id 13so342706nzn
        for <git@vger.kernel.org>; Fri, 04 Nov 2005 13:22:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tc1G9W/vHGYylMxbjSgVzdKwdYJoPijR0dmAHOa4ef2nr+NHLYp89U1K0WsDXb2k5WIV7Hn2XVArcqoyb4YOsgCbtpXHTMfcQ/+kQxvy9QDMib837rj4FltNSCU0HM0Jp0wusvb/v1DFtPNOafjc4epbKWuwR6KyFHa4pae/XxI=
Received: by 10.65.215.5 with SMTP id s5mr2638311qbq;
        Fri, 04 Nov 2005 13:22:29 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Fri, 4 Nov 2005 13:22:29 -0800 (PST)
To: David Brown <git@davidb.org>
In-Reply-To: <20051104165419.GA12145@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11159>

On 11/5/05, David Brown <git@davidb.org> wrote:
> On Fri, Nov 04, 2005 at 12:00:54PM +1300, Martin Langhoff wrote:
>
> > Yes it works, and cvsimport -k will do the right thing for you.
>
> Unless it has changed from 0.99.9b, 'cvsimport -k' will very much scramble
> some binary files.  '-k' passes the '-kk' option which causes CVS to strip
> the keywords down.  It needs to pass -ko through if you want it to be able
> to handle binary files.

There is a misunderstanding here. We don't pass '-kk' to the cvs
utility -- we pass it at the protocol level. Strangely enough, when
passing ko we were getting broken files, and when passing kk we got
all the files correctly. I explored and tested this quite a bit when I
added the flag, and explicitly tested it with files that _would_ get
broken with cvs update -kk.

To recap: my main test repository has a lot of binary files, files
that do get broken if I do a cvs checkout with -kk. git-cvsimport gets
them right with its -k parameter. Don't ask me why, though: the cvs
protocol is really messy, and I suspect that part of the -kk option is
being 'implemented' on the client side.

(That being said, if you have a case where git-cvsimport is doing the
wrong thing, let me know!)

> However, since CVS (RCS really) can remember the state of this flag, it
> does work to  'cvs admin -ko filename' beforehand, and then do the
> cvsimport without the '-k' option.

Yes, but a repo you don't control, where people are using keywords,
means thatyou need to do -kk to kill the keywords or your imported
files are going to have a horrid amount of noise in them.

cheers,


martin
