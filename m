From: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: [PATCH] Simplify the code and avoid an attribution.
Date: Wed, 21 Nov 2007 23:00:02 -0200
Message-ID: <b8bf37780711211700m1aa32006t6302f134f9c3fb7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25926_4956583.1195693202682"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 02:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv0Qb-0001z8-FX
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbXKVBAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 20:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbXKVBAH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 20:00:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:42719 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbXKVBAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 20:00:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so227935ugc
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 17:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=T002pCZ9lRD/JkPOxrJfhpJcFDvq8TbnmSYeNdyFpzI=;
        b=lyPJISI5U+Pd9IP3iVg/stJwJJ6u6iwMD4YMj0EfE3JZcNZ/VexXLBK/BpzhJvW5WJT6CcjtAX1WIf97zXcTV/8HEfduxlEQcdXmFNrPnZP7hOmBg3ythJBJiPLpMrOduN2yJkKHphYJfUi8Nb2Vz48657FNTicCPSbxT9cpNOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=ZLD/35W3Lcj574jWfzuq1fEjUYEqI07z8CudxIm0gTiRbIj23QNjYz40RTk3ene4Lm4ozGcC/uPgURvUUSPqLrLkH5k8Ht9JHURgbHy2cjK/MDrgZi0oWhz+T9ZVGmLaLkE/5FJy4X9Hihpc9yaVloGbqtQbJusECAKLy1usHTg=
Received: by 10.78.204.7 with SMTP id b7mr1474181hug.1195693202686;
        Wed, 21 Nov 2007 17:00:02 -0800 (PST)
Received: by 10.78.120.18 with HTTP; Wed, 21 Nov 2007 17:00:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65726>

------=_Part_25926_4956583.1195693202682
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, all!

    Please cc: me as I'm not subscribed. I'm sending the patch inline
only for review, probably it is mangled.
    Please use the attached patch if you agree with it. Sorry about
sending it attached.

>From cd0cc6995684e2801011910735146052e5b59ccc Mon Sep 17 00:00:00 2001
From: Andre Goddard Rosa <andre.goddard@gmail.com>
Date: Tue, 27 Nov 2007 10:22:46 -0200
Subject: [PATCH] Simplify the code and avoid an attribution.

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

-	ret = -1;
-	if (f) {
-		config_file = f;
-		config_file_name = filename;
-		config_linenr = 1;
-		ret = git_parse_file(fn);
-		fclose(f);
-		config_file_name = NULL;
-	}
+	if (!f)
+		return -1;
+
+	config_file = f;
+	config_file_name = filename;
+	config_linenr = 1;
+	ret = git_parse_file(fn);
+	fclose(f);
+	config_file_name = NULL;
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

-	if (f == NULL)
+	if (!f)
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
-	if ((f = fopen(filename, "rb")) == NULL)
+	if (!(f = fopen(filename, "rb")))
 		return error("Could not open %s", filename);
 	sz = xsize_t(st.st_size);
 	ptr->ptr = xmalloc(sz);
-- 
1.5.3.6.861.gd794-dirty

------=_Part_25926_4956583.1195693202682
Content-Type: text/x-patch;
 name=0004-Simplify-the-code-and-avoid-an-attribution.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9akrmyt0
Content-Disposition: attachment;
 filename=0004-Simplify-the-code-and-avoid-an-attribution.patch

