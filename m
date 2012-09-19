From: Jeff King <peff@peff.net>
Subject: Re: possible bug in autocompletion
Date: Wed, 19 Sep 2012 19:43:32 -0400
Message-ID: <20120919234332.GB27626@sigill.intra.peff.net>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
 <20120717121232.GA32571@sigill.intra.peff.net>
 <CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
 <20120919174336.GA11699@sigill.intra.peff.net>
 <CAMP44s1Xvvs7g1quUEs2b43VciK2=Nt-AntJcwG0CPf6p8Xk_A@mail.gmail.com>
 <CAMP44s1ZVTgBTQDyBHKvos-uSo0FeOO437MvTYH0YE0Lx-xDOA@mail.gmail.com>
 <20120919195518.GA22310@sigill.intra.peff.net>
 <CAMP44s33b7uNg6G3m3wHEACa_wYwf_5==h64CHw2b86-rJd5VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeroen Meijer <jjgmeijer@hotmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETvl-0008Ai-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab2ISXnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:43:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50213 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab2ISXne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:43:34 -0400
Received: (qmail 8926 invoked by uid 107); 19 Sep 2012 23:43:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 19:43:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 19:43:32 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s33b7uNg6G3m3wHEACa_wYwf_5==h64CHw2b86-rJd5VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206014>

On Thu, Sep 20, 2012 at 01:08:29AM +0200, Felipe Contreras wrote:

> On Wed, Sep 19, 2012 at 9:55 PM, Jeff King <peff@peff.net> wrote:
> 
> > I have no idea if that internal to bash's filename completion, or if
> > there is some easy facility offered to programmable completions to do
> > the same thing.  I don't think this is a high priority, but it would be
> > nice to handle it. And moreover, I am really wondering if we are missing
> > some solution that bash is providing to help us with the quoting issues.
> > Surely we are not the first completion script to come up against this.
> 
> I found a much easier solution:
> 
> -       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
> +       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$(quote "$1")"
> -- "${3-$cur}"))

Oh, nice. :)

> But what about the people that don't have bash-completion?
> 
> BTW:
> 
> quote()
> {
>     local quoted=${1//\'/\'\\\'\'}
>     printf "'%s'" "$quoted"
> }

That is short and obvious enough that we could probably just
cut-and-paste it into our script as _git_quote (and it is basically a
cleaner version of the thing that I posted).

-Peff
