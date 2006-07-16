From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: comparing file contents in is_exact_match?
Date: Sun, 16 Jul 2006 15:03:49 +0000
Message-ID: <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
References: <20060706055729.GA12512@admingilde.org>
	 <87k66p8jee.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <87fyh1ncm0.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 16 17:04:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G28AD-0007K0-Mb
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 17:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWGPPDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 11:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWGPPDv
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 11:03:51 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:21338 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750886AbWGPPDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 11:03:50 -0400
Received: by py-out-1112.google.com with SMTP id x31so2730901pye
        for <git@vger.kernel.org>; Sun, 16 Jul 2006 08:03:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jC46/P+R6gXrt4CL3qCQ/hFOikC8vgjN5/VC1Dj8VBsYDFawGg05MCtRRc4vWsXoY8xq3YulgyIH/GiMg5P91dFvY1+hTPKxEDgsfkbHos887pADFHupwT8v4sAe0wNhWb8CLJd6KYcm2vFYE9w56OTLQno+MYzjnS7kUpwJiMI=
Received: by 10.35.87.8 with SMTP id p8mr1707181pyl;
        Sun, 16 Jul 2006 08:03:49 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Sun, 16 Jul 2006 08:03:49 -0700 (PDT)
To: "Florian Weimer" <fw@deneb.enyo.de>
In-Reply-To: <87fyh1ncm0.fsf@mid.deneb.enyo.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23952>

On 7/16/06, Florian Weimer <fw@deneb.enyo.de> wrote:
> * Johannes Schindelin:
>
> > Hi,
> >
> > On Fri, 7 Jul 2006, Florian Weimer wrote:
> >
> >> -               s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
> >> +               s->data = mmap(NULL, s->size, PROT_READ, MAP_SHARED, fd, 0);
> >
> > Be advised that this breaks setups with NO_MMAP, in particular most (all)
> > cygwin setups I know of.
>
> Are these Cygwin setups running on top of the Windows 95 code base by
> chance?

Cygwin has mmap. But cygwin's mmap() not good enough for git.
What happens is that git does rename() when target file has active mmap().
In cygwin, this makes rename() to fail. This is what makes cygwin's
mmap unusable for git. (BTW for read-only git access, mmap() will work
on cygwin, for what I saw. But attempts to modify index will break).

Yakov
