From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/5] git-bisect: use dash-less form on git bisect log
Date: Fri, 11 Jul 2008 08:39:14 +0200
Message-ID: <200807110839.14764.chriscool@tuxfamily.org>
References: <cover.1215734604.git.vmiklos@frugalware.org> <9568dd5d03cd0f1da8872fd71f8bb253560e2352.1215734605.git.vmiklos@frugalware.org> <eb505d0d8f7d2bf50073414baa799a80a9df7453.1215734605.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 08:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHCF2-0004PY-Kh
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 08:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbYGKGfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jul 2008 02:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbYGKGfZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 02:35:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:41321 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbYGKGfY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jul 2008 02:35:24 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9B2DD1AB2F0;
	Fri, 11 Jul 2008 08:35:22 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 60B191AB2AA;
	Fri, 11 Jul 2008 08:35:22 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <eb505d0d8f7d2bf50073414baa799a80a9df7453.1215734605.git.vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88084>

Le vendredi 11 juillet 2008, Miklos Vajna a =E9crit :
> Given that users are supposed to type 'git bisect' now, make the outp=
ut
> of 'git bisect log' consistent with this.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  git-bisect.sh |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 991b2ef..f4852a9 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -149,7 +149,7 @@ bisect_start() {
>  	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
>  	sq "$@" >"$GIT_DIR/BISECT_NAMES" &&
>  	eval "$eval" &&
> -	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
> +	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
>  	#
>  	# Check if we can proceed to the next bisect state.
>  	#
> @@ -169,7 +169,7 @@ bisect_write() {
>  	esac
>  	git update-ref "refs/bisect/$tag" "$rev" || exit
>  	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
> -	test -n "$nolog" || echo "git-bisect $state $rev"
> >>"$GIT_DIR/BISECT_LOG" +	test -n "$nolog" || echo "git bisect $state
> $rev" >>"$GIT_DIR/BISECT_LOG" }
>
>  bisect_state() {
> @@ -426,9 +426,9 @@ bisect_clean_state() {
>  bisect_replay () {
>  	test -r "$1" || die "cannot read $1 for replaying"
>  	bisect_reset
> -	while read bisect command rev
> +	while read git bisect command rev
>  	do
> -		test "$bisect" =3D "git-bisect" || continue
> +		test "$git $bisect" =3D "git bisect" || continue
>  		case "$command" in
>  		start)
>  			cmd=3D"bisect_start $rev"

Wouldn't it be better if bisect_replay could read old logs?

Maybe with something like:

+	while read git bisect command rev
 	do
-		test "$bisect" =3D "git-bisect" || continue
+		test "$git $bisect" =3D "git bisect" -o "$git" =3D "git-bisect" || c=
ontinue
+		if test "$git" =3D "git-bisect"; then
+			rev=3D"$command"
+			command=3D"$bisect"
+		fi
 		case "$command" in
 		start)
 			cmd=3D"bisect_start $rev"

Thanks,
Christian.
