From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 18:08:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811261804550.30769@pacific.mpi-cbg.de>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>  <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>  <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>  <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
  <492D6CC3.2050408@drmicha.warpmail.net> <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com> <alpine.DEB.1.00.0811261739110.30769@pacific.mpi-cbg.de> <492D7CF5.1020202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 18:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Nm5-0003Tc-Nm
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 18:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYKZRAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 12:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbYKZRAr
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 12:00:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:46773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754223AbYKZRAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 12:00:46 -0500
Received: (qmail invoked by alias); 26 Nov 2008 17:00:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 26 Nov 2008 18:00:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IMq0TFoAIKrISed6yENn62+sUyk4vO3Htpf47t4
	pA582dzeLFGOtU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <492D7CF5.1020202@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101748>

Hi,

On Wed, 26 Nov 2008, Michael J Gruber wrote:

> Looking at the source I suspect that fast-export fails to denote 
> parenthood in the case of yet unmarked parents (last for-loop of 
> handle_commit() in builtin_fast_export.c). But I don't really know that 
> code at all.

I strongly doubt so.  Noticed the use of has_unshown_parent(commit) in 
both cases before calling handle_commit()?

In any case, here is a script that I wrote _long_ time ago, to be able to 
reconstruct history from the output of "git rev-list --all --parents".  
Maybe this helps you in reconstructing something that is handled 
incorrectly by fast-export | fast-import, but is lighter than a full-blown 
repository.

-- snip --
#!/bin/sh

# Given the output of git-rev-list, this reconstructs the DAG of the 
history

i=0
tac | while read rev parents; do
        let i=$i+1
        echo $i > a1
        git add a1
        tree=$(git write-tree)
        parents="$(for parent in $parents
                do
                        echo -n "-p $(git rev-parse sp-$parent) "
                done)"
        commit=$(echo "$rev $i" | git commit-tree $tree $parents)
        git tag sp-$rev $commit
done
-- snap --

Ciao,
Dscho

--

          |

Ceci n'est pas une pipe
