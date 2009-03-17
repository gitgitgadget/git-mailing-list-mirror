From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] tg-patch: fix invocation in sub working tree
	directory
Date: Tue, 17 Mar 2009 09:33:26 +0100
Message-ID: <20090317083326.GA22384@pengutronix.de>
References: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjUlZ-0000pi-Ht
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 09:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762777AbZCQIdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 04:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762755AbZCQIdd
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 04:33:33 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56492 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbZCQIda (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 04:33:30 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LjUjm-0003W1-WB; Tue, 17 Mar 2009 09:33:27 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LjUjm-0006JN-FM; Tue, 17 Mar 2009 09:33:26 +0100
Content-Disposition: inline
In-Reply-To: <1237241299-25515-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113440>

Hello again,

On Mon, Mar 16, 2009 at 11:08:19PM +0100, Bert Wesarg wrote:
> --- a/tg-patch.sh
> +++ b/tg-patch.sh
> @@ -50,13 +50,18 @@ cat_file "$topic:.topmsg"
>  echo
>  [ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"}=
 -- ".topmsg")" ] || echo '---'
> =20
> +# if we are in a sub working tree dir, we need to prefix all file na=
mes from
> +# git diff --name-only with this cdup
> +cdup=3D$(git rev-parse --show-cdup)
> +
>  # Evil obnoxious hack to work around the lack of git diff --exclude
>  git_is_stupid=3D"$(mktemp -t tg-patch-changes.XXXXXX)"
>  git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"=
$name"} -- |
>  	fgrep -vx ".topdeps" |
>  	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail ra=
ndomly?
>  if [ -s "$git_is_stupid" ]; then
> -	cat "$git_is_stupid" | xargs git diff --patch-with-stat $diff_opts =
"$base_rev" ${diff_committed_only:+"$name"} --
> +	sed -e "s#^#$cdup#" "$git_is_stupid" |
> +		xargs git diff --patch-with-stat $diff_opts "$base_rev" ${diff_com=
mitted_only:+"$name"} --
My not move pretty_tree from tg-export.sh to tg.sh and use that.
i.e.

	git diff $someopts "$(pretty_tree "$base_rev")" "$(pretty_tree "...")"

then we wouldn't need that git_is_stupid-hack and the relative path nam=
e
thinggy wouldn hurt us.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
