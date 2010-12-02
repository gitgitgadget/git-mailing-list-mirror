From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [PATCH v4 0/2] Make git-completion Bash 4 compatible
Date: Thu, 2 Dec 2010 09:16:13 -0500
Message-ID: <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
	<20101202091624.GB1771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 15:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO9xc-0004Jc-AK
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 15:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735Ab0LBOQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 09:16:27 -0500
Received: from morn.lunarbreeze.com ([216.227.218.220]:43306 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445Ab0LBOQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 09:16:26 -0500
Received: from c-69-248-93-14.hsd1.nj.comcast.net ([69.248.93.14] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PO9xJ-0004Nr-Pg; Thu, 02 Dec 2010 06:16:18 -0800
Received: from MonteCarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id D24A3D79EE;
	Thu,  2 Dec 2010 09:16:14 -0500 (EST)
In-Reply-To: <20101202091624.GB1771@burratino>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; i486-pc-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162706>

On Thu, 2 Dec 2010 03:16:24 -0600
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi again,
>=20
> Peter van der Does wrote:
>=20
> > Make git-completion Bash 4 compatible.
>=20
> Thanks again for this work and sorry for all the fuss.
>=20
> > Peter van der Does (2):
> >   Introduce functions from bash-completion project.
>=20
> This patch introduces a minor regression in that it breaks the
> (already somewhat incomplete) zsh support.  Should be fixable by
> falling back to using COMP_WORDS on zsh.
>=20
> >   Use the new functions to get the current cword.
>=20
> This one introduces some subtle differences between commands and imho
> does more than it set out to do, by differentiating word splitting
> behavior between commands.  bash 3 was not splitting COMP_WORDS at
> equal signs or colons, ever.  Maybe we can start with that and then
> make refinements on top later.
>=20
> While trying that out, I had an idea.  The patch depends on
> understanding the bash-completion library function introduced by patc=
h
> 1, but I think we can avoid that by rearranging the patch series like
> this:
>=20
>  1. If _get_comp_words_by_ref is already defined, use it to fetch
>     completion words.  Otherwise, just use COMP_WORDS (using a stub
>     _get_comp_words_by_ref), maintaining the current behavior.
>     [shown below]
>=20
>  2. Import the definition of _get_comp_words_by_ref from the
>     bash-completion lib and use it if ZSH_VERSION is unset.
>=20
>  3. Further refinements, if needed.
>=20
> What do you think?
>=20

I like the idea and we should go with this solution.

If by importing you mean using :
[CODE]. /git_bash_completion-functions[/CODE] in the
contrib/completion/git-completion.bash script, which would be the best
solution imho. The question is where to place that the function file.

This would also means changing the documentation inside the
git-completion.bash script, currently the instructions are:
[QUOTE]
# To use these routines:
#
#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
#    2) Added the following line to your .bashrc:
#        source ~/.git-completion.sh
[/QUOTE]

It would have to include copying the functions file somewhere as well.

Or we could use the method used now and include the functions in the
git-completion.bash script.

I'll be waiting for further feedback from G=E1bor, as he mentioned on t=
he
list of he had some little changes to fix some minor nits and bugs
before completely implementing this solution.

--=20
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes
