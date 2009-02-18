From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] disallow providing multiple upstream branches to rebase,
  pull --rebase
Date: Wed, 18 Feb 2009 14:28:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181427030.6274@intel-tinevez-2-302>
References: <1234932262-63469-1-git-send-email-jaysoffian@gmail.com>  <alpine.DEB.1.00.0902181118160.6274@intel-tinevez-2-302> <76718490902180523l6df2067bxc1274a105756d16b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmUi-00031q-33
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbZBRN2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbZBRN2Q
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:28:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:49299 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752036AbZBRN2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:28:15 -0500
Received: (qmail invoked by alias); 18 Feb 2009 13:28:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp044) with SMTP; 18 Feb 2009 14:28:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18S75deu5oSm7QMEbflFfmHudYwREtYNZ+gbdahWJ
	HdESoejtmP/i3U
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902180523l6df2067bxc1274a105756d16b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110535>

Hi,

On Wed, 18 Feb 2009, Jay Soffian wrote:

> On Wed, Feb 18, 2009 at 5:18 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> diff --git a/git-rebase.sh b/git-rebase.sh
> >> index 5d9a393..ffb6027 100755
> >> --- a/git-rebase.sh
> >> +++ b/git-rebase.sh
> >> @@ -319,6 +319,7 @@ do
> >>       esac
> >>       shift
> >>  done
> >> +test $# -gt 1 && usage
> >
> > Did you just break
> >
> >        $ git rebase $UPSTREAM $BRANCH_TO_SWITCH_TO
> 
> Crap, I missed that usage somehow (and I guess the test suite doesn't
> rely on it either...). I think moving the "test $# -gt 1 && usage"
> below:
> 
> if test -z "$rebase_root"
> then
> 	# The upstream head must be given.  Make sure it is valid.
> 	upstream_name="$1"
> 	shift
> 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
> 	die "invalid upstream $upstream_name"
> 	unset root_flag
> 	upstream_arg="$upstream_name"
> else
> 	test -z "$newbase" && die "--root must be used with --onto"
> 	unset upstream_name
> 	unset upstream
> 	root_flag="--root"
> 	upstream_arg="$root_flag"
> fi
> 
> will do the trick, yes?

Nope.  Note the "shift" in the first arm?  It is so that the code below 
can check for $#, and it indeed does, in a 'case' statement.

(Note: I am writing all this from memory, it could be slightly different, 
but the essence is still valid.)

Ciao,
Dscho
