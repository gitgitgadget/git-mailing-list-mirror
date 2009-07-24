From: Bill Priest <priestwilliaml@yahoo.com>
Subject: Fw: Portability changes to mozilla-sha1
Date: Fri, 24 Jul 2009 10:17:21 -0700 (PDT)
Message-ID: <45093.12936.qm@web55008.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-792534853-1248455841=:12936"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 19:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUOOg-0003b5-RK
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 19:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbZGXRRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 13:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbZGXRRW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 13:17:22 -0400
Received: from web55008.mail.re4.yahoo.com ([206.190.58.142]:48727 "HELO
	web55008.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751362AbZGXRRW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 13:17:22 -0400
Received: (qmail 31461 invoked by uid 60001); 24 Jul 2009 17:17:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1248455842; bh=JlT4HoTF16JqmOKQ7D70klDOM06PrlR3ypEBzqdyqDI=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=4IKPCepaXGsXna5ffuUA1FSaYGpSkp+0Y5JJJ9ZU/7ACLGdV+HXgFaYPf0ykcCukF1tjR/GpfgqmfBjl1Z2RnyqErHbGjp+b3Ll2nMMpjs8nurb2n0TE3MaKvgFbcD6FjxJBq4spw4WkQtyBX73hsU7qU8uccepI9GK2SKxQ/Ac=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=ZqbHwALWRpq69B3PuRWxytraCD838Qqv5qT07bSNqsIK/o113wrKmvwgB7FvAf1ploJppEmoRHPeIhx7mVhruoB5QXUr5yup2EPa6aHK0g+jS6Rzb37njAsA9pjk7hHhFR1YhcjVc1z486GjkIxHzE/CRvH/0/YnXA8SretLqOk=;
X-YMail-OSG: G1rma3kVM1nCng4uOzDLfCsNW6mADmmpNbxUx.hq9rrKdyUMUr7JSNuDL9eihtBasu8dBw0EA8Yb3Qwvd7MNUw2rxHaALWQ.JVJdSNL2TUIEqaTgbA1lWGBV9AJKSNXGmriAmVjVrWZTjB35s_KEEX.AJuu35Gan6g90XYXWKk6OZUwQUmquNRXTd6SZRsnWiUHrxsy2OkCwzIaSSn44uJJRRRJTfNShuW6bZNcyo0iuzcF...SjefMQ95UI0X1I3yXQtfi8bF11Kx.A09z5bdM5IIKVpVXWvyUm7OEUFOv3WuF.KMDw7JC4Xs9hQ0SvmTmO7.EM
Received: from [71.164.240.90] by web55008.mail.re4.yahoo.com via HTTP; Fri, 24 Jul 2009 10:17:21 PDT
X-Mailer: YahooMailClassic/5.4.17 YahooMailWebService/0.7.338.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123932>

--0-792534853-1248455841=:12936
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

All,=0A  Here is a patch to mozilla-sha1/sha1.[ch] that makes the files mor=
e portable using types from stdint.h.  With gcc 4.3.3 I verified that the a=
ssembly produced w/ gcc -O2 -S -c sha1.c before and after the change was id=
entical.  The patch also contains a couple of extra casts that allow splint=
 to be silent.=0A  In case the webmail botches the patch below; I've also a=
ttached the file.  I couldn't find a recommended method for sending in a pa=
tch; apologies if this doesn't match the preferred method.=0A=0ABill=0A=0As=
plint -exportlocal -fixedformalarray sha1.c=0ASplint 3.1.2 --- 08 Nov 2008=
=0A=0AFinished checking --- no warnings=0A=0Adiff --git a/mozilla-sha1/sha1=
.c b/mozilla-sha1/sha1.c=0Aindex 95a4ebf..8c6291c 100644=0A--- a/mozilla-sh=
a1/sha1.c=0A+++ b/mozilla-sha1/sha1.c=0A@@ -56,9 +56,9 @@ void moz_SHA1_Ini=
t(moz_SHA_CTX *ctx) {=0A }=0A =0A =0A-void moz_SHA1_Update(moz_SHA_CTX *ctx=
, const void *_dataIn, int len) {=0A+void moz_SHA1_Update(moz_SHA_CTX *ctx,=
 const void *_dataIn, int32_t len) {=0A   const unsigned char *dataIn =3D _=
dataIn;=0A-  int i;=0A+  int32_t i;=0A =0A   /* Read the data into W and pr=
ocess blocks as they get full=0A    */=0A@@ -70,14 +70,14 @@ void moz_SHA1_=
Update(moz_SHA_CTX *ctx, const void *_dataIn, int len) {=0A       ctx->lenW=
 =3D 0;=0A     }=0A     ctx->sizeLo +=3D 8;=0A-    ctx->sizeHi +=3D (ctx->s=
izeLo < 8);=0A+    ctx->sizeHi +=3D (uint32_t) (ctx->sizeLo < 8);=0A   }=0A=
 }=0A =0A =0A void moz_SHA1_Final(unsigned char hashout[20], moz_SHA_CTX *c=
tx) {=0A-  unsigned char pad0x80 =3D 0x80;=0A-  unsigned char pad0x00 =3D 0=
x00;=0A+  unsigned char pad0x80 =3D (unsigned char) 0x80;=0A+  unsigned cha=
r pad0x00 =3D (unsigned char) 0x00;=0A   unsigned char padlen[8];=0A   int =
i;=0A =0A@@ -114,7 +114,7 @@ void moz_SHA1_Final(unsigned char hashout[20],=
 moz_SHA_CTX *ctx) {=0A =0A static void shaHashBlock(moz_SHA_CTX *ctx) {=0A=
   int t;=0A-  unsigned int A,B,C,D,E,TEMP;=0A+  uint32_t A,B,C,D,E,TEMP;=
=0A =0A   for (t =3D 16; t <=3D 79; t++)=0A     ctx->W[t] =3D=0Adiff --git =
a/mozilla-sha1/sha1.h b/mozilla-sha1/sha1.h=0Aindex aa48a46..2cb5e26 100644=
=0A--- a/mozilla-sha1/sha1.h=0A+++ b/mozilla-sha1/sha1.h=0A@@ -33,15 +33,17=
 @@=0A  * GPL.=0A  */=0A =0A+#include <stdint.h>=0A+=0A typedef struct {=0A=
-  unsigned int H[5];=0A-  unsigned int W[80];=0A-  int lenW;=0A-  unsigned=
 int sizeHi,sizeLo;=0A+  uint32_t H[5];=0A+  uint32_t W[80];=0A+  int32_t  =
lenW;=0A+  uint32_t sizeHi,sizeLo;=0A } moz_SHA_CTX;=0A =0A void moz_SHA1_I=
nit(moz_SHA_CTX *ctx);=0A-void moz_SHA1_Update(moz_SHA_CTX *ctx, const void=
 *dataIn, int len);=0A+void moz_SHA1_Update(moz_SHA_CTX *ctx, const void *d=
ataIn, int32_t len);=0A void moz_SHA1_Final(unsigned char hashout[20], moz_=
SHA_CTX *ctx);=0A =0A #define git_SHA_CTX    moz_SHA_CTX=0A=0A=0A--- On Fri=
, 7/24/09, Bill Priest <priestwilliaml@yahoo.com> wrote:=0A=0A> From: Bill =
Priest <priestwilliaml@yahoo.com>=0A> Subject: Portability changes to mozil=
la-sha1=0A> To: git@vger.kernel.org=0A> Date: Friday, July 24, 2009, 12:32 =
AM=0A> All,=0A> =A0 =A0 In compiling sha1.c for a micro-controller=0A> and =
testing it I noticed that many of the types of the=0A> fields and local var=
iables aren't portable.=A0 Much of=0A> git appears to use uint32_t and the =
like when the size of=0A> the variable "matters".=0A> =A0 =A0 If a patch wa=
s provided to make sha1.[ch]=0A> portable in terms of the types used would =
it be=0A> accepted?=A0 Of course the resulting code would be=0A> regression=
 tested prior to submission.=0A> =A0 =A0 I google'd a little bit but didn't=
 find any=0A> prior questions in a similar vein (sorry if I missed it).=0A>=
 =0A> Regards,=0A> =0A> Bill=0A> =0A> =0A> =0A> =A0 =A0 =A0 =0A> --=0A> To =
unsubscribe from this list: send the line "unsubscribe=0A> git" in=0A> the =
body of a message to majordomo@vger.kernel.org=0A> More majordomo info at=
=A0 http://vger.kernel.org/majordomo-info.html=0A>=0A=0A=0A      
--0-792534853-1248455841=:12936
Content-Type: text/x-patch; name="sha1.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sha1.patch"

ZGlmZiAtLWdpdCBhL21vemlsbGEtc2hhMS9zaGExLmMgYi9tb3ppbGxhLXNo
YTEvc2hhMS5jCmluZGV4IDk1YTRlYmYuLjhjNjI5MWMgMTAwNjQ0Ci0tLSBh
L21vemlsbGEtc2hhMS9zaGExLmMKKysrIGIvbW96aWxsYS1zaGExL3NoYTEu
YwpAQCAtNTYsOSArNTYsOSBAQCB2b2lkIG1vel9TSEExX0luaXQobW96X1NI
QV9DVFggKmN0eCkgewogfQogCiAKLXZvaWQgbW96X1NIQTFfVXBkYXRlKG1v
el9TSEFfQ1RYICpjdHgsIGNvbnN0IHZvaWQgKl9kYXRhSW4sIGludCBsZW4p
IHsKK3ZvaWQgbW96X1NIQTFfVXBkYXRlKG1vel9TSEFfQ1RYICpjdHgsIGNv
bnN0IHZvaWQgKl9kYXRhSW4sIGludDMyX3QgbGVuKSB7CiAgIGNvbnN0IHVu
c2lnbmVkIGNoYXIgKmRhdGFJbiA9IF9kYXRhSW47Ci0gIGludCBpOworICBp
bnQzMl90IGk7CiAKICAgLyogUmVhZCB0aGUgZGF0YSBpbnRvIFcgYW5kIHBy
b2Nlc3MgYmxvY2tzIGFzIHRoZXkgZ2V0IGZ1bGwKICAgICovCkBAIC03MCwx
NCArNzAsMTQgQEAgdm9pZCBtb3pfU0hBMV9VcGRhdGUobW96X1NIQV9DVFgg
KmN0eCwgY29uc3Qgdm9pZCAqX2RhdGFJbiwgaW50IGxlbikgewogICAgICAg
Y3R4LT5sZW5XID0gMDsKICAgICB9CiAgICAgY3R4LT5zaXplTG8gKz0gODsK
LSAgICBjdHgtPnNpemVIaSArPSAoY3R4LT5zaXplTG8gPCA4KTsKKyAgICBj
dHgtPnNpemVIaSArPSAodWludDMyX3QpIChjdHgtPnNpemVMbyA8IDgpOwog
ICB9CiB9CiAKIAogdm9pZCBtb3pfU0hBMV9GaW5hbCh1bnNpZ25lZCBjaGFy
IGhhc2hvdXRbMjBdLCBtb3pfU0hBX0NUWCAqY3R4KSB7Ci0gIHVuc2lnbmVk
IGNoYXIgcGFkMHg4MCA9IDB4ODA7Ci0gIHVuc2lnbmVkIGNoYXIgcGFkMHgw
MCA9IDB4MDA7CisgIHVuc2lnbmVkIGNoYXIgcGFkMHg4MCA9ICh1bnNpZ25l
ZCBjaGFyKSAweDgwOworICB1bnNpZ25lZCBjaGFyIHBhZDB4MDAgPSAodW5z
aWduZWQgY2hhcikgMHgwMDsKICAgdW5zaWduZWQgY2hhciBwYWRsZW5bOF07
CiAgIGludCBpOwogCkBAIC0xMTQsNyArMTE0LDcgQEAgdm9pZCBtb3pfU0hB
MV9GaW5hbCh1bnNpZ25lZCBjaGFyIGhhc2hvdXRbMjBdLCBtb3pfU0hBX0NU
WCAqY3R4KSB7CiAKIHN0YXRpYyB2b2lkIHNoYUhhc2hCbG9jayhtb3pfU0hB
X0NUWCAqY3R4KSB7CiAgIGludCB0OwotICB1bnNpZ25lZCBpbnQgQSxCLEMs
RCxFLFRFTVA7CisgIHVpbnQzMl90IEEsQixDLEQsRSxURU1QOwogCiAgIGZv
ciAodCA9IDE2OyB0IDw9IDc5OyB0KyspCiAgICAgY3R4LT5XW3RdID0KZGlm
ZiAtLWdpdCBhL21vemlsbGEtc2hhMS9zaGExLmggYi9tb3ppbGxhLXNoYTEv
c2hhMS5oCmluZGV4IGFhNDhhNDYuLjJjYjVlMjYgMTAwNjQ0Ci0tLSBhL21v
emlsbGEtc2hhMS9zaGExLmgKKysrIGIvbW96aWxsYS1zaGExL3NoYTEuaApA
QCAtMzMsMTUgKzMzLDE3IEBACiAgKiBHUEwuCiAgKi8KIAorI2luY2x1ZGUg
PHN0ZGludC5oPgorCiB0eXBlZGVmIHN0cnVjdCB7Ci0gIHVuc2lnbmVkIGlu
dCBIWzVdOwotICB1bnNpZ25lZCBpbnQgV1s4MF07Ci0gIGludCBsZW5XOwot
ICB1bnNpZ25lZCBpbnQgc2l6ZUhpLHNpemVMbzsKKyAgdWludDMyX3QgSFs1
XTsKKyAgdWludDMyX3QgV1s4MF07CisgIGludDMyX3QgIGxlblc7CisgIHVp
bnQzMl90IHNpemVIaSxzaXplTG87CiB9IG1vel9TSEFfQ1RYOwogCiB2b2lk
IG1vel9TSEExX0luaXQobW96X1NIQV9DVFggKmN0eCk7Ci12b2lkIG1vel9T
SEExX1VwZGF0ZShtb3pfU0hBX0NUWCAqY3R4LCBjb25zdCB2b2lkICpkYXRh
SW4sIGludCBsZW4pOwordm9pZCBtb3pfU0hBMV9VcGRhdGUobW96X1NIQV9D
VFggKmN0eCwgY29uc3Qgdm9pZCAqZGF0YUluLCBpbnQzMl90IGxlbik7CiB2
b2lkIG1vel9TSEExX0ZpbmFsKHVuc2lnbmVkIGNoYXIgaGFzaG91dFsyMF0s
IG1vel9TSEFfQ1RYICpjdHgpOwogCiAjZGVmaW5lIGdpdF9TSEFfQ1RYCW1v
el9TSEFfQ1RYCg==

--0-792534853-1248455841=:12936--
