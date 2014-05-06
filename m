From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 20/28] "guilt graph": Handle patch names containing
 quotes.
Date: Tue, 6 May 2014 16:24:46 -0400
Message-ID: <20140506202446.GQ1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-21-git-send-email-cederp@opera.com>
 <CAPig+cQ8aPSjCzf0AjNQRvtJJ52eaOi=fJNZ8vXdnFoE5vxyAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Per Cederqvist <cederp@opera.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:33:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whluy-0007Pi-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbaEFUYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2014 16:24:45 -0400
Received: from josefsipek.net ([64.9.206.49]:1615 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261AbaEFUYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:24:43 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 2DF9055654;
	Tue,  6 May 2014 16:24:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQ8aPSjCzf0AjNQRvtJJ52eaOi=fJNZ8vXdnFoE5vxyAQ@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248245>

On Fri, Mar 21, 2014 at 03:57:37AM -0400, Eric Sunshine wrote:
> On Fri, Mar 21, 2014 at 3:31 AM, Per Cederqvist <cederp@opera.com> wr=
ote:
> > Quote quotes with a backslash in the "guitl graph" output.  Otherwi=
se,
>=20
> s/guitl/guilt/

Yep.

> > the "dot" file could contain syntax errors.
> >
> > Added a test case.
> > ---
> >  guilt-graph          |  2 ++
> >  regression/t-033.out | 22 ++++++++++++++++++++++
> >  regression/t-033.sh  |  9 +++++++++
> >  3 files changed, 33 insertions(+)
> >
> > diff --git a/guilt-graph b/guilt-graph
> > index 575f03b..24ab83b 100755
> > --- a/guilt-graph
> > +++ b/guilt-graph
> > @@ -58,6 +58,8 @@ while [ "$current" !=3D "$base" ]; do
> >  }"`
> >         [ -z "$pname" ] && pname=3D"?"
> >
> > +       pname=3D"`printf \"%s\" $pname|sed 's/\"/\\\\\"/g'`"

Some of this filtering is getting a bit unwieldy.  I'd add spaces aroun=
d the
|.  Do we want to be paranoid and add quotes around $pname?  If not, th=
en it
looks good.

> > +
> >         disp "# checking rev $current"
> >         disp "  \"$current\" [label=3D\"$pname\"]"
> >
> > diff --git a/regression/t-033.out b/regression/t-033.out
> > index e638d7b..1c28ea9 100644
> > --- a/regression/t-033.out
> > +++ b/regression/t-033.out
> > @@ -63,3 +63,25 @@ digraph G {
> >         "ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label=3D"a.patc=
h"]
> >         "891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc=
753f635830adcc3a067e0b681e2d"; // ?
> >  }
> > +% guilt new a-"better&quicker'-patch.patch
> > +% git add file.txt
> > +% guilt refresh
> > +Patch a-"better&quicker'-patch.patch refreshed
> > +% guilt pop
> > +Now at c.patch.
> > +% guilt push
> > +Applying patch..a-"better&quicker'-patch.patch
> > +Patch applied.
> > +% guilt graph
> > +digraph G {
> > +# checking rev bc7df666a646739eaf559af23cab72f2bfd01f0e
> > +       "bc7df666a646739eaf559af23cab72f2bfd01f0e" [label=3D"a-\"be=
tter&quicker'-patch.patch"]
> > +# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
> > +       "891bc14b5603474c9743fd04f3da888644413dc5" [label=3D"c.patc=
h"]
> > +       "bc7df666a646739eaf559af23cab72f2bfd01f0e" -> "891bc14b5603=
474c9743fd04f3da888644413dc5"; // ?
> > +# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
> > +       "c7014443c33d2b0237293687ceb9cbd38313df65" [label=3D"b.patc=
h"]
> > +# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
> > +       "ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label=3D"a.patc=
h"]
> > +       "891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc=
753f635830adcc3a067e0b681e2d"; // ?
> > +}
> > diff --git a/regression/t-033.sh b/regression/t-033.sh
> > index 57dce78..968292c 100755
> > --- a/regression/t-033.sh
> > +++ b/regression/t-033.sh
> > @@ -46,3 +46,12 @@ cmd git add file.txt
> >  cmd guilt refresh
> >  fixup_time_info c.patch
> >  cmd guilt graph
> > +
> > +# A patch name that contains funky characters, including unbalance=
d
> > +# quotes.
> > +cmd guilt new "a-\"better&quicker'-patch.patch"
> > +cmd echo d >> file.txt
> > +cmd git add file.txt
> > +cmd guilt refresh
> > +fixup_time_info "a-\"better&quicker'-patch.patch"
> > +cmd guilt graph
> > --
> > 1.8.3.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
All parts should go together without forcing.  You must remember that t=
he
parts you are reassembling were disassembled by you.  Therefore, if you
can=E2=80=99t get them together again, there must be a reason.  By all =
means, do not
use a hammer.
		=E2=80=94 IBM Manual, 1925
