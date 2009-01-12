From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable
	errors.
Date: Mon, 12 Jan 2009 22:40:52 +0100
Message-ID: <20090112214052.GB24941@chistera.yi.org>
References: <496BA0E4.2040607@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUY9-0004tU-OE
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbZALVk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 16:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbZALVk6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:40:58 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1269
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZALVk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:40:57 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id BADA1801C078;
	Mon, 12 Jan 2009 22:40:54 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LMUWi-0006jR-4C; Mon, 12 Jan 2009 22:40:52 +0100
Content-Disposition: inline
In-Reply-To: <496BA0E4.2040607@tedpavlic.com>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105392>

* Ted Pavlic [Mon, 12 Jan 2009 14:58:28 -0500]:

I don't know if this patch will go forward or not, but there are severa=
l
instances of spurious ${x-}, eg.:

>  __gitdir ()
>  {
> -	if [ -z "$1" ]; then
> +	if [ -z "${1-}" ]; then

Given the above...

> -	elif [ -d "$1/.git" ]; then
> -		echo "$1/.git"
> +	elif [ -d "${1-}/.git" ]; then
> +		echo "${1-}/.git"
>  	else
> -		echo "$1"
> +		echo "${1-}"

=2E.. this other hunk is redundant, because if [ -z "${1-}" ] fails, th=
en
$1 is surely set.

>  __git_ps1 ()
>  {
>  	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
> -	if [ -n "$g" ]; then
> +	if [ -n "${g-}" ]; then

Spurious, $g is always set here.

> @@ -111,8 +111,8 @@ __git_ps1 ()
> -		if [ -n "$1" ]; then
> +		if [ -n "${1-}" ]; then

This one is okay...

> -			printf "$1" "${b##refs/heads/}$r"
> +			printf "${1-}" "${b##refs/heads/}$r"

But this one is unnecessary, if [ -n "${1-}" ] succeeds, then $1 is set=
=2E

And so on.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
The true teacher defends his pupils against his own personal influence.
                -- Amos Bronson Alcott
