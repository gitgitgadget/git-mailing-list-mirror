From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: broken bash completion
Date: Sat, 5 May 2012 01:32:13 +0200
Message-ID: <20120504233213.GF2164@goldbirke>
References: <4FA14016.8050503@rolf.leggewie.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rolf Leggewie <foss@rolf.leggewie.biz>
X-From: git-owner@vger.kernel.org Sat May 05 01:32:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQRzB-0000Jb-F8
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 01:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760628Ab2EDXcZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 19:32:25 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:55649 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2EDXcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 19:32:24 -0400
Received: from localhost6.localdomain6 (p5B1305D8.dip0.t-ipconnect.de [91.19.5.216])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M0spD-1SAqZr2h0p-00uxY8; Sat, 05 May 2012 01:32:17 +0200
Content-Disposition: inline
In-Reply-To: <4FA14016.8050503@rolf.leggewie.biz>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:PoOSTMiHpMtGaLwKf/l+3GKqB/b97j6FaBb1RpmnxOo
 YZ5+E82rplwN+HKQd8HqEUhU0Rn0ygxuaW4qNnxNLDWLkFOuxp
 TUO5wxF9S7p1kKCu0Kw2Gdo0Tm93lCSTeOcKjdPX3+XbajuYvY
 uCq5Ic3K+a76pOtoIs/Grl8fqPwhueMTHdrAiqH+2uDQv0cScC
 p0AHcZuo81Ww1oZyEk2Yk7t6gDMwobDCiPOhFbzPNbbaaPWa1e
 R2PuIT0ZfpIb7XotuCyQBepwYFCpO5YrGmIYpim9kuTl35y+iZ
 nKo/NCP9tA9mfrcc7TZbKUD69wL1OakhYBHsqeR8MqgV5OTGf/
 C/Ci/7KiAXs9nZXMe9Yo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197083>

Hi,


On Wed, May 02, 2012 at 10:09:26PM +0800, Rolf Leggewie wrote:
> Current bash completion works the following way.
>=20
> 1) only tag-completion possible: complete tag as much as possible
> 2) only file/dir-completion possible: complete path as much as possib=
le
> 3) all of tag/file/dir-completion possible: complete tag (!) as much
> as possible
>=20
> 1 and 2 are fine, but for #3 git should really stop at the lowest
> common denominator for all of tags, files and directories. This is
> explained better in above tickets, but I'll also include an example
> here for illustration.  Let's say I had tags debian/1.4.9-1 and
> debian/1.4.9-2 as well as debian/changelog file (as is common when
> using git-buildpackage, this is a real life example).  Current
> bash-completion behavior for "git log debiTAB" is to complete to
> "git log debian/1.4.9-"

Yeah, there are a lot of git commands that accept refs (not just tags)
and files as well.  When completing a non-option word (i.e. a word
that does not begin with a double dash) for such a command, git's
completion script offers only refs, but when none of the refs matches
the word to be completed, then COMPREPLY remains empty and Bash falls
back to the default filename completion.

Now, to resolve ambiguity between options/refs and paths, the '--'
separator should be used before the first path to separate options and
refs from paths.  The completion script recognizes this separator, and
lets Bash perform filename completion for subsequent words.  So if you
know that you want to complete a file, then 'git log -- d<TAB>' will
give you 'debian/'.  Alternatively, you can just prefix './' to the
path, e.g. write 'git log ./d<TAB>' to get './debian/'.

> when it really should be "git log debian/".

I understand why you think that offering 'debian/' there would be the
correct behavior.  However, in this case being correct is perhaps not
the right thing.  Currently 'git log c<TAB>' offers me a couple of
completion-related branches, but with your correct behavior that would
be cluttered by all files and directories starting with 'c'.  I for
one would find that inconvenient and annoying, especially because,
while there are easy ways to get filename completion instead of refs,
as shown above, there is no similarly easy way to get only refs
completion. =20


Best,
G=E1bor
