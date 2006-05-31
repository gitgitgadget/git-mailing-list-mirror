From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 22:08:43 +0200
Message-ID: <4d8e3fd30605311308j6a784635g91e2721258f53c9f@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
	 <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
	 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
	 <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com>
	 <Pine.LNX.4.64.0605311233030.24646@g5.osdl.org>
	 <4d8e3fd30605311243q5a93a7a9l827c55827817602f@mail.gmail.com>
	 <4d8e3fd30605311249l6ba4ff74l72778ffe60462263@mail.gmail.com>
	 <4d8e3fd30605311256o67e45d06ve0efeff65fcf4851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 22:10:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWzv-0001T2-71
	for gcvg-git@gmane.org; Wed, 31 May 2006 22:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWEaUIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 16:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWEaUIu
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 16:08:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:42330 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751657AbWEaUIs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 16:08:48 -0400
Received: by wr-out-0506.google.com with SMTP id i7so103548wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 13:08:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t30Af2wHkJo2XaYWQ+J41zHWwblaw1FRckBF1nYNTx72jnVGdOfTwUiSJNYlGw8xJ+vHduEDOWtj/DLnbpIyLfydwnJTE5T+cJD+abSgAS2Msxidth6ts6N4HskH4aE2T3UJvPWwS/YAK58Qd32GXfgSHnqQUGGTx6AuTaep3wY=
Received: by 10.65.214.15 with SMTP id r15mr737018qbq;
        Wed, 31 May 2006 13:08:43 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 13:08:43 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <4d8e3fd30605311256o67e45d06ve0efeff65fcf4851@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21090>

On 5/31/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 5/31/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> [...]
> > And even more intersting:
> > make clean && make && sudo make install
> > git --version
> > git version 1.3.GIT
> >
> > make install
> > [...]
> > mv git-cherry-pick+ git-cherry-pick
> > mv: sovrascrivo `git-cherry-pick' ignorando il modo 0755?
> > that in english is something like:
> > mv: overwrite `git-cherry-pick' ignoring mod 0755?
> >
> > Wow...of course, make clean && make install fix everything
> >
>
> Thanks to loops on #git for asking me to do the following test:
>
> <PaoloC> paolo@Italia:~/git$ sudo ./GIT-VERSION-GEN
> <PaoloC> GIT_VERSION = 1.3.GIT
> <PaoloC> paolo@Italia:~/git$ ./GIT-VERSION-GEN
> <PaoloC> GIT_VERSION = 1.3.3.g2186
>
> I don't know why it's happening...

Ok, thanks to the people living in #git!!

the problem is the following, from GIT-VERSION-GEN:
#!/bin/sh

GVF=GIT-VERSION-FILE
DEF_VER=v1.3.GIT

# First try git-describe, then see if there is a version file
# (included in release tarballs), then default
if VN=$(git describe --abbrev=4 HEAD 2>/dev/null); then
        VN=$(echo "$VN" | sed -e 's/-/./g');
elif test -f version
then
        VN=$(cat version) || VN="$DEF_VER"
else
        VN="$DEF_VER"
fi

paolo@Italia:~/git$ git describe --abbrev=4 HEAD
v1.3.3-g2186

but...

paolo@Italia:~/git$ sudo git describe --abbrev=4 HEAD
sudo: git: command not found

that's because:
paolo@Italia:~/git$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/games:/home/paolo/bin
but...
paolo@Italia:~/git$ sudo sh
sh-3.1# echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin

Don't know whay $PATH are different but at least why I know why git
has that strange behaviour.

Ciao,


-- 
Paolo
http://paolociarrocchi.googlepages.com
