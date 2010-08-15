From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] hash binary sha1 into patch id
Date: Sun, 15 Aug 2010 09:20:43 +0200
Message-ID: <20100815072043.GA368@localhost>
References: <20100813094027.GA20906@localhost>
 <20100813200031.GD2003@burratino>
 <20100813212331.GA24127@localhost>
 <20100813213726.GB2516@burratino>
 <20100813215801.GA24534@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Cc: git@vger.kernel.org, Marat Radchenko <marat@slonopotamus.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 09:21:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkXWj-0005QF-Ao
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 09:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab0HOHUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 03:20:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58625 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab0HOHUt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 03:20:49 -0400
Received: by ewy23 with SMTP id 23so1902185ewy.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=yyLMd9XNw6tu3CUEnajK1tqCwvuUjMf1E1P/BrWtkp8=;
        b=TxWKOkPP/y+jwHdjGxqdPYJ3g6j6ZZNnw7cMWbkCCJXqmi7jEXkAOl+b+yo7wpmoo/
         0M0kRJzU+eKctyC9tuc1t15qL6Wr0f4YxcAW+T4e0UfMubzwJ9PO79o6/7vVxUCw6nfa
         brtVX4df2pfotnAbaSrOg+2ogj8Ftw6Be7dfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=WjBp3WikQdpcthYFp4kp9yNFJomRt9ZpZiulTfiPUCHH3Yp061BncHxy6PGaU+qATY
         nkDQpFieiSPoNERv1g2EQULVP3IFNL/vzi+H4NLz1LPXp62Hs9D1EPqMnBxif8JGK5sd
         qK0MTiWooWBa9WiXOKYL6HeIU2Bs7mnpkoGQE=
Received: by 10.213.19.74 with SMTP id z10mr3592349eba.37.1281856848376;
        Sun, 15 Aug 2010 00:20:48 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id a48sm7564070eei.7.2010.08.15.00.20.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 00:20:46 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OkXWN-0000Ap-Bo; Sun, 15 Aug 2010 09:20:43 +0200
Content-Disposition: inline
In-Reply-To: <20100813215801.GA24534@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153598>


--XF85m9dhOBO43t/C
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since commit 2f82f760 (Take binary diffs into
account for "git rebase"), binary files are
included in patch ID computation. Binary files are
diffed using the text diff algorithm, however,
which has a huge impact on performance. The
following tests performance for a 50000 line file
marked as binary in .gitattributes.

$ git format-patch --stdout --ignore-if-in-upstream master

real    0m0.367s
user    0m0.354s
sys     0m0.010s

Instead of diffing the binary files, hash the pre-
and post-image sha1, which is just as unique. As a
result, performance is much improved.

$ git format-patch --stdout --ignore-if-in-upstream master

real    0m0.016s
user    0m0.015s
sys     0m0.001s

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I am again attaching the corresponding test script. Since it mostly
tests performance, I am not sure how to incorporate it into the
main test suite.

 diff.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 17873f3..f4a23ab 100644
--- a/diff.c
+++ b/diff.c
@@ -3758,6 +3758,13 @@ static int diff_get_patch_id(struct diff_options *op=
tions, unsigned char *sha1)
 					len2, p->two->path);
 		git_SHA1_Update(&ctx, buffer, len1);
=20
+		if (diff_filespec_is_binary(p->one) ||
+		    diff_filespec_is_binary(p->two)) {
+			git_SHA1_Update(&ctx, sha1_to_hex(p->one->sha1), 40);
+			git_SHA1_Update(&ctx, sha1_to_hex(p->two->sha1), 40);
+			continue;
+		}
+
 		xpp.flags =3D 0;
 		xecfg.ctxlen =3D 3;
 		xecfg.flags =3D XDL_EMIT_FUNCNAMES;
--=20
1.7.2.1.1.g202c


