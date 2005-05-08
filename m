From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 17:56:56 +0200
Message-ID: <20050508155656.GV9495@pasky.ji.cz>
References: <1115564550.9031.96.camel@pegasus> <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 17:51:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUo2m-0006nl-3u
	for gcvg-git@gmane.org; Sun, 08 May 2005 17:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVEHP5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVEHP5F
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 11:57:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20184 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262885AbVEHP46 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 11:56:58 -0400
Received: (qmail 29696 invoked by uid 2001); 8 May 2005 15:56:56 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115566990.9031.108.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 05:43:10PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> > What is so special about 74 columns? Why not 75 (fmt default), or 72
> > (emails)?
> 
> I ended up with 74, because "CG" has only two letters instead of "CVS"
> which has three. And cg-log uses a prefix of four whitespaces. This
> leaves two free characters at the end of a line if your terminal uses a
> width of 80 characters. The decision was of cosmetic nature.

Isn't one free character enough?  I'll just stay with 75. :-)

> > Also, I'd prefer the empty line to be always there in front of the CG:
> > stuff (two empty lines in case of merge - I want to encourage people to
> > keep possible details w.r.t. the merge separated by an empty line from
> > the merge information), and when reading it back cg-commit should strip
> > any trailing empty lines.
> 
> I think we should differentiate between the merges. There is no need for
> additional information if it is an automatic merge (no conflicts) and in
> general it makes no sense to open the editor (until forced). I wanted to
> address this later. And yes in case of a manual merge it is a good idea
> to add two extra empty lines at the top.

Not so. I frequently write a brief summary of what I'm actually merging.
I'm not forcing you to do so too, but I personally think it's a good
idea, and want to do it in the future too. :-)

> This is only cosmetic. Using vim it displays the name of the temporary
> file and confusing the user with gitci2.XXXX instead of gitci.XXX is
> weird. Even using gitci as basename looks not good to me, but I left it
> for now.

It boosts the patch size unnecessarily. It shouldn't be called gitci2
anyway... :-) Feel free to change the mktemp templates instead.

The gitci name comes all the way from the times where this command was
usually triggered by 'git ci'.

> Index: cg-commit
> ===================================================================
> --- f00d7589973e8ea65d2264f5fbac82e1b217dc8f/cg-commit  (mode:100755)
> +++ cb61efa8a01400150162af9b0f3773f21d502fe9/cg-commit  (mode:100755)
> @@ -94,30 +78,55 @@
>  		echo "$uri" >>$LOGMSG
>  		[ "$msgs" ] && echo "$uri"
>  	done
> -	echo >>$LOGMSG
> +else
> +	first=1
>  fi
> -first=1
> +
>  for msg in "${msgs[@]}"; do
>  	if [ "$first" ]; then
>  		first=
>  	else
>  		echo >>$LOGMSG
>  	fi
> -	echo $msg | fmt >>$LOGMSG
> +	echo $msg | fmt -s -w 74 >>$LOGMSG
>  done
> +
> +if [ "$first" ]; then
> +	echo >>$LOGMSG
> +fi

This mess is still here.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
