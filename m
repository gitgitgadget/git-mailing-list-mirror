From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH v4 4/6] completion: simplify command stuff
Date: Mon, 7 May 2012 12:08:58 +0200
Message-ID: <20120507100858.GQ2164@goldbirke>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
	<1336353800-17323-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 12:09:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKsP-0007Yx-HO
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 12:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab2EGKJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 06:09:04 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:51016 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997Ab2EGKJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 06:09:03 -0400
Received: from localhost6.localdomain6 (p5B13051B.dip0.t-ipconnect.de [91.19.5.27])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M40YM-1S97If3YDi-00qyXs; Mon, 07 May 2012 12:09:00 +0200
Content-Disposition: inline
In-Reply-To: <1336353800-17323-5-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:qqdjq33pMCFh/mJKN1qbvJgCoxiJLM1bY0X0vkayLGo
 +eIKuOsAb0Jwz4riBXINLne0IWKyIdZqbrf4cG/Lrm61dUXKwW
 0k8tCKFHaJWKcbowdn3q0F3zZLREJp6/C2QzTJOp5RPBPE3Rlj
 aarM9I30amNCAMEH7+RvGV+3e8ie+w6tSPtJ5WMQpZyvy5dahd
 LiiJVkzL/In7AR/AHFVZbaKBam7ii35dSK26IaLVY5B4XZmNG7
 Di3FJKaudKk+r5rY0H/le+SluzlwUcu7w/pdladwebpFHLPZS4
 XJcRFSYMaet3dLN4lq+EzICETC19PQqfarsI4G+LElYO0UBZm4
 +ycx1bU+UO20RPV0TRQs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197255>

Hi,

On Mon, May 07, 2012 at 03:23:18AM +0200, Felipe Contreras wrote:
> No need to recalculate it.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

This seems to be the same patch you sent earlier as 7/12 in the first
round.  I had a few comments back then, see

  http://thread.gmane.org/gmane.comp.version-control.git/194958/focus=3D=
195276

But this $cmd variable will be only used in
__git_complete_remote_or_refspec(), so perhaps your idea later in that
thread about invoking it from _git_fetch() as

  __git_complete_remote_or_refspec "fetch"

would be better.  That would only require one modification in its four
callers, but neither in _git() in this patch nor in __git_complete()
later in the series to set $cmd.


Best,
G=E1bor


> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 8de0358..e648d7c 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -723,7 +723,7 @@ __git_complete_revlist ()
> =20
>  __git_complete_remote_or_refspec ()
>  {
> -	local cur_=3D"$cur" cmd=3D"${words[1]}"
> +	local cur_=3D"$cur"
>  	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
>  	if [ "$cmd" =3D "remote" ]; then
>  		((c++))
> @@ -2603,22 +2603,22 @@ _git_whatchanged ()
> =20
>  _git ()
>  {
> -	local i c=3D1 command __git_dir
> +	local i c=3D1 cmd __git_dir
> =20
>  	while [ $c -lt $cword ]; do
>  		i=3D"${words[c]}"
>  		case "$i" in
>  		--git-dir=3D*) __git_dir=3D"${i#--git-dir=3D}" ;;
>  		--bare)      __git_dir=3D"." ;;
> -		--help) command=3D"help"; break ;;
> +		--help) cmd=3D"help"; break ;;
>  		-c) c=3D$((++c)) ;;
>  		-*) ;;
> -		*) command=3D"$i"; break ;;
> +		*) cmd=3D"$i"; break ;;
>  		esac
>  		((c++))
>  	done
> =20
> -	if [ -z "$command" ]; then
> +	if [ -z "$cmd" ]; then
>  		case "$cur" in
>  		--*)   __gitcomp "
>  			--paginate
> @@ -2642,10 +2642,10 @@ _git ()
>  		return
>  	fi
> =20
> -	local completion_func=3D"_git_${command//-/_}"
> +	local completion_func=3D"_git_${cmd//-/_}"
>  	declare -f $completion_func >/dev/null && $completion_func && retur=
n
> =20
> -	local expansion=3D$(__git_aliased_command "$command")
> +	local expansion=3D$(__git_aliased_command "$cmd")
>  	if [ -n "$expansion" ]; then
>  		completion_func=3D"_git_${expansion//-/_}"
>  		declare -f $completion_func >/dev/null && $completion_func
> --=20
> 1.7.10
>=20
