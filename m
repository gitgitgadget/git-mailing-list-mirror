From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 04/15] branch: die on config error when editing branch description
Date: Tue,  2 Feb 2016 12:51:45 +0100
Message-ID: <1454413916-31984-5-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:52:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZVT-000650-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbcBBLwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:52:17 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57002 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754458AbcBBLwP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:52:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 2168321252
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:52:15 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 02 Feb 2016 06:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=xv4c
	pmx1hcWi7ZvnJRsvR1u0vCU=; b=GGL64r8YZ22wJe57wUh0MVTkfNfh28Frk8Mn
	Y7JI13RJca1bYIkEiM4H6TLzsbvsK7exj5ZVMfTVKCfd8PNHJ4diFmQB1P2y9cYe
	5LHC5kcbtGPaJAys6TJEMK1KqKcFQISFzSqalan6yR3RSGB+LwYwcIe4fJ0A52QS
	Qtm/UmY=
X-Sasl-enc: 6tJA5jnjZqvi71+HDLPRG5b1hdhXGmeXpYsRtmwdv1kA 1454413934
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id A7E04C00012;
	Tue,  2 Feb 2016 06:52:14 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285251>

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
2.7.0
