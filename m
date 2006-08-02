From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 6/10] Fix header breakage with _XOPEN_SOURCE.
Date: Wed, 2 Aug 2006 02:03:39 +0100
Message-ID: <00b601c6b5cf$7d54b940$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B7_01C6B5D7.DF192140"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858z-00071U-VZ
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWHBBDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWHBBDU
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:20 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:52233 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750908AbWHBBDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:19 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858n-000C1I-Hv
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:19 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24627>

This is a multi-part message in MIME format.

------=_NextPart_000_00B7_01C6B5D7.DF192140
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

convert-objects.c sets _XOPEN_SOURCE and _XOPEN_SOURCE_EXTENDED before
including <time.h>, in order to get the declaration of strptime().
This leads to breakage in cache.h, due to S_ISLNK and S_IFLNK no longer
being defined by <sys/stat.h>.  These definitions are protected by the
__USE_BSD symbol, which is not set when _XOPEN_SOURCE is set.  Moving
the #defines and #include <time.h> below all other #includes does not
fix the problem, however, since now _USE_XOPEN, which protects the
declaration of strptime(), is now not defined (don't ask!).

The fix is to #define _GNU_SOURCE, which enables the definition of
practically everything.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 convert-objects.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/convert-objects.c b/convert-objects.c
index 0fabd89..971ad6d 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -1,5 +1,6 @@
 #define _XOPEN_SOURCE 500 /* glibc2 and AIX 5.3L need this */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
+#define _GNU_SOURCE
 #include <time.h>
 #include "cache.h"
 #include "blob.h"
-- 
1.4.1

------=_NextPart_000_00B7_01C6B5D7.DF192140
Content-Type: text/plain;
	name="P0006.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0006.TXT"

RnJvbSA3MmY3NDVjNGMxZTM2NmEwZjFmYzc1ZWM4ZGE1NWEzY2ZiNTQ1N2M3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTdW4sIDMwIEp1bCAyMDA2IDE2OjUyOjA5ICswMTAwClN1YmplY3Q6
IFtQQVRDSCA2LzEwXSBGaXggaGVhZGVyIGJyZWFrYWdlIHdpdGggX1hPUEVOX1NPVVJDRS4KCmNv
bnZlcnQtb2JqZWN0cy5jIHNldHMgX1hPUEVOX1NPVVJDRSBhbmQgX1hPUEVOX1NPVVJDRV9FWFRF
TkRFRCBiZWZvcmUKaW5jbHVkaW5nIDx0aW1lLmg+LCBpbiBvcmRlciB0byBnZXQgdGhlIGRlY2xh
cmF0aW9uIG9mIHN0cnB0aW1lKCkuClRoaXMgbGVhZHMgdG8gYnJlYWthZ2UgaW4gY2FjaGUuaCwg
ZHVlIHRvIFNfSVNMTksgYW5kIFNfSUZMTksgbm8gbG9uZ2VyCmJlaW5nIGRlZmluZWQgYnkgPHN5
cy9zdGF0Lmg+LiAgVGhlc2UgZGVmaW5pdGlvbnMgYXJlIHByb3RlY3RlZCBieSB0aGUKX19VU0Vf
QlNEIHN5bWJvbCwgd2hpY2ggaXMgbm90IHNldCB3aGVuIF9YT1BFTl9TT1VSQ0UgaXMgc2V0LiAg
TW92aW5nCnRoZSAjZGVmaW5lcyBhbmQgI2luY2x1ZGUgPHRpbWUuaD4gYmVsb3cgYWxsIG90aGVy
ICNpbmNsdWRlcyBkb2VzIG5vdApmaXggdGhlIHByb2JsZW0sIGhvd2V2ZXIsIHNpbmNlIG5vdyBf
VVNFX1hPUEVOLCB3aGljaCBwcm90ZWN0cyB0aGUKZGVjbGFyYXRpb24gb2Ygc3RycHRpbWUoKSwg
aXMgbm93IG5vdCBkZWZpbmVkIChkb24ndCBhc2shKS4KClRoZSBmaXggaXMgdG8gI2RlZmluZSBf
R05VX1NPVVJDRSwgd2hpY2ggZW5hYmxlcyB0aGUgZGVmaW5pdGlvbiBvZgpwcmFjdGljYWxseSBl
dmVyeXRoaW5nLgoKU2lnbmVkLW9mZi1ieTogUmFtc2F5IEFsbGFuIEpvbmVzIDxyYW1zYXlAcmFt
c2F5MS5kZW1vbi5jby51az4KLS0tCiBjb252ZXJ0LW9iamVjdHMuYyB8ICAgIDEgKwogMSBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
Y29udmVydC1vYmplY3RzLmMgYi9jb252ZXJ0LW9iamVjdHMuYwppbmRleCAwZmFiZDg5Li45NzFh
ZDZkIDEwMDY0NAotLS0gYS9jb252ZXJ0LW9iamVjdHMuYworKysgYi9jb252ZXJ0LW9iamVjdHMu
YwpAQCAtMSw1ICsxLDYgQEAKICNkZWZpbmUgX1hPUEVOX1NPVVJDRSA1MDAgLyogZ2xpYmMyIGFu
ZCBBSVggNS4zTCBuZWVkIHRoaXMgKi8KICNkZWZpbmUgX1hPUEVOX1NPVVJDRV9FWFRFTkRFRCAx
IC8qIEFJWCA1LjNMIG5lZWRzIHRoaXMgKi8KKyNkZWZpbmUgX0dOVV9TT1VSQ0UKICNpbmNsdWRl
IDx0aW1lLmg+CiAjaW5jbHVkZSAiY2FjaGUuaCIKICNpbmNsdWRlICJibG9iLmgiCi0tIAoxLjQu
MQoK

------=_NextPart_000_00B7_01C6B5D7.DF192140--
