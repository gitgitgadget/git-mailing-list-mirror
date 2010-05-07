From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Any way to get complete diff up to a tag?
Date: Fri, 7 May 2010 18:35:41 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74482E5113B@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
 <20100506094212.GB9921@atjola.homenet>
 <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
 <4BE2BE2C.8050403@viscovery.net>
 <A612847CFE53224C91B23E3A5B48BAC74482E50F03@xmail3.se.axis.com>
 <alpine.LFD.2.00.1005060955000.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A612847CFE53224C91B23E3A5B48BAC74482E5113Bxmail3seaxisc_"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 07 18:36:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQX3-0005No-Lr
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab0EGQgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 12:36:05 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:42168 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243Ab0EGQgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 12:36:01 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o47GZj61013136;
	Fri, 7 May 2010 18:35:45 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Fri, 7 May 2010 18:35:45 +0200
Thread-Topic: Any way to get complete diff up to a tag?
Thread-Index: AcrtP0fkUoyPGeS5R46y3TfYU0rF5QAwZjWQ
In-Reply-To: <alpine.LFD.2.00.1005060955000.901@i5.linux-foundation.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146539>

--_002_A612847CFE53224C91B23E3A5B48BAC74482E5113Bxmail3seaxisc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Linus Torvalds
> Sent: den 6 maj 2010 19:09
> To: Peter Kjellerstedt
> Cc: Johannes Sixt; git@vger.kernel.org; Bj=F6rn Steinbrink
> Subject: RE: Any way to get complete diff up to a tag?
>=20
> On Thu, 6 May 2010, Peter Kjellerstedt wrote:
> >
> > Since the 4b825dc642cb6eb9a060e54bf8d69288fbee4904 SHA1 is somewhat
> > cumbersome to remember, wouldn't it be an idea to give it some kind
> > of alias or mnemonic? E.g., something like @~ (or some other mix of
> > odd characters which do not clash with all the other similar
> > constructs already used for references).
>=20
> Well, you don't strictly speaking have to "remember" it, you can always
> just re-generate it. The most straightforward way to do that is
> probably
>=20
> 	git hash-object -t tree --stdin < /dev/null

Thank you, that is good to know.

> although I admit that maybe we could have some syntax for "git diff"
> that would do the "diff against empty tree" automatically. It does=20
> seem to be conceptually a reasonable thing to do.
>=20
> For example, right now if you give "git diff" a single SHA1, it will
> work against the working tree. Except if you add "--cached", to say=20
> that you want the diff against the index. I don't think it would be in=20
> any way _wrong_ to make "--root" mean that you want it against an=20
> empty tree.
>=20
> [ We already accept "--root", but it has no meaning for "git diff"=20
>   with a single SHA1. It matters for showing the root commit for=20
>   'git-diff-tree'.
>=20
>   And means something totally different for git-format-patch ]
>=20
> So we certainly _could_ do something like
>=20
> 	git diff --root <treeish>

I went ahead and implemented support for --root as an option to git=20
diff (patch attached for reference). However, I then realized that=20
there are probably more commands that would benefit from the same=20
support, e.g., git diff-index. Then I thought about git diff-tree
and realized that it could also benefit from my version of --root,
but as you mentioned above, it already has a --root option with
a different semantic... I also figured it would be a hassle for me=20
to find all commands who can use a --root option, not knowing the=20
internals of git well enough yet.

So I then went back to my original idea of making an alias for the
empty tree, and came up with a two line patch which I will send as
a separate patch, and see what you guys think of the idea.

> and make it do what you want. That said, the "empty tree" thing works
> for all versions of git (well, some older versions of git need the=20
> actual object, but you could always use "-w" on that git-hash-object=20
> command line, and then it really should work for every git version).
>=20
> 			Linus

//Peter


--_002_A612847CFE53224C91B23E3A5B48BAC74482E5113Bxmail3seaxisc_
Content-Type: application/octet-stream;
	name="0001-diff-Make-git-diff-support-the-root-option.patch"
Content-Description: 0001-diff-Make-git-diff-support-the-root-option.patch
Content-Disposition: attachment;
	filename="0001-diff-Make-git-diff-support-the-root-option.patch"; size=3454;
	creation-date="Fri, 07 May 2010 18:24:04 GMT";
	modification-date="Fri, 07 May 2010 17:41:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkOWQ0ODJkYjk4YWEzZmYzNTQ1Y2Y2NmE4Zjg1MWNjNDU5YjBlYWNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlciBLamVsbGVyc3RlZHQgPHBrakBheGlzLmNvbT4KRGF0
