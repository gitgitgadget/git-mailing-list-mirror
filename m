From: Jeff King <peff@peff.net>
Subject: Re: 'git add' regression in git-1.7?
Date: Fri, 19 Feb 2010 01:02:49 -0500
Message-ID: <20100219060249.GD22645@coredump.intra.peff.net>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 07:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiLx2-0003hg-WE
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 07:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab0BSGCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 01:02:52 -0500
Received: from peff.net ([208.65.91.99]:38722 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655Ab0BSGCv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 01:02:51 -0500
Received: (qmail 11410 invoked by uid 107); 19 Feb 2010 06:03:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 19 Feb 2010 01:03:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2010 01:02:49 -0500
Content-Disposition: inline
In-Reply-To: <20100219053431.GB22645@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140412>

On Fri, Feb 19, 2010 at 12:34:31AM -0500, Jeff King wrote:

> > On Fri, Feb 19, 2010 at 12:04 AM, SungHyun Nam <goweol@gmail.com> w=
rote:
> > > Well, before sending the previous email, I checked the
> > > RelNotes-1.7.*.txt, =C2=A0and could not find such a change by sea=
rching
> > > 'git add'. =C2=A0So, I thought it's a regression.
> >=20
> > As far as I know, git add has refused to add ignored files for as l=
ong
> > as I can remember.  Maybe there was briefly a bug in this behaviour
> > that was later fixed...
> >=20
> > If you use 'git bisect' on the git repo, you could probably discove=
r
> > what happened, in case you're interested.
>=20
> It was intentional. Try 48ffef9 (ls-files: fix overeager pathspec
> optimization, 2010-01-08).

But this is a little disturbing still:

  $ git init
  $ mkdir dir
  $ touch dir/sub
  $ touch root
  $ echo dir >.gitignore
  $ echo root >>.gitignore

  $ git add root
  The following paths are ignored by one of your .gitignore files:
  root
  Use -f if you really want to add them.
  fatal: no files added
  $ echo $?
  128

  $ git add dir
  The following paths are ignored by one of your .gitignore files:
  dir
  Use -f if you really want to add them.
  fatal: no files added
  $ echo $?
  128

  $ git add dir/sub
  $ echo $?
  0

but we didn't actually add the file.

-Peff
