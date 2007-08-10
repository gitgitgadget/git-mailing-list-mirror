From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix handle leak in "git branch -D"
Date: Fri, 10 Aug 2007 15:06:57 +0200
Message-ID: <81b0412b0708100606v7bcceaf6xc0783ea9761d7ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_109398_22752403.1186751217475"
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 15:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJUCm-0007Sx-0N
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 15:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685AbXHJNHA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 09:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbXHJNHA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 09:07:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:62547 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814AbXHJNG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 09:06:59 -0400
Received: by nf-out-0910.google.com with SMTP id g13so241093nfb
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 06:06:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=pAd5C5oLhQsMdFFUmySXWZX6OeI7lDUoFNC8sYbPBgsR7hVnR0hdsLlmxdoNFrDABVOoFlD6KDLI/pyvoyWRGWBcjP8akDHvtkAQIzqUAcGU+qzXhVFGm6CyPpiKAXNjZEnXaA3uO20cQwLsAd2Yp9sMfx4wdkvcDAn/twaZUbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Q3VHJ0XChl9clqMgid72h7ko3Y7yLPdgIoPU1/9nkMCETfPG0TgpYIs0MzRKMjZLzOw+ZtkHNPwdDZCNN6BLDDT5771H4be4Th9B8PmpqpMup3YGoC9ChxlnbESHtLSc8NeYOGW34pYYCZN+MWcDZcdFj+I0t8SZ9k61CJ00QvM=
Received: by 10.78.153.17 with SMTP id a17mr1305794hue.1186751217515;
        Fri, 10 Aug 2007 06:06:57 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 10 Aug 2007 06:06:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55535>

------=_Part_109398_22752403.1186751217475
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Windows (it can't touch open files in any way) the following fails:

    git branch -D branch1 branch2

if the both branches are in packed-refs.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

BTW, why does not commit_lock_file takes care of closing the file
opened by hold_lock_file_for_update?

------=_Part_109398_22752403.1186751217475
Content-Type: text/plain; name=0001-Fix-handle-leak-in-git-branch-D.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f56p200x
Content-Disposition: attachment; filename="0001-Fix-handle-leak-in-git-branch-D.txt"

RnJvbSA0ZTIxOWJmNWIyYzdkZTA5MTk3MzMzNmY2MTQzZjc3ZmU5YTk2ZWZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBGcmksIDEwIEF1ZyAyMDA3IDE1OjA2OjIyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGhh
bmRsZSBsZWFrIGluICJnaXQgYnJhbmNoIC1EIgoKT24gV2luZG93cyAoaXQgY2FuJ3QgdG91Y2gg
b3BlbiBmaWxlcyBpbiBhbnkgd2F5KSB0aGUgZm9sbG93aW5nIGZhaWxzOgoKICAgIGdpdCBicmFu
Y2ggLUQgYnJhbmNoMSBicmFuY2gyCgppZiB0aGUgYm90aCBicmFuY2hlcyBhcmUgaW4gcGFja2Vk
LXJlZnMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgot
LS0KIHJlZnMuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcmVmcy5jIGIvcmVmcy5jCmluZGV4IGZhYzY1NDgu
LjA5YTJjODcgMTAwNjQ0Ci0tLSBhL3JlZnMuYworKysgYi9yZWZzLmMKQEAgLTg2OSw2ICs4Njks
NyBAQCBzdGF0aWMgaW50IHJlcGFja193aXRob3V0X3JlZihjb25zdCBjaGFyICpyZWZuYW1lKQog
CQkJZGllKCJ0b28gbG9uZyBhIHJlZm5hbWUgJyVzJyIsIGxpc3QtPm5hbWUpOwogCQl3cml0ZV9v
cl9kaWUoZmQsIGxpbmUsIGxlbik7CiAJfQorCWNsb3NlKGZkKTsKIAlyZXR1cm4gY29tbWl0X2xv
Y2tfZmlsZSgmcGFja2xvY2spOwogfQogCi0tIAoxLjUuMy5yYzQuODEuZ2JkNjIKCg==
------=_Part_109398_22752403.1186751217475--
