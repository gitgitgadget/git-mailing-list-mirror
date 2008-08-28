From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix use of hardlinks in "make install"
Date: Thu, 28 Aug 2008 16:04:29 +0200
Message-ID: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3638_24156571.1219932269634"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYi80-0007JT-TD
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbYH1OEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbYH1OEb
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:04:31 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:33192 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYH1OEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:04:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so214269yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=uOke5kWIzyQjttCi80+MmmqCMSfcpADsPShjWFhN/CA=;
        b=bIqkwKh+fBI5MYp8zS4pCt26zmsoKlxZGjYE+nn/tLTF8ug+w6gCGYi1twh8H/CuiH
         qSaJhBJPQRUnyCwimpRlSJSti5uvqAwKMiZwct8YhprOnbnTqyK9XgXxkqFuYV2OVIp5
         oJjjK+6RZwcDPvv3/oXPKIM+PBbp4t1m1iNxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=lrU+o3j5CNwNM8Q1voCGZxco5g291YlTLCF1s745AlwpJ+kRZaLmsxFZU5ZbgsGUZq
         HgJP8EyTJWeueWUwjqL2EfdNi/8qvD8YvmroYDfE/3dRMY59mdlVrv3CFW1ScXM746RX
         Mx8ztmirMeZyC0Tg3GQO6kjje5W9BaGLgiIwU=
Received: by 10.115.33.1 with SMTP id l1mr1323078waj.115.1219932269597;
        Thu, 28 Aug 2008 07:04:29 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 07:04:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94056>

------=_Part_3638_24156571.1219932269634
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The code tried to create a hardlink to the file ($execdir/git-add) it just
removed, so ln failed (but because stderr was redirected into /dev/null the
error was never seen), and the whole install ended up using "ln -s" instead.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

It created endless symlink loops on cygwin, but obviously nowhere else.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_3638_24156571.1219932269634
Content-Type: text/x-patch;
 name=0001-Fix-use-of-hardlinks-in-make-install.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkfg6vqj0
Content-Disposition: attachment;
 filename=0001-Fix-use-of-hardlinks-in-make-install.patch

RnJvbSA5NDNlMDgyNGI5ZmQxYThjMjc5OGFlOWZkMzQxYjZhOWI3NDI5Y2MxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDI4IEF1ZyAyMDA4IDE1OjU3OjMyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IHVz
ZSBvZiBoYXJkbGlua3MgaW4gIm1ha2UgaW5zdGFsbCIKClRoZSBjb2RlIHRyaWVkIHRvIGNyZWF0
ZSBhIGhhcmRsaW5rIHRvIHRoZSBmaWxlICgkZXhlY2Rpci9naXQtYWRkKSBpdCBqdXN0CnJlbW92
ZWQsIHNvIGxuIGZhaWxlZCAoYnV0IGJlY2F1c2Ugc3RkZXJyIHdhcyByZWRpcmVjdGVkIGludG8g
L2Rldi9udWxsIHRoZQplcnJvciB3YXMgbmV2ZXIgc2VlbiksIGFuZCB0aGUgd2hvbGUgaW5zdGFs
bCBlbmRlZCB1cCB1c2luZyAibG4gLXMiIGluc3RlYWQuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJp
ZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgotLS0KIE1ha2VmaWxlIHwgICAgMiArLQogMSBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
TWFrZWZpbGUgYi9NYWtlZmlsZQppbmRleCBiZjQwMGU2Li4yMGExNzA0IDEwMDY0NAotLS0gYS9N
YWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtMTM4MCw3ICsxMzgwLDcgQEAgZW5kaWYKIAkJbG4g
Z2l0LWFkZCRYICIkJGV4ZWNkaXIvZ2l0LWFkZCRYIiAyPi9kZXYvbnVsbCB8fCBcCiAJCWNwIGdp
dC1hZGQkWCAiJCRleGVjZGlyL2dpdC1hZGQkWCI7IH0gJiYgXAogCXsgJChmb3JlYWNoIHAsJChm
aWx0ZXItb3V0IGdpdC1hZGQsJChCVUlMVF9JTlMpKSwgJChSTSkgIiQkZXhlY2Rpci8kcCIgJiYg
XAotCQlsbiAiJCRleGVjZGlyL2dpdC1hZGQkWCIgIiQkZXhlY2Rpci8kcCIgMj4vZGV2L251bGwg
fHwgXAorCQlsbiAiZ2l0LWFkZCRYIiAiJCRleGVjZGlyLyRwIiB8fCBcCiAJCWxuIC1zICJnaXQt
YWRkJFgiICIkJGV4ZWNkaXIvJHAiIDI+L2Rldi9udWxsIHx8IFwKIAkJY3AgIiQkZXhlY2Rpci9n
aXQtYWRkJFgiICIkJGV4ZWNkaXIvJHAiIHx8IGV4aXQ7KSB9ICYmIFwKIAkuL2NoZWNrX2JpbmRp
ciAieiQkYmluZGlyIiAieiQkZXhlY2RpciIgIiQkYmluZGlyL2dpdC1hZGQkWCIKLS0gCjEuNi4w
LjEuMTUwLmc4MzA3LmRpcnR5Cgo=
------=_Part_3638_24156571.1219932269634--
