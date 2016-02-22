From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 04/15] branch: die on config error when editing branch description
Date: Mon, 22 Feb 2016 12:23:25 +0100
Message-ID: <1456140216-24169-5-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:25:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXocV-0001MQ-PC
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbcBVLZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:25:33 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57845 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754550AbcBVLYj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:39 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 5F49C20C26
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:39 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 22 Feb 2016 06:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=splo
	ML0q83tUuiYUnQMFlHjfYF4=; b=UAH7Qw3f2HLzKRICFg/Bo9s2QoDIs8EmDp9C
	1WR6ptmiJghW2lNK5Us8Ios+eDDSSxGxxRUgAR5ZblKBhUPMo6z8dUZ5J/Lnwlno
	rp/9x0LvuTEg/ui5rJtpX+MH6S7A1xWzFhk5rBKEFCjQZGSHVwAXIWiNkPaiYD1K
	8cjc3WI=
X-Sasl-enc: dncxea6WpyUQH1A7aBx4y/FKgu1necbc9IXO3Nhr0cjD 1456140278
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id D9504680206;
	Mon, 22 Feb 2016 06:24:38 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286923>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0978287..c043cfc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -570,7 +570,6 @@ static const char edit_description[] = "BRANCH_DESCRIPTION";
 
 static int edit_branch_description(const char *branch_name)
 {
-	int status;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf name = STRBUF_INIT;
 
@@ -595,11 +594,11 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_stripspace(&buf, 1);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	status = git_config_set(name.buf, buf.len ? buf.buf : NULL);
+	git_config_set_or_die(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
 
-	return status;
+	return 0;
 }
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
-- 
2.7.1
