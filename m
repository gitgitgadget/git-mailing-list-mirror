From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 17:32:07 +0200
Message-ID: <871w09kvew.fsf@lysator.liu.se>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 17:33:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjUy-0004rF-Sp
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbYH1PcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 11:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbYH1PcR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:32:17 -0400
Received: from main.gmane.org ([80.91.229.2]:38489 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbYH1PcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:32:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KYjTq-0000J0-Gq
	for git@vger.kernel.org; Thu, 28 Aug 2008 15:32:14 +0000
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 15:32:14 +0000
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 15:32:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:59BIwRYwM465TfYbOQIbDpIq7/E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94077>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> The following syntax:
>
>         char foo[] =3D {
>                 [0] =3D 1,
>                 [7] =3D 2,
>                 [15] =3D 3
>         };
>
> is a c99 construct which some compilers do not support even though th=
ey
> support other c99 constructs. Use an alternative.

But the alternative is much worse. So how important is it to support
non-C99 compilers?

> ---
>  dir.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 29d1d5b..14d2eea 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -680,13 +680,14 @@ static int cmp_name(const void *p1, const void =
*p2)
>   */
>  static int simple_length(const char *match)
>  {
> -	const char special[256] =3D {
> -		[0] =3D 1, ['?'] =3D 1,
> -		['\\'] =3D 1, ['*'] =3D 1,
> -		['['] =3D 1
> -	};
> +	char special[256] =3D { 1, };
>  	int len =3D -1;
> =20
> +	special['?'] =3D 1;
> +	special['\\'] =3D 1;
> +	special['*'] =3D 1;
> +	special['['] =3D 1;
> +
>  	for (;;) {
>  		unsigned char c =3D *match++;
>  		len++;

--=20
David K=C3=A5gedal
