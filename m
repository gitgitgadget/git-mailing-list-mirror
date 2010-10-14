From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] bash: support pretty format aliases
Date: Thu, 14 Oct 2010 10:55:38 +0200
Message-ID: <20101014085538.GB838@neumann>
References: <1286746461-7338-1-git-send-email-szeder@ira.uka.de>
	<20101010214410.GA16253@burratino> <20101010220622.GC12529@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 10:55:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6JbM-00051u-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 10:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab0JNIzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 04:55:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab0JNIzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 04:55:47 -0400
Received: from [127.0.1.1] (p5B130B36.dip0.t-ipconnect.de [91.19.11.54])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MJmaK-1P5D8Z3zD2-001chH; Thu, 14 Oct 2010 10:55:40 +0200
Content-Disposition: inline
In-Reply-To: <20101010220622.GC12529@neumann>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V02:K0:DfwFVNENxkqKfgwDUAaQRVN4y2tIZ73WQ+Jj82kDhX+
 TNZXOpIS/3Hmay1bPoT/b0DRV9GEgpmq9Xr7tDe0DDZ96LetA2
 +4ajdW3MZo5fkJoW+jeEySc5bsiZsqDmbRcTED9a4/hfkH/3VG
 9oo7MXUCU55qQ9fCmiqfrxbtwnhDqw7LRrjegSOuaumdtLrCqi
 WX/Yf5dgLJQOqRrL+6Zkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159030>

On Mon, Oct 11, 2010 at 12:06:22AM +0200, SZEDER G=E1bor wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 6756990..4d54c32 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -750,6 +750,19 @@ __git_compute_porcelain_commands ()
>  	: ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
>  }
> =20
> +__git_pretty_aliases ()
> +{
> +	local i IFS=3D$'\n'
> +	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "prett=
y\..*" 2>/dev/null); do
> +		case "$i" in
> +		pretty.*)
> +			i=3D"${i#pretty.}"
> +			echo "${i/ */}"
> +			;;
> +		esac
> +	done
> +}
> +
>  __git_aliases ()
>  {
>  	local i IFS=3D$'\n'
=20
If you look at this new __git_pretty_aliases() function and the old
__git_aliases(), then you'll see that it's quite a code duplication.
So, how about the following two patches instead?
