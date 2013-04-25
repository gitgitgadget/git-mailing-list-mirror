From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 15:06:16 +0200
Message-ID: <51792A48.60603@web.de>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 15:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVLsz-0005Ke-8T
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 15:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757476Ab3DYNGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 09:06:48 -0400
Received: from mout.web.de ([212.227.15.3]:56492 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757068Ab3DYNGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 09:06:48 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MFtKQ-1UJmu63XeQ-00ErSB; Thu, 25 Apr 2013 15:06:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
X-Provags-ID: V02:K0:QhPfF1hDXseGp7eB4Y0GY3kiITDuW0qziqEjOKrXkX+
 Izmttk97k5CG+D1ijZT0wAsyIU3YXwKjZczwT8FXXh8nJLeybu
 6gh07A+QDbKuDR7AI+hJikQIuw35RilUYsZ0DS5jV1zVmo82HF
 DXOFiAkpRFc/TKcDzQWF5F3Qz/RKj7LhY/DojW4cGb3naVujde
 NVgBjidSSnam/14e/vQxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222383>

On 25.04.13 12:09, Michael J Gruber wrote:
> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduce=
d a
> test which was meant to skip the test unless the test shell is bash.
> Unfortunately, it tests for the availability of bash only. But users =
can
> opt to use a different shell (using SHELL_PATH) for the tests even th=
ough
> bash is available.
>=20
> At least for dash,
> 21610d8 (transport-helper: clarify pushing without refspecs, 2013-04-=
17)
> is the commit which actually introduces a test (pushing without refsp=
ec)
> which fails to fail even though it is supposed to. It uses the
> construct:
>=20
> VAR=3Dvalue function arguments
>=20
> Make t5801 actually test whether the test shell is bash.
>=20
> An even better alternative would be to make the test POSIX compliant,=
 of
> course.
>=20
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t5801-remote-helpers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index ed962c4..c979863 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -8,7 +8,7 @@ test_description=3D'Test remote-helper import and exp=
ort commands'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-gpg.sh
> =20
> -if ! type "${BASH-bash}" >/dev/null 2>&1; then
> +if test $(basename "${SHELL_PATH}") !=3D "bash"; then
>  	skip_all=3D'skipping remote-testgit tests, bash not available'
>  	test_done
>  fi
>=20
Could we use the same logic as in t9903:
#!/bin/sh
#
# Copyright (c) 2012 SZEDER G=E1bor
#

test_description=3D'test git-specific bash prompt functions'

=2E ./lib-bash.sh
