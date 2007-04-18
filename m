From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix overwriting of the files to apply the patch to in git-apply
Date: Wed, 18 Apr 2007 18:29:59 +0200
Message-ID: <81b0412b0704180929h7960bedeje87050fa5ca543b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17984_15811992.1176913799356"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeD2o-0001Zf-G3
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbXDRQaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbXDRQaB
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:30:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:25214 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbXDRQaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:30:00 -0400
Received: by wx-out-0506.google.com with SMTP id h31so237196wxd
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 09:29:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Dlng3ZAjiCxheRYa64IpRg5z6ewQPWdlYD9X3bdUu6zRn4WvPWZ91+Cu1gjDeC11gwe2Im+A/CpmzV01HqH3QXXknYDEMzlgE0zr+SdofhWVrSFmbIbNMIkVhZlbS6gVnU48I9cWU+Ic+pHO1yoduUSdkzKBeVvwu4ULHA75P0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=AI4oQJQwVnIYukra7PXcyz3mHGz94qiSNe54vGauFlCS/5AiS/LqiP/CCb5xMhQy9bGCjZ0vo9Tg5HB5Gl6nALfdyfokzs328uC/7t03ay1ZuhGOromIjvh0FI5mZRO5s4xhGNgdosPIlEe4Afr93DkhOrP+ySyYwWOtFmSNots=
Received: by 10.100.31.2 with SMTP id e2mr475968ane.1176913799446;
        Wed, 18 Apr 2007 09:29:59 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Wed, 18 Apr 2007 09:29:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44911>

------=_Part_17984_15811992.1176913799356
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The check for existence of a file was wrong: it assumed it was a directory
and reset the errno (twice: directly and by calling lstat). So if an entry
existed and was _not_ a directory no attempt was made to rename into it,
because the errno (expected by renaming code) was already reset to 0.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

The decision to check for directory first looks suboptimal.
Why not try to _rename_ first and if that fails check if we've got a directory?
An existing file seems to be more of a common case.

P.S. gmail: will resend unless applied

 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_17984_15811992.1176913799356
Content-Type: text/plain; 
	name=0001-Fix-overwriting-of-the-files-to-apply-the-patch-to.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0nzye3j
Content-Disposition: attachment; filename="0001-Fix-overwriting-of-the-files-to-apply-the-patch-to.txt"

RnJvbSAyM2Q4ZDU2NzdmOGMzNGM4YzE3YmVmMWM3Njc4Y2NhMDhiYTg1NmI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDE4IEFwciAyMDA3IDE4OjI0OjUzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IG92
ZXJ3cml0aW5nIG9mIHRoZSBmaWxlcyB0byBhcHBseSB0aGUgcGF0Y2ggdG8gaW4gZ2l0LWFwcGx5
CgpUaGUgY2hlY2sgZm9yIGV4aXN0ZW5jZSBvZiBhIGZpbGUgd2FzIHdyb25nOiBpdCBhc3N1bWVk
IGl0IHdhcyBhIGRpcmVjdG9yeQphbmQgcmVzZXQgdGhlIGVycm5vICh0d2ljZTogZGlyZWN0bHkg
YW5kIGJ5IGNhbGxpbmcgbHN0YXQpLiBTbyBpZiBhbiBlbnRyeQpleGlzdGVkIGFuZCB3YXMgX25v
dF8gYSBkaXJlY3Rvcnkgbm8gYXR0ZW1wdCB3YXMgbWFkZSB0byByZW5hbWUgaW50byBpdCwKYmVj
YXVzZSB0aGUgZXJybm8gKGV4cGVjdGVkIGJ5IHJlbmFtaW5nIGNvZGUpIHdhcyBhbHJlYWR5IHJl
c2V0IHRvIDAuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29t
PgotLS0KIGJ1aWx0aW4tYXBwbHkuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4tYXBwbHkuYyBi
L2J1aWx0aW4tYXBwbHkuYwppbmRleCBmZDkyZWY3Li4yNDBjYzA4IDEwMDY0NAotLS0gYS9idWls
dGluLWFwcGx5LmMKKysrIGIvYnVpbHRpbi1hcHBseS5jCkBAIC0yNDE3LDcgKzI0MTcsNyBAQCBz
dGF0aWMgdm9pZCBjcmVhdGVfb25lX2ZpbGUoY2hhciAqcGF0aCwgdW5zaWduZWQgbW9kZSwgY29u
c3QgY2hhciAqYnVmLCB1bnNpZ25lZAogCQkgKi8KIAkJc3RydWN0IHN0YXQgc3Q7CiAJCWVycm5v
ID0gMDsKLQkJaWYgKCFsc3RhdChwYXRoLCAmc3QpICYmIFNfSVNESVIoc3Quc3RfbW9kZSkgJiYg
IXJtZGlyKHBhdGgpKQorCQlpZiAoIWxzdGF0KHBhdGgsICZzdCkgJiYgKCFTX0lTRElSKHN0LnN0
X21vZGUpIHx8ICFybWRpcihwYXRoKSkpCiAJCQllcnJubyA9IEVFWElTVDsKIAl9CiAKLS0gCjEu
NS4xLjEuMTk1LmdkY2IzZgoK
------=_Part_17984_15811992.1176913799356--
