From: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: [PATCH] For the sake of correctness, fix file descriptor leak.
Date: Wed, 21 Nov 2007 22:59:16 -0200
Message-ID: <b8bf37780711211659v4fbd5936t29d0a0a2ff84f4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25921_23541160.1195693156234"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 01:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv0Pr-0001lb-0g
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbXKVA7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbXKVA7S
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:59:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:41230 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXKVA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:59:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so227802ugc
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 16:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=qSMya4yIzGIuEl+kX1H4VlnKpwjYMynBWO6/cFdXt7I=;
        b=fAzLHGgAQmGB/nn+vXVjrOUZAo3Bt1mbcpAT/csijFe0abTEkRaiH6G3/wVxP+dIi5j2IFdu6ixf+JE5KWNrAKyLcvVqrqwJH7WEKCnxR4bDTnuYSy0tbyeY+W6RfTGU7HSLf08JfdUHyRZGtPRIirQV2bnpu7U77k+5vrAORjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Hxqo1TbX/5az3F/1iK05NmDCMIkf4pUSTta7SDMtk17JyuEi1kJehE6vRFKgvlpdOe4Wus8fyjljXuoBMk9S7Ux7vWitWvxexyW19oPA48PYOlCqciUZEQuQ42eeAFy1xfklEJpF6lXKIXUMu0PxvqcPbGqn4oENXaN0kMlQZnw=
Received: by 10.78.151.3 with SMTP id y3mr9089802hud.1195693156247;
        Wed, 21 Nov 2007 16:59:16 -0800 (PST)
Received: by 10.78.120.18 with HTTP; Wed, 21 Nov 2007 16:59:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65724>

------=_Part_25921_23541160.1195693156234
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, all!

    Please cc: me as I'm not subscribed. I'm sending the patch inline
only for review, probably it is mangled.
    Please use the attached patch if you agree with it. Sorry about
sending it attached.

>From 9fba346aca7470633ee46848013051248493896c Mon Sep 17 00:00:00 2001
From: Andre Goddard Rosa <andre.goddard@gmail.com>
Date: Tue, 27 Nov 2007 10:16:22 -0200
Subject: [PATCH] For the sake of correctness, fix file descriptor leak.

Signed-off-by: Andre Goddard Rosa <andre.goddard@gmail.com>
---
 builtin-rerere.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 7449323..31766be 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -275,8 +275,10 @@ static int copy_file(const char *src, const char *dest)

 	if (!(in = fopen(src, "r")))
 		return error("Could not open %s", src);
-	if (!(out = fopen(dest, "w")))
+	if (!(out = fopen(dest, "w"))) {
+		fclose(in);
 		return error("Could not open %s", dest);
+	}
 	while ((count = fread(buffer, 1, sizeof(buffer), in)))
 		fwrite(buffer, 1, count, out);
 	fclose(in);
-- 
1.5.3.6.861.gd794-dirty

------=_Part_25921_23541160.1195693156234
Content-Type: text/x-patch;
 name=0002-For-the-sake-of-correctness-fix-file-descriptor-le.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9akopii0
Content-Disposition: attachment;
 filename=0002-For-the-sake-of-correctness-fix-file-descriptor-le.patch

RnJvbSA5ZmJhMzQ2YWNhNzQ3MDYzM2VlNDY4NDgwMTMwNTEyNDg0OTM4OTZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI3IE5vdiAyMDA3IDEwOjE2OjIyIC0wMjAwClN1YmplY3Q6IFtQ
QVRDSF0gRm9yIHRoZSBzYWtlIG9mIGNvcnJlY3RuZXNzLCBmaXggZmlsZSBkZXNjcmlwdG9yIGxl
YWsuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgotLS0KIGJ1aWx0aW4tcmVyZXJlLmMgfCAgICA0ICsrKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4t
cmVyZXJlLmMgYi9idWlsdGluLXJlcmVyZS5jCmluZGV4IDc0NDkzMjMuLjMxNzY2YmUgMTAwNjQ0
Ci0tLSBhL2J1aWx0aW4tcmVyZXJlLmMKKysrIGIvYnVpbHRpbi1yZXJlcmUuYwpAQCAtMjc1LDgg
KzI3NSwxMCBAQCBzdGF0aWMgaW50IGNvcHlfZmlsZShjb25zdCBjaGFyICpzcmMsIGNvbnN0IGNo
YXIgKmRlc3QpCiAKIAlpZiAoIShpbiA9IGZvcGVuKHNyYywgInIiKSkpCiAJCXJldHVybiBlcnJv
cigiQ291bGQgbm90IG9wZW4gJXMiLCBzcmMpOwotCWlmICghKG91dCA9IGZvcGVuKGRlc3QsICJ3
IikpKQorCWlmICghKG91dCA9IGZvcGVuKGRlc3QsICJ3IikpKSB7CisJCWZjbG9zZShpbik7CiAJ
CXJldHVybiBlcnJvcigiQ291bGQgbm90IG9wZW4gJXMiLCBkZXN0KTsKKwl9CiAJd2hpbGUgKChj
b3VudCA9IGZyZWFkKGJ1ZmZlciwgMSwgc2l6ZW9mKGJ1ZmZlciksIGluKSkpCiAJCWZ3cml0ZShi
dWZmZXIsIDEsIGNvdW50LCBvdXQpOwogCWZjbG9zZShpbik7Ci0tIAoxLjUuMy42Ljg2MS5nZDc5
NC1kaXJ0eQoK
------=_Part_25921_23541160.1195693156234--
