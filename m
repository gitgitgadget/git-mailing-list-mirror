From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 15:58:47 +0200
Message-ID: <E1FyUNT-0007Ko-JR@moooo.ath.cx>
References: <20060706124025.G325584e9@leonov.stosberg.net> <20060706161011.ccc2ea1c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 15:59:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyUNh-0007OR-78
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 15:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWGFN66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 09:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWGFN65
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 09:58:57 -0400
Received: from moooo.ath.cx ([85.116.203.178]:10463 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1030271AbWGFN65 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 09:58:57 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
Mail-Followup-To: Timo Hirvonen <tihirvon@gmail.com>,
	Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060706161011.ccc2ea1c.tihirvon@gmail.com>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23389>

> "which" isn't portable. On SunOS 5.9 "which foo" prints error message to
> stdout and returns 0.  I use this in my own configure scripts:
> 
> path_find()
> {
>         if test -x "$1"
>         then
>                 echo "$1"
>                 return 0
>         fi
>         for i in `echo $PATH | sed 's/:/ /g'`
>         do
>                 if test -x "$i/$1"
>                 then
>                         echo "$i/$1"
>                         return 0
>                 fi
>         done
>         return 1
> }

This will not work with spaces in $PATH. I'd do something like this if
cut is portable (I have only freebsd and linux to test):

path_find()
{
    path="$PATH"
    while [ "$path" != "" ]; do
        p="`echo $path | cut -d : -f 1`"
        if [ "$p" = "$path" ]; then
            path=""
        else
            path="`echo $path | cut -d : -f 2-`"
        fi
        if [ -x "$p/$1" ]; then
            echo "$p/$1"
            return 0
        fi
    done
    return 1
}

Is there any reason to check the current directory first? "which"
doesn't do it for me and without ./ in the front it does not work
(without . is not in $PATH).
