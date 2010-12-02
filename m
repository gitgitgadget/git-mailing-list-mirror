From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Thu, 02 Dec 2010 22:11:13 +0100
Message-ID: <4CF80B71.3010309@web.de>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, mlevedahl@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 22:12:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POGRu-0005pI-QS
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 22:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab0LBVMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 16:12:09 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43704 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757967Ab0LBVMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 16:12:08 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2127717B063B5;
	Thu,  2 Dec 2010 22:11:18 +0100 (CET)
Received: from [93.246.39.92] (helo=[192.168.178.51])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1POGQw-0000wg-00; Thu, 02 Dec 2010 22:11:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101201185046.GB27024@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19fgyEQAoekcfqVjlHMgy+RqwN8qD2JE0iz73uR
	O47+breT6GRw/uXd53YDNFZ+nimBKUn3SHEzLt9VMYZT2jvFa8
	f0OiEmhcGxmru5bMqYYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162747>

Am 01.12.2010 19:50, schrieb Jonathan Nieder:
> 	git submodule add -b $branch $repository
>=20
> fails when HEAD already points to $branch in $repository.
>=20
> Reported-by: Klaus Ethgen <Klaus@Ethgen.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi Klaus,
>=20
> Klaus Ethgen wrote at <http://bugs.debian.org/605600>:
>=20
>> Strange problem, if I create a submodule of an other repository givi=
ng
>> the currently used HEAD branch I get the error: =C2=BBfatal: git che=
ckout:
>> branch myimbabranch already exists=C2=AB while when giving other bra=
nch
>> work well.
>=20
> Interesting.  The problem is in cmd_add of git-submodule.sh; this
> patch demonstrates a quick fix.  Jens, any idea why git submodule
> is not using "clone --branch" directly?

Nope, these lines date back to the time before I got involved in the
submodule business ... Seems like this "git checkout" was added in
March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
that.

But to me your change looks good, so feel free to add:
Acked-by: Jens Lehmann <Jens.Lehmann@web.de>


> diff --git a/git-submodule.sh b/git-submodule.sh
> index 33bc41f..6242d7f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -241,7 +241,7 @@ cmd_add()
>  			# ash fails to wordsplit ${branch:+-b "$branch"...}
>  			case "$branch" in
>  			'') git checkout -f -q ;;
> -			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
> +			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
>  			esac
>  		) || die "Unable to checkout submodule '$path'"
>  	fi
>=20
