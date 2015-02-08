From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/11] refs: move REF_DELETING to refs.c
Date: Sun,  8 Feb 2015 17:13:55 +0100
Message-ID: <1423412045-15616-2-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUVO-0002tl-5d
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbbBHQO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:14:27 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52179 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755001AbbBHQOZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:14:25 -0500
X-AuditID: 1207440d-f79976d000005643-09-54d78b59bd60
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.FC.22083.95B87D45; Sun,  8 Feb 2015 11:14:17 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9l5014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:16 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqBvZfT3EYOcCaYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZEzb/ZS3Yw1XR9/EIWwPjfI4uRk4OCQETiXvXn7JA2GISF+6tZ+ti
	5OIQErjMKNG35BYThHOCSaJt+yM2kCo2AV2JRT3NTCC2iICaxMS2Q2DdzAKrmSS23gWrERaw
	kFi59S5rFyMHB4uAqsS0y3ogYV4BF4mm1pNQy+Qkzh//yQxicwq4Six50wtmCwHV7LnVyzSB
	kXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJAg493B+H+dzCFGAQ5G
	JR7eDrnrIUKsiWXFlbmHGCU5mJREeY+GA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8C46fC1E
	iDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwXuiE2ioYFFqempFWmZO
	CUKaiYMTZDiXlEhxal5KalFiaUlGPCgy4ouBsQGS4gHa2wnSzltckJgLFIVoPcWoKCXO+x8k
	IQCSyCjNgxsLSx2vGMWBvhTmfQNSxQNMO3Ddr4AGMwENXrz0CsjgkkSElFQDo/6e1K2qD2Z9
	zf48IWrd5et7tWTKBe/9lFlkGOKz5vx6+diNKXcW1LKEeTJs4DaP1PpzNH/+15/dai+y15as
	5zaLLDGaee317ePH8kK7b1icT8+v4oz6uXBlbmrUP4mWJ79usM1ljWFZtsmwagGz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263521>

It is only used internally now. Document it a little bit better, too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 6 ++++++
 refs.h | 4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index c5fa709..cd5208b 100644
--- a/refs.c
+++ b/refs.c
@@ -35,6 +35,12 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
+ * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
+ * refs (i.e., because the reference is about to be deleted anyway).
+ */
+#define REF_DELETING	0x02
+
+/*
  * Used as a flag to ref_transaction_delete when a loose ref is being
  * pruned.
  */
diff --git a/refs.h b/refs.h
index afa3c4d..9bf2148 100644
--- a/refs.h
+++ b/refs.h
@@ -183,12 +183,10 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
- * REF_DELETING: tolerate broken refs
  *
- * Flags >= 0x100 are reserved for internal use.
+ * Other flags are reserved for internal use.
  */
 #define REF_NODEREF	0x01
-#define REF_DELETING	0x02
 
 /*
  * Setup reflog before using. Set errno to something meaningful on failure.
-- 
2.1.4
