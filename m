From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 18:56:29 -0400
Message-ID: <20160531225628.GA4585@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:56:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7saT-0001D4-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbcEaW4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 18:56:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:46816 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750750AbcEaW4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:56:33 -0400
Received: (qmail 2670 invoked by uid 102); 31 May 2016 22:56:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:56:32 -0400
Received: (qmail 28123 invoked by uid 107); 31 May 2016 22:56:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:56:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 18:56:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296029>

On Tue, May 31, 2016 at 03:53:15PM -0700, Junio C Hamano wrote:

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

Thanks. This one is my fault. There's another use of the same name
elsewhere, but it's to call "git commit" directly, so it's OK.

-Peff

PS I really hate this particular shell behavior, as it means that your
   code can break because somebody _else_ decides to replace the comman=
d
   you are calling with a function.  But I guess we are stuck with it.
