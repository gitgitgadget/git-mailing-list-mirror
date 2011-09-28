From: Jeff King <peff@peff.net>
Subject: Re: SVN -> Git *but* with special changes
Date: Wed, 28 Sep 2011 15:07:16 -0400
Message-ID: <20110928190716.GD1482@sigill.intra.peff.net>
References: <16808473.33899.1317229852319.JavaMail.root@mail.hq.genarts.com>
 <vpq62kc36kn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Bash <bash@genarts.com>,
	Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 28 21:07:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8zTZ-0003hl-AN
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 21:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1I1THU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 15:07:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47533
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab1I1THT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 15:07:19 -0400
Received: (qmail 7925 invoked by uid 107); 28 Sep 2011 19:12:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Sep 2011 15:12:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2011 15:07:16 -0400
Content-Disposition: inline
In-Reply-To: <vpq62kc36kn.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182359>

On Wed, Sep 28, 2011 at 07:44:24PM +0200, Matthieu Moy wrote:

> > I'd eliminate these on the SVN side before converting to Git. If you
> > have svnadmin access to the SVN repo svnadmin dump, svndumpfilter,
> > svnadmin load is a pretty easy process.
> 
> Otherwise, you can do it on the Git side with:
> 
>   git filter-branch --tree-filter 'rm -f some-large-blob'

It's much more efficient to do:

    git filter-branch --index-filter \
      'git rm --cached --ignore-unmatch some-large-blob'

which avoids checking out the large files over and over[1], just to
delete them. Of course, it's even more efficient not to import them from
svn in the first place. :)

-Peff

[1] This is straight from the filter-branch manpage, btw.
