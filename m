From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
   'dirty worktree'
Date: Wed, 04 Feb 2009 18:25:13 +0100
Message-ID: <4989CF79.2070209@viscovery.net>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de> <7vvdrqunog.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlWW-0000N6-Ca
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbZBDRZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbZBDRZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:25:26 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65259 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbZBDRZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:25:25 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUlUv-0004y5-KW; Wed, 04 Feb 2009 18:25:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5E7006D9; Wed,  4 Feb 2009 18:25:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vvdrqunog.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108399>

Junio C Hamano schrieb:
> If so, why do we even check dirtiness of anything at all?
> 
> This is not a "wouldn't this better?" proposal patch, but a "why isn't the
> patch like this?" question patch.
> 
>  git-filter-branch.sh |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git i/git-filter-branch.sh w/git-filter-branch.sh
> index eb62f71..dda32e0 100755
> --- i/git-filter-branch.sh
> +++ w/git-filter-branch.sh
> @@ -107,12 +107,6 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
>  OPTIONS_SPEC=
>  . git-sh-setup
>  
> -if [ "$(is_bare_repository)" = false ]; then
> -	git diff-files --quiet &&
> -	git diff-index --cached --quiet HEAD -- ||
> -	die "Cannot rewrite branch(es) with a dirty working directory."
> -fi
> -
>  tempdir=.git-rewrite
>  filter_env=
>  filter_tree=

Because if the repository is non-bare, then filter-branch updates the
work-tree at the end of the run; we don't want to overwrite uncommitted
work in this case.

This behavior is a relic from cg-admin-rewritehist, I think. I've never
found it useful.

-- Hannes
