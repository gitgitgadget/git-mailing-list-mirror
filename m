From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: [PATCH] commit: ignore assume-unchanged files in "commmit
 <file>" mode
Date: Tue, 09 Dec 2014 02:44:50 +0000
Message-ID: <1418093090.19104.1.camel@segulix>
References: <1417732931.20814.16.camel@segulix>
	 <1417776974-6537-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 03:45:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyAnM-0003Kz-02
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 03:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419AbaLICo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 21:44:56 -0500
Received: from host1.easyho.st ([62.210.60.225]:40677 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756338AbaLICoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 21:44:55 -0500
Received: from [188.250.193.97] (port=61627 helo=[192.168.1.67])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1XyAnC-003DT0-Jn; Tue, 09 Dec 2014 02:44:52 +0000
In-Reply-To: <1417776974-6537-1-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host1.easyho.st
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - serjux.com
X-Get-Message-Sender-Via: host1.easyho.st: authenticated_id: sergio@serjux.com
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261104>

On Sex, 2014-12-05 at 17:56 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:=20
> In the same spirit of 7fce6e3 (commit: correctly respect skip-worktre=
e
> bit - 2009-12-14), if a file is marked unchanged, skip it.
>=20
> Noticed-by: S=C3=A9rgio Basto <sergio@serjux.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/commit.c                         |  2 +-
>  t/t2106-update-index-assume-unchanged.sh | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e108c53..ee3de12 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -252,7 +252,7 @@ static int list_paths(struct string_list *list, c=
onst char *with_tree,
>  		if (!ce_path_match(ce, pattern, m))
>  			continue;
>  		item =3D string_list_insert(list, ce->name);
> -		if (ce_skip_worktree(ce))
> +		if (ce->ce_flags & (CE_VALID | CE_SKIP_WORKTREE))
>  			item->util =3D item; /* better a valid pointer than a fake one */
>  	}
> =20
> diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-updat=
e-index-assume-unchanged.sh
> index 99d858c..dc332f5 100755
> --- a/t/t2106-update-index-assume-unchanged.sh
> +++ b/t/t2106-update-index-assume-unchanged.sh
> @@ -21,4 +21,14 @@ test_expect_success 'do not switch branches with d=
irty file' \
>  	 git update-index --assume-unchanged file &&
>  	 test_must_fail git checkout master'
> =20
> +test_expect_success 'commit <paths> ignore assume-unchanged files' '
> +	: >anotherfile &&
> +	git add anotherfile &&
> +	echo dirty >anotherfile &&
> +	git commit -m one -- file anotherfile &&
> +	git diff --name-only HEAD^ HEAD >actual &&
> +	echo anotherfile >expected &&
> +	test_cmp expected actual
> +'
> +
>  test_done


works great many thanks,=20

--=20
S=C3=A9rgio M. B.
