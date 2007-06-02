From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 2 Jun 2007 12:38:50 +0200
Message-ID: <8c5c35580706020338v89d341cg811982891a439685@mail.gmail.com>
References: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
	 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	 <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
	 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706020139k3beae8bbj3f51eee0ff5fd30c@mail.gmail.com>
	 <7vejkuyaxq.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580706020253j4e24785cyce712460d8d1a1b8@mail.gmail.com>
	 <7vbqfyvf5o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:39:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuR0h-0006wl-Ga
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 12:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbXFBKix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 06:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbXFBKix
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 06:38:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:35348 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbXFBKiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 06:38:52 -0400
Received: by wa-out-1112.google.com with SMTP id j4so852031wah
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 03:38:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VfgJV9iT6j/hpRbNsRjGkgvpMvtpSH6BGrLoP0VE8mjDj01n8IXttrrrC/OPg4drrSkuMeSfaF+15UlsakwCr4GXgo7iAiQlG2SfWLA/01QNjEAc1HVliJzuX8k1GqR6uAHsCsGG7g+QmBAlYSxREWfje3JmfKo0YFr8wpbd5og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pLbCjXf+mwlwBmu4N+cp+InbYBAx47hUFW9+3351oQVdr9YI8xmlgLRBLLMdlaK2BqUEL+VYEWXSuWua4sHTXpCHc0LGAS+1vblBOLcqbxSRiH6VKhbxD7qAKjILR6v/bdx49D3C3xRbyDnFhk4SC3EHGOehNaL8uCf3mtFhxRw=
Received: by 10.115.22.1 with SMTP id z1mr397996wai.1180780730155;
        Sat, 02 Jun 2007 03:38:50 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 2 Jun 2007 03:38:50 -0700 (PDT)
In-Reply-To: <7vbqfyvf5o.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48922>

On 6/2/07, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > So I'll make 'git-submodule' expect the .gitmodules layout to be like this:
> >
> > [submodule 'xyz']
> >  url=git://example.com/xyz.git
> >  path=xyz1
> >  path=xyz2
> >
> > And submodule.$name.path should be optional: if no submodule.*.path
> > entry exists for a given $path, submodule $name == $path.
> >
> > Ok?
>
> I do not think having more than one path for a given submodule
> makes much sense

Me neither, but it was mentioned as a possibility to have the same
repo checked out in multiple paths simultaneously. It does raise an
issue of how to push changes back into .git/submodules/$name.git tough
(git-submodule push). My initial plan for this was to push into the
branch registered for each path:

[submodule 'xyz']
  url=git://example.com/xyz.git

[path 'xyz1']
  submodule=xyz
  branch=stable

[path 'xyz2']
  submodule=xyz
  branch=bleedingedge

but there is probably other/better solutions.

>but other than that yes.

Thanks

-- 
larsh
