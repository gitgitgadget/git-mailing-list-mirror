From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RESEND] git submodule add: make the <path> parameter
 optional
Date: Mon, 5 Oct 2009 11:16:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910051113370.4985@pacific.mpi-cbg.de>
References: <4AB8E8D4.40105@web.de> <7vbpl2srw9.fsf@alter.siamese.dyndns.org> <4AC8E0A8.4000901@web.de> <alpine.DEB.1.00.0910042304060.4985@pacific.mpi-cbg.de> <7vtyyek4nz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MujfU-0000Rr-07
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 11:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbZJEJO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbZJEJOZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:14:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:40381 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932319AbZJEJOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:14:25 -0400
Received: (qmail invoked by alias); 05 Oct 2009 09:13:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 05 Oct 2009 11:13:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OeUdHVISOYTIKyvSnr7cMKGbKCVLWwoBzA3jVHY
	DdE/R6lmyXNWkH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vtyyek4nz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129540>

Hi,

On Sun, 4 Oct 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So far, I started submodules by cloning them, doing everything in the 
> > other files needed to integrate, and then actually wondered why "git 
> > submodule add" could not simply take the (relative) path to the 
> > checked-out submodule and deduce the URL from the corresponding config?
> 
> Let me try to rephrase the above to see if I understand what you are
> doing.  When building a top-level superproject that uses two submodules
> from other places, you would do:
> 
> 	$ git init toplevel
>         $ cd toplevel
>         $ git clone $overthere submodule1
>         $ git clone $elsewhere submodule2
>         $ edit Makefile common.h
>         $ git add Makefile common.h submodule1 submodule2
> 
> and by "the corresponding config", you mean "submodule1/.git/config
> already records that it came from $overthere, and there is no reason to
> say it again in 'git submodule add $overthere submodule1'".

Yes, that's what I meant.

But I do like your idea of enhancing "git add" to do this.  Then we can 
keep "git submodule add" as-is, and then it actually makes sense to make 
the <path> parameter optional: "git submodule add" is then about _cloning_ 
and adding the submodule.  Which is not my scenario.

> > So I would actually vote for making the <repository> parameter 
> > optional...
> 
> In your "git submodule add submodule1", it would be quite clear that it is
> a local path and <repository> is being omitted.  On the other hand, if you
> said "git submodule add $overthere" without submodule1, because $overthere
> is not likely to be an in-tree path, it also would be clear that it is
> omitting the path.  IOW, these two typesavers are not mutually exclusive.

I thought about that, but it seems a bit too magical, and it is obvious 
that

	git submodule add $(pwd)/bla

would test that magic.

Ciao,
Dscho
