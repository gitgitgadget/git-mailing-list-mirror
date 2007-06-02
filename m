From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 2 Jun 2007 10:39:41 +0200
Message-ID: <8c5c35580706020139k3beae8bbj3f51eee0ff5fd30c@mail.gmail.com>
References: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
	 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
	 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
	 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	 <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
	 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jun 02 10:39:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuP9J-0007BO-K4
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 10:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbXFBIjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 04:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbXFBIjn
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 04:39:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:31821 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbXFBIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 04:39:42 -0400
Received: by wa-out-1112.google.com with SMTP id j4so824209wah
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 01:39:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P8WTe/YDCeAJaw/BvCwZ3OmgujhYlOvMvzrX4oUN4FdCc5LdkEAPlov5+K6oDlt8ADNijID6SVIRSb7tpPnihUovw9AhJlUFrgbdJ9FdVKHdOID/2kqne6NxagsShmnZNxFXDCRZj9AovF+uCaQw1zU29t8EaSAzpmFKxmjFX3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=coqJRstEHoT8hL0ZFh7lED3gcmtAWcSPCzAiGbyYLP2nFboKNpTftIs9tzGG1cZCmeSBVx3NlH7R+c8ifw011r+UviSFze5F6PcfxDHd6iNlB7e4oLPdfSa/YbsMf3PTTnYwgDLK9zUMYZ0BNHjc7bWvN129ep6gu2FRItceVac=
Received: by 10.114.178.1 with SMTP id a1mr2632681waf.1180773581858;
        Sat, 02 Jun 2007 01:39:41 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 2 Jun 2007 01:39:41 -0700 (PDT)
In-Reply-To: <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48915>

On 6/2/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Sat, Jun 02, 2007 at 09:13:55AM +0200, Lars Hjemli wrote:
> > Then Sven suggested to create a submodule section for the url, which would
> > allow
> >
> >  $ name=$(GIT_CONFIG=.gitmodules git-config path."$path".submodule)
> >  $ url=$(GIT_CONFIG=.gitmodules git-config submodule."$name".url)
> >
> >
> > But I don't see an easy way to do the mapping from path to url/submodule
> > with:
> >
> > [submodule "xyzzylib"]
> >  path=lib
> >  url=git://xyzzy/lib-1.2.3
> >
> > Suggestions?
>
> I'm not a shell programmer,

Me neither ;-)

>but it could look something like this
>
>     $ name=$(git config --get-regexp 'submodule\..*\.path' | while read module modulepath; do if test "$modulepath" = "$path"; then echo $module | sed -e 's/^submodule.//' -e 's/.path//'; fi; done)
>

Ahh, --get-regexp, thanks.

Then this actually works:

name=$(GIT_CONFIG=.gitmodules git-config --get-regexp
'submodule\..*\.path' 'lib' | sed -e 's/^submodule\.\(.*\)\.path
lib$/\1/')


But why would we want to design .gitmodules in a way that makes it
hard to do the mapping from path to url?

-- 
larsh
