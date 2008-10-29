From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Use find instead of perl in t5000 to get file modification time
Date: Wed, 29 Oct 2008 11:38:32 +0100
Message-ID: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6688_24007533.1225276712231"
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 11:39:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv8Sq-00083m-AB
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 11:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbYJ2Kie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 06:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbYJ2Kie
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 06:38:34 -0400
Received: from mail-gx0-f18.google.com ([209.85.217.18]:53070 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbYJ2Kid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 06:38:33 -0400
Received: by gxk11 with SMTP id 11so2520607gxk.13
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=OwNjw0vnaxnZr5eGLh8sEy//41x+Kp+oJKJu8u+vMc0=;
        b=X1zri+KWEcahupusP7Ss3KnMhknVp38QeSqsomQgJ9gWAoHQ/xILJs+sqK6tWxHxhe
         gvGRBF9YXmU6mI10obNxM0Bbg/2Prwsj4cQchyU3tGbnWiPqVNJKNb+MVuFlWeAUU+iP
         TqckUNMwvZj11hAU9amy7ws+iuy2kVs5d7POs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=HQMYVl3BbjNalrljGUDXAFhcogYfbQRMqkwz2LL5vjK/ulYhDFBoZWMcxdCry6OTQ/
         TJdb4idRlghQJpRsU3r75BQiUV8VRdwA0dk4tc/wDbes0v4JSnKNkMiQnJEXjbV7azux
         XOyyLLMAzgvjgHlArNx0DSmwOW8WMiz0E7Quw=
Received: by 10.101.69.6 with SMTP id w6mr8465268ank.140.1225276712238;
        Wed, 29 Oct 2008 03:38:32 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Wed, 29 Oct 2008 03:38:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99359>

------=_Part_6688_24007533.1225276712231
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The test "validate file modification time" was broken on admittedly broken
combination of Windows, Cygwin, and ActiveState Perl. Something (I blame
ActiveState) of the three is very confused about what time zone
to use for the modification time.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I could not find what exactly does the ActiveState's Perl use for its stat
implementation (and honestly, have no motivation to look harder).
It seems to honor TZ, but the produced time does not seem to be either
local or GMT.

There can be a problem with "-printf": Open Group SUS does not specify
-printf for find(1), so it is probably a problem somewhere. I just don't know.

There is always a fallback, which is to write a small program which calls
native stat(2). Or modify test-chmtime to just print mtime when asked.

 t/t5000-tar-tree.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

------=_Part_6688_24007533.1225276712231
Content-Type: text/x-diff;
 name=0001-Use-find-instead-of-perl-in-t5000-to-get-file-modifi.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmvtlwev0
Content-Disposition: attachment;
 filename=0001-Use-find-instead-of-perl-in-t5000-to-get-file-modifi.patch

RnJvbSAxYmQ4YTk0NDVkOWJiYTQ2M2ZiMWVkYjc1OGQ3NzYwZmJmNTNiMDNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDI5IE9jdCAyMDA4IDEwOjIyOjE1ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gVXNlIGZp
bmQgaW5zdGVhZCBvZiBwZXJsIGluIHQ1MDAwIHRvIGdldCBmaWxlIG1vZGlmaWNhdGlvbiB0aW1l
CgpUaGUgdGVzdCB3YXMgYnJva2VuIG9uIGFkbWl0dGVkbHkgYnJva2VuIGNvbWJpbmF0aW9uIG9m
IFdpbmRvd3MsIEN5Z3dpbiwKYW5kIEFjdGl2ZVN0YXRlIFBlcmwuCgpTaWduZWQtb2ZmLWJ5OiBB
bGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgotLS0KIHQvdDUwMDAtdGFyLXRyZWUuc2gg
fCAgICA2ICsrKystLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvdC90NTAwMC10YXItdHJlZS5zaCBiL3QvdDUwMDAtdGFyLXRy
ZWUuc2gKaW5kZXggMGYyN2Q3My4uNGVhYmViZCAxMDA3NTUKLS0tIGEvdC90NTAwMC10YXItdHJl
ZS5zaAorKysgYi90L3Q1MDAwLXRhci10cmVlLnNoCkBAIC0yNiw2ICsyNiw4IEBAIGNvbW1pdCBp
ZCBlbWJlZGRpbmc6CiAKIC4gLi90ZXN0LWxpYi5zaAogVU5aSVA9JHtVTlpJUDotdW56aXB9CitU
Wj1HTVQKK2V4cG9ydCBUWgogCiBTVUJTVEZPUk1BVD0lSCVuCiAKQEAgLTU0LDcgKzU2LDcgQEAg
dGVzdF9leHBlY3Rfc3VjY2VzcyBcCiAgICAgIGZpbmQgYSAtdHlwZSBsIHwgeGFyZ3MgZ2l0IHVw
ZGF0ZS1pbmRleCAtLWFkZCAmJgogICAgICB0cmVlaWQ9YGdpdCB3cml0ZS10cmVlYCAmJgogICAg
ICBlY2hvICR0cmVlaWQgPnRyZWVpZCAmJgotICAgICBnaXQgdXBkYXRlLXJlZiBIRUFEICQoVFo9
R01UIEdJVF9DT01NSVRURVJfREFURT0iMjAwNS0wNS0yNyAyMjowMDowMCIgXAorICAgICBnaXQg
dXBkYXRlLXJlZiBIRUFEICQoR0lUX0NPTU1JVFRFUl9EQVRFPSIyMDA1LTA1LTI3IDIyOjAwOjAw
IiBcCiAgICAgIGdpdCBjb21taXQtdHJlZSAkdHJlZWlkIDwvZGV2L251bGwpJwogCiB0ZXN0X2V4
cGVjdF9zdWNjZXNzIFwKQEAgLTkwLDcgKzkyLDcgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyBcCiAg
ICAgJ3ZhbGlkYXRlIGZpbGUgbW9kaWZpY2F0aW9uIHRpbWUnIFwKICAgICAnbWtkaXIgZXh0cmFj
dCAmJgogICAgICAiJFRBUiIgeGYgYi50YXIgLUMgZXh0cmFjdCBhL2EgJiYKLSAgICAgcGVybCAt
ZSAnXCcncHJpbnQoKHN0YXQoImV4dHJhY3QvYS9hIikpWzldLCAiXG4iKSdcJycgPmIubXRpbWUg
JiYKKyAgICAgZmluZCBleHRyYWN0L2EvYSAtcHJpbnRmICIlVEBcXG4iID5iLm10aW1lICYmCiAg
ICAgIGVjaG8gIjExMTcyMzEyMDAiID5leHBlY3RlZC5tdGltZSAmJgogICAgICBkaWZmIGV4cGVj
dGVkLm10aW1lIGIubXRpbWUnCiAKLS0gCjEuNi4wLjMuNTQ5LmdiNDc1ZAoK
------=_Part_6688_24007533.1225276712231--
