From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] git apply: binary files differ can be applied with -pN
 (N>1).
Date: Wed, 24 Nov 2010 14:53:39 +0800
Message-ID: <4CECB673.9090809@gmail.com>
References: <4CECA0AE.90505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 07:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL9En-00057Q-TL
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 07:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab0KXGxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 01:53:48 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36763 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab0KXGxr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 01:53:47 -0500
Received: by pwj3 with SMTP id 3so447730pwj.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 22:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=NxEiwgCcxcf4VcJsZnC6ZgyICjz2lzxNsfSKFJziIEI=;
        b=DX0smYk/VxrH2dguwR0cyluQtKcisaf0kh+JfkQbEydB3VA+AAy6nCsgwhI4bjYx1d
         jI41/thRbQ9LWV/ZHdAryV/6crefOGuTwQFHoEkGcffSrgMoGBfp8nnFV1l5/vK/UnQn
         njDQHXesjbgWBS/OXfjKL8xJEkMcxtIWFpqok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=tewtrJ5hTq6XpKC5sqZPkOYdHMyPVZL/U8c0H2sUZkf99+j72iRrDme1fZkNUm26Zz
         RnKzYzB4DXpgYCIjoN/qp8DzLIpWszvjXSsxMGBwJYjpGgjgbwYCKIasBM5iwucNkykr
         /X4Ayymz7gFpAG8Z0PVj3eD5J2IMBhwMzmrNo=
Received: by 10.142.111.11 with SMTP id j11mr7971313wfc.327.1290581626889;
        Tue, 23 Nov 2010 22:53:46 -0800 (PST)
Received: from [192.168.0.50] ([123.115.150.125])
        by mx.google.com with ESMTPS id y42sm8996559wfd.10.2010.11.23.22.53.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 22:53:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); zh-CN; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CECA0AE.90505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162049>

How to reproduce the bug:

1. Generate a patch file against two directory with binary diff.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

$ mkdir hello-1.0 hello-2.0

$ dd if=3D/bin/ls of=3Dhello-1.0/binary.dat count=3D1 bs=3D32
1+0 records in
1+0 records out
32 bytes (32 B) copied, 0.00121276 s, 26.4 kB/s

$ dd if=3D/bin/ls of=3Dhello-2.0/binary.dat count=3D1 bs=3D64
1+0 records in
1+0 records out
64 bytes (64 B) copied, 0.00030288 s, 211 kB/s

$ git diff --no-index --binary hello-1.0 hello-2.0 > patch.txt

2. The patch file has patch level 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

$ cat patch.txt=20
diff --git a/hello-1.0/binary.dat b/hello-2.0/binary.dat
index dc2e37f81e0fa88308bec48cd5195b6542e61a20..bf948689934caf2d874ff81=
68cb716fbc2a127c3 100644
GIT binary patch
delta 37
hcmY#zn4qBGzyJX+<}pH93=3D9qo77QFfQiegA0RUZd1MdI;

delta 4
LcmZ=3Dzn4kav0;B;E

3. Apply the patch failed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

$ cd hello-1.0

$ git apply --check -p2 ../patch.txt
fatal: git diff header lacks filename information when removing 2 leadi=
ng pathname components (line 3)


=D3=DA 2010=C4=EA11=D4=C224=C8=D5 13:20, Jiang Xin =D0=B4=B5=C0:
> When patch file generated against two non-git directories using
> 'git diff --binary --no-index' without '--no-prefix', the patch
> file has patch level greater then 1, and should be applied with
> '-p2' option. But it does not work if there are binary differ
> in the patch file, it is because in one case the patch level is
> not properly handled.
>=20
> Signed-off-by: Jiang Xin <jiangxin@ossxp.com>
> ---
>  builtin/apply.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 23c18c5..d603e37 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1126,6 +1126,7 @@ static char *git_header_name(char *line, int ll=
en)
>  	 * form.
>  	 */
>  	for (len =3D 0 ; ; len++) {
> +		int nslash =3D p_value;
>  		switch (name[len]) {
>  		default:
>  			continue;
> @@ -1137,7 +1138,7 @@ static char *git_header_name(char *line, int ll=
en)
>  				char c =3D *second++;
>  				if (c =3D=3D '\n')
>  					return NULL;
> -				if (c =3D=3D '/')
> +				if (c =3D=3D '/' && --nslash <=3D 0)
>  					break;
>  			}
>  			if (second[len] =3D=3D '\n' && !memcmp(name, second, len)) {


--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=A1=A1=A1=A1  http://blog.ossxp.com/
=B5=E7=BB=B0: 010-51262007, 13910430470
=B4=AB=D5=E6: 010-51262007
