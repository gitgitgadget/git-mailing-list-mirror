From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Thu, 26 Dec 2013 09:25:42 -0800
Message-ID: <20131226172542.GS20443@google.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
 <1387789361-29036-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tfnico@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 18:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwEh1-00034s-4X
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 18:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab3LZRZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Dec 2013 12:25:50 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:50536 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab3LZRZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 12:25:48 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so1809347yha.3
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8UJAF7iJtClO0LHIhyCZDslpPT9zjB0x3Xjarg2q32s=;
        b=Kt7PZmUceT5AWByURaKtyyxQp3UIVENvWjwURxk9Foz/nBiXmTj9mVTsClZPGTrQHx
         +/1J/rIGr4AzXNNrmOfAAXKMGOyWLInNLG7bK/MaK2scNuJ+CIVoZRGKtkLSQ3Swmusj
         NMUIapiMnTijJdmxnWq0Twv1EP13n6F3F0Oz2mjC3FV4zSSxiMwXau7yabMnCJIdKrMD
         THqfo4Rjyp1thJwyRRC7W9r2V2+iE9AWqR9srq+IHh8/zLaGWs65+7dVM+5BfvxFSPyQ
         amY5X3MXI6y9EkejzbwNCk35vfByVpxSgbHxjyVkuP2PxMOO1bfeNAZ5YWfDROEYNTwT
         E09g==
X-Received: by 10.236.92.70 with SMTP id i46mr5701873yhf.83.1388078746205;
        Thu, 26 Dec 2013 09:25:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w8sm42542242yhg.8.2013.12.26.09.25.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 09:25:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387789361-29036-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239704>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Thanks.

[...]
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -544,7 +544,7 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
> =20
>  		for (i =3D 0; i < pathspec.nr; i++) {
>  			const char *path =3D pathspec.items[i].match;
> -			if (!seen[i] &&
> +			if (!seen[i] && pathspec.items[i].match[0] &&
>  			    ((pathspec.items[i].magic &
>  			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
>  			     !file_exists(path))) {

Nit: in this loop there's already the synonym 'path' for item.match,
so perhaps

			if (!seen[i] && path[0] && ...)

would be clearer.

Should "git add --refresh ." get the same treatment?

> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -307,4 +307,8 @@ test_expect_success 'git add --dry-run --ignore-m=
issing of non-existing file out
>  	test_i18ncmp expect.err actual.err
>  '
> =20
> +test_expect_success 'git add -A on empty repo does not error out' '
> +	git init empty && ( cd empty && git add -A . )
> +'

Adding a test at the end like this means the tests come in chronologica=
l
order instead of logical order and simultaneous patches to the same
test script become more likely to conflict.

How about something like the following, for squashing in?

With or without the tweaks below,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/builtin/add.c w/builtin/add.c
index fbd3f3a..d7e3e44 100644
--- i/builtin/add.c
+++ w/builtin/add.c
@@ -544,7 +544,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 		for (i =3D 0; i < pathspec.nr; i++) {
 			const char *path =3D pathspec.items[i].match;
-			if (!seen[i] && pathspec.items[i].match[0] &&
+			if (!seen[i] && path[0] &&
 			    ((pathspec.items[i].magic &
 			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
 			     !file_exists(path))) {
diff --git i/t/t3700-add.sh w/t/t3700-add.sh
index 1535d8f..fe274e2 100755
--- i/t/t3700-add.sh
+++ w/t/t3700-add.sh
@@ -272,6 +272,25 @@ test_expect_success '"add non-existent" should fai=
l' '
 	! (git ls-files | grep "non-existent")
 '
=20
+test_expect_success 'git add -A on empty repo does not error out' '
+	rm -fr empty &&
+	git init empty &&
+	(
+		cd empty &&
+		git add -A . &&
+		git add -A
+	)
+'
+
+test_expect_success '"git add ." in empty repo' '
+	rm -fr empty &&
+	git init empty &&
+	(
+		cd empty &&
+		git add .
+	)
+'
+
 test_expect_success 'git add --dry-run of existing changed file' "
 	echo new >>track-this &&
 	git add --dry-run track-this >actual 2>&1 &&
@@ -307,8 +326,4 @@ test_expect_success 'git add --dry-run --ignore-mis=
sing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
=20
-test_expect_success 'git add -A on empty repo does not error out' '
-	git init empty && ( cd empty && git add -A . )
-'
-
 test_done
