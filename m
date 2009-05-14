From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use UTF-8 instead of utf8 for backward compatibility
Date: Thu, 14 May 2009 15:05:55 +0200
Message-ID: <81b0412b0905140605o21143369ibc3147c6619c7845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5c0cc0bf1400469defda8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 15:06:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4adv-000315-Lg
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 15:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760870AbZENNF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 09:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760413AbZENNF6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 09:05:58 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:43799 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760327AbZENNF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 09:05:57 -0400
Received: by bwz22 with SMTP id 22so1275737bwz.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=fQemwgdbPlEeeobvmDOlK6xdOYi7k1TQJAxfiE9nbNw=;
        b=ZPf94kG8BaabApzI0sWtKHhu/fkiNNeVdMu7fvghdtMJPKZMvaxJtnyK5GzBQIjVuG
         fEmQ5MwxjWgzex2PBi4UgYvz4oDCuWatO6ePBg+NDrs+PLZb1AZ+2OoaodTiF57FBYEM
         k9i+yDji8J6Gy5afYbUKFPg49PtLAqE5tEhvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Fcb5W6dW0amUXUkrZR59PimDD0HGDVZsdMBMT127nY+nQfUr6scNn+AyPkMFGPGCfR
         wivTajg7KO31GxjRCtiNtdI3XKatZ/fHRXsR1Ibd3Cd3sFrTOBtoB8o23KwQHcoq7oEv
         VeRXqDu5CYvIGur8l+csZLTzO9B06k/LhjurM=
Received: by 10.204.59.18 with SMTP id j18mr2081694bkh.206.1242306355916; Thu, 
	14 May 2009 06:05:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119188>

--001636c5c0cc0bf1400469defda8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

An old iconv (GNU libiconv 1.11) does not know about utf8, it does know
UTF-8 though, which is also understood by all newer iconv implementations.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

2009/5/12 Junio C Hamano <gitster@pobox.com>:
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -9,7 +9,15 @@ test_description=3D'commit and log output encodings'
>
> =C2=A0compare_with () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git show -s $1 | sed -e '1,/^$/d' -e 's/^ =C2=
=A0 =C2=A0//' >current &&
> - =C2=A0 =C2=A0 =C2=A0 test_cmp current "$2"
> + =C2=A0 =C2=A0 =C2=A0 case "$3" in
> + =C2=A0 =C2=A0 =C2=A0 '')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cmp "$2" current =
;;
> + =C2=A0 =C2=A0 =C2=A0 ?*)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iconv -f "$3" -t utf8 =
>current.utf8 <current &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iconv -f "$3" -t utf8 =
>expect.utf8 <"$2" &&

I happen to have an old one (Cygwin):
$ iconv --version
iconv (GNU libiconv 1.11)

 t/t3900-i18n-commit.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 5dbbcb6..b4ec2b5 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -13,8 +13,8 @@ compare_with () {
 	'')
 		test_cmp "$2" current ;;
 	?*)
-		iconv -f "$3" -t utf8 >current.utf8 <current &&
-		iconv -f "$3" -t utf8 >expect.utf8 <"$2" &&
+		iconv -f "$3" -t UTF-8 >current.utf8 <current &&
+		iconv -f "$3" -t UTF-8 >expect.utf8 <"$2" &&
 		test_cmp expect.utf8 current.utf8
 		;;
 	esac
--=20
1.6.3.49.ge312c

--001636c5c0cc0bf1400469defda8
Content-Type: application/octet-stream; 
	name="0001-Use-UTF-8-instead-of-utf8-for-backward-compatibility.diff"
Content-Disposition: attachment; 
	filename="0001-Use-UTF-8-instead-of-utf8-for-backward-compatibility.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fuph389j0

RnJvbSBiYjlkZDE2MGQ5M2NiNjc1M2FiMDhkYmMyOWM2ZWU4NDBjZmQwNmJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDE0IE1heSAyMDA5IDE0OjU1OjU0ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gVXNlIFVU
Ri04IGluc3RlYWQgb2YgdXRmOCBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eQoKQW4gb2xkIGlj
b252IChHTlUgbGliaWNvbnYgMS4xMSkgZG9lcyBub3Qga25vdyBhYm91dCB1dGY4LCBpdCBkb2Vz
IGtub3cKVVRGLTggdGhvdWdoLCB3aGljaCBpcyBhbHNvIHVuZGVyc3Rvb2QgYnkgYWxsIG5ld2Vy
IGljb252IGltcGxlbWVudGF0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEu
bGttbEBnbWFpbC5jb20+Ci0tLQogdC90MzkwMC1pMThuLWNvbW1pdC5zaCB8ICAgIDQgKystLQog
MSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdC90MzkwMC1pMThuLWNvbW1pdC5zaCBiL3QvdDM5MDAtaTE4bi1jb21taXQuc2gKaW5k
ZXggNWRiYmNiNi4uYjRlYzJiNSAxMDA3NTUKLS0tIGEvdC90MzkwMC1pMThuLWNvbW1pdC5zaAor
KysgYi90L3QzOTAwLWkxOG4tY29tbWl0LnNoCkBAIC0xMyw4ICsxMyw4IEBAIGNvbXBhcmVfd2l0
aCAoKSB7CiAJJycpCiAJCXRlc3RfY21wICIkMiIgY3VycmVudCA7OwogCT8qKQotCQlpY29udiAt
ZiAiJDMiIC10IHV0ZjggPmN1cnJlbnQudXRmOCA8Y3VycmVudCAmJgotCQlpY29udiAtZiAiJDMi
IC10IHV0ZjggPmV4cGVjdC51dGY4IDwiJDIiICYmCisJCWljb252IC1mICIkMyIgLXQgVVRGLTgg
PmN1cnJlbnQudXRmOCA8Y3VycmVudCAmJgorCQlpY29udiAtZiAiJDMiIC10IFVURi04ID5leHBl
Y3QudXRmOCA8IiQyIiAmJgogCQl0ZXN0X2NtcCBleHBlY3QudXRmOCBjdXJyZW50LnV0ZjgKIAkJ
OzsKIAllc2FjCi0tIAoxLjYuMy40OS5nZTMxMmMKCg==
--001636c5c0cc0bf1400469defda8--
