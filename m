From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 08/10] t2200, t7004: Avoid glob pattern that also matches files
Date: Thu, 19 Mar 2009 20:52:42 +0100
Message-ID: <200903192052.43162.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org> <3827d7fab3e9e233a0ac528b84ab2d6a36658365.1237410682.git.j6t@kdbg.org> <7v7i2mbap2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:54:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOJo-0005An-8c
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbZCSTwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 15:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbZCSTwt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:52:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:60231 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbZCSTws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 15:52:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 29FB81002D;
	Thu, 19 Mar 2009 20:52:44 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D07651D224;
	Thu, 19 Mar 2009 20:52:43 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v7i2mbap2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113813>

On Donnerstag, 19. M=E4rz 2009, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > On Windows, there is an unfortunate interaction between the MSYS ba=
sh and
> > git's command line processing:
> >
> > - Since Windows's CMD does not do the wildcard expansion, but passe=
s
> >   arguments like path* through to the programs, the programs must d=
o the
> >   expansion themselves. This happens in the startup code before mai=
n() is
> >   entered.
> >
> > - bash, however, passes the argument "path*" to git, assuming that =
git
> > will see the unquoted word unchanged as a single argument.
> >
> > But actually git expands the unquoted word before main() is entered=
=2E
>
> Doesn't this mean on Windows, the glob pathspec git supports is not u=
seful
> at all?

No, it is still useful. There is a difference if I say

   git add "*a*"

from bash or from Windows's CMD. The latter passes the argument to git =
with=20
the dquotes; the startup code removes them and does not expand the wild=
card.=20
But if bash invokes the command, bash removes the quotes, so that the s=
tartup=20
code only sees *a* and does the expansion.

> > In t2200, not all names that the test case is interested in exist a=
s
> > files at the time when 'git ls-files' is invoked. git expands "path=
?" to
> > only the subset of files the exist, and only that subset was listed=
, so
> > that the test failed.  We now list all interesting paths explicitly=
=2E
>
> But that conversion misses the whole point of that particular test,
> doesn't it?  It wants to see path2 that was unmerged and existed only=
 in
> the index but not in the work tree has disappeared, while the similar=
ly
> unmerged path1 resolved after "add -u".  IOW, you are not testing tha=
t
> "add -u" notices a removal of path2 from the work tree anymore.

I see. Then I'll just add path2 to the list, OK? It still passes the te=
st.

-- Hannes
