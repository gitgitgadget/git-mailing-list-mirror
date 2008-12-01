From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6 (v2)] connect.c::read_extra_info(): prepare to receive
 more than server capabilities
Date: Mon,  1 Dec 2008 06:12:51 -0800
Message-ID: <1228140775-29212-3-git-send-email-gitster@pobox.com>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:14:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79Xr-0007ng-DB
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbYLAONT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbYLAONT
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:13:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbYLAONS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:13:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D89448318F
	for <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 469788318E for
 <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:12 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.23.g38649f
In-Reply-To: <1228140775-29212-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 336B6BAE-BFB2-11DD-8A8A-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102040>

This still does not actually parse and accept anything more than the list
of server capabilities, but prepares for the uploader that sends more
"extra" information than that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 932c503..114d691 100644
--- a/connect.c
+++ b/connect.c
@@ -59,8 +59,11 @@ static void read_extra_info(char *line, int len)
 	 * The first such "extra" piece of information is the list of
 	 * server capabilities.
 	 */
+	int infolen = strlen(line) + 1;
+
 	free(server_capabilities);
-	server_capabilities = xstrdup(line);
+	server_capabilities = xmalloc(infolen);
+	memcpy(server_capabilities, line, infolen);
 }
 
 /*
-- 
1.6.0.4.864.g0f47a
