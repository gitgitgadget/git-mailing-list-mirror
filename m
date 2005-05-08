From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 23:08:58 +0200
Message-ID: <20050508210857.GL9495@pasky.ji.cz>
References: <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus> <20050508171209.GX9495@pasky.ji.cz> <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz> <1115574035.9031.145.camel@pegasus> <20050508175156.GA9495@pasky.ji.cz> <1115578658.8949.9.camel@pegasus> <20050508200334.GG9495@pasky.ji.cz> <1115584015.8949.43.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 23:03:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsvU-0005iF-Sv
	for gcvg-git@gmane.org; Sun, 08 May 2005 23:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVEHVKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVEHVJa
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 17:09:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13534 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262935AbVEHVJB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 17:09:01 -0400
Received: (qmail 30082 invoked by uid 2001); 8 May 2005 21:08:58 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115584015.8949.43.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 10:26:55PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> > > look at the attached patch. We should use "fmt -s" to keep newlines that
> > > are inside the commit message and there is one unneeded empty CG: line.
> > 
> > thanks, fixed and pushed out.
> 
> cool. Now I have everything I am used to from CVS, but ...

Excellent.

> @@ -113,7 +113,9 @@
>                 # TODO: Prepend a letter describing whether it's addition,
>                 # removal or update. Or call git status on those files.
>                 echo "CG:    $file" >>$LOGMSG
> -               [ "$msgs" ] && echo $file
> +               if [ "$msgs" ] && ! [ "$forceeditor" ]; then
> +                       echo $file
> +               fi
>         done
>  fi
> 
> There is no need to print out the files if we start the editor anyway.

Thanks, fixed.

> @@ -122,10 +124,10 @@
>  if tty -s; then
>         if ! [ "$msgs" ] || [ "$forceeditor" ]; then
>                 ${EDITOR:-vi} $LOGMSG2
> -       fi
> -       if ! [ "$msgs" ] && ! [ $LOGMSG2 -nt $LOGMSG ]; then
> -               rm $LOGMSG $LOGMSG2
> -               die 'Commit message not modified, commit aborted'
> +               if ! [ $LOGMSG2 -nt $LOGMSG ]; then
> +                       rm $LOGMSG $LOGMSG2
> +                       die 'Commit message not modified, commit aborted'
> +               fi
>         fi
>  else
> 
> If you provide a commit message via -m and then close the editor without
> changing it, it will commit the message. I think that will not be the
> intention of the user.

Now, this is a pretty difficult question. The only other place in the
Cogito toolkit which uses cg-commit -e is now cg-init when doing the
initial commit - and you definitively want to commit even if the message
was not modified in that case. Also, what if you want to just review
how the -m stuff flows like before committing?

OTOH, we might want to stay consistent in behaviour and always abandon
action when the file was not modified (except for the initial commit).
Perhaps some -E for that? Other thoughts?

> /*
>  * Remove empty lines from the beginning and end.
>  *
>  * Turn multiple consecutive empty lines into just one
>  * empty line.
>  */

Bah, that's even easier when you want to squeeze the empty lines inside
of the commit message. I don't, though.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
