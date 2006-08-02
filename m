From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/10] Ensure git-clone exits with error if perl script fails.
Date: Wed, 2 Aug 2006 02:03:16 +0100
Message-ID: <00a201c6b5cf$6fe0d0a0$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00A3_01C6B5D7.D1A538A0"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858W-0006w4-HS
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWHBBC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWHBBC6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:02:58 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:33033 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750894AbWHBBC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:02:57 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858R-000C1I-H2
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:02:56 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24620>

This is a multi-part message in MIME format.

------=_NextPart_000_00A3_01C6B5D7.D1A538A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

This helps tests 5400,5600,5700,5710 "fail correctly" rather than
give some false positives.  Also ensure cleanup actions in exit trap
work correctly even if user has alias rm='rm -i'.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 git-clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 6a14b25..47bd8e7 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -205,7 +205,7 @@ # Try using "humanish" part of source re
 [ -e "$dir" ] && echo "$dir already exists." && usage
 mkdir -p "$dir" &&
 D=$(cd "$dir" && pwd) &&
-trap 'err=$?; cd ..; rm -r "$D"; exit $err' 0
+trap 'err=$?; cd ..; rm -rf "$D"; exit $err' 0
 case "$bare" in
 yes)
 	GIT_DIR="$D" ;;
@@ -324,7 +324,7 @@ test -d "$GIT_DIR/refs/reference-tmp" &&
 if test -f "$GIT_DIR/CLONE_HEAD"
 then
 	# Read git-fetch-pack -k output and store the remote branches.
-	perl -e "$copy_refs" "$GIT_DIR" "$use_separate_remote" "$origin"
+	perl -e "$copy_refs" "$GIT_DIR" "$use_separate_remote" "$origin" || exit 1
 fi

 cd "$D" || exit
--
1.4.1

------=_NextPart_000_00A3_01C6B5D7.D1A538A0
Content-Type: text/plain;
	name="P0001.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0001.TXT"

RnJvbSAwOGI2NTAyMzUzZDZkNjE5MWMxY2ViMWE3MDk1ODgzZmZjMmI0YjRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTYXQsIDI5IEp1bCAyMDA2IDE3OjEyOjM0ICswMTAwClN1YmplY3Q6
IFtQQVRDSCAxLzEwXSBFbnN1cmUgZ2l0LWNsb25lIGV4aXRzIHdpdGggZXJyb3IgaWYgcGVybCBz
Y3JpcHQgZmFpbHMuCgpUaGlzIGhlbHBzIHRlc3RzIDU0MDAsNTYwMCw1NzAwLDU3MTAgImZhaWwg
Y29ycmVjdGx5IiByYXRoZXIgdGhhbgpnaXZlIHNvbWUgZmFsc2UgcG9zaXRpdmVzLiAgQWxzbyBl
bnN1cmUgY2xlYW51cCBhY3Rpb25zIGluIGV4aXQgdHJhcAp3b3JrIGNvcnJlY3RseSBldmVuIGlm
IHVzZXIgaGFzIGFsaWFzIHJtPSdybSAtaScuCgpTaWduZWQtb2ZmLWJ5OiBSYW1zYXkgQWxsYW4g
Sm9uZXMgPHJhbXNheUByYW1zYXkxLmRlbW9uLmNvLnVrPgotLS0KIGdpdC1jbG9uZS5zaCB8ICAg
IDQgKystLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZ2l0LWNsb25lLnNoIGIvZ2l0LWNsb25lLnNoCmluZGV4IDZhMTRiMjUu
LjQ3YmQ4ZTcgMTAwNzU1Ci0tLSBhL2dpdC1jbG9uZS5zaAorKysgYi9naXQtY2xvbmUuc2gKQEAg
LTIwNSw3ICsyMDUsNyBAQCAjIFRyeSB1c2luZyAiaHVtYW5pc2giIHBhcnQgb2Ygc291cmNlIHJl
CiBbIC1lICIkZGlyIiBdICYmIGVjaG8gIiRkaXIgYWxyZWFkeSBleGlzdHMuIiAmJiB1c2FnZQog
bWtkaXIgLXAgIiRkaXIiICYmCiBEPSQoY2QgIiRkaXIiICYmIHB3ZCkgJiYKLXRyYXAgJ2Vycj0k
PzsgY2QgLi47IHJtIC1yICIkRCI7IGV4aXQgJGVycicgMAordHJhcCAnZXJyPSQ/OyBjZCAuLjsg
cm0gLXJmICIkRCI7IGV4aXQgJGVycicgMAogY2FzZSAiJGJhcmUiIGluCiB5ZXMpCiAJR0lUX0RJ
Uj0iJEQiIDs7CkBAIC0zMjQsNyArMzI0LDcgQEAgdGVzdCAtZCAiJEdJVF9ESVIvcmVmcy9yZWZl
cmVuY2UtdG1wIiAmJgogaWYgdGVzdCAtZiAiJEdJVF9ESVIvQ0xPTkVfSEVBRCIKIHRoZW4KIAkj
IFJlYWQgZ2l0LWZldGNoLXBhY2sgLWsgb3V0cHV0IGFuZCBzdG9yZSB0aGUgcmVtb3RlIGJyYW5j
aGVzLgotCXBlcmwgLWUgIiRjb3B5X3JlZnMiICIkR0lUX0RJUiIgIiR1c2Vfc2VwYXJhdGVfcmVt
b3RlIiAiJG9yaWdpbiIKKwlwZXJsIC1lICIkY29weV9yZWZzIiAiJEdJVF9ESVIiICIkdXNlX3Nl
cGFyYXRlX3JlbW90ZSIgIiRvcmlnaW4iIHx8IGV4aXQgMQogZmkKIAogY2QgIiREIiB8fCBleGl0
Ci0tIAoxLjQuMQoK

------=_NextPart_000_00A3_01C6B5D7.D1A538A0--
