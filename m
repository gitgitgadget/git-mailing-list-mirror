From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 15:48:45 +0100
Message-ID: <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:48:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtX0-0001Ky-S7
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbXBJOsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbXBJOsr
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:48:47 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:20305 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435AbXBJOsq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:48:46 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1157324wra
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 06:48:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tLyW4PE+nUBbmffUvnIL46ex50R5eBqeQHH+2b1zN6CyiUrFhKyQDzTsNZr6wYe5b6CYaGtlr+5p79xKatNHeX3yu5oGyaNGUEovGhGHC6sEFnKDXoFKHTZjSnUFqAUhgw+0F9nxpMytsqNJcYMSQxmTxYawvCb1q5k+2NZYlqI=
Received: by 10.114.111.1 with SMTP id j1mr6448694wac.1171118925647;
        Sat, 10 Feb 2007 06:48:45 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 06:48:45 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39224>

On 2/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 10 Feb 2007, Marco Costalba wrote:
>
> > On 2/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Fri, 9 Feb 2007, Marco Costalba wrote:
> > >
> > > > I just need to know if current working directory is clean and report
> > > > back to qgit user, so read-only access would be ok for me.
> > >
> > > So, why don't you just do a
> > >
> > >         git diff --name-only HEAD
> > >
> > > and check for an empty output???
> >
> > It seems to have the same issues of 'git runstatus' in case of ntfs
> > filesystems, so I would prefer, eventually, use 'git runstatus' that at
> > least gives me index status of the files.
>
> Which issues? That the lstat data are not equal on Cygwin and Linux? The
> patch does not help here.

Well, I tested the patch and indeed it helps a lot ;-)

It's correct that checking Linux lstat against cygwin one (stored in
index) gives different results, but it's now where the patch makes the
difference rechecking all the files (in memory) to see if are really
changed and discarding false positives created by lstat issues.

> Maybe a patch to Linux' ntfs driver
> would, but I fail to see how Git could possibly help here.

>
> You need a new version of _Git_ if you use that option.
>

That's a true point. Altough if git 1.5 ships _without_ '--refresh'
option in 'git runstatus' for a porcelain tool point of view it means
*do forget* that option until next major release. There's no point in
adding the feature one day after git 1.5 is out; qgit will not use
that feature anyway for next months.


   Marco
