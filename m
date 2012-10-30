From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] completion: simplify __gitcomp test helper
Date: Tue, 30 Oct 2012 22:27:25 +0100
Message-ID: <20121030212725.GA15709@goldbirke>
References: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
 <1350869941-22485-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:28:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJLq-00068C-47
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab2J3V1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Oct 2012 17:27:45 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:51939 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab2J3V1o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:27:44 -0400
Received: from localhost6.localdomain6 (p5B130686.dip0.t-ipconnect.de [91.19.6.134])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MaV1V-1TnKGV0jdZ-00KBNE; Tue, 30 Oct 2012 22:27:26 +0100
Content-Disposition: inline
In-Reply-To: <1350869941-22485-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:7t9rQsRru48TFuf31fCXMlOnjr18UErNEqiMI7rmRPX
 h7sljLJm4D4jaX4gi/TLlL+EH9DcpvgnS33RL6JBXf+NpY1lt1
 sM10mGM0NIYIyln1fU0wYwdZanrS/zTQdlWbHgr+PfwN96NttA
 ia5fRfJveSg6t3+neltmVi65nWQ1GHmAbJGMJY2kvrYYXweZgW
 o5hAXdL6psDBY7e+pOgJFX3ZEceO0q9FFE1bS6e5GEATy2agjj
 kHK0TlFppDjsAl7w4FOgM/BVYnTTreBBlEZCrXEAeGVEeZg17p
 65KrpL5WiXDQUXHjA5e8U4oVRKkI4PvqDYLY6F7BnJlKP2mG5L
 Fpm+PohzMeBSbjyXskB0D33wV43fI5zuaMrUPPuEO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208742>

On Mon, Oct 22, 2012 at 03:39:01AM +0200, Felipe Contreras wrote:
> By using print_comp as suggested by SZEDER G=E1bor.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 1c6952a..2e7fc06 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -74,15 +74,12 @@ newline=3D$'\n'

This $newline variable was only used to set IFS to a newline inside SQ
blocks.  AFAICS after this change there are no such places left,
because print_comp() takes care of IFS, so $newline is not necessary
anymore.

>  test_gitcomp ()
>  {
> +	local -a COMPREPLY &&
>  	sed -e 's/Z$//' > expected &&
> -	(
> -		local -a COMPREPLY &&
> -		cur=3D"$1" &&
> -		shift &&
> -		__gitcomp "$@" &&
> -		IFS=3D"$newline" &&
> -		echo "${COMPREPLY[*]}" > out
> -	) &&
> +	cur=3D"$1" &&
> +	shift &&
> +	__gitcomp "$@" &&
> +	print_comp &&
>  	test_cmp expected out
>  }
> =20
> --=20
> 1.8.0
>=20
