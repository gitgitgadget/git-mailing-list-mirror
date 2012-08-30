From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] describe --contains: use "name-rev --weight"
Date: Wed, 29 Aug 2012 20:50:29 -0700
Message-ID: <1346298629-13730-7-git-send-email-gitster@pobox.com>
References: <1346298629-13730-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vn2-0007mt-G3
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab2H3DvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:51:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab2H3Duo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:50:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 332F188B8
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=X3Og
	1e8Dt84GN+f/4rxkYLzps7k=; b=uBt83KPZnOYncKFoQ9CofqrXJWmQXIN4aemD
	gGxeTFdZr/teGCWOoG0nVDptHm5alhYaoSZ4hEoTmYVnsB8/3SVfJMQk3F8rMR1v
	8uZWLlTK+4HzpmA0Aotw/dsxu7zRlerOUtYiL+ibCEZmEHpT6DFDghqiggRkTITj
	QGwrmTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=joFJKO
	yhZjJHcky+4jvNyBDrHzaMGhui9KuROPOHApluaI6cMSSfPC21ayerjDko9tFE/J
	tCJcSe+O/Me4jUMoFFSfrpMqyN3zvcNbLERXEdy6kmMx1WMGhf6deQDhK5BHgCsj
	4kxVKMI4fu8NeIbIyxPqgzR/QHEwC9wdCpHkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20CC088B7
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AB3988B6 for
 <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.286.g9df01f7
In-Reply-To: <1346298629-13730-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DF9F8AB6-F255-11E1-A8C5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204511>

And this is the logical conclusion of the series, to
allow 0136db586c in the kernel history to be described
as v3.5-rc1~83^2~81^2~76, not as v3.6-rc1~59^2~56^2~76.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 9f63067..fbd5be5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -436,11 +436,12 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("--long is incompatible with --abbrev=0"));
 
 	if (contains) {
-		const char **args = xmalloc((7 + argc) * sizeof(char *));
+		const char **args = xmalloc((8 + argc) * sizeof(char *));
 		int i = 0;
 		args[i++] = "name-rev";
 		args[i++] = "--name-only";
 		args[i++] = "--no-undefined";
+		args[i++] = "--weight";
 		if (always)
 			args[i++] = "--always";
 		if (!all) {
-- 
1.7.12.286.g9df01f7
