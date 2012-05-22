From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] xdiff: avoid compiler warnings with XDL_FAST_HASH on
 32-bit machines
Date: Tue, 22 May 2012 22:36:25 +0200
Message-ID: <4FBBF8C9.7050906@lsrfire.ath.cx>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com> <4FB4A4B9.3080009@lsrfire.ath.cx> <xmqqmx56rd2r.fsf@junio.mtv.corp.google.com> <4FB5460C.10807@lsrfire.ath.cx> <CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue May 22 22:37:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvoz-0005s6-04
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023Ab2EVUgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 16:36:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:33099 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760529Ab2EVUgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:36:31 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id E03C92F8058;
	Tue, 22 May 2012 22:36:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAA787rmJixvyKhubHXZCDVYc=DdVk8_vHsHF6bOsLQ_j=39bGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198245>

Import macro REPEAT_BYTE from Linux (arch/x86/include/asm/word-at-a-tim=
e.h)
to avoid 64-bit integer literals, which cause some 32-bit compilers to
print warnings.

Reported-by: =C3=98yvind A. Holm <sunny@sunbase.org>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff/xutils.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index ae6ce0d..8580da7 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -251,9 +251,11 @@ static unsigned long xdl_hash_record_with_whitespa=
ce(char const **data,
=20
 #ifdef XDL_FAST_HASH
=20
-#define ONEBYTES	0x0101010101010101ul
-#define NEWLINEBYTES	0x0a0a0a0a0a0a0a0aul
-#define HIGHBITS	0x8080808080808080ul
+#define REPEAT_BYTE(x)  ((~0ul / 0xff) * (x))
+
+#define ONEBYTES	REPEAT_BYTE(0x01)
+#define NEWLINEBYTES	REPEAT_BYTE(0x0a)
+#define HIGHBITS	REPEAT_BYTE(0x80)
=20
 /* Return the high bit set in the first byte that is a zero */
 static inline unsigned long has_zero(unsigned long a)
--=20
1.7.10.2