ZTogRnJpLCA3IE1heSAyMDEwIDE3OjExOjE5ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZGlmZjog
TWFrZSBnaXQgZGlmZiBzdXBwb3J0IHRoZSAtLXJvb3Qgb3B0aW9uCgpVc2luZyAnZ2l0IGRpZmYg
LS1yb290IDx0cmVlLWlzaD4nIHdpbGwgZ2l2ZSBhbGwgdGhlIGNoYW5nZXMgYmV0d2Vlbgp0aGUg
ZW1wdHkgdHJlZSBhbmQgPHRyZWUtaXNoPi4gSXQgaXMgYWxzbyBwb3NzaWJsZSB0byB1c2UgJ2dp
dCBkaWZmCi0tcm9vdCAtLWNhY2hlZCcgdG8gZ2V0IGFsbCBjaGFuZ2VzIGJldHdlZW4gdGhlIGVt
cHR5IHRyZWUgYW5kIHRoZQpjdXJyZW50IGluZGV4LgoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgS2pl
bGxlcnN0ZWR0IDxwa2pAYXhpcy5jb20+Ci0tLQogYnVpbHRpbi9kaWZmLmMgfCAgIDI4ICsrKysr
KysrKysrKysrKysrKysrKystLS0tLS0KIHJldmlzaW9uLmMgICAgIHwgICAxMiArKysrKysrKysr
KysKIHJldmlzaW9uLmggICAgIHwgICAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi9kaWZmLmMgYi9idWls
dGluL2RpZmYuYwppbmRleCBmZmNkZDA1Li44ZGE1OWRkIDEwMDY0NAotLS0gYS9idWlsdGluL2Rp
ZmYuYworKysgYi9idWlsdGluL2RpZmYuYwpAQCAtMjUzLDYgKzI1Myw3IEBAIGludCBjbWRfZGlm
ZihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkKIAljb25z
dCBjaGFyICpwYXRoID0gTlVMTDsKIAlzdHJ1Y3QgYmxvYmluZm8gYmxvYlsyXTsKIAlpbnQgbm9u
Z2l0OworCWludCBjYWNoZWQgPSAwOwogCWludCByZXN1bHQgPSAwOwogCiAJLyoKQEAgLTMxNiwx
MCArMzE3LDEwIEBAIGludCBjbWRfZGlmZihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNv
bnN0IGNoYXIgKnByZWZpeCkKIAkJc2V0dXBfcGFnZXIoKTsKIAogCS8qCi0JICogRG8gd2UgaGF2
ZSAtLWNhY2hlZCBhbmQgbm90IGhhdmUgYSBwZW5kaW5nIG9iamVjdCwgdGhlbgotCSAqIGRlZmF1
bHQgdG8gSEVBRCBieSBoYW5kLiAgRWVrLgorCSAqIElmIHdlIGhhdmUgLS1jYWNoZWQgYW5kL29y
IC0tcm9vdCB3ZSBtYXkgbmVlZCB0byBhZGQgdGhlIGVtcHR5IHRyZWUKKwkgKiBvciBIRUFEIGJ5
IGhhbmQuICBFZWsuCiAJICovCi0JaWYgKCFyZXYucGVuZGluZy5ucikgeworCWlmIChyZXYucGVu
ZGluZy5uciA8PSAxKSB7CiAJCWludCBpOwogCQlmb3IgKGkgPSAxOyBpIDwgYXJnYzsgaSsrKSB7
CiAJCQljb25zdCBjaGFyICphcmcgPSBhcmd2W2ldOwpAQCAtMzI3LDE0ICszMjgsMjkgQEAgaW50
IGNtZF9kaWZmKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4
KQogCQkJCWJyZWFrOwogCQkJZWxzZSBpZiAoIXN0cmNtcChhcmcsICItLWNhY2hlZCIpIHx8CiAJ
CQkJICFzdHJjbXAoYXJnLCAiLS1zdGFnZWQiKSkgewotCQkJCWFkZF9oZWFkX3RvX3BlbmRpbmco
JnJldik7Ci0JCQkJaWYgKCFyZXYucGVuZGluZy5ucikKLQkJCQkJZGllKCJObyBIRUFEIGNvbW1p
dCB0byBjb21wYXJlIHdpdGggKHlldCkiKTsKKwkJCQljYWNoZWQgPSAxOwogCQkJCWJyZWFrOwog
CQkJfQogCQl9CiAJfQogCisJaWYgKCFyZXYucGVuZGluZy5ucikgeworCQlpZiAocmV2LnNob3df
cm9vdF9kaWZmKSB7CisJCQlhZGRfZW1wdHlfdHJlZV90b19wZW5kaW5nKCZyZXYpOworCQkJaWYg
KCFyZXYucGVuZGluZy5ucikKKwkJCQlkaWUoIk5vIGVtcHR5IHRyZWUgdG8gY29tcGFyZSB3aXRo
Iik7CisJCX0gZWxzZSBpZiAoY2FjaGVkKSB7CisJCQlhZGRfaGVhZF90b19wZW5kaW5nKCZyZXYp
OworCQkJaWYgKCFyZXYucGVuZGluZy5ucikKKwkJCQlkaWUoIk5vIEhFQUQgY29tbWl0IHRvIGNv
bXBhcmUgd2l0aCAoeWV0KSIpOworCQl9CisJfSBlbHNlIGlmIChyZXYucGVuZGluZy5uciA9PSAx
ICYmIHJldi5zaG93X3Jvb3RfZGlmZiAmJiAhY2FjaGVkKSB7CisJCWFkZF9lbXB0eV90cmVlX3Rv
X3BlbmRpbmcoJnJldik7CisJCWlmIChyZXYucGVuZGluZy5uciAhPSAyKQorCQkJZGllKCJObyBl
bXB0eSB0cmVlIHRvIGNvbXBhcmUgd2l0aCIpOworCQlyZXYuZGlmZm9wdC5mbGFncyBePSBESUZG
X09QVF9SRVZFUlNFX0RJRkY7CisJfQorCiAJZm9yIChpID0gMDsgaSA8IHJldi5wZW5kaW5nLm5y
OyBpKyspIHsKIAkJc3RydWN0IG9iamVjdF9hcnJheV9lbnRyeSAqbGlzdCA9IHJldi5wZW5kaW5n
Lm9iamVjdHMraTsKIAkJc3RydWN0IG9iamVjdCAqb2JqID0gbGlzdC0+aXRlbTsKZGlmZiAtLWdp
dCBhL3JldmlzaW9uLmMgYi9yZXZpc2lvbi5jCmluZGV4IGY0YjhiMzguLmMzYTc4ZGMgMTAwNjQ0
Ci0tLSBhL3JldmlzaW9uLmMKKysrIGIvcmV2aXNpb24uYwpAQCAtMTY5LDYgKzE2OSwxOCBAQCB2
b2lkIGFkZF9oZWFkX3RvX3BlbmRpbmcoc3RydWN0IHJldl9pbmZvICpyZXZzKQogCWFkZF9wZW5k
aW5nX29iamVjdChyZXZzLCBvYmosICJIRUFEIik7CiB9CiAKK3ZvaWQgYWRkX2VtcHR5X3RyZWVf
dG9fcGVuZGluZyhzdHJ1Y3QgcmV2X2luZm8gKnJldnMpCit7CisJdW5zaWduZWQgY2hhciBzaGEx
WzIwXTsKKwlzdHJ1Y3Qgb2JqZWN0ICpvYmo7CisJaWYgKGdldF9zaGExKEVNUFRZX1RSRUVfU0hB
MV9IRVgsIHNoYTEpKQorCQlyZXR1cm47CisJb2JqID0gcGFyc2Vfb2JqZWN0KHNoYTEpOworCWlm
ICghb2JqKQorCQlyZXR1cm47CisJYWRkX3BlbmRpbmdfb2JqZWN0KHJldnMsIG9iaiwgRU1QVFlf
VFJFRV9TSEExX0hFWCk7Cit9CisKIHN0YXRpYyBzdHJ1Y3Qgb2JqZWN0ICpnZXRfcmVmZXJlbmNl
KHN0cnVjdCByZXZfaW5mbyAqcmV2cywgY29uc3QgY2hhciAqbmFtZSwgY29uc3QgdW5zaWduZWQg
Y2hhciAqc2hhMSwgdW5zaWduZWQgaW50IGZsYWdzKQogewogCXN0cnVjdCBvYmplY3QgKm9iamVj
dDsKZGlmZiAtLWdpdCBhL3JldmlzaW9uLmggYi9yZXZpc2lvbi5oCmluZGV4IDU2OGYxYzkuLmUx
YTdkOWQgMTAwNjQ0Ci0tLSBhL3JldmlzaW9uLmgKKysrIGIvcmV2aXNpb24uaApAQCAtMTc2LDYg
KzE3Niw3IEBAIGV4dGVybiB2b2lkIGFkZF9vYmplY3Qoc3RydWN0IG9iamVjdCAqb2JqLAogZXh0
ZXJuIHZvaWQgYWRkX3BlbmRpbmdfb2JqZWN0KHN0cnVjdCByZXZfaW5mbyAqcmV2cywgc3RydWN0
IG9iamVjdCAqb2JqLCBjb25zdCBjaGFyICpuYW1lKTsKIAogZXh0ZXJuIHZvaWQgYWRkX2hlYWRf
dG9fcGVuZGluZyhzdHJ1Y3QgcmV2X2luZm8gKik7CitleHRlcm4gdm9pZCBhZGRfZW1wdHlfdHJl
ZV90b19wZW5kaW5nKHN0cnVjdCByZXZfaW5mbyAqcmV2cyk7CiAKIGVudW0gY29tbWl0X2FjdGlv
biB7CiAJY29tbWl0X2lnbm9yZSwKLS0gCjEuNy4wLjEKCg==

--_002_A612847CFE53224C91B23E3A5B48BAC74482E5113Bxmail3seaxisc_--
