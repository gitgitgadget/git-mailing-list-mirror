From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Improve the naming of guessed target repository for 
	git clone
Date: Thu, 14 May 2009 10:33:02 +0200
Message-ID: <81b0412b0905140133l78def06kae0cb4798feaa4a9@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <200905121557.18542.Hugo.Mildenberger@namir.de>
	 <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	 <200905121900.00625.Hugo.Mildenberger@namir.de>
	 <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	 <20090512172452.GA32594@blimp.localdomain>
	 <20090513180853.GB26288@blimp.localdomain>
	 <20090513205333.GA21631@blimp.localdomain>
	 <7vfxf81ppd.fsf@alter.siamese.dyndns.org>
	 <81b0412b0905132254n5046666t24f3887f1fd4e4d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f040921c3a2f0469db2d11
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 10:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4WNT-0004ER-O0
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 10:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbZENIdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 04:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZENIdG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 04:33:06 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43405 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbZENIdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 04:33:02 -0400
Received: by fxm2 with SMTP id 2so1141214fxm.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=K3Rhx0hnzydPCsbAy5qdxEzO0XfHYialMDJ0tdzn7zM=;
        b=udcuN6JQKS5iKH1kZQIhfN2ViLbVVqUv0tSZ5uzhS1iHyi3T0U31RfjCfSgW96ZYuY
         mvBFR0xTZRP5Dfc3e185pSwfguzuM4fH+itlLxLVWh5ITQZFpwtKlZyBlFw+tjZQKGx5
         q+8Qnh/YGQtk7Vhn55iWYti+Rb5JrXlbKQGCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WI044Npa8q6ax3ZD8XTYfHBBA5y5eGMnmrMWEGHeUcG6LyVENsPVSdJvWBkSbfL86J
         19s29dVeRI179CL/OAqpo/ipS4mVdeYFDG5uixVKY7k+IIMtcy7K+9ncWBHmsFPsJqwM
         vNetGDTXitxr3CGb7IRZqKP10CxcHt1MTwyV0=
Received: by 10.204.31.78 with SMTP id x14mr1905727bkc.3.1242289982421; Thu, 
	14 May 2009 01:33:02 -0700 (PDT)
In-Reply-To: <81b0412b0905132254n5046666t24f3887f1fd4e4d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119170>

--001485f040921c3a2f0469db2d11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Strip leading and trailing spaces off guessed target directory, and
replace sequences of whitespace and 'control' characters with one
space character.

User still can have any name by specifying it explicitely after url.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

2009/5/14 Alex Riesen <raa.lkml@gmail.com>:
> But I should complete the patch: remove heading whitespace, and replace
> multiple spaces and control characters with one space.

Done.

 builtin-clone.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 880373f..d068b7e 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -104,11 +104,12 @@ static char *get_repo_path(const char *repo, int
*is_bundle)
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
+	char *dir;

 	/*
-	 * Strip trailing slashes and /.git
+	 * Strip trailing spaces, slashes and /.git
 	 */
