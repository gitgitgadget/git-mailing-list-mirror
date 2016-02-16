From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 04/15] branch: die on config error when editing branch description
Date: Tue, 16 Feb 2016 13:56:31 +0100
Message-ID: <1455627402-752-5-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:01:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfFN-0004fp-SL
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbcBPNAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:00:43 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33766 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932197AbcBPM44 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:56:56 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E0E8D20A41
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:56:55 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 16 Feb 2016 07:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=splo
	ML0q83tUuiYUnQMFlHjfYF4=; b=GwgaKRAOveKLRW2bo7m6/pb3IJLupOv/QqqA
	cfy7ZMCa8Zm9uyk6asW2Bbree7Dw5jq4sPnPO6nmdOiRrp2rp66V0EK1ebXQrCNb
	0Ng5QqJHc0Zrft6y+xNnQZxFmGk/tn4OU0Gfi++j+ZTDa0vn/xxrJDdtDubsgVzS
	4G1XZcA=
X-Sasl-enc: aXnj/4vt47vUoIVVslREwD3EacCXQmNqCl+Qk4mbeoHi 1455627415
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7439DC00018;
	Tue, 16 Feb 2016 07:56:55 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286356>

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
