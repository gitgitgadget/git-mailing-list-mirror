From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Avoid gcc compiler warning
Date: Mon, 8 Dec 2014 17:38:59 +0100 (CET)
Message-ID: <b9e1cb1f858e71b964be4f752fcebc22cd944ebc.1418056722.git.johannes.schindelin@gmx.de>
References: <cover.1418056722.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:39:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy1L7-00020w-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbaLHQjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:39:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:62901 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851AbaLHQjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:39:07 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MXqV1-1YRwPr2ylr-00Wj7S;
 Mon, 08 Dec 2014 17:39:00 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418056722.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:FUVd+NoqVVAGlozzioh/ZiaSB3akKBX/yC6ClZda9B8kTkxn/Wu
 FJhuhXbjIjMcNX4rUgsSd1S4JLx/lBxokcXwsMmoIk7TUlo78oVxxqj9l2IjR/wOldA7Ogq
 5pOlonSZ+6nPFNh6nvrL6wv0ZQDcv16xUxiKhti7fV6HIRHmSliXQMNsSouKgUztEqLkt7v
 UwEY1x98RfH+XqDj8GDZg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261077>

At least on this developer's MacOSX (Snow Leopard, gcc-4.2.1), GCC prints
a warning that 'hash' may be used uninitialized when compiling
test-hashmap that 'hash' may be used uninitialized (but GCC 4.6.3 on this
developer's Ubuntu server does not report this problem).

Since hash() is called from perf_hashmap() which accepts an unchecked
integer value from the command line, the warning appears to be legitimate,
even if the test-hashmap command is only called from the test suite.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 test-hashmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test-hashmap.c b/test-hashmap.c
index 07aa7ec..40a126d 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -62,6 +62,8 @@ static unsigned int hash(unsigned int method, unsigned int i, const char *key)
 	case HASH_METHOD_0:
 		hash = 0;
 		break;
+	default:
+		die("Unknown method: %d", method);
 	}
 
 	if (method & HASH_METHOD_X2)
-- 
2.0.0.rc3.9669.g840d1f9
