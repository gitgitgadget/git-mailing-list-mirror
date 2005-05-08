From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 08 May 2005 19:40:34 +0200
Message-ID: <1115574035.9031.145.camel@pegasus>
References: <1115564550.9031.96.camel@pegasus>
	 <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus>
	 <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus>
	 <20050508171209.GX9495@pasky.ji.cz> <1115572667.9031.139.camel@pegasus>
	 <20050508173003.GY9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:34:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpez-0008H0-Q6
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVEHRkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVEHRkq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:40:46 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:58029 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262908AbVEHRkd
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:40:33 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48HfoWX004367
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 19:41:51 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050508173003.GY9495@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > Sometime you don't have any other choice, because diff is not perfect.
> > Do you wanna apply that patch or should I change the mktemp templates
> > first?
> 
> It looks like it'll be most painless when I just reinvent parts of your
> patch here locally and you can send me patches on top of that.

it is your choice. I can change that if you like. My latest version
should apply cleanly against your current tree.

> > > > > > Index: cg-commit
> > > > > > ===================================================================
> > > > > > --- f00d7589973e8ea65d2264f5fbac82e1b217dc8f/cg-commit  (mode:100755)
> > > > > > +++ cb61efa8a01400150162af9b0f3773f21d502fe9/cg-commit  (mode:100755)
> > > > > > @@ -94,30 +78,55 @@
> > > > > >  		echo "$uri" >>$LOGMSG
> > > > > >  		[ "$msgs" ] && echo "$uri"
> > > > > >  	done
> > > > > > -	echo >>$LOGMSG
> > > > > > +else
> > > > > > +	first=1
> > > > > >  fi
> > > > > > -first=1
> > > > > > +
> > > > > >  for msg in "${msgs[@]}"; do
> > > > > >  	if [ "$first" ]; then
> > > > > >  		first=
> > > > > >  	else
> > > > > >  		echo >>$LOGMSG
> > > > > >  	fi
> > > > > > -	echo $msg | fmt >>$LOGMSG
> > > > > > +	echo $msg | fmt -s -w 74 >>$LOGMSG
> > > > > >  done
> > > > > > +
> > > > > > +if [ "$first" ]; then
> > > > > > +	echo >>$LOGMSG
> > > > > > +fi
> > > > > 
> > > > > This mess is still here.
> > > > 
> > > > That is not mess. Think about it. If we have messages provided by -m we
> > > > want an empty line between the merge message and the the first commit
> > > > message. And we don't wanna have an extra empty line at the top if you
> > > > provide a commit messages via -m.
> > > 
> > > But, that's the current behaviour, isn't it?
> > 
> > No it is not, because with my change the messages are at the top and
> > before the CG: lines.
> 
> I'm sorry but I still don't get what are you trying to say. :-)
> As far as I can see, the output will be the same, except that with to -m
> arguments, there won't be the extra newline for the merge message - and
> we agreed we want it, didn't we?

The -m has nothing to do with the merge message. You can have one of
them, but also both. Maybe I missed something in your latest changes.

If you want the extra newline(s) then it is a good idea to add something
that strips heading and trailing empty lines from the final commit
message, because otherwise it will be ugly if you don't enter extra text
for the merge.

Regards

Marcel


