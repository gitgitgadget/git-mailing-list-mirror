From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH (3rd try)] Add git-stash script
Date: Sat, 30 Jun 2007 16:41:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301641000.4438@racer.site>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
 <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-672430328-1183218059=:4438"
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 17:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4f4h-0006kK-KS
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 17:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbXF3PlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 11:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXF3PlR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 11:41:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:55904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753828AbXF3PlR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 11:41:17 -0400
Received: (qmail invoked by alias); 30 Jun 2007 15:41:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 30 Jun 2007 17:41:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UBhETdvYUJnM+q+kMUoRZPVSPCdy6wGVCPb2KOO
	v1b0F9kqRH4l0g
X-X-Sender: gene099@racer.site
In-Reply-To: <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51220>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-672430328-1183218059=:4438
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 30 Jun 2007, しらいしななこ wrote:

> diff --git a/git-stash.sh b/git-stash.sh
> [...]
> +	printf >&2 'Saved WIP on %s\n' "$msg"

You have an awful lot of printfs in the code. Why not just use echos?

> +list_stash () {
> +	git-log --pretty=oneline -g "$@" $ref_stash |

Wouldn't you want "--default $ref_stash" here?

> +apply_stash () {
> +	git-diff-files --quiet ||
> +		die 'Cannot restore on top of a dirty state'

You meant "no_changes", right? I think you miss changes in the index 
otherwise.

> +		git-diff --cached --name-only --diff-filter=A $c_tree >"$a" &&
> +		git-read-tree --reset $c_tree &&
> +		git-update-index --add --stdin <"$a" ||
> +			die "Cannot unstage modified files"

Isn't there a way to avoid the temporary file here?

> +	else
> +		# Merge conflict
> +		exit 1

Since $? is already != 0, and it might tell the savvy user what kind of 
error merge-recursive returned, why not use "exit", which is equivalent to 
"exit $?"?

> +		set x -n 10
> +		shift

This is more elegantly written as "set -- -n 10", or in our context even 
"set -- -10".

Ciao,
Dscho

--8323584-672430328-1183218059=:4438--