-	while (repo < end && is_dir_sep(end[-1]))
+	while (repo < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
 		end--;
 	if (end - repo > 5 && is_dir_sep(end[-5]) &&
 	    !strncmp(end - 4, ".git", 4)) {
@@ -140,10 +141,33 @@ static char *guess_dir_name(const char *repo,
int is_bundle, int is_bare)
 	if (is_bare) {
 		struct strbuf result = STRBUF_INIT;
 		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
-		return strbuf_detach(&result, 0);
+		dir = strbuf_detach(&result, 0);
+	} else
+		dir = xstrndup(start, end - start);
+	/*
+	 * Replace sequences of 'control' characters and whitespace
+	 * with one ascii space, remove leading and trailing spaces.
+	 */
+	if (*dir) {
+		char *out = dir;
+		int prev_space = 1 /* strip leading whitespace */;
+		for (end = dir; *end; ++end) {
+			char ch = *end;
+			if ((unsigned char)ch < '\x20')
+				ch = '\x20';
+			if (isspace(ch)) {
+				if (prev_space)
+					continue;
+				prev_space = 1;
+			} else
+				prev_space = 0;
+			*out++ = ch;
+		}
+		*out = '\0';
+		if (out > dir && prev_space)
+			out[-1] = '\0';
 	}
-
-	return xstrndup(start, end - start);
+	return dir;
 }

 static void strip_trailing_slashes(char *dir)
-- 
1.6.3.1.37.g5d96e

--001485f040921c3a2f0469db2d11
Content-Type: application/octet-stream; 
	name="0002-Improve-the-naming-of-guessed-target-repository-for-.patch"
Content-Disposition: attachment; 
	filename="0002-Improve-the-naming-of-guessed-target-repository-for-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fup7dkaf0

RnJvbSA2ZDYwNzUxMzBhZmJkZDM1MjYwZTNlMzNjMDk5ZjU3ZDlmYWViZTk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDEzIE1heSAyMDA5IDE4OjMyOjA2ICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIElt
cHJvdmUgdGhlIG5hbWluZyBvZiBndWVzc2VkIHRhcmdldCByZXBvc2l0b3J5IGZvciBnaXQgY2xv
bmUKClN0cmlwIGxlYWRpbmcgYW5kIHRyYWlsaW5nIHNwYWNlcyBvZmYgZ3Vlc3NlZCB0YXJnZXQg
ZGlyZWN0b3J5LCBhbmQKcmVwbGFjZSBzZXF1ZW5jZXMgb2Ygd2hpdGVzcGFjZSBhbmQgJ2NvbnRy
b2wnIGNoYXJhY3RlcnMgd2l0aCBvbmUKc3BhY2UgY2hhcmFjdGVyLgoKVXNlciBzdGlsbCBjYW4g
aGF2ZSBhbnkgbmFtZSBieSBzcGVjaWZ5aW5nIGl0IGV4cGxpY2l0ZWx5IGFmdGVyIHVybC4KClNp
Z25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogYnVpbHRp
bi1jbG9uZS5jIHwgICAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZp
bGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvYnVpbHRpbi1jbG9uZS5jIGIvYnVpbHRpbi1jbG9uZS5jCmluZGV4IDg4MDM3M2YuLmQwNjhi
N2UgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tY2xvbmUuYworKysgYi9idWlsdGluLWNsb25lLmMKQEAg
LTEwNCwxMSArMTA0LDEyIEBAIHN0YXRpYyBjaGFyICpnZXRfcmVwb19wYXRoKGNvbnN0IGNoYXIg
KnJlcG8sIGludCAqaXNfYnVuZGxlKQogc3RhdGljIGNoYXIgKmd1ZXNzX2Rpcl9uYW1lKGNvbnN0
IGNoYXIgKnJlcG8sIGludCBpc19idW5kbGUsIGludCBpc19iYXJlKQogewogCWNvbnN0IGNoYXIg
KmVuZCA9IHJlcG8gKyBzdHJsZW4ocmVwbyksICpzdGFydDsKKwljaGFyICpkaXI7CiAKIAkvKgot
CSAqIFN0cmlwIHRyYWlsaW5nIHNsYXNoZXMgYW5kIC8uZ2l0CisJICogU3RyaXAgdHJhaWxpbmcg
c3BhY2VzLCBzbGFzaGVzIGFuZCAvLmdpdAogCSAqLwotCXdoaWxlIChyZXBvIDwgZW5kICYmIGlz
X2Rpcl9zZXAoZW5kWy0xXSkpCisJd2hpbGUgKHJlcG8gPCBlbmQgJiYgKGlzX2Rpcl9zZXAoZW5k
Wy0xXSkgfHwgaXNzcGFjZShlbmRbLTFdKSkpCiAJCWVuZC0tOwogCWlmIChlbmQgLSByZXBvID4g
NSAmJiBpc19kaXJfc2VwKGVuZFstNV0pICYmCiAJICAgICFzdHJuY21wKGVuZCAtIDQsICIuZ2l0
IiwgNCkpIHsKQEAgLTE0MCwxMCArMTQxLDMzIEBAIHN0YXRpYyBjaGFyICpndWVzc19kaXJfbmFt
ZShjb25zdCBjaGFyICpyZXBvLCBpbnQgaXNfYnVuZGxlLCBpbnQgaXNfYmFyZSkKIAlpZiAoaXNf
YmFyZSkgewogCQlzdHJ1Y3Qgc3RyYnVmIHJlc3VsdCA9IFNUUkJVRl9JTklUOwogCQlzdHJidWZf
YWRkZigmcmVzdWx0LCAiJS4qcy5naXQiLCAoaW50KShlbmQgLSBzdGFydCksIHN0YXJ0KTsKLQkJ
cmV0dXJuIHN0cmJ1Zl9kZXRhY2goJnJlc3VsdCwgMCk7CisJCWRpciA9IHN0cmJ1Zl9kZXRhY2go
JnJlc3VsdCwgMCk7CisJfSBlbHNlCisJCWRpciA9IHhzdHJuZHVwKHN0YXJ0LCBlbmQgLSBzdGFy
dCk7CisJLyoKKwkgKiBSZXBsYWNlIHNlcXVlbmNlcyBvZiAnY29udHJvbCcgY2hhcmFjdGVycyBh
bmQgd2hpdGVzcGFjZQorCSAqIHdpdGggb25lIGFzY2lpIHNwYWNlLCByZW1vdmUgbGVhZGluZyBh
bmQgdHJhaWxpbmcgc3BhY2VzLgorCSAqLworCWlmICgqZGlyKSB7CisJCWNoYXIgKm91dCA9IGRp
cjsKKwkJaW50IHByZXZfc3BhY2UgPSAxIC8qIHN0cmlwIGxlYWRpbmcgd2hpdGVzcGFjZSAqLzsK
KwkJZm9yIChlbmQgPSBkaXI7ICplbmQ7ICsrZW5kKSB7CisJCQljaGFyIGNoID0gKmVuZDsKKwkJ
CWlmICgodW5zaWduZWQgY2hhciljaCA8ICdceDIwJykKKwkJCQljaCA9ICdceDIwJzsKKwkJCWlm
IChpc3NwYWNlKGNoKSkgeworCQkJCWlmIChwcmV2X3NwYWNlKQorCQkJCQljb250aW51ZTsKKwkJ
CQlwcmV2X3NwYWNlID0gMTsKKwkJCX0gZWxzZQorCQkJCXByZXZfc3BhY2UgPSAwOworCQkJKm91
dCsrID0gY2g7CisJCX0KKwkJKm91dCA9ICdcMCc7CisJCWlmIChvdXQgPiBkaXIgJiYgcHJldl9z
cGFjZSkKKwkJCW91dFstMV0gPSAnXDAnOwogCX0KLQotCXJldHVybiB4c3RybmR1cChzdGFydCwg
ZW5kIC0gc3RhcnQpOworCXJldHVybiBkaXI7CiB9CiAKIHN0YXRpYyB2b2lkIHN0cmlwX3RyYWls
aW5nX3NsYXNoZXMoY2hhciAqZGlyKQotLSAKMS42LjMuMS4zNy5nNWQ5NmUKCg==
--001485f040921c3a2f0469db2d11--
