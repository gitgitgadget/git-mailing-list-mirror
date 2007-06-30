From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (2nd try)] Add git-stash script
Date: Fri, 29 Jun 2007 19:23:42 -0700
Message-ID: <7vbqeydvtd.fsf@assigned-by-dhcp.pobox.com>
References: <200706300126.l5U1QPda021795@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 04:23:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Scp-0001eB-Jt
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 04:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbXF3CXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Jun 2007 22:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbXF3CXo
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 22:23:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62054 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbXF3CXn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jun 2007 22:23:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630022343.LJDW3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 22:23:43 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HePi1X0071kojtg0000000; Fri, 29 Jun 2007 22:23:42 -0400
In-Reply-To: <200706300126.l5U1QPda021795@mi1.bluebottle.com>
	(nanako3@bluebottle.com's message of "Sat, 30 Jun 2007 10:29:06
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51188>

 =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 <nanak=
o3@bluebottle.com> writes:

> Unfortunately I haven't managed to get the suggestion to use
> "export GITHEAD_xxxx=3DNicerName" from Johannes Schindelin working
> yet.

I'd drop hints below, but first...

>  git-stash.sh |  153 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 153 insertions(+), 0 deletions(-)
>  create mode 100755 git-stash.sh

=2E.. we would want an entry in .gitignore and Makefile as well ;-)

> diff --git a/git-stash.sh b/git-stash.sh
> new file mode 100755
> index 0000000..8bf83c1
> --- /dev/null
> +++ b/git-stash.sh
> ...
> +apply_stash () {
> +	git-diff-files --quiet ||
> +		die 'Cannot restore on top of a dirty state'
> +
> +	# current index state
> +	c_tree=3D$(git-write-tree) ||
> +		die 'Cannot apply a stash in the middle of a merge'
> +
> +	s=3D$(git-rev-parse --revs-only --no-flags --default $ref_stash "$@=
") &&
> +	w_tree=3D$(git-rev-parse --verify "$s:") &&
> +	b_tree=3D$(git-rev-parse --verify "$s^:") ||
> +		die "$*: no valid stashed state found"

At this point, you would say:

	eval "
		GITHEAD_$w_tree=3D'Stashed changes' &&
                GITHEAD_$c_tree=3D'Updated upstream' &&
                GITHEAD_$b_tree=3D'Version stash was based on'
	" &&
	export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree

I suspect you did not use eval and got syntax errors from
variable assignment from the shell?

	VAR_$iable=3D'Assign ment'

is a syntax error, while

	export VAR_$iable

is not.  Don't ask me why.