RnJvbSBjZDBjYzY5OTU2ODRlMjgwMTAxMTkxMDczNTE0NjA1MmU1YjU5Y2NjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI3IE5vdiAyMDA3IDEwOjIyOjQ2IC0wMjAwClN1YmplY3Q6IFtQ
QVRDSF0gU2ltcGxpZnkgdGhlIGNvZGUgYW5kIGF2b2lkIGFuIGF0dHJpYnV0aW9uLgoKU2lnbmVk
LW9mZi1ieTogQW5kcmUgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWlsLmNvbT4KLS0t
CiBjb25maWcuYyAgICAgICAgICB8ICAgMTkgKysrKysrKysrKy0tLS0tLS0tLQogbWFpbG1hcC5j
ICAgICAgICAgfCAgICAyICstCiB4ZGlmZi1pbnRlcmZhY2UuYyB8ICAgIDIgKy0KIDMgZmlsZXMg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
Y29uZmlnLmMgYi9jb25maWcuYwppbmRleCA1NmU5OWZjLi43YzlmY2RkIDEwMDY0NAotLS0gYS9j
b25maWcuYworKysgYi9jb25maWcuYwpAQCAtNDQ3LDE1ICs0NDcsMTYgQEAgaW50IGdpdF9jb25m
aWdfZnJvbV9maWxlKGNvbmZpZ19mbl90IGZuLCBjb25zdCBjaGFyICpmaWxlbmFtZSkKIAlpbnQg
cmV0OwogCUZJTEUgKmYgPSBmb3BlbihmaWxlbmFtZSwgInIiKTsKIAotCXJldCA9IC0xOwotCWlm
IChmKSB7Ci0JCWNvbmZpZ19maWxlID0gZjsKLQkJY29uZmlnX2ZpbGVfbmFtZSA9IGZpbGVuYW1l
OwotCQljb25maWdfbGluZW5yID0gMTsKLQkJcmV0ID0gZ2l0X3BhcnNlX2ZpbGUoZm4pOwotCQlm
Y2xvc2UoZik7Ci0JCWNvbmZpZ19maWxlX25hbWUgPSBOVUxMOwotCX0KKwlpZiAoIWYpCisJCXJl
dHVybiAtMTsKKworCWNvbmZpZ19maWxlID0gZjsKKwljb25maWdfZmlsZV9uYW1lID0gZmlsZW5h
bWU7CisJY29uZmlnX2xpbmVuciA9IDE7CisJcmV0ID0gZ2l0X3BhcnNlX2ZpbGUoZm4pOworCWZj
bG9zZShmKTsKKwljb25maWdfZmlsZV9uYW1lID0gTlVMTDsKKwogCXJldHVybiByZXQ7CiB9CiAK
ZGlmZiAtLWdpdCBhL21haWxtYXAuYyBiL21haWxtYXAuYwppbmRleCA4NzE0MTY3Li4wYzEzZWNk
IDEwMDY0NAotLS0gYS9tYWlsbWFwLmMKKysrIGIvbWFpbG1hcC5jCkBAIC03LDcgKzcsNyBAQCBp
bnQgcmVhZF9tYWlsbWFwKHN0cnVjdCBwYXRoX2xpc3QgKm1hcCwgY29uc3QgY2hhciAqZmlsZW5h
bWUsIGNoYXIgKipyZXBvX2FiYnJldgogCWNoYXIgYnVmZmVyWzEwMjRdOwogCUZJTEUgKmYgPSBm
b3BlbihmaWxlbmFtZSwgInIiKTsKIAotCWlmIChmID09IE5VTEwpCisJaWYgKCFmKQogCQlyZXR1
cm4gMTsKIAl3aGlsZSAoZmdldHMoYnVmZmVyLCBzaXplb2YoYnVmZmVyKSwgZikgIT0gTlVMTCkg
ewogCQljaGFyICplbmRfb2ZfbmFtZSwgKmxlZnRfYnJhY2tldCwgKnJpZ2h0X2JyYWNrZXQ7CmRp
ZmYgLS1naXQgYS94ZGlmZi1pbnRlcmZhY2UuYyBiL3hkaWZmLWludGVyZmFjZS5jCmluZGV4IGJl
ODY2ZDEuLjlkZDFmM2IgMTAwNjQ0Ci0tLSBhL3hkaWZmLWludGVyZmFjZS5jCisrKyBiL3hkaWZm
LWludGVyZmFjZS5jCkBAIC0xMTEsNyArMTExLDcgQEAgaW50IHJlYWRfbW1maWxlKG1tZmlsZV90
ICpwdHIsIGNvbnN0IGNoYXIgKmZpbGVuYW1lKQogCiAJaWYgKHN0YXQoZmlsZW5hbWUsICZzdCkp
CiAJCXJldHVybiBlcnJvcigiQ291bGQgbm90IHN0YXQgJXMiLCBmaWxlbmFtZSk7Ci0JaWYgKChm
ID0gZm9wZW4oZmlsZW5hbWUsICJyYiIpKSA9PSBOVUxMKQorCWlmICghKGYgPSBmb3BlbihmaWxl
bmFtZSwgInJiIikpKQogCQlyZXR1cm4gZXJyb3IoIkNvdWxkIG5vdCBvcGVuICVzIiwgZmlsZW5h
bWUpOwogCXN6ID0geHNpemVfdChzdC5zdF9zaXplKTsKIAlwdHItPnB0ciA9IHhtYWxsb2Moc3op
OwotLSAKMS41LjMuNi44NjEuZ2Q3OTQtZGlydHkKCg==
------=_Part_25926_4956583.1195693202682--
