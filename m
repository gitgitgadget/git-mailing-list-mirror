From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 01:09:08 +0100
Message-ID: <574E27A4.6040804@ramsayjones.plus.com>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 02:09:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7tio-00068n-1n
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 02:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbcFAAJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 20:09:14 -0400
Received: from avasout01.plus.net ([84.93.230.227]:60497 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcFAAJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 20:09:13 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 1C9A1t0035VX2mk01C9BXT; Wed, 01 Jun 2016 01:09:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=ybZZDoGAAAAA:8 a=X179QWE8MYt-nEQjoh8A:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296041>



On 31/05/16 23:53, Junio C Hamano wrote:
> One-shot assignment to an environment variable, i.e.
>=20
> 	VAR=3DVAL cmd
>=20
> does not work as expected for "cmd" that is a shell function on
> certain shells.  test_commit _is_ a helper function and cannot be
> driven that way portably.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t4014-format-patch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 8049cad..c3aa543 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1072,7 +1072,7 @@ test_expect_success '--from omits redundant in-=
body header' '
>  '
> =20
>  test_expect_success 'in-body headers trigger content encoding' '
> -	GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic &&
> +	(export GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc"; test_commit exot=
ic) &&

Isn't 'export VAR=3DVAL' non-portable? So, maybe:

	(GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc"; export GIT_AUTHOR_NAME; te=
st_commit exotic) &&

>  	test_when_finished "git reset --hard HEAD^" &&
>  	git format-patch -1 --stdout --from >patch &&
>  	cat >expect <<-\EOF &&

ATB,
Ramsay Jones
