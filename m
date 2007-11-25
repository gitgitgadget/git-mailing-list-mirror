From: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: [Resend PATCH] Simplify the code and avoid an assignment
Date: Sun, 25 Nov 2007 19:42:31 -0200
Message-ID: <b8bf37780711251342j5c733a2du18f5d79a11df4b9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33521_4347517.1196026951701"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 22:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPFg-0002un-4J
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 22:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbXKYVmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 16:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbXKYVmh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 16:42:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:17442 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbXKYVmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 16:42:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so808905ugc
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 13:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=Nx+5vCEnj2QPRDPJlN5iPgT5hPRXDSi6q5/idnZWZAM=;
        b=kYWFyUlbuwBEeNPHzc6TLLS8giGbeNr8I/syrrHxjnPPZp8JB2kg00iRO0vr7VziujThRDnfcqoVbrPG317UOVren9xifSEEQsuUaBSqyfw7aSv2yHFVNcuEe9AQHiGrYjOV02YnkD89o6uAh8b2ToyuyuqmFy1voCsKAFzh/Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=JYSWv5oGPsQDtPsS+2OiOiPv9c8WrWXTNbZZa+vlDMqI03O0uVx8wIZ5WE8FBr5MxOIVfTR1q1am5BL/HigPPmU5A1xgOqIDQGR4gTxVGNlHSAJWUTjVAKlgGKoFfUwPAH8FRhqKgBGvWXG509Eqq1xtZ6ArVtebPmkCpJmlcjE=
Received: by 10.78.160.2 with SMTP id i2mr2121644hue.1196026951709;
        Sun, 25 Nov 2007 13:42:31 -0800 (PST)
Received: by 10.78.120.18 with HTTP; Sun, 25 Nov 2007 13:42:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66011>

------=_Part_33521_4347517.1196026951701
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, all!

     Simplify the code for easier understanding.

>From cd0cc6995684e2801011910735146052e5b59ccc Mon Sep 17 00:00:00 2001
From: Andre Goddard Rosa <andre.goddard@gmail.com>
Date: Tue, 27 Nov 2007 10:22:46 -0200
Subject: [PATCH] Simplify the code and avoid an assignment.

Signed-off-by: Andre Goddard Rosa <andre.goddard@gmail.com>
---
 config.c          |   19 ++++++++++---------
 mailmap.c         |    2 +-
 xdiff-interface.c |    2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 56e99fc..7c9fcdd 100644
--- a/config.c
+++ b/config.c
@@ -447,15 +447,16 @@ int git_config_from_file(config_fn_t fn, const
char *filename)
        int ret;
        FILE *f = fopen(filename, "r");

-       ret = -1;
-       if (f) {
-               config_file = f;
-               config_file_name = filename;
-               config_linenr = 1;
-               ret = git_parse_file(fn);
-               fclose(f);
-               config_file_name = NULL;
-       }
+       if (!f)
+               return -1;
+
+       config_file = f;
+       config_file_name = filename;
+       config_linenr = 1;
+       ret = git_parse_file(fn);
+       fclose(f);
+       config_file_name = NULL;
+
        return ret;
 }

