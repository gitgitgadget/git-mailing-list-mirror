From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: FEATURE REQUEST: Cherry pick in not checked out branch
Date: Mon, 15 Mar 2010 14:12:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003151359440.7596@pacific.mpi-cbg.de>
References: <be8f531d1003150139p7cc99700m807ab21bddf8fbb@mail.gmail.com>,<fabb9a1e1003150243o21bab937y122ac61d65777d5f@mail.gmail.com> <SNT124-W1769013489F8B7CE42C581C42E0@phx.gbl> <4B9E13A4.3090502@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 15 14:07:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrA1R-0001is-UU
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 14:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936259Ab0CONHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 09:07:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:54061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934247Ab0CONHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 09:07:48 -0400
Received: (qmail invoked by alias); 15 Mar 2010 13:07:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 15 Mar 2010 14:07:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LQ/N56dyLR890YPJPpeof/p0QGfyQiYyWfUBqwh
	bytA1tMkgUhB6j
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B9E13A4.3090502@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52000000000000002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142208>

Hi,

On Mon, 15 Mar 2010, Michael J Gruber wrote:

> Tim Mazid venit, vidit, dixit 15.03.2010 10:54:
> 
> > Could we not make cherry-pick "stash, checkout, cherry-pick, checkout, 
> > pop"?
> 
> Sure, that would be 5 command invocations requiring a work tree ;)

Actually, if you want something that does not change all the timestamps, 
and that does only trivial merges (i.e. no conflicts), you may have luck 
with something like this:

	test $# = 2 || {
		echo "Usage: $0 <commit> <branch>" >&2
		exit 1
	}
	GIT_INDEX_FILE=.git/tmp.index &&
	export GIT_INDEX_FILE &&
	git read-tree "$2" &&
	git diff "$1"^! | git apply --index &&
	tree=$(git write-tree) &&
	msg="$(git cat-file commit "$1" | sed '1,/^$/d')" &&
	commit=$(echo "$msg" | git commit-tree $tree -p "$2") &&
	git update-ref -m cherry-pick-2.0 "$2" $commit

Totally Untested(tm),
Dscho