--CE+1k2dSO48ffgeK
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test-patchid.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Aset -e=0A=0ANLINES=3D50000=0ANRAND=3D32768=0A# probability=
 of change in percent=0ACHG_PROB=3D30=0Aperf=3D=0Awhile test $# -gt 0=0Ado=
=0A	case $1 in=0A	-p)=0A		perf=3Dt=0A		;;=0A	-n)=0A		shift=0A		NLINES=3D$1=
=0A		;;=0A	*)=0A		break=0A		;;=0A	esac=0A	shift=0Adone=0A=0Aif test $# -gt =
0=0Athen=0A	export PATH=3D"$1:$PATH"=0A	shift=0Afi=0A=0Aif test $# -gt 0=0A=
then=0A	echo "too many arguments" >&2=0A	exit 1=0Afi=0A=0Adir=3D$(mktemp -d=
)=0A=0Ascramble()=0A{=0A	while read x=0A	do=0A		if test $RANDOM -lt $((($CH=
G_PROB * $NRAND)/100))=0A		then=0A			echo $RANDOM=0A		else=0A			echo "$x"=
=0A		fi=0A	done < "$1" > "$1.new"=0A	mv -f "$1.new" "$1"=0A}=0A=0Arun()=0A{=
=0A	echo \$ "$@"=0A	if test -n "$perf"=0A	then=0A		perf record -g -f "$@" >=
/dev/null=0A		perf report -g=0A	else=0A		time "$@" >/dev/null=0A	fi=0A}=0A=
=0Acd "$dir"=0Agit init -q=0A=0Afor i in $(seq $NLINES)=0Ado=0A	echo $i=0Ad=
one > file=0Agit add file=0Aecho "file binary" >.gitattributes=0Agit add .g=
itattributes=0Agit commit -q -m initial=0Agit branch other=0A=0Ascramble fi=
le=0Agit add file=0Agit commit -q -m 'change big file'=0A=0Agit checkout -q=
 other=0A: >newfile=0Agit add newfile=0Agit commit -q -m 'add small file'=
=0A=0Agfp=3D"git format-patch --stdout"=0A=0Arun $gfp master=0Arun $gfp --i=
gnore-if-in-upstream master=0A=0Agit cherry-pick master >/dev/null 2>&1=0A=
=0Agit checkout -q master=0Ascramble file=0Agit add file=0Agit commit -q -m=
 'change big file again'=0A=0Agit checkout -q other^{}=0Arun git rebase mas=
ter=0Aif test -n "$(git rev-list master...HEAD~)"=0Athen=0A	echo "patch not=
 identified" >&2=0A	exit 1=0Afi=0A=0Agit checkout -q -b squashed master=0Ag=
it reset -q --soft HEAD~2=0Agit commit -q -m squashed=0Agit checkout -q oth=
er^{}=0Aif git rebase squashed >/dev/null=0Athen=0A	echo "patch dropped" >&=
2=0A	exit 1=0Afi=0A=0Acd - >/dev/null=0Arm -rf "$dir"=0A
--CE+1k2dSO48ffgeK--

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMZ5VLAAoJELKdZexG8uqM8XsH/jf6o3Dqw2LnFKz5lVGrCORU
jtzsyvh9wZl+Dq0R/f6vnmpFyMptlNAflzPz8ur8ofX8PWQgd2asmK5oK6BxhdbU
GWn22bbTYt4L3JWI4x+p7iZcqiId3ZMJ/zUzVxdn+RdxtyHYW3Ndeu3VkChl+Ocv
GXf8LCYViK3dUzKVoWstRibLDoDRNVHaNBQNKIFajCG3H+t7fySikaPOiPoIZ62k
ozSMeyYm97pdXnepCmf7L18mOGMDLeLy5z8lQG0SUjKNa4E6DJ2R6nmcKBpOutn1
5v8lkfsOE4ZMCMX062cqHB7TTvjDa81x+FnA/FOvkuyYxha3F/P4PytUFmRxG6c=
=/1Co
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