diff --git a/mailmap.c b/mailmap.c
index 8714167..0c13ecd 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -7,7 +7,7 @@ int read_mailmap(struct path_list *map, const char
*filename, char **repo_abbrev
        char buffer[1024];
        FILE *f = fopen(filename, "r");

-       if (f == NULL)
+       if (!f)
                return 1;
        while (fgets(buffer, sizeof(buffer), f) != NULL) {
                char *end_of_name, *left_bracket, *right_bracket;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index be866d1..9dd1f3b 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -111,7 +111,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)

        if (stat(filename, &st))
                return error("Could not stat %s", filename);
-       if ((f = fopen(filename, "rb")) == NULL)
+       if (!(f = fopen(filename, "rb")))
                return error("Could not open %s", filename);
        sz = xsize_t(st.st_size);
        ptr->ptr = xmalloc(sz);
--
1.5.3.6.861.gd794-dirty

------=_Part_33521_4347517.1196026951701
Content-Type: text/x-patch;
 name=0004-Simplify-the-code-and-avoid-an-assignment.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9g3i37n1
Content-Disposition: attachment;
 filename=0004-Simplify-the-code-and-avoid-an-assignment.patch

RnJvbSBjZDBjYzY5OTU2ODRlMjgwMTAxMTkxMDczNTE0NjA1MmU1YjU5Y2NjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI3IE5vdiAyMDA3IDEwOjIyOjQ2IC0wMjAwClN1YmplY3Q6IFtQ
QVRDSF0gU2ltcGxpZnkgdGhlIGNvZGUgYW5kIGF2b2lkIGFuIGFzc2lnbm1lbnQuCgpTaWduZWQt
b2ZmLWJ5OiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21haWwuY29tPgotLS0K
IGNvbmZpZy5jICAgICAgICAgIHwgICAxOSArKysrKysrKysrLS0tLS0tLS0tCiBtYWlsbWFwLmMg
ICAgICAgICB8ICAgIDIgKy0KIHhkaWZmLWludGVyZmFjZS5jIHwgICAgMiArLQogMyBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9j
b25maWcuYyBiL2NvbmZpZy5jCmluZGV4IDU2ZTk5ZmMuLjdjOWZjZGQgMTAwNjQ0Ci0tLSBhL2Nv
bmZpZy5jCisrKyBiL2NvbmZpZy5jCkBAIC00NDcsMTUgKzQ0NywxNiBAQCBpbnQgZ2l0X2NvbmZp
Z19mcm9tX2ZpbGUoY29uZmlnX2ZuX3QgZm4sIGNvbnN0IGNoYXIgKmZpbGVuYW1lKQogCWludCBy
ZXQ7CiAJRklMRSAqZiA9IGZvcGVuKGZpbGVuYW1lLCAiciIpOwogCi0JcmV0ID0gLTE7Ci0JaWYg
KGYpIHsKLQkJY29uZmlnX2ZpbGUgPSBmOwotCQljb25maWdfZmlsZV9uYW1lID0gZmlsZW5hbWU7
Ci0JCWNvbmZpZ19saW5lbnIgPSAxOwotCQlyZXQgPSBnaXRfcGFyc2VfZmlsZShmbik7Ci0JCWZj
bG9zZShmKTsKLQkJY29uZmlnX2ZpbGVfbmFtZSA9IE5VTEw7Ci0JfQorCWlmICghZikKKwkJcmV0
dXJuIC0xOworCisJY29uZmlnX2ZpbGUgPSBmOworCWNvbmZpZ19maWxlX25hbWUgPSBmaWxlbmFt
ZTsKKwljb25maWdfbGluZW5yID0gMTsKKwlyZXQgPSBnaXRfcGFyc2VfZmlsZShmbik7CisJZmNs
b3NlKGYpOworCWNvbmZpZ19maWxlX25hbWUgPSBOVUxMOworCiAJcmV0dXJuIHJldDsKIH0KIApk
aWZmIC0tZ2l0IGEvbWFpbG1hcC5jIGIvbWFpbG1hcC5jCmluZGV4IDg3MTQxNjcuLjBjMTNlY2Qg
MTAwNjQ0Ci0tLSBhL21haWxtYXAuYworKysgYi9tYWlsbWFwLmMKQEAgLTcsNyArNyw3IEBAIGlu
dCByZWFkX21haWxtYXAoc3RydWN0IHBhdGhfbGlzdCAqbWFwLCBjb25zdCBjaGFyICpmaWxlbmFt
ZSwgY2hhciAqKnJlcG9fYWJicmV2CiAJY2hhciBidWZmZXJbMTAyNF07CiAJRklMRSAqZiA9IGZv
cGVuKGZpbGVuYW1lLCAiciIpOwogCi0JaWYgKGYgPT0gTlVMTCkKKwlpZiAoIWYpCiAJCXJldHVy
biAxOwogCXdoaWxlIChmZ2V0cyhidWZmZXIsIHNpemVvZihidWZmZXIpLCBmKSAhPSBOVUxMKSB7
CiAJCWNoYXIgKmVuZF9vZl9uYW1lLCAqbGVmdF9icmFja2V0LCAqcmlnaHRfYnJhY2tldDsKZGlm
ZiAtLWdpdCBhL3hkaWZmLWludGVyZmFjZS5jIGIveGRpZmYtaW50ZXJmYWNlLmMKaW5kZXggYmU4
NjZkMS4uOWRkMWYzYiAxMDA2NDQKLS0tIGEveGRpZmYtaW50ZXJmYWNlLmMKKysrIGIveGRpZmYt
aW50ZXJmYWNlLmMKQEAgLTExMSw3ICsxMTEsNyBAQCBpbnQgcmVhZF9tbWZpbGUobW1maWxlX3Qg
KnB0ciwgY29uc3QgY2hhciAqZmlsZW5hbWUpCiAKIAlpZiAoc3RhdChmaWxlbmFtZSwgJnN0KSkK
IAkJcmV0dXJuIGVycm9yKCJDb3VsZCBub3Qgc3RhdCAlcyIsIGZpbGVuYW1lKTsKLQlpZiAoKGYg
PSBmb3BlbihmaWxlbmFtZSwgInJiIikpID09IE5VTEwpCisJaWYgKCEoZiA9IGZvcGVuKGZpbGVu
YW1lLCAicmIiKSkpCiAJCXJldHVybiBlcnJvcigiQ291bGQgbm90IG9wZW4gJXMiLCBmaWxlbmFt
ZSk7CiAJc3ogPSB4c2l6ZV90KHN0LnN0X3NpemUpOwogCXB0ci0+cHRyID0geG1hbGxvYyhzeik7
Ci0tIAoxLjUuMy42Ljg2MS5nZDc5NC1kaXJ0eQoK
------=_Part_33521_4347517.1196026951701--
