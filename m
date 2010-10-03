From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH 3/6] tg-files: list files changed by the topic
	branch
Date: Mon, 4 Oct 2010 00:03:30 +0200
Message-ID: <20101003220330.GE28679@pengutronix.de>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com> <1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com> <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 00:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Wef-0001T8-TT
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 00:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab0JCWDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 18:03:32 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59414 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab0JCWDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 18:03:32 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2WeZ-0002O8-7o; Mon, 04 Oct 2010 00:03:31 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2WeY-00022f-Sp; Mon, 04 Oct 2010 00:03:30 +0200
Content-Disposition: inline
In-Reply-To: <1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157938>

Hi Bert,

On Sun, Oct 03, 2010 at 11:25:54PM +0200, Bert Wesarg wrote:
> this could also be a --name-only option to tg-patch. But I Like the
> similarity to 'quilt files'.
>=20
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>=20
> ---
>  .gitignore                 |    2 +
>  README                     |    8 ++++++
>  contrib/tg-completion.bash |    1 +
>  tg-files.sh                |   52 ++++++++++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 63 insertions(+), 0 deletions(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index 0342e09..0dc4d0e 100644 .gitignore
> --- a/.gitignore
> +++ b/.gitignore
> @@ -22,6 +22,8 @@
>  /tg-depend.txt
>  /tg-export
>  /tg-export.txt
> +/tg-files
> +/tg-files.txt
>  /tg-import
>  /tg-import.txt
>  /tg-info
> diff --git a/README b/README
> index f103d92..46f564a 100644 README
> --- a/README
> +++ b/README
> @@ -272,6 +272,14 @@ tg depend
> =20
>  	TODO: Subcommand for removing dependencies, obviously
> =20
> +tg files
> +~~~~~~~~
> +	List files changed by the current or specified topic branch.
> +
> +	Options:
> +	  -i		list files based on index instead of branch
> +	  -w		list files based on working tree instead of branch
> +
>  tg info
>  ~~~~~~~
>  	Show a summary information about the current or specified
> diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
> index 0ee233c..38567d0 100755 contrib/tg-completion.bash
> --- a/contrib/tg-completion.bash
> +++ b/contrib/tg-completion.bash
> @@ -467,6 +467,7 @@ _tg ()
>  	delete)      _tg_delete ;;
>  	depend)      _tg_depend ;;
>  	export)      _tg_export ;;
> +	files)       _tg_patch ;;
>  	help)        _tg_help ;;
>  	import)      _tg_import ;;
>  	info)        _tg_info ;;
> diff --git a/tg-files.sh b/tg-files.sh
> new file mode 100644
> index 0000000..0723bf1 tg-files.sh
> --- /dev/null
> +++ b/tg-files.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +# TopGit - A different patch queue manager
> +# (c) Petr Baudis <pasky@suse.cz>  2008
> +# GPLv2
> +
> +name=3D
> +
> +topic=3D
> +diff_opts=3D
> +diff_committed_only=3Dyes	# will be unset for index/worktree
> +
> +
> +## Parse options
> +
> +while [ -n "$1" ]; do
> +	arg=3D"$1"; shift
> +	case "$arg" in
> +	-i)
> +		topic=3D'(i)'
> +		diff_opts=3D"$diff_opts --cached";
> +		diff_committed_only=3D;;
> +	-w)
> +		topic=3D'(w)'
> +		diff_committed_only=3D;;
> +	-*)
> +		echo "Usage: tg [...] files [-i | -w] [NAME]" >&2
> +		exit 1;;
> +	*)
> +		[ -z "$name" ] || die "name already specified ($name)"
> +		name=3D"$arg";;
> +	esac
> +done
> +
> +
> +[ -n "$name"  -a  -z "$diff_committed_only" ]  &&
> +	die "-i/-w are mutually exclusive with NAME"
> +
> +[ -n "$name" ] || name=3D"$(git symbolic-ref HEAD | sed 's#^refs/\(h=
eads\|top-bases\)/##')"
> +base_rev=3D"$(git rev-parse --short --verify "refs/top-bases/$name" =
2>/dev/null)" ||
> +	die "not a TopGit-controlled branch"
> +
> +# if not index/worktree, topic is current branch
> +[ -z "$topic" ] && topic=3D"$name"
> +
> +
> +
> +# Evil obnoxious hack to work around the lack of git diff --exclude
> +git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"=
$name"} -- |
> +	fgrep -vx ".topdeps" |
> +	fgrep -vx ".topmsg" || : # fgrep likes to fail randomly?
Instead of using fgrep you could export the branch and call git diff
--name-only $diff_opts on the resulting commit?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
