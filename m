From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 19:17:47 +0200
Message-ID: <1115572667.9031.139.camel@pegasus>
References: <1115564550.9031.96.camel@pegasus>
	 <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus>
	 <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus>
	 <20050508171209.GX9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:12:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpJT-0005wT-Pw
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVEHRSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVEHRSf
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:18:35 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:57005 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262896AbVEHRSa
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:18:30 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48HJkWX004197
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 19:19:47 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508171209.GX9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > What do you think about a special flag for automatic merging (which
> > makes the commit message say "Automatic merge") and a .cogitorc file
> > like .cvsrc where you can choose the default method.
> > 
> > I am using a lot of temporary trees where I pull a lot of kernel
> > subsystems together and I don't need that "feature" there.
> 
> No problem with that per se, but please keep the configfile
> infrastructure and the automerge switch as separate patches from this
> one.

It was never part of this patch. It is something I am thinking about.

> > > > This is only cosmetic. Using vim it displays the name of the temporary
> > > > file and confusing the user with gitci2.XXXX instead of gitci.XXX is
> > > > weird. Even using gitci as basename looks not good to me, but I left it
> > > > for now.
> > > 
> > > It boosts the patch size unnecessarily. It shouldn't be called gitci2
> > > anyway... :-) Feel free to change the mktemp templates instead.
> > 
> > I will check what I can do, but I don't really care that much about the
> > patch size ;)
> 
> But I do. :-)

Sometime you don't have any other choice, because diff is not perfect.
Do you wanna apply that patch or should I change the mktemp templates
first?

> > > The gitci name comes all the way from the times where this command was
> > > usually triggered by 'git ci'.
> > 
> > I thought so. Is using cogito.XXXXXX and cogito.temp.XXXXX fine with
> > you?
> 
> No. I think it's useful (and doesn't cost us anything) to have the
> "owner" of the file denoted in the filename.
> 
> > > > Index: cg-commit
> > > > ===================================================================
> > > > --- f00d7589973e8ea65d2264f5fbac82e1b217dc8f/cg-commit  (mode:100755)
> > > > +++ cb61efa8a01400150162af9b0f3773f21d502fe9/cg-commit  (mode:100755)
> > > > @@ -94,30 +78,55 @@
> > > >  		echo "$uri" >>$LOGMSG
> > > >  		[ "$msgs" ] && echo "$uri"
> > > >  	done
> > > > -	echo >>$LOGMSG
> > > > +else
> > > > +	first=1
> > > >  fi
> > > > -first=1
> > > > +
> > > >  for msg in "${msgs[@]}"; do
> > > >  	if [ "$first" ]; then
> > > >  		first=
> > > >  	else
> > > >  		echo >>$LOGMSG
> > > >  	fi
> > > > -	echo $msg | fmt >>$LOGMSG
> > > > +	echo $msg | fmt -s -w 74 >>$LOGMSG
> > > >  done
> > > > +
> > > > +if [ "$first" ]; then
> > > > +	echo >>$LOGMSG
> > > > +fi
> > > 
> > > This mess is still here.
> > 
> > That is not mess. Think about it. If we have messages provided by -m we
> > want an empty line between the merge message and the the first commit
> > message. And we don't wanna have an extra empty line at the top if you
> > provide a commit messages via -m.
> 
> But, that's the current behaviour, isn't it?

No it is not, because with my change the messages are at the top and
before the CG: lines.

Regards

Marcel


