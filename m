From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 18:02:56 +0200
Message-ID: <201010041802.57398.robin.rosenberg@dewire.com>
References: <4CA847D5.4000903@workspacewhiz.com> <1286099806-25774-7-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 18:03:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2nVM-0006pp-Eq
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 18:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441Ab0JDQDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 12:03:01 -0400
Received: from mail.dewire.com ([83.140.172.130]:10741 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab0JDQDA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 12:03:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 85EF3139BECA;
	Mon,  4 Oct 2010 18:02:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l6L06ah1Walu; Mon,  4 Oct 2010 18:02:57 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id D7EAE1396DAC;
	Mon,  4 Oct 2010 18:02:57 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-25-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <1286099806-25774-7-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158062>

s=F6ndagen den 3 oktober 2010 11.56.44 skrev  =C6var Arnfj=F6r=F0 Bjarm=
ason:
> From: Joshua Jensen <jjensen@workspacewhiz.com>
>=20
> When mydir/filea.txt is added, mydir/ is renamed to MyDir/, and
> MyDir/fileb.txt is added, running git ls-files mydir only shows
> mydir/filea.txt. Running git ls-files MyDir shows MyDir/fileb.txt.
> Running git ls-files mYdIR shows nothing.
>=20
> With this patch running git ls-files for mydir, MyDir, and mYdIR show=
s
> mydir/filea.txt and MyDir/fileb.txt.
>=20
> Wildcards are not handled case insensitively in this patch. Example:
> MyDir/aBc/file.txt is added. git ls-files MyDir/a* works fine, but gi=
t
> ls-files mydir/a* does not.
>=20
> Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  dir.c |   38 ++++++++++++++++++++++++++------------
>  1 files changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/dir.c b/dir.c
> index cf8f65c..53aa4f3 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -107,16 +107,30 @@ static int match_one(const char *match, const c=
har
> *name, int namelen) if (!*match)
>  		return MATCHED_RECURSIVELY;
>=20
> -	for (;;) {
> -		unsigned char c1 =3D *match;
> -		unsigned char c2 =3D *name;
> -		if (c1 =3D=3D '\0' || is_glob_special(c1))
> -			break;
> -		if (c1 !=3D c2)
> -			return 0;
> -		match++;
> -		name++;
> -		namelen--;
> +	if (ignore_case) {
> +		for (;;) {
> +			unsigned char c1 =3D tolower(*match);
> +			unsigned char c2 =3D tolower(*name);

Is anyone thinking "unicode" around here?

-- robin
