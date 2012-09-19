From: Jeff King <peff@peff.net>
Subject: Re: possible bug in autocompletion
Date: Wed, 19 Sep 2012 13:43:36 -0400
Message-ID: <20120919174336.GA11699@sigill.intra.peff.net>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
 <20120717121232.GA32571@sigill.intra.peff.net>
 <CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeroen Meijer <jjgmeijer@hotmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOJT-0008Pg-DO
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab2ISRnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:43:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49754 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756782Ab2ISRnl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:43:41 -0400
Received: (qmail 2395 invoked by uid 107); 19 Sep 2012 17:44:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 13:44:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 13:43:36 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205959>

On Wed, Sep 19, 2012 at 07:08:09PM +0200, Felipe Contreras wrote:

> On Tue, Jul 17, 2012 at 2:12 PM, Jeff King <peff@peff.net> wrote:
> 
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -261,7 +261,12 @@ __gitcomp ()
> >  __gitcomp_nl ()
> >  {
> >         local IFS=$'\n'
> > -       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
> > +       local words=$1
> > +       words=${words//\\/\\\\}
> > +       words=${words//\$/\\\$}
> > +       words=${words//\'/\\\'}
> > +       words=${words//\"/\\\"}
> > +       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))
> >  }
> 
> What about something like this?
> 
> local words
> printf -v words "%q" "$w"
> COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))

Thanks, I didn't know about bash's internal printf magic. That is a much
more elegant solution.

Care to wrap it up in a patch?

-Peff
