From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH] branch: change install_branch_config() to use skip_prefix()
Date: Thu, 27 Feb 2014 15:13:49 +0400
Message-ID: <530F1DED.50308@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 12:25:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIz5J-0005ds-PL
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbaB0LYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:24:30 -0500
Received: from forward13.mail.yandex.net ([95.108.130.120]:43106 "EHLO
	forward13.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaB0LXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 06:23:49 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 06:23:49 EST
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net [95.108.130.67])
	by forward13.mail.yandex.net (Yandex) with ESMTP id 746D91423AF
	for <git@vger.kernel.org>; Thu, 27 Feb 2014 15:14:27 +0400 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id 41A547E0097
	for <git@vger.kernel.org>; Thu, 27 Feb 2014 15:14:27 +0400 (MSK)
Received: from unknown (unknown [31.181.12.71])
	by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Z2DgrOdxGc-EQ4S2Hap;
	Thu, 27 Feb 2014 15:14:26 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: a05c811c-fcd7-496b-9a95-37f30664f2a7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393499666;
	bh=telOsYLRnlAmvpTikbknNzBL2nKVMO4bYttKrtltwww=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 Content-Type:Content-Transfer-Encoding;
	b=xEMJYhTv4vJHjhbQ1r1KX/I9A6QLS3v3sxZieXA1Oob0tMgGcYze9QnN0kjKptYXJ
	 WH24JNAXXGz8WszwAfITmpyaClNyXrqal9x0HiTC0SGjNarvRLzJfbK11B66iUzAmk
	 a7Vj4PHGioZ5MazRkSl5vaTDJHmE2OLCQ1W7NOEw=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242805>

Change install_branch_config() function to use skip_prefix()
for getting short name of remote branch.

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 branch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..310749b 100644
--- a/branch.c
+++ b/branch.c
@@ -4,6 +4,8 @@
 #include "remote.h"
 #include "commit.h"
 
+static const char refs_heads_prefix[] = "refs/heads/";
+
 struct tracking {
 	struct refspec spec;
 	char *src;
@@ -49,8 +51,8 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	const char *shortname = skip_prefix(remote, refs_heads_prefix);
+	int remote_is_branch = starts_with(remote, refs_heads_prefix);
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-- 
1.8.5.3
