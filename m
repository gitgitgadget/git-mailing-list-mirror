From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 7/7] grep: fix string_list_append calls
Date: Sat, 26 Jun 2010 00:41:39 +0100
Message-ID: <20100625234140.18927.35025.julian@quantumfyre.co.uk>
References: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:55:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIkH-0004gB-W3
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab0FYXzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:55:33 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39021 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751969Ab0FYXzV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 19:55:21 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id AD8B4819C6D9;
	Sat, 26 Jun 2010 01:20:45 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8A0F61EC127;
	Sat, 26 Jun 2010 00:45:46 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pK4yBIS9PpVV; Sat, 26 Jun 2010 00:45:46 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id DB9401EC12A;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-git-sha1: 5f992878f75257f25f4f32cea1a3650df0be694f 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149718>

This updates string_list_append calls added in the new grep -O
functionality to have the string list as the first argument.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin/grep.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0374a76..232cd1c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -564,7 +564,7 @@ static void append_path(struct grep_opt *opt, const void *data, size_t len)
 
 	if (len == 1 && *(const char *)data == '\0')
 		return;
-	string_list_append(xstrndup(data, len), path_list);
+	string_list_append(path_list, xstrndup(data, len));
 }
 
 static void run_pager(struct grep_opt *opt, const char *prefix)
@@ -1005,7 +1005,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		opt.null_following_name = 1;
 		opt.output_priv = &path_list;
 		opt.output = append_path;
-		string_list_append(show_in_pager, &path_list);
+		string_list_append(&path_list, show_in_pager);
 		use_threads = 0;
 	}
 
@@ -1080,7 +1080,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			strbuf_addf(&buf, "+/%s%s",
 					strcmp("less", pager) ? "" : "*",
 					opt.pattern_list->pattern);
-			string_list_append(buf.buf, &path_list);
+			string_list_append(&path_list, buf.buf);
 			strbuf_detach(&buf, NULL);
 		}
 	}
-- 
1.7.0.4
