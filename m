From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 06/19] fsck: Report the ID of the error/warning
Date: Fri, 19 Jun 2015 15:33:34 +0200
Organization: gmx
Message-ID: <d0c24a7643acd3a1a17ab3abf0ba54ab352b3e41.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wQR-0007wD-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbbFSNdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:33:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:51378 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbbFSNdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:33:37 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeALI-1YlC3W1rOW-00puN0; Fri, 19 Jun 2015 15:33:34
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:CBx2N0gqa7ANFCiCJHKOJ9VtKrn11+0diRhiYq38/IfxwpWqgB3
 b+OeZaFS0/mWTjzfG8MaOwSyxfX9K6DRHJ2xM2RkwX+qp+GthsNjAXXcdXuVxkr0gnX7+j8
 yk4oS1gxIcM8NoNrsVDw8QXsagx0U/6UzPY1KcSmp3Jkw4hEHvNDxQi22TgqTcmnxe0tKw5
 GE/CfJzXy2y5CvQ4Ox/IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kauUAtkHtq8=:KcIueRwKC2B+wJyVWqDvmV
 9tafiBmB1xXbpZdX2RTFKIJBke6gF22RDcWOfY9LZpBSW1zwqQJXS6BT2REqicj/cuRdv/FaL
 MpkQUGfsZG1erocupvqP1J1bTg/Mo5RKrh2wX2FbY0jghGg5PKlabei3gIYuOVyNRjuG5Vu5d
 geL8fVxGlu5pdqTqh0Fxt3fRxL0tBXZWeHgEtvHpIHX5CBmD9A9RBmQeIi3Df+zSJsu2Rd25l
 vUP6zd3QpAHcsO9X4SKatUPl1CtCXm5DtkNAMg+aYZbEL+6WErGYuypDgmg6ATKsjzjrEUgsS
 /SXuWWltt2Yj1TyRY58NNdSzSANam6BLLVuhZ5GfZc4C4TDJG8OhM9FB8JkzO5Mlvd3c20Pps
 oDOwA93We5dBLSXArG2yRrXKANS9kpgg/QzCPMw6M5EDc83lo0q0Hiqb1cbmemv6GlbbbNC3c
 epvHxQDpU00xtMtTtUvh7MJ5L9zieB3j0ggA/zXhLN3vdbuTIKcE8O0MGdYYeBmHGI6Y4cDMu
 6uTf4b4eyilRUduw8XeOMmkLoCZ57KsSGtsV704tnA4Z3HJFDslSZUHIt9Cztpg2PZ8v/NqwG
 WZE0OW3D4rCV6dkobtUr85f6LJt58o6A1am6dA9ukHtWd3Gvcib5TPDakcSlf6mih1WkHid//
 TSXmqs/EhKXem0n6rFl10vmo/0GpoIYHPcQMGYo37mf67fwgF1T9VYY0DW+9TWCSHev4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272141>

Some legacy code has objects with non-fatal fsck issues; To enable the
user to ignore those issues, let's print out the ID (e.g. when
encountering "missingemail", the user might want to call `git config
--add receive.fsck.missingemail=warn`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c          | 16 ++++++++++++++++
 t/t1450-fsck.sh |  4 ++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 8e6faa8..0b3e18f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -190,6 +190,20 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	}
 }
 
+static void append_msg_id(struct strbuf *sb, const char *msg_id)
+{
+	for (;;) {
+		char c = *(msg_id)++;
+
+		if (!c)
+			break;
+		if (c != '_')
+			strbuf_addch(sb, tolower(c));
+	}
+
+	strbuf_addstr(sb, ": ");
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -198,6 +212,8 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	append_msg_id(&sb, msg_id_info[id].id_string);
+
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(object, msg_type, sb.buf);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index cfb32b6..d6d3b13 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: invalid '\''tag'\'' name: wrong name format
-	warning in tag $tag: invalid format - expected '\''tagger'\'' line
+	warning in tag $tag: badtagname: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: missingtaggerentry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
 '
-- 
2.3.1.windows.1.9.g8c01ab4
