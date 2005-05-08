From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 19:12:09 +0200
Message-ID: <20050508171209.GX9495@pasky.ji.cz>
References: <1115564550.9031.96.camel@pegasus> <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus> <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:05:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpDQ-0005PW-ML
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVEHRMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVEHRMU
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:12:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47065 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262895AbVEHRMK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:12:10 -0400
Received: (qmail 1741 invoked by uid 2001); 8 May 2005 17:12:09 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115568937.9031.129.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 06:15:36PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> What do you think about a special flag for automatic merging (which
> makes the commit message say "Automatic merge") and a .cogitorc file
> like .cvsrc where you can choose the default method.
> 
> I am using a lot of temporary trees where I pull a lot of kernel
> subsystems together and I don't need that "feature" there.

No problem with that per se, but please keep the configfile
infrastructure and the automerge switch as separate patches from this
one.

> > > This is only cosmetic. Using vim it displays the name of the temporary
> > > file and confusing the user with gitci2.XXXX instead of gitci.XXX is
> > > weird. Even using gitci as basename looks not good to me, but I left it
> > > for now.
> > 
> > It boosts the patch size unnecessarily. It shouldn't be called gitci2
> > anyway... :-) Feel free to change the mktemp templates instead.
> 
> I will check what I can do, but I don't really care that much about the
> patch size ;)

But I do. :-)

> > The gitci name comes all the way from the times where this command was
> > usually triggered by 'git ci'.
> 
> I thought so. Is using cogito.XXXXXX and cogito.temp.XXXXX fine with
> you?

No. I think it's useful (and doesn't cost us anything) to have the
"owner" of the file denoted in the filename.

> > > Index: cg-commit
> > > ===================================================================
> > > --- f00d7589973e8ea65d2264f5fbac82e1b217dc8f/cg-commit  (mode:100755)
> > > +++ cb61efa8a01400150162af9b0f3773f21d502fe9/cg-commit  (mode:100755)
> > > @@ -94,30 +78,55 @@
> > >  		echo "$uri" >>$LOGMSG
> > >  		[ "$msgs" ] && echo "$uri"
> > >  	done
> > > -	echo >>$LOGMSG
> > > +else
> > > +	first=1
> > >  fi
> > > -first=1
> > > +
> > >  for msg in "${msgs[@]}"; do
> > >  	if [ "$first" ]; then
> > >  		first=
> > >  	else
> > >  		echo >>$LOGMSG
> > >  	fi
> > > -	echo $msg | fmt >>$LOGMSG
> > > +	echo $msg | fmt -s -w 74 >>$LOGMSG
> > >  done
> > > +
> > > +if [ "$first" ]; then
> > > +	echo >>$LOGMSG
> > > +fi
> > 
> > This mess is still here.
> 
> That is not mess. Think about it. If we have messages provided by -m we
> want an empty line between the merge message and the the first commit
> message. And we don't wanna have an extra empty line at the top if you
> provide a commit messages via -m.

But, that's the current behaviour, isn't it?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
