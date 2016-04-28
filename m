From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 11:36:02 -0400
Message-ID: <20160428153601.GD31063@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
 <20160428133744.GC25319@sigill.intra.peff.net>
 <CA+P7+xoJrU884n7xG_kof46TSg_4NwS=5+nZza8PM7D=YtsXng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:36:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnzB-0000p7-Jc
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbcD1PgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:36:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:58487 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751865AbcD1PgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:36:05 -0400
Received: (qmail 31434 invoked by uid 102); 28 Apr 2016 15:36:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:36:04 -0400
Received: (qmail 11182 invoked by uid 107); 28 Apr 2016 15:36:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:36:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 11:36:02 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xoJrU884n7xG_kof46TSg_4NwS=5+nZza8PM7D=YtsXng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292905>

On Thu, Apr 28, 2016 at 08:28:29AM -0700, Jacob Keller wrote:

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 2a84d7e..3a40d4b 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -200,6 +200,7 @@ sanitize_submodule_env()
> >         sanitized_config=$(git submodule--helper sanitize-config)
> >         clear_local_git_env
> >         GIT_CONFIG_PARAMETERS=$sanitized_config
> > +       export GIT_CONFIG_PARAMETERS
> 
> why not
> 
> export GIT_CONFIG_PARAMETERS=$santized_config

Portability. Try:

  $ dash -c 'one="foo bar"; export two=$one; echo $two'
  foo

  $ bash -c 'one="foo bar"; export two=$one; echo $two'
  foo bar

I think:

  export GIT_CONFIG_PARAMETERS="$sanitized_config"

solves that. Some antique shells do not like "export x=y" at all, but I
don't know if any of them are still relevant.

-Peff
