From: Jeff King <peff@peff.net>
Subject: Re: Problem using git-filter-branch to move tree when repository
 name contains space
Date: Fri, 1 Apr 2011 10:41:07 -0400
Message-ID: <20110401144107.GA3103@sigill.intra.peff.net>
References: <4D95E182.6030903@revelate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jean-Fran=C3=A7ois?= Burdet <jfburdet@revelate.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5fXI-0008GR-FL
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 16:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab1DAOlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 10:41:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51403
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961Ab1DAOlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 10:41:09 -0400
Received: (qmail 10791 invoked by uid 107); 1 Apr 2011 14:41:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 10:41:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 10:41:07 -0400
Content-Disposition: inline
In-Reply-To: <4D95E182.6030903@revelate.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170590>

On Fri, Apr 01, 2011 at 04:30:26PM +0200, Jean-Fran=C3=A7ois Burdet wro=
te:

> I want to move my repository (wich is contained in a directory whose
> name's containing a space)  root tree to a subdirectory.
>=20
> I followed what's documented in
> http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.htm=
l ,
> using the last example :
>=20
> [...]
>
> jfburdet@nagios:~/git test$ git filter-branch --index-filter \
> >         'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
> >                 GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
> >                         git update-index --index-info &&
> >          mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
> Rewrite 3658e305df3ace21d39bf57dd4e0e5627818dfcc (1/1)mv: target
> `test/.git-rewrite/t/../index' is not a directory

The problem is that GIT_INDEX_FILE is an absolute path that contains th=
e
repo name. So it needs to be quoted in the mv command. This should work=
:

  git filter-branch --index-filter \
    'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
      GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
        git update-index --index-info &&
     mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD

-Peff
