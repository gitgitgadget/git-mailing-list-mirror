From: Santhosh <santhoshmani@gmail.com>
Subject: [PATCH/BUG] git-svn: add test for renamed directory fetch
Date: Thu, 3 Apr 2008 19:17:21 +0530
Message-ID: <3bc895b00804030647o652e432cqb5a90eafbac906b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1217_13346998.1207230441474"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 15:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhPnU-0007TN-5l
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 15:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbYDCNrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 09:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756072AbYDCNrW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 09:47:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:21674 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbYDCNrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 09:47:21 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3155762wff.4
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=Y2KbrKKJAAebjr/+qgl+Z6SmEjJH0URXFtbtZRFptaw=;
        b=ZhKi5DNfi9/7tMIhE25/+6TixcnzV17eomZD+7hSHbSuMyApAb86JzEVXzMX4auwEMSsftRqzfltDdxBt1Ejx+tHQfQ6f0XzrFYyPKHg06Y4o55qjOGPAD3Yaf6eWXg6n3jVDbG2zTFcCLg2QTNw0sEaOXNfaTWW9zIBHeKAq5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=e2Uolkl2V0XMrlo4M8/MdTJsZV1t79MhPRYYqPZ7chvpi8MgrD+Lc6mYYr4HyoYbKynP+GjZRSUGhQtGFXuhe0hwCvzTZLP9t+Ad20CB9KbRz9pkZMM/U6F51mjDJwyoT3WBFATr5TWhrUDjR/wR5XC1c5f0ucnf6tNvWgvk72g=
Received: by 10.143.160.1 with SMTP id m1mr7117971wfo.9.1207230441473;
        Thu, 03 Apr 2008 06:47:21 -0700 (PDT)
Received: by 10.142.133.13 with HTTP; Thu, 3 Apr 2008 06:47:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78751>

------=_Part_1217_13346998.1207230441474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This test tries to fetch a directory which had renames in the history from a
SVN repository.
---
 t/t9121-git-svn-fetch-renamed-dir.sh |   23 +++++++++
 t/t9121/renamed-dir.dump             |   90 ++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100755 t/t9121-git-svn-fetch-renamed-dir.sh
 create mode 100644 t/t9121/renamed-dir.dump

diff --git a/t/t9121-git-svn-fetch-renamed-dir.sh
b/t/t9121-git-svn-fetch-renamed-dir.sh
new file mode 100755
index 0000000..5cd65a6
--- /dev/null
+++ b/t/t9121-git-svn-fetch-renamed-dir.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Santhosh Kumar Mani
+
+
+test_description='git-svn can fetch renamed directories'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'load repository with renamed directory' "
+	svnadmin load -q $rawsvnrepo < ../t9121/renamed-dir.dump &&
+	start_httpd
+	"
+
+test_expect_success 'init and fetch repository' "
+	git svn init $svnrepo/newname &&
+	git svn fetch
+	"
+
+stop_httpd
+
+test_done
+
diff --git a/t/t9121/renamed-dir.dump b/t/t9121/renamed-dir.dump
new file mode 100644
index 0000000..5f9127b
--- /dev/null
+++ b/t/t9121/renamed-dir.dump
@@ -0,0 +1,90 @@
+SVN-fs-dump-format-version: 2
+
+UUID: 06b9b3ad-f546-4fbe-8328-fcb4e6ef5c3f
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2008-04-02T09:11:59.778557Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 117
+Content-length: 117
+
+K 7
+svn:log
+V 14
+initial import
+K 10
+svn:author
+V 8
+santhosh
+K 8
+svn:date
+V 27
+2008-04-02T09:13:03.170863Z
+PROPS-END
+
+Node-path: name
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: name/a.txt
+Node-kind: file
+Node-action: add
+Prop-content-length: 71
+Text-content-length: 6
+Text-content-md5: b1946ac92492d2347c6235b4d2611184
+Content-length: 77
+
+K 13
+svn:mime-type
+V 10
+text/plain
+K 13
+svn:eol-style
+V 2
+LF
+PROPS-END
+hello
+
+
+Revision-number: 2
+Prop-content-length: 109
+Content-length: 109
+
+K 7
+svn:log
+V 7
+renamed
+K 10
+svn:author
+V 8
+santhosh
+K 8
+svn:date
+V 27
+2008-04-02T09:14:22.952186Z
+PROPS-END
+
+Node-path: newname
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: name
+
+
+Node-path: name
+Node-action: delete
+
+
-- 
1.5.5.rc3.dirty

