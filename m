From: Jeff King <peff@peff.net>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Wed, 25 May 2016 17:52:14 -0500
Message-ID: <20160525225214.GA2612@sigill.intra.peff.net>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com>
 <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com>
 <vpq37p74nu1.fsf@anie.imag.fr>
 <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Git Mailing List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:52:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hf3-0003Po-FA
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbcEYWwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:52:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:44315 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbcEYWwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:52:17 -0400
Received: (qmail 23225 invoked by uid 102); 25 May 2016 22:52:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:52:16 -0400
Received: (qmail 14904 invoked by uid 107); 25 May 2016 22:52:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:52:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 17:52:14 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295609>

On Tue, May 24, 2016 at 09:07:53AM -0700, Junio C Hamano wrote:

> On Tue, May 24, 2016 at 5:55 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > So, when trying a forbidden push, Git would deny it and the only way to
> > force the push would be to remove the blacklist from the config, right?
> >
> > Probably the sanest way to go. I thought about adding a "git push
> > --force-even-if-in-blacklist" or so, but I don't think the feature
> > deserves one specific option (hence add some noise in `git push -h`).
> 
> Yeah, I agree --even-if-in-blacklist is a road to madness, but I wonder
> how this is different from setting pushURL to /dev/null or something
> illegal and replace that phony configuration value when you really need
> to push?

That was my thought on reading this, too. In that scheme, you could do:

  git -c remote.foo.pushurl=example.com:repo.git push ...

to override it.  It would be nice if you could do:

  git -c remote.foo.pushurl= push ...

to "unset" the push-url list and default to the regular fetch url, but
this is one of those multi-value config options that would have to learn
that explicitly.

I suppose one can do:

  git -c remote.foo.pushurl=$(git config remote.foo.url)

but that is getting a bit long.

-Peff
