From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/21] check_aliased_update(): check that dst_name is non-NULL
Date: Wed, 23 Mar 2016 11:04:37 +0100
Message-ID: <3260ac9599bc9efa6d7355b79d01e1a3e80bcb73.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmh-0001Ah-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbcCWKMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:49 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54349 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754698AbcCWKMk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:40 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 06:12:38 EDT
X-AuditID: 12074413-f03ff7000000516b-25-56f26a5ea84c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 64.AE.20843.E5A62F65; Wed, 23 Mar 2016 06:05:18 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1P018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:17 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqBuX9SnM4PtBJYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZ16+dZiy4z14x4ckKxgbG9WxdjJwcEgImEncfdQLZXBxCAlsZJeZ8
	XsoK4Zxkknj3/R5YFZuArsSinmYmEFtEQE1iYtshFpAiZoEFjBIbFy9mBkkIC/hJ3J6yhBHE
	ZhFQlbjdsYUdxOYViJLYdW4FO8Q6JYkNDy6ADeIUsJA4eXIpWL2QgLnE9gdrmSYw8ixgZFjF
	KJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERJQwjsYd52UO8QowMGoxMNbeO5j
	mBBrYllxZe4hRkkOJiVR3vNBn8KE+JLyUyozEosz4otKc1KLDzFKcDArifByZgLleFMSK6tS
	i/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvNsygBoFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQVEQXwyMA5AUD9BeXrC9xQWJuUBRiNZTjLocC37cXsskxJKXn5cq
	Jc6rAbJDAKQoozQPbgUsfbxiFAf6WBjiBR5g6oGb9ApoCRPQkoU+YEtKEhFSUg2MM+pnHs++
	WLI8bLZC3ItQedk4qS0sT+wk93Irqh7J//OUwa6u19cupsOPa8XcHPsuV67bx5Z0Op9KFjN4
	cd6i3sHPyUpE3/Xzy1kdqoHuPtVyk4r+PvkfcPHe0soFqzS+s82S7M34ahPTtHU5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289620>

If there is an error in resolve_ref_unsafe(), it returns NULL. We check
for this case, but not until after calling strip_namespace(). Instead,
call strip_namespace() *after* the NULL check.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c8e32b2..49cc88d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1081,13 +1081,13 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	if (!(flag & REF_ISSYMREF))
 		return;
 
-	dst_name = strip_namespace(dst_name);
 	if (!dst_name) {
 		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
 		cmd->skip_update = 1;
 		cmd->error_string = "broken symref";
 		return;
 	}
+	dst_name = strip_namespace(dst_name);
 
 	if ((item = string_list_lookup(list, dst_name)) == NULL)
 		return;
-- 
2.8.0.rc3
