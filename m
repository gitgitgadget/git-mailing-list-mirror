From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Mon, 12 Aug 2013 11:45:21 -0400
Message-ID: <20130812154520.GA18215@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net>
 <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 17:45:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8uJE-000690-Vs
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 17:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879Ab3HLPpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 11:45:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:48098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755995Ab3HLPpY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 11:45:24 -0400
Received: (qmail 22291 invoked by uid 102); 12 Aug 2013 15:45:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Aug 2013 10:45:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Aug 2013 11:45:21 -0400
Content-Disposition: inline
In-Reply-To: <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232194>

On Mon, Aug 12, 2013 at 11:01:03PM +1000, Andrew Ardill wrote:

> On 12 August 2013 22:39, Jeff King <peff@peff.net> wrote:
> > We could do something like the patch below, which allows:
> >
> >   $ git config --global include./magic/.path .gitconfig-magic
> >
> > to read ~/.gitconfig-magic only when we are in a repository with a
> > directory component "/magic/".
> 
> Thanks, this looks great! I'll have a play with it tomorrow.
> 
> Would locally configured config options override this one? From a
> quick read of the patch there doesn't look like there is a way of
> turning this off for a specific repository, but perhaps that is
> unnecessary. I think after a bit of use the edge cases will be a bit
> clearer.

Yes, the usual config and include rules apply; the patch just selectively
ignores the include based on the subsection regex. So if you put the
magic include in your ~/.gitconfig, anything in the repo's .git/config
will override it.

But that also means the usual restrictions apply, too. There is no way
to "unset" a variable as if it had never been specified in the first
place. And multi-valued variables will always append (e.g.,
remote.*.fetch).

The matcher is a regex, so depending on how tortured you want your regex
to get, you can probably exclude a particular directory with that. :)

-Peff
