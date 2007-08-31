From: Timo Sirainen <tss@iki.fi>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 08:00:30 +0300
Message-ID: <1188536430.29782.903.camel@hurina>
References: <1188502009.29782.874.camel@hurina>
	 <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>
	 <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>
	 <alpine.LFD.0.999.0708302050170.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qbYEstjkEqdbeC5PQkqJ"
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 07:00:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQycb-00039K-1W
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 07:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbXHaFAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 01:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757044AbXHaFAf
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 01:00:35 -0400
Received: from dovecot.org ([82.118.211.50]:45956 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689AbXHaFAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 01:00:34 -0400
Received: from [192.168.10.2] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 9333A16471E1;
	Fri, 31 Aug 2007 08:00:31 +0300 (EEST)
In-Reply-To: <alpine.LFD.0.999.0708302050170.25853@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57112>


--=-qbYEstjkEqdbeC5PQkqJ
Content-Type: multipart/mixed; boundary="=-0wcW9MvPqzfpjsfLYvmI"


--=-0wcW9MvPqzfpjsfLYvmI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-08-30 at 21:09 -0700, Linus Torvalds wrote:
>=20
> On Fri, 31 Aug 2007, Timo Sirainen wrote:
> > >=20
> > > Perhaps because your patch was using a totally nonstandard and slow
> > > interface, and had nasty string declaration issues, as people even po=
inted
> > > out to you.
> >=20
> > Slow?
>=20
> Having a string library, and then implementing "str_append()" with a=20
> strlen() sounds pretty disgusting to me.=20
>=20
> Gcc could have optimized the strlen() away for constant string arguments,=
=20
> but since you made the thing out-of-line, it can't do that any more.
>=20
> So yes, I bet there are faster string libraries out there.

Oh, well that's easy to fix. But I don't think the speed matters much in
string manipulation, it's usually not done in performance critical
paths.

> > The code should be easy to verify to be secure, and with some kind of a=
 safe
> > string API it's a lot easier than trying to figure out corner cases whe=
re
> > strcpy() calls break.
>=20
> I actually looked at the patches, and the "stringbuf()" thing was just to=
o=20
> ugly to live. It was also nonportable, in that you use the reserved=20
> namespace (which we do extensively in the kernel, but that's an=20
> "embdedded" application that doesn't use system header files).
>=20
> So the API was anything but "safe".

Some of those were fixed in the patch I sent at the beginning of this
thread. But since you asked, attached is yet another version of it. As
far as I know it's fully C99 compatible. Would be C89 but there's that
va_copy() call.

I guess it could still be optimized more, but at least strlen() is now
in a macro. :)

Or if you don't like the STR_STATIC() macro, another way would be:

#define STR_STATIC_INIT(buf) { buf, sizeof(buf), 0, }

char static_buf[1024];
struct string str =3D STR_STATIC_INIT(static_buf);

str_append(&str, "hello world");


--=-0wcW9MvPqzfpjsfLYvmI
Content-Disposition: attachment; filename=git-strings.diff
Content-Type: text/x-patch; name=git-strings.diff; charset=ISO-8859-15
Content-Transfer-Encoding: base64

LS0tIC9kZXYvbnVsbAkyMDA3LTA3LTEyIDAzOjQwOjQxLjE2NTIxMjE2NyArMDMwMA0KKysrIHN0
ci5oCTIwMDctMDgtMzEgMDc6MzU6MDQuMDAwMDAwMDAwICswMzAwDQpAQCAtMCwwICsxLDMzIEBA
DQorI2lmbmRlZiBTVFJfSA0KKyNkZWZpbmUgU1RSX0gNCisNCitzdHJ1Y3Qgc3RyaW5nIHsNCisJ
Y2hhciAqYnVmOw0KKw0KKwl1bnNpZ25lZCBpbnQgYWxsb2Nfc2l6ZTsNCisJdW5zaWduZWQgaW50
IGxlbjsNCisNCisJdW5zaWduZWQgaW50IG1hbGxvY2VkOjE7DQorCXVuc2lnbmVkIGludCBvdmVy
Zmxvd2VkOjE7DQorfTsNCisNCisjZGVmaW5lIFNUUl9TVEFUSUMobmFtZSwgc2l6ZSkgXA0KKwlz
dHJ1Y3QgeyBcDQorCSAgc3RydWN0IHN0cmluZyBzdHI7IFwNCisJICBjaGFyIHN0cmluZ19idWZb
KHNpemUpICsgMV07IFwNCisJfSBuYW1lID0geyB7IChuYW1lKS5zdHJpbmdfYnVmLCBzaXplb2Yo
KG5hbWUpLnN0cmluZ19idWYpLCAwLCB9IH0NCisNCitleHRlcm4gc3RydWN0IHN0cmluZyAqc3Ry
X2FsbG9jKHVuc2lnbmVkIGludCBpbml0aWFsX3NpemUpOw0KK2V4dGVybiB2b2lkIHN0cl9mcmVl
KHN0cnVjdCBzdHJpbmcgKipzdHIpOw0KKw0KK2V4dGVybiB2b2lkIHN0cl9hcHBlbmRfbihzdHJ1
Y3Qgc3RyaW5nICpzdHIsIGNvbnN0IGNoYXIgKmNzdHIsDQorCQkJIHVuc2lnbmVkIGludCBsZW4p
Ow0KK2V4dGVybiB2b2lkIHN0cl9wcmludGZhKHN0cnVjdCBzdHJpbmcgKnN0ciwgY29uc3QgY2hh
ciAqZm10LCAuLi4pDQorCV9fYXR0cmlidXRlX18oKGZvcm1hdCAocHJpbnRmLCAyLCAzKSkpOw0K
K2V4dGVybiB2b2lkIHN0cl90cnVuY2F0ZShzdHJ1Y3Qgc3RyaW5nICpzdHIsIHVuc2lnbmVkIGlu
dCBsZW4pOw0KKw0KKyNkZWZpbmUgc3RyX2FwcGVuZChzdHIsIGNzdHIpIHN0cl9hcHBlbmRfbihz
dHIsIGNzdHIsIHN0cmxlbihjc3RyKSkNCisjZGVmaW5lIHN0cl9jKHN0cikgKChzdHIpLT5idWYp
DQorI2RlZmluZSBzdHJfbGVuKHN0cikgKChzdHIpLT5sZW4pDQorDQorI2VuZGlmDQotLS0gL2Rl
di9udWxsCTIwMDctMDctMTIgMDM6NDA6NDEuMTY1MjEyMTY3ICswMzAwDQorKysgc3RyLmMJMjAw
Ny0wOC0zMSAwNzozNjo1Ni4wMDAwMDAwMDAgKzAzMDANCkBAIC0wLDAgKzEsODUgQEANCisjaW5j
bHVkZSAic3RyLmgiDQorI2luY2x1ZGUgImdpdC1jb21wYXQtdXRpbC5oIg0KKw0KK3N0cnVjdCBz
dHJpbmcgKnN0cl9hbGxvYyh1bnNpZ25lZCBpbnQgaW5pdGlhbF9zaXplKQ0KK3sNCisJc3RydWN0
IHN0cmluZyAqc3RyOw0KKw0KKwlzdHIgPSB4Y2FsbG9jKHNpemVvZigqc3RyKSwgMSk7DQorCXN0
ci0+YWxsb2Nfc2l6ZSA9IGluaXRpYWxfc2l6ZSArIDE7DQorCXN0ci0+YnVmID0geG1hbGxvYyhz
dHItPmFsbG9jX3NpemUpOw0KKwlzdHItPmJ1ZlswXSA9ICdcMCc7DQorCXJldHVybiBzdHI7DQor
fQ0KKw0KK3ZvaWQgc3RyX2ZyZWUoc3RydWN0IHN0cmluZyAqKl9zdHIpDQorew0KKwlzdHJ1Y3Qg
c3RyaW5nICpzdHIgPSAqX3N0cjsNCisNCisJaWYgKHN0ci0+bWFsbG9jZWQpDQorCQlmcmVlKHN0
ci0+YnVmKTsNCisJc3RyLT5idWYgPSBOVUxMOw0KKwlmcmVlKHN0cik7DQorDQorCSpfc3RyID0g
TlVMTDsNCit9DQorDQorc3RhdGljIHZvaWQgc3RyX2dyb3dfaWZfbmVlZGVkKHN0cnVjdCBzdHJp
bmcgKnN0ciwgdW5zaWduZWQgaW50ICpsZW4pDQorew0KKwl1bnNpZ25lZCBpbnQgYXZhaWwgPSBz
dHItPmFsbG9jX3NpemUgLSBzdHItPmxlbjsNCisNCisJaWYgKCpsZW4gPj0gYXZhaWwpIHsNCisJ
CWlmICghc3RyLT5tYWxsb2NlZCkgew0KKwkJCS8qIHN0YXRpYyBidWZmZXIgc2l6ZSAqLw0KKwkJ
CSpsZW4gPSBhdmFpbDsNCisJCQlzdHItPm92ZXJmbG93ZWQgPSAxOw0KKwkJfSBlbHNlIHsNCisJ
CQlzdHItPmFsbG9jX3NpemUgPSAoc3RyLT5sZW4gKyAqbGVuKSAqIDI7DQorCQkJc3RyLT5idWYg
PSB4cmVhbGxvYyhzdHItPmJ1Ziwgc3RyLT5hbGxvY19zaXplKTsNCisJCX0NCisJfQ0KK30NCisN
Cit2b2lkIHN0cl9hcHBlbmRfbihzdHJ1Y3Qgc3RyaW5nICpzdHIsIGNvbnN0IGNoYXIgKmNzdHIs
IHVuc2lnbmVkIGludCBsZW4pDQorew0KKwlzdHJfZ3Jvd19pZl9uZWVkZWQoc3RyLCAmbGVuKTsN
CisJbWVtY3B5KHN0ci0+YnVmICsgc3RyLT5sZW4sIGNzdHIsIGxlbik7DQorCXN0ci0+bGVuICs9
IGxlbjsNCisJc3RyLT5idWZbc3RyLT5sZW5dID0gJ1wwJzsNCit9DQorDQordm9pZCBzdHJfcHJp
bnRmYShzdHJ1Y3Qgc3RyaW5nICpzdHIsIGNvbnN0IGNoYXIgKmZtdCwgLi4uKQ0KK3sNCisJdW5z
aWduZWQgaW50IGxlbiwgYXZhaWwgPSBzdHItPmFsbG9jX3NpemUgLSBzdHItPmxlbjsNCisJdmFf
bGlzdCB2YSwgdmEyOw0KKwlpbnQgcmV0Ow0KKw0KKwl2YV9zdGFydCh2YSwgZm10KTsNCisJdmFf
Y29weSh2YTIsIHZhKTsNCisJcmV0ID0gdnNucHJpbnRmKHN0ci0+YnVmICsgc3RyLT5sZW4sIGF2
YWlsLCBmbXQsIHZhKTsNCisJYXNzZXJ0KHJldCA+PSAwKTsNCisNCisJaWYgKCh1bnNpZ25lZCBp
bnQpcmV0ID49IGF2YWlsKSB7DQorCQlpZiAoIXN0ci0+bWFsbG9jZWQpIHsNCisJCQlzdHItPm92
ZXJmbG93ZWQgPSAxOw0KKwkJCXJldCA9IGF2YWlsID09IDAgPyAwIDogYXZhaWwtMTsNCisJCX0g
ZWxzZSB7DQorCQkJbGVuID0gcmV0Ow0KKwkJCXN0cl9ncm93X2lmX25lZWRlZChzdHIsICZsZW4p
Ow0KKwkJCWF2YWlsID0gc3RyLT5hbGxvY19zaXplIC0gc3RyLT5sZW47DQorDQorCQkJcmV0ID0g
dnNucHJpbnRmKHN0ci0+YnVmICsgc3RyLT5sZW4sIGF2YWlsLCBmbXQsIHZhMik7DQorCQkJYXNz
ZXJ0KHJldCA+PSAwICYmICh1bnNpZ25lZCBpbnQpcmV0IDwgYXZhaWwpOw0KKwkJfQ0KKwl9DQor
CXN0ci0+bGVuICs9IHJldDsNCisJdmFfZW5kKHZhKTsNCit9DQorDQordm9pZCBzdHJfdHJ1bmNh
dGUoc3RydWN0IHN0cmluZyAqc3RyLCB1bnNpZ25lZCBpbnQgbGVuKQ0KK3sNCisJaWYgKGxlbiA+
PSBzdHItPmFsbG9jX3NpemUpDQorCQlsZW4gPSBzdHItPmFsbG9jX3NpemUgLSAxOw0KKwlzdHIt
PmxlbiA9IGxlbjsNCisJc3RyLT5idWZbbGVuXSA9ICdcMCc7DQorfQ0K


--=-0wcW9MvPqzfpjsfLYvmI--

--=-qbYEstjkEqdbeC5PQkqJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG16BuyUhSUUBViskRAn0tAJ4k2sMOOdg5whjAPKjtMyogqXJHgQCgnRIt
cs2BDiZ35CuymldU9Or/f5I=
=RoRR
-----END PGP SIGNATURE-----

--=-qbYEstjkEqdbeC5PQkqJ--
