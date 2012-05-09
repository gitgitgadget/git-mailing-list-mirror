From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 12/19] bash prompt: use bash builtins to check whether
 inside git dir
Date: Wed, 09 May 2012 10:07:21 +0200
Message-ID: <4FAA25B9.3010208@viscovery.net>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de> <1336524290-30023-13-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 10:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS1vv-0004q8-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 10:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab2EIIH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 04:07:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26739 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab2EIIHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 04:07:22 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SS1wG-0004SK-8V; Wed, 09 May 2012 10:08:00 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4FF981660F;
	Wed,  9 May 2012 10:07:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336524290-30023-13-git-send-email-szeder@ira.uka.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197458>

Am 5/9/2012 2:44, schrieb SZEDER G=C3=A1bor:
> __git_ps1() runs the '$(git rev-parse --is-inside-git-dir)' command
> substitution to check whether we are inside a .git directory and the
> bash prompt needs to be adjusted accordingly (i.e. display 'BARE!' or
> 'GIT_DIR!').  This imposes the overhead of fork()ing a subshell and
> fork()+exec()ing a git process.
>=20
> Perform this check by comparing the path to the repository and the
> current directory using only bash builtins, thereby sparing all that
> fork()+exec() overhead.

> -	if [ "true" =3D "$(git rev-parse --is-inside-git-dir 2>/dev/null)" =
]; then
> +	local pwd_p
> +	__git_pwd_p pwd_p
> +	# inside .git dir?
> +	if [ "$__git_dir" =3D "." -o \
> +			"${pwd_p#$__git_dir}" !=3D "$pwd_p" ]; then

At this point, $__git_dir is c:/dir style, whereas $pwd_p is /c/dir sty=
le,
and the intended prefix check does not trigger.

As long as $__git_dir is only used to access files, it does not matter
whether it is Windows style or POSIX style. But if $__git_dir is used i=
n a
comparison, then you must make 100% sure that the involved paths are of
the same vintage.

What would be lost if this patch were dropped?

-- Hannes
