From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Heads up, an emergency fix for git-cvsimport is coming shortly
Date: Sun, 30 Dec 2012 20:23:44 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121231012344.GA17361@thyrsus.com>
References: <20121230192116.C2A2444143@snark.thyrsus.com>
 <CAEUsAPZ7kzc4qYSvD-YCk9sqQOuW219gOWyxpGqfkxmF2VC-PQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 02:24:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpU7Q-0003am-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 02:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab2LaBY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Dec 2012 20:24:26 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46674
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab2LaBYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 20:24:24 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 6627644143; Sun, 30 Dec 2012 20:23:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAEUsAPZ7kzc4qYSvD-YCk9sqQOuW219gOWyxpGqfkxmF2VC-PQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212346>

Chris Rorvick <chris@rorvick.com>:
> I tried the new version and found I'm unable to import via pserver:
>=20
>   $ ./cvsps --root :pserver:me@localhost:/cvsroot module
>   cvsps: connect error: Connection refused
>   cvsps: can't get CVS log data: Connection refused
>=20
> Running 2.2b1 (the version packaged w/ Fedora 17) with the same
> arguments with the addition of --cvs-direct connects OK.  I haven't
> taken much time to look into this, so I might be doing something dumb=
=2E
>  Thought I'd find out if this is a known issue before delving into it=
=2E

Your problem does reproduce here. This paragraph from the output of=20
'aptitude show cvs' may be relevant:

 This package contains a CVS binary which can act as both client and se=
rver,
 although there is no CVS d=E6mon; to access remote repositories, pleas=
e use
 :extssh: not :pserver: any more.

It's therefore possible there's something slightly busted about the pse=
rver=20
method at the CVS end, and the 3.[23] code trips over it even though th=
e old
code did not.  Note that new cvsps uses cvs-direct mode all the time; t=
he old
support for fetching logs through local CVS commands is gone.

I use=20

      cvsps --root :local:$PWD/repo module

for my testing, and that works. I'm up to my ears in finishing up the
test suite and tracking bugs in the repo-analysis code; if you want to
speed the process up, try running a :pserver: fetch with -v on under
both old and new code to see how the protocol transactions differ.

> Also, I'm curious what impact removing the caching from cvsps will
> have on incremental imports.  Is there any?

Not that I know of.  The caching was a performance hack for human viewi=
ng
of changesets.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
