From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 07/12] completion: simplify command stuff
Date: Thu, 12 Apr 2012 00:14:30 +0200
Message-ID: <20120411221430.GT2289@goldbirke>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5oN-0003TA-Bx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 00:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933499Ab2DKWOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 18:14:36 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:59694 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933495Ab2DKWOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 18:14:34 -0400
Received: from localhost6.localdomain6 (p5B130C22.dip0.t-ipconnect.de [91.19.12.34])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MbF3n-1Sbgze0Ump-00KhFP; Thu, 12 Apr 2012 00:14:29 +0200
Content-Disposition: inline
In-Reply-To: <1333854479-23260-8-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:WhvglbE64nptyHV2bjx1J0uf/ulNaJPB1z8wNNtw+kx
 rezmEo5zHlRIQrV2cI0VDsvEC6m2j7BGouSmMPUjvilv8sv5VR
 4SQJmzqmk8B3SUc/g5NZRjAd04gB1w12z6jQqe9yUB5B/CPgAc
 p88i57FNAgr8HRcBNQzNYNgSWX2HLo96/3VCxCcIU9EvwkwEB3
 LJGKjhDO/hcnZtSdQOsNm/f5aMb1IShQu0fyG/0tRb992ELO8R
 WnEzFOEQlOuvLlpXsfp3ZRUx1SGwEoOTckRWSylOmoccOKSKay
 KI0aP1jRbr/QEDVF3eARjkMKz4wmmfks436KrT23IP4VWwyAFS
 4P9BI3+4H6zc0dBA33ak=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195276>

Hi,


On Sun, Apr 08, 2012 at 06:07:54AM +0300, Felipe Contreras wrote:
> No need to recalculate it.

Based on this short description I would expect that this "command
stuff" is calculated somewhere, and a helper function is changed to
use the already calculated value ...

> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index c9672b2..1fe11f4 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -721,7 +721,7 @@ __git_complete_revlist ()
> =20
>  __git_complete_remote_or_refspec ()
>  {
> -	local cur_=3D"$cur" cmd=3D"${words[1]}"
> +	local cur_=3D"$cur"
>  	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
>  	if [ "$cmd" =3D "remote" ]; then
>  		((c++))
> @@ -2599,7 +2599,7 @@ _git_whatchanged ()
> =20
>  _git ()
>  {
> -	local i c=3D1 command __git_dir
> +	local i c=3D1 cmd __git_dir
> =20
>  	if [[ -n ${ZSH_VERSION-} ]]; then
>  		emulate -L bash
> @@ -2625,13 +2625,13 @@ _git ()
>  		-p|--paginate|--no-pager) ;;
>  		--exec-path=3D*|--html-path|--info-path) ;;
>  		--work-tree=3D*|--namespace=3D*|--no-replace-objects) ;;
> -		--help) command=3D"help"; break ;;
> -		*) command=3D"$i"; break ;;
> +		--help) cmd=3D"help"; break ;;
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
> @@ -2654,10 +2654,10 @@ _git ()
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
> 1.7.10.3.g5a738d
>=20

=2E.. but the bulk of this change is in the top-level _git() function,
as it renames a variable there to match the variable name in the
helper function.  Perhaps it should be the other way around.

However, this change "promotes" the command (or cmd) variable from
being just a variable in _git() to a variable that is used in other
completion functions, too.  Why not go one more step further, and
denote this by adding a __git prefix (i.e. renaming the variable to
__git_command)?


Best,
G=E1bor
