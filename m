From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 2 Jun 2007 09:13:55 +0200
Message-ID: <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
References: <1180385483418-git-send-email-hjemli@gmail.com>
	 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
	 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
	 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
	 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	 <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, skimo@liacs.nl,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 09:14:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuNoM-0004so-BG
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 09:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbXFBHN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 03:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbXFBHN5
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 03:13:57 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:7223 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbXFBHN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 03:13:57 -0400
Received: by py-out-1112.google.com with SMTP id a29so1357711pyi
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 00:13:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YCVLu2lYSPdRfWiTQxaBxsRi5MRqLoS9SAu8lCB8ZUdNw5I1JlcerQ7oza1PPxOlbTho3LMOJ4G7rvAFeAYN765M9gW4kBv96jJZqRQhFizzreznmTC7/QzIgn1X27nAbZNzpnoFRFj/XL2zaBimI26Ur4RHkCg9fx155Jz954E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EEOvcQtJ4C4LWxWNr3VXlTnkhFaZ2TE7ohX5+T+jZmyuhAgTiHLYZSCwN38EsZRS4sN5LQ/z7Ve8YjtSxz+jGR3wmwsKUkOpqxg/04FYAXmmTFWqOMC3v4MLiTN7X7GPwXrRLxwSg7Mr9EwCt4KHQ/OTxGPgs/y9qyo0/Fksig0=
Received: by 10.114.137.2 with SMTP id k2mr2596820wad.1180768435900;
        Sat, 02 Jun 2007 00:13:55 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 2 Jun 2007 00:13:55 -0700 (PDT)
In-Reply-To: <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48912>

On 6/1/07, Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Fri, 1 Jun 2007, Lars Hjemli wrote:
> > ...
> > Ack. I think the natural thing for a lot of cases is the trivial "module
> > name == path" case, so having to have
> >
> >       [path "kernel"]
> >               module = kernel
> >
> > for that case just sounds unnecessary.
> >
> > That said, I wonder if it wouldn't be more natural to do things the other
> > way around, because quite often a "module" (under CVS conventions) is a
> > *set* of directories, so with that in mind, it might be better to have the
> > mapping be something like this:
> >
> >       [module "infrastructure"]
> >               submodule = lib
> >               submodule = build
> >
> >       [submodule "lib"]
> >               url = git://xyzzy/lib-1.2.3
> >
> >       [submodule "build"]
> >               url = git://xyzzy/build-0.61
> >
> > and make the rule be:
> >  - submodules are named by their paths (ie "path == submodule")
> >  - a module is a set of such submodules/paths
> >  - if no "module" is defined, the default is to just use the
> >    path/submodule name
>
> I take that if you do want to name a submodule differently from
> its (currently in-tree) path, you would do something like...
>
>         [submodule "xyzzylib"]
>                 path = lib
>                 url = git://xyzzy/lib-1.2.3
>

The reason I wanted to use

[path "lib"]
  submodule=xyzzylib
  url=git://xyzzy/lib-1.2.3

is that the git-submodule command always starts out with the submodule
path, trying to map that to an url or a submodule name. My proposal
allows

  $ name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
  $ url=$(GIT_CONFIG=.gitmodules git-config path."$path".url)


Then Sven suggested to create a submodule section for the url, which would allow

  $ name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
  $ url=$(GIT_CONFIG=.gitmodules git-config submodule."$name".url)


But I don't see an easy way to do the mapping from path to url/submodule with:

[submodule "xyzzylib"]
  path=lib
  url=git://xyzzy/lib-1.2.3

Suggestions?

--
larsh
