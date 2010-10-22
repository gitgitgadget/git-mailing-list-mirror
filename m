From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Thu, 21 Oct 2010 21:08:42 -0400
Message-ID: <20101021210842.6545a661@montecarlo.grandprix.int>
References: <4CC05E4B.1010106@xiplink.com>
	<4CC06439.8040003@xiplink.com>
	<20101021191045.GC11759@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 03:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P967v-00006e-5Z
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 03:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab0JVBIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 21:08:53 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:49595 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0JVBIw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 21:08:52 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1P967g-0003jY-1t; Thu, 21 Oct 2010 18:08:44 -0700
Received: from montecarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id BBB48101F82;
	Thu, 21 Oct 2010 21:08:42 -0400 (EDT)
In-Reply-To: <20101021191045.GC11759@burratino>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159628>

On Thu, 21 Oct 2010 14:10:45 -0500
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Marc Branchaud wrote:
>=20
> > Hmmm, perhaps this is really a bug.
>=20
> Compare:
> http://thread.gmane.org/gmane.comp.version-control.git/159448
>=20
> G=E1bor, would it be possible to summarize the problem with a simple
> test case that could be used to get help on this from the (upstream
> or distro-specific) bash maintainers?
> --

In the case of Marc's problem, it would be helpful to see what the
result is in Bash 3.

As for G=E1bor find:
The problem resides in Bash 4. Bash 4 has a new set of characters that
are defined as break up characters
Thanks to Brain Gernhard:=20
=46rom the Bash 4.0 changelog:
i.  The programmable completion code now uses the same set of
characters as readline when breaking the command line into a list of
words.

As far as I can tell, from the Bash 4.0 source, these are the
characters: " \t\n\"'@><=3D;|&(:"=20
In the completion script checks are performed if an option is given.
The test includes the equal sign but the array with words does not the
equal sign. Example to clarify:

local cur=3D"${COMP_WORDS[COMP_CWORD]}" dir=3D"$(__gitdir)"
case "$cur" in
  --whitespace=3D*)
      __gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=3D}"
      return
      ;;

If you execute:
$ git am --whitespace=3D<tab><tab>

The variable cur holds the equal sign and so the __gitcomp function is
never executed.

I have patched the entire completion script which fixes this, and some
other issues related to the Bash 4 change, but it will only work in Bas=
h
4.0 and I am sure it will dramatically fail in Bash 3.0.
I don't have the knowledge to determine which Bash version is running
in the git.spec.in file. If you could that would be a way to either
install the new version or the old one.


--=20
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes

WordPress Plugin Developer
Blog: http://blog.avirtualhome.com
=46orums: http://forums.avirtualhome.com
Twitter: @avhsoftware
