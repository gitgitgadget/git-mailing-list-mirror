From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 10/10] use strbuf_add_absolute_path() to add absolute paths
Date: Mon, 28 Jul 2014 20:34:42 +0200
Message-ID: <53D697C2.8090504@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpl2-0005uO-RV
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbaG1Sep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:34:45 -0400
Received: from mout.web.de ([212.227.17.11]:63852 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaG1Seo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:34:44 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M57dy-1WH6RY44nG-00zCox; Mon, 28 Jul 2014 20:34:43
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:7e+VEW9hlwNxG/hBj9XulgLkBuwLlD6cqG97krNNiiUOFeQ9wcw
 tw6dium9LAgPNnn5H+yTQ4/utDtkQO57FfqHBuzolahGGPrn/qwgQBLTh2jAmC8vkcmRLvX
 hWKtgnZkCO9uhHNJjzEVjM+pQd1jVqeUgmbdWJhneWarD2Rd2WAMxFFEc+9KFHWCTx+QxOh
 uXpO7PxJAwWnXF/zYocBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254343>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 exec_cmd.c  | 6 +-----
 sha1_file.c | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 125fa6f..698e752 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -86,11 +86,7 @@ const char *git_exec_path(void)
 static void add_path(struct strbuf *out, const char *path)
 {
 	if (path && *path) {
-		if (is_absolute_path(path))
-			strbuf_addstr(out, path);
-		else
-			strbuf_addstr(out, absolute_path(path));
-
+		strbuf_add_absolute_path(out, path);
 		strbuf_addch(out, PATH_SEP);
 	}
 }
diff --git a/sha1_file.c b/sha1_file.c
index 3f70b1d..95afd20 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -350,7 +350,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 		return;
 	}
 
-	strbuf_addstr(&objdirbuf, absolute_path(get_object_directory()));
+	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
 	normalize_path_copy(objdirbuf.buf, objdirbuf.buf);
 
 	alt_copy = xmemdupz(alt, len);
-- 
2.0.2
