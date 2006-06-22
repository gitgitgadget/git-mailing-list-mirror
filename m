From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Tracking CVS
Date: Thu, 22 Jun 2006 10:17:15 -0400
Message-ID: <9e4733910606220717of2ba299ta8a38c7d63fd5635@mail.gmail.com>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
	 <20060622135831.GB21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 16:17:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtPzm-0008JN-WD
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 16:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWFVORR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 10:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWFVORR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 10:17:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:20398 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751791AbWFVORQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 10:17:16 -0400
Received: by nz-out-0102.google.com with SMTP id l1so472007nzf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 07:17:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RuXjNksEQoL+lchuTD5P7vjv+s/IsvK3O+RyQIY/xD6soaU9KblX1+3tF+OgIKx91LydJoDQ0KykVeoAgwPe/sISZaNDYvezech+3KqVAnJfjlUpC4Pnt50EJBvir+R2e9zjiTG35BBNYMfcw5vcwcVzuKEZ5VzFqMRj+jkf994=
Received: by 10.36.25.2 with SMTP id 2mr771926nzy;
        Thu, 22 Jun 2006 07:17:15 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Thu, 22 Jun 2006 07:17:15 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060622135831.GB21864@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22343>

On 6/22/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Jun 22, 2006 at 02:41:16PM CEST, I got a letter
> where Jon Smirl <jonsmirl@gmail.com> said that...
> > I'm tracking cvs using this sequence.
> >
> > cvs update
> > cg rm -a
> > cg commit
> > cg add -r .
> > cg commit
> >
> > Is there a way to avoid the two commits? If you do the add with out
> > the intervening commit it just adds the files back.
>
> I think the most straightforward way is:
>
>         cvs update
>         cg-rm -a
>         cg-status -wns \? | xargs cg-add
>         cg-commit
>
> If you want to be careful about filenames polluted by non-newline
> whitespaces,
>
>         cg-status -wns \? | tr '\n' '\0' | xargs -0 cg-add
>
> If you want to be safe even with filenames containing newlines, you need
> to go at the Git level:
>
>         git-ls-files -z --others | \
>                 xargs -0 git-update-index --add --
>
> Perhaps we might make a special command which would sync the index set
> with the working copy set...

How about a cg-sync? Tracking cvs (or other SCM) with git is probably
a common activitiy while you try to convince the other CVS users to
switch. It is probably worth a little write up in the readme on the
best way to do it.

cg-sync should probably default to having a prompt before actually
adding/removing the files. Add a -f or something to get rid of the
prompt.

-- 
Jon Smirl
jonsmirl@gmail.com