------=_Part_1217_13346998.1207230441474
Content-Type: text/x-patch;
 name=0001-git-svn-add-test-for-renamed-directory-fetch.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_feldriau0
Content-Disposition: attachment;
 filename=0001-git-svn-add-test-for-renamed-directory-fetch.patch

RnJvbSAzMGZhMjlhNDViZTNiOGMwZjQ3MGMwYWM1NWY4MjBhNDhlNTNhOTM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50aG9zaCBLdW1hciBNYW5pIDxzYW50aG9zaG1hbmlAZ21h
aWwuY29tPgpEYXRlOiBUaHUsIDMgQXByIDIwMDggMTU6NDA6MTUgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBnaXQtc3ZuOiBhZGQgdGVzdCBmb3IgcmVuYW1lZCBkaXJlY3RvcnkgZmV0Y2gKClRoaXMg
dGVzdCB0cmllcyB0byBmZXRjaCBhIGRpcmVjdG9yeSB3aGljaCBoYWQgcmVuYW1lcyBpbiB0aGUg
aGlzdG9yeSBmcm9tIGEKU1ZOIHJlcG9zaXRvcnkuCi0tLQogdC90OTEyMS1naXQtc3ZuLWZldGNo
LXJlbmFtZWQtZGlyLnNoIHwgICAyMyArKysrKysrKysKIHQvdDkxMjEvcmVuYW1lZC1kaXIuZHVt
cCAgICAgICAgICAgICB8ICAgOTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwog
MiBmaWxlcyBjaGFuZ2VkLCAxMTMgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0
ZSBtb2RlIDEwMDc1NSB0L3Q5MTIxLWdpdC1zdm4tZmV0Y2gtcmVuYW1lZC1kaXIuc2gKIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0L3Q5MTIxL3JlbmFtZWQtZGlyLmR1bXAKCmRpZmYgLS1naXQgYS90L3Q5
MTIxLWdpdC1zdm4tZmV0Y2gtcmVuYW1lZC1kaXIuc2ggYi90L3Q5MTIxLWdpdC1zdm4tZmV0Y2gt
cmVuYW1lZC1kaXIuc2gKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAwMC4uNWNkNjVh
NgotLS0gL2Rldi9udWxsCisrKyBiL3QvdDkxMjEtZ2l0LXN2bi1mZXRjaC1yZW5hbWVkLWRpci5z
aApAQCAtMCwwICsxLDIzIEBACisjIS9iaW4vc2gKKyMKKyMgQ29weXJpZ2h0IChjKSAyMDA4IFNh
bnRob3NoIEt1bWFyIE1hbmkKKworCit0ZXN0X2Rlc2NyaXB0aW9uPSdnaXQtc3ZuIGNhbiBmZXRj
aCByZW5hbWVkIGRpcmVjdG9yaWVzJworCisuIC4vbGliLWdpdC1zdm4uc2gKKwordGVzdF9leHBl
Y3Rfc3VjY2VzcyAnbG9hZCByZXBvc2l0b3J5IHdpdGggcmVuYW1lZCBkaXJlY3RvcnknICIKKwlz
dm5hZG1pbiBsb2FkIC1xICRyYXdzdm5yZXBvIDwgLi4vdDkxMjEvcmVuYW1lZC1kaXIuZHVtcCAm
JgorCXN0YXJ0X2h0dHBkCisJIgorCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdpbml0IGFuZCBmZXRj
aCByZXBvc2l0b3J5JyAiCisJZ2l0IHN2biBpbml0ICRzdm5yZXBvL25ld25hbWUgJiYKKwlnaXQg
c3ZuIGZldGNoCisJIgorCitzdG9wX2h0dHBkCisKK3Rlc3RfZG9uZQorCmRpZmYgLS1naXQgYS90
L3Q5MTIxL3JlbmFtZWQtZGlyLmR1bXAgYi90L3Q5MTIxL3JlbmFtZWQtZGlyLmR1bXAKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNWY5MTI3YgotLS0gL2Rldi9udWxsCisrKyBi
L3QvdDkxMjEvcmVuYW1lZC1kaXIuZHVtcApAQCAtMCwwICsxLDkwIEBACitTVk4tZnMtZHVtcC1m
b3JtYXQtdmVyc2lvbjogMgorCitVVUlEOiAwNmI5YjNhZC1mNTQ2LTRmYmUtODMyOC1mY2I0ZTZl
ZjVjM2YKKworUmV2aXNpb24tbnVtYmVyOiAwCitQcm9wLWNvbnRlbnQtbGVuZ3RoOiA1NgorQ29u
dGVudC1sZW5ndGg6IDU2CisKK0sgOAorc3ZuOmRhdGUKK1YgMjcKKzIwMDgtMDQtMDJUMDk6MTE6
NTkuNzc4NTU3WgorUFJPUFMtRU5ECisKK1JldmlzaW9uLW51bWJlcjogMQorUHJvcC1jb250ZW50
LWxlbmd0aDogMTE3CitDb250ZW50LWxlbmd0aDogMTE3CisKK0sgNworc3ZuOmxvZworViAxNAor
aW5pdGlhbCBpbXBvcnQKK0sgMTAKK3N2bjphdXRob3IKK1YgOAorc2FudGhvc2gKK0sgOAorc3Zu
OmRhdGUKK1YgMjcKKzIwMDgtMDQtMDJUMDk6MTM6MDMuMTcwODYzWgorUFJPUFMtRU5ECisKK05v
ZGUtcGF0aDogbmFtZQorTm9kZS1raW5kOiBkaXIKK05vZGUtYWN0aW9uOiBhZGQKK1Byb3AtY29u
dGVudC1sZW5ndGg6IDEwCitDb250ZW50LWxlbmd0aDogMTAKKworUFJPUFMtRU5ECisKKworTm9k
ZS1wYXRoOiBuYW1lL2EudHh0CitOb2RlLWtpbmQ6IGZpbGUKK05vZGUtYWN0aW9uOiBhZGQKK1By
b3AtY29udGVudC1sZW5ndGg6IDcxCitUZXh0LWNvbnRlbnQtbGVuZ3RoOiA2CitUZXh0LWNvbnRl
bnQtbWQ1OiBiMTk0NmFjOTI0OTJkMjM0N2M2MjM1YjRkMjYxMTE4NAorQ29udGVudC1sZW5ndGg6
IDc3CisKK0sgMTMKK3N2bjptaW1lLXR5cGUKK1YgMTAKK3RleHQvcGxhaW4KK0sgMTMKK3N2bjpl
b2wtc3R5bGUKK1YgMgorTEYKK1BST1BTLUVORAoraGVsbG8KKworCitSZXZpc2lvbi1udW1iZXI6
IDIKK1Byb3AtY29udGVudC1sZW5ndGg6IDEwOQorQ29udGVudC1sZW5ndGg6IDEwOQorCitLIDcK
K3N2bjpsb2cKK1YgNworcmVuYW1lZAorSyAxMAorc3ZuOmF1dGhvcgorViA4CitzYW50aG9zaAor
SyA4Citzdm46ZGF0ZQorViAyNworMjAwOC0wNC0wMlQwOToxNDoyMi45NTIxODZaCitQUk9QUy1F
TkQKKworTm9kZS1wYXRoOiBuZXduYW1lCitOb2RlLWtpbmQ6IGRpcgorTm9kZS1hY3Rpb246IGFk
ZAorTm9kZS1jb3B5ZnJvbS1yZXY6IDEKK05vZGUtY29weWZyb20tcGF0aDogbmFtZQorCisKK05v
ZGUtcGF0aDogbmFtZQorTm9kZS1hY3Rpb246IGRlbGV0ZQorCisKLS0gCjEuNS41LnJjMy5kaXJ0
eQoK
------=_Part_1217_13346998.1207230441474--
