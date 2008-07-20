From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Mon, 21 Jul 2008 01:08:46 +0200
Message-ID: <20080720230846.GH32184@machine.or.cz>
References: <1216592735-23789-1-git-send-email-code@istique.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steve =?iso-8859-2?Q?Fr=E9cinaux?= <code@istique.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 01:09:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKi2G-0004QY-VL
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbYGTXIs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2008 19:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbYGTXIs
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:08:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47622 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbYGTXIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:08:48 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 472A8393B31D; Mon, 21 Jul 2008 01:08:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1216592735-23789-1-git-send-email-code@istique.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89261>

On Mon, Jul 21, 2008 at 12:25:35AM +0200, Steve Fr=E9cinaux wrote:
> The notice covers this behaviour:
> if you are in the git/ subdirectory of your repository, it will pick
> the tree corresponding to that directory instead of the root one if y=
ou
> specify the root tree object id.
>=20
> Compare the output of both of those commands:
>  git-ls-tree cb44e6571708aa2792c73a289d87586fe3c0c362
>  git-cat-file -p cb44e6571708aa2792c73a289d87586fe3c0c362
> ---
>  Documentation/git-ls-tree.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tre=
e.txt
> index 1cdec22..7cba394 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -21,6 +21,10 @@ though - 'paths' denote just a list of patterns to=
 match, e.g. so specifying
>  directory name (without '-r') will behave differently, and order of =
the
>  arguments does not matter.
> =20
> +Note that if you give ls-tree the sha1 id of a parent of the tree
> +corresponding to the directory you're in, it will resolve that tree =
and list
> +its contents instead of listing the contents of the tree you gave.
> +
>  OPTIONS
>  -------
>  <tree-ish>::

It's hard to make out what do you mean, the patch description is much
clearer, paradoxically. Also, this in fact holds for the root tree
instead of the parent tree, and the behaviour changes from "weird" to
"simply broken" when you try to list a tree object that is _not_ the
root project tree from within a subdirectory:

	git$ git ls-tree HEAD Documentation
	040000 tree 066c25e86a44d4c7bde2d3e9b91e6891d752efa1    Documentation
	git/Documentation$ git ls-tree 066c25e86a44d4c7bde2d3e9b91e6891d752efa=
1
	git/Documentation$

I think that ls-tree simply shouldn't auto-fill its pathspec based on
current prefix in case no pathspec was supplied. Patch to follow.

--=20
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
