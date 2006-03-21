From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] fix field width/precision warnings in blame.c
Date: Tue, 21 Mar 2006 15:28:06 -0800
Message-ID: <200603212328.k2LNS6eK019132@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Wed Mar 22 00:28:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLqGr-0004VZ-FT
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 00:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWCUX2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 18:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWCUX2K
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 18:28:10 -0500
Received: from fmr23.intel.com ([143.183.121.15]:25276 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964891AbWCUX2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 18:28:09 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k2LNS6JL009360
	for <git@vger.kernel.org>; Tue, 21 Mar 2006 23:28:06 GMT
Received: from intel.com (agluck-lia64.sc.intel.com [10.3.52.217])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k2LNSF1a006368
	for <git@vger.kernel.org>; Tue, 21 Mar 2006 23:28:15 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by intel.com (Postfix) with ESMTP id 6E41E19F64
	for <git@vger.kernel.org>; Tue, 21 Mar 2006 15:28:06 -0800 (PST)
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id k2LNS6eK019132;
	Tue, 21 Mar 2006 15:28:06 -0800
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17794>

Using "size_t" values for printf field width/precision upsets gcc, it
wants to see an "int".

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

gcc -o blame.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>'  blame.c
blame.c: In function `main':
blame.c:864: warning: field width is not type int (arg 2)
blame.c:864: warning: field precision is not type int (arg 3)
blame.c:868: warning: field width is not type int (arg 2)
blame.c:868: warning: field precision is not type int (arg 3)

diff --git a/blame.c b/blame.c
index 9c97aec..7e88833 100644
--- a/blame.c
+++ b/blame.c
@@ -748,7 +748,7 @@ int main(int argc, const char **argv)
 	struct commit_info ci;
 	const char *buf;
 	int max_digits;
-	size_t longest_file, longest_author;
+	int longest_file, longest_author;
 	int found_rename;
 
 	const char* prefix = setup_git_directory();
