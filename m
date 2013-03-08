From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] for_each_recent_reflog_ent(): simplify opening of a
 reflog file
Date: Fri,  8 Mar 2013 13:53:43 -0800
Message-ID: <1362779624-15513-3-git-send-email-gitster@pobox.com>
References: <1362779624-15513-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 22:54:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE5FI-0000cF-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab3CHVx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:53:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab3CHVxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:53:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92B9CB4C6
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vEuh
	9LZKv5x6dy6lAqm0Tn5MxEo=; b=PjQxPtit6ADFqgP9YZ42fWgLUUfZa50DRwoL
	Jd28v+oh5ONWaEEY5O0Jemat/ThjXN0KYi+fsCENIJVG4PRSAghOIT7nWsnOHuOc
	0D9Q6GH5FzN8SaU6cjhsecGsSz85mdSY2aDv/t4178N46awacawuk1R9LbvoN4pD
	LhalNVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LjR8yQ
	skVh0uAVktVZeZhruNIe5hzAEk5PQYy6/T4Cw3nJepFT93a26TLyOez/CpdPJAvm
	yH/iC2V6Ho4yZtq+zV8EwH9kD5tDYZ8bEOQHXc5rjWcI2MJwb0DEXGmQRwoeuIn8
	LwUyWN7vL82Hhr5PEGbkOwLRPo/S4azpnaXP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 879BDB4C5
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B7D0B4C4 for
 <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:49 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-189-g94c4d42
In-Reply-To: <1362779624-15513-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A911E9E6-883A-11E2-8415-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217689>

There is no reason to use a temporary variable logfile.
---
 refs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9f702a7..e302521 100644
--- a/refs.c
+++ b/refs.c
@@ -2320,13 +2320,11 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 
 int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long ofs, void *cb_data)
 {
-	const char *logfile;
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
-	logfile = git_path("logs/%s", refname);
-	logfp = fopen(logfile, "r");
+	logfp = fopen(git_path("logs/%s", refname), "r");
 	if (!logfp)
 		return -1;
 
-- 
1.8.2-rc3-189-g94c4d42
