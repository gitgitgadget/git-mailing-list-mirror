From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 11/13] implement write rollback in write_one() if --pack-limit exceeded
Date: Thu, 5 Apr 2007 15:39:24 -0700
Message-ID: <56b7f5510704051539p36ba3368xd827acd3fa4a3181@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59103_2149137.1175812764946"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZacA-0008Mc-6z
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767388AbXDEWj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767387AbXDEWj2
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:39:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:27148 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767388AbXDEWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:39:26 -0400
Received: by wr-out-0506.google.com with SMTP id 71so466815wri
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:39:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=N+QDlocPGqgxUo8fmpBvT/H5uzwDpFTdCgbfJnX2YpJh0C19WfHzAKGj+rJPt2F4WRtpy1ue0ZOAxam9DeZxQCwrnHyf2FUVi8CbzWUGTFcwdVum/UlcchW6iuWsBo5y53LSCtiRxcYXh4yjpmu8Upmf+nJMir7qJffH31r1wsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=rOem6lvmEcL6kFrRSZe7UBLzj0+TV2Vjm77vcyZ/hrZb5yyLAvok9G5MMrJkVz+lwxGvcnmvL5j2KZa1LQA3UzoX0C4eWNx0yHUf+OiwQec3g9sdfTRGbHbHr2JxL5G9AMp/oYq7V3oI1G0+cX5yteB6k6a/N2ytgqZ6UXaRW1Y=
Received: by 10.114.183.1 with SMTP id g1mr967022waf.1175812765032;
        Thu, 05 Apr 2007 15:39:25 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:39:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43874>

------=_Part_59103_2149137.1175812764946
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59103_2149137.1175812764946
Content-Type: text/plain; name="0011-implement-write-rollback-in-write_one-if-pack-li.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0011-implement-write-rollback-in-write_one-if-pack-li.patch.txt"
X-Attachment-Id: f_f05sk0yg

RnJvbSBkN2Q3M2E5MTRlN2M0NTg3ODQ1ZWEwNDA4ZDNlNjJmYTQ0YjRhYzY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTQ6MjU6NTAgLTA3MDAKU3ViamVjdDogW1BBVENIIDEx
LzEzXSBpbXBsZW1lbnQgd3JpdGUgcm9sbGJhY2sgaW4gd3JpdGVfb25lKCkgaWYgLS1wYWNrLWxp
bWl0IGV4Y2VlZGVkCgotLS0KIGJ1aWx0aW4tcGFjay1vYmplY3RzLmMgfCAgIDI2ICsrKysrKysr
KysrKysrKysrKysrKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1wYWNrLW9iamVjdHMuYyBiL2J1aWx0
aW4tcGFjay1vYmplY3RzLmMKaW5kZXggYTI0M2VlZC4uYWM2NDNkZCAxMDA2NDQKLS0tIGEvYnVp
bHRpbi1wYWNrLW9iamVjdHMuYworKysgYi9idWlsdGluLXBhY2stb2JqZWN0cy5jCkBAIC01MTEs
MTUgKzUxMSwzNyBAQCBzdGF0aWMgb2ZmX3Qgd3JpdGVfb25lKHN0cnVjdCBzaGExZmlsZSAqZiwK
IAkJCSAgICAgICBzdHJ1Y3Qgb2JqZWN0X2VudHJ5ICplLAogCQkJICAgICAgIG9mZl90IG9mZnNl
dCkKIHsKLQlpZiAoZS0+b2Zmc2V0IHx8IGUtPnByZWZlcnJlZF9iYXNlKQorCWlmIChlLT5vZmZz
ZXQgfHwgZS0+cHJlZmVycmVkX2Jhc2UgfHwgZS0+bm9fd3JpdGUpCiAJCS8qIG9mZnNldCBzdGFy
dHMgZnJvbSBoZWFkZXIgc2l6ZSBhbmQgY2Fubm90IGJlIHplcm8KIAkJICogaWYgaXQgaXMgd3Jp
dHRlbiBhbHJlYWR5LgogCQkgKi8KIAkJcmV0dXJuIG9mZnNldDsKIAkvKiBpZiB3ZSBhcmUgZGVs
dGlmaWVkLCB3cml0ZSBvdXQgaXRzIGJhc2Ugb2JqZWN0IGZpcnN0LiAqLwotCWlmIChlLT5kZWx0
YSkKKwlpZiAoZS0+ZGVsdGEpIHsKIAkJb2Zmc2V0ID0gd3JpdGVfb25lKGYsIGUtPmRlbHRhLCBv
ZmZzZXQpOworCQlpZiAoIW9mZnNldCkKKwkJCXJldHVybiBvZmZzZXQ7CisJfQogCWUtPm9mZnNl
dCA9IG9mZnNldDsKKwlpZiAob2Zmc2V0X2xpbWl0KSB7CisJCS8qIHNhdmUgc3RhdGUgYmVmb3Jl
IHdyaXRlIGZvciBwb3NzaWJsZSBsYXRlciBzZWVrYmFjayAqLworCQlzdHJ1Y3Qgc2hhMXBvc24g
cG9zbjsKKwkJdWludDMyX3Qgc2F2ZV93cml0dGVuID0gd3JpdHRlbiwgc2F2ZV93cml0dGVuX2Rl
bHRhID0gd3JpdHRlbl9kZWx0YTsKKwkJdWludDMyX3Qgc2F2ZV9yZXVzZWQgPSByZXVzZWQsIHNh
dmVfcmV1c2VkX2RlbHRhID0gcmV1c2VkX2RlbHRhOworCQlzaGExbWFyayhmLCAmcG9zbik7CisJ
CW9mZnNldCArPSB3cml0ZV9vYmplY3QoZiwgZSk7CisJCS8qCisJCSAqIEVuc3VyZSB0aGUgcGFj
a2ZpbGUgc2l6ZSBuZXZlciBleGNlZWRzIG9yIG1hdGNoZXMgb2Zmc2V0X2xpbWl0LgorCQkgKiBU
aGUgIjIwIiBpcyBmb3IgdGhlIGZpbmFsIFNIQTEuCisJCSAqLworCQlpZiAoKHVuc2lnbmVkIGxv
bmcpb2Zmc2V0IDwgKHVuc2lnbmVkIGxvbmcpKG9mZnNldF9saW1pdCAtIDIwKSkKKwkJCXJldHVy
biBvZmZzZXQ7CisJCXdyaXR0ZW4gPSBzYXZlX3dyaXR0ZW4sIHdyaXR0ZW5fZGVsdGEgPSBzYXZl
X3dyaXR0ZW5fZGVsdGE7CisJCXJldXNlZCA9IHNhdmVfcmV1c2VkLCByZXVzZWRfZGVsdGEgPSBz
YXZlX3JldXNlZF9kZWx0YTsKKwkJc2hhMXVuZG8oZiwgJnBvc24sIG9mZnNldCwgZS0+b2Zmc2V0
KTsKKwkJZS0+b2Zmc2V0ID0gMDsKKwkJcmV0dXJuIDA7CisJfQogCXJldHVybiBvZmZzZXQgKyB3
cml0ZV9vYmplY3QoZiwgZSk7CiB9CiAKLS0gCjEuNS4xLnJjMi4xOC5nOWM4OC1kaXJ0eQoK
------=_Part_59103_2149137.1175812764946--
