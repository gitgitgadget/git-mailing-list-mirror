From: Jeff King <peff@peff.net>
Subject: Re: Possible bug with argument parsing in git blame
Date: Sun, 23 May 2010 16:08:54 -0400
Message-ID: <20100523200853.GA23377@coredump.intra.peff.net>
References: <AANLkTikn1-Ua6G7eAc8UD8DJx0vpc-5-BOoxsi2mx2BC@mail.gmail.com>
 <20100523080002.GB24598@coredump.intra.peff.net>
 <AANLkTinMlvmOneGgkIqxE8qWlhoOlqgALl-YHprqPI6h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Debayan Banerjee <debayanin@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 22:09:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGHTt-0005mo-1n
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 22:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab0EWUI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 May 2010 16:08:59 -0400
Received: from peff.net ([208.65.91.99]:42013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610Ab0EWUI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 16:08:58 -0400
Received: (qmail 27674 invoked by uid 107); 23 May 2010 20:08:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 16:08:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 16:08:54 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinMlvmOneGgkIqxE8qWlhoOlqgALl-YHprqPI6h@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147581>

On Sun, May 23, 2010 at 07:22:41PM +0530, Debayan Banerjee wrote:

> > I can't reproduce the problem here. For example, in git.git, both o=
f the
> > following produce the same output:
> >
> > =C2=A0git blame HEAD~5..HEAD~3 alloc.c
> > =C2=A0git blame HEAD~5..HEAD~3 -- alloc.c
>=20
> It seems to happen only if the path has '/' in it. For example alloc.=
c
> will be parsed fine, but dir/alloc.c wont.

Sorry, I still can't reproduce with:

  mkdir repo && cd repo && git init
  mkdir subdir

  commit() {
    echo content >>subdir/file
    git add subdir/file
    git commit -m foo
  }

  commit; commit; commit; commit; commit

  git blame HEAD~3..HEAD~1 subdir/file >no-dash &&
  git blame HEAD~3..HEAD~1 -- subdir/file >dash &&
  diff no-dash dash &&
  echo ok

So there must be some difference between your setup and my test case.
Can you give more details?

-Peff

PS I tested on a variety of git versions back to v1.5.5, and I couldn't
trigger the problem, so I don't think it is a version issue.
