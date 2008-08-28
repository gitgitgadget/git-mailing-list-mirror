From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix use of hardlinks in "make install"
Date: Thu, 28 Aug 2008 16:30:07 +0200
Message-ID: <81b0412b0808280730m351d409cnab9bbda1f5871938@mail.gmail.com>
References: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com>
	 <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4047_29477335.1219933807319"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:35:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYiWq-0000i2-OM
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbYH1OaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbYH1OaK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:30:10 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:44762 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYH1OaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:30:08 -0400
Received: by yx-out-2324.google.com with SMTP id 8so220292yxm.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=vezp9cye2YpbsizywEt3g5EnoU8Zdw/Fi3Ni3AWj+gc=;
        b=ql6iyDdbVuH9pIds/ss0Kh0TV0rU1dP8QybaJPZXjdGkvcpX5hOxfncEuyI41R21Wk
         4tcNokkMmqJdlvGTTiaS2hLHNZ8M0x84vti832Eeia+aaUjne0YCiXVBUSuvd/JMqvFD
         KtZ/ehfXMEhG3KTlN0zafgBtFyww2KZIBFqEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=ovhGVne+PiELPI3EyoukMmt2ex2wxkf6Ppmo4hdWDDMaJNBwDNwKKTARmPRzK+xnG4
         8n9XAnN13DtIU6pjnUMsnO3McROm36JNIhI9ktlkvZ9DlbfXHFQgmFRZUCz2LNDJvwLW
         Sm/FYnv91bp5T7WjZqqGJ8g7kV2s1oiF94KmE=
Received: by 10.114.47.12 with SMTP id u12mr1336544wau.187.1219933807329;
        Thu, 28 Aug 2008 07:30:07 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 07:30:07 -0700 (PDT)
In-Reply-To: <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94062>

------=_Part_4047_29477335.1219933807319
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The code failed to filter-out git-add properly on platforms were $X is
not empty (ATM there is only one such a platform).

Than it tried to create a hardlink to the file ($execdir/git-add) it just
removed (because git-add is first in the BUILT_INS), so ln failed (but
because stderr was redirected into /dev/null the error was never seen), and
the whole install ended up using "ln -s" instead.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

2008/8/28 Alex Riesen <raa.lkml@gmail.com>:
> 2008/8/28 Alex Riesen <raa.lkml@gmail.com>:
>>
>> It created endless symlink loops on cygwin, but obviously nowhere else.
>>
>
> Sh@#! Scrap that, there is something else going on in that cygwindows thing...
>

Well, as usual, simple fix for trivial typo caused by existence of an
idiotic platform.

------=_Part_4047_29477335.1219933807319
Content-Type: text/x-patch;
 name=0001-Fix-use-of-hardlinks-in-make-install.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkfh0ylf0
Content-Disposition: attachment;
 filename=0001-Fix-use-of-hardlinks-in-make-install.patch

RnJvbSA2ZDgzZGJiMGUzYjc4YmZhYWQ5NTIyYjIyNjZkMDg2NGU0MzRhY2NlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDI4IEF1ZyAyMDA4IDE1OjU3OjMyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IHVz
ZSBvZiBoYXJkbGlua3MgaW4gIm1ha2UgaW5zdGFsbCIKClRoZSBjb2RlIGZhaWxlZCB0byBmaWx0
ZXItb3V0IGdpdC1hZGQgcHJvcGVybHkgb24gcGxhdGZvcm1zIHdlcmUgJFggaXMKbm90IGVtcHR5
IChBVE0gdGhlcmUgaXMgb25seSBvbmUgc3VjaCBhIHBsYXRmb3JtKS4KClRoYW4gaXQgdHJpZWQg
dG8gY3JlYXRlIGEgaGFyZGxpbmsgdG8gdGhlIGZpbGUgKCRleGVjZGlyL2dpdC1hZGQpIGl0IGp1
c3QKcmVtb3ZlZCAoYmVjYXVzZSBnaXQtYWRkIGlzIGZpcnN0IGluIHRoZSBCVUlMVF9JTlMpLCBz
byBsbiBmYWlsZWQgKGJ1dApiZWNhdXNlIHN0ZGVyciB3YXMgcmVkaXJlY3RlZCBpbnRvIC9kZXYv
bnVsbCB0aGUgZXJyb3Igd2FzIG5ldmVyIHNlZW4pLCBhbmQKdGhlIHdob2xlIGluc3RhbGwgZW5k
ZWQgdXAgdXNpbmcgImxuIC1zIiBpbnN0ZWFkLgoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4g
PHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBNYWtlZmlsZSB8ICAgIDIgKy0KIDEgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL01ha2Vm
aWxlIGIvTWFrZWZpbGUKaW5kZXggYmY0MDBlNi4uMjBmMDI4ZiAxMDA2NDQKLS0tIGEvTWFrZWZp
bGUKKysrIGIvTWFrZWZpbGUKQEAgLTEzNzksNyArMTM3OSw3IEBAIGVuZGlmCiAJeyAkKFJNKSAi
JCRleGVjZGlyL2dpdC1hZGQkWCIgJiYgXAogCQlsbiBnaXQtYWRkJFggIiQkZXhlY2Rpci9naXQt
YWRkJFgiIDI+L2Rldi9udWxsIHx8IFwKIAkJY3AgZ2l0LWFkZCRYICIkJGV4ZWNkaXIvZ2l0LWFk
ZCRYIjsgfSAmJiBcCi0JeyAkKGZvcmVhY2ggcCwkKGZpbHRlci1vdXQgZ2l0LWFkZCwkKEJVSUxU
X0lOUykpLCAkKFJNKSAiJCRleGVjZGlyLyRwIiAmJiBcCisJeyAkKGZvcmVhY2ggcCwkKGZpbHRl
ci1vdXQgZ2l0LWFkZCRYLCQoQlVJTFRfSU5TKSksICQoUk0pICIkJGV4ZWNkaXIvJHAiICYmIFwK
IAkJbG4gIiQkZXhlY2Rpci9naXQtYWRkJFgiICIkJGV4ZWNkaXIvJHAiIDI+L2Rldi9udWxsIHx8
IFwKIAkJbG4gLXMgImdpdC1hZGQkWCIgIiQkZXhlY2Rpci8kcCIgMj4vZGV2L251bGwgfHwgXAog
CQljcCAiJCRleGVjZGlyL2dpdC1hZGQkWCIgIiQkZXhlY2Rpci8kcCIgfHwgZXhpdDspIH0gJiYg
XAotLSAKMS42LjAuMS4xNTIuZzY5NjljCgo=
------=_Part_4047_29477335.1219933807319--
