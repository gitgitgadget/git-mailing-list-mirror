From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/2] cmd_clone: free dir and path buffers
Date: Thu, 31 Mar 2011 17:10:41 +0200
Message-ID: <1301584242-3193-1-git-send-email-cmn@elego.de>
References: <1301583996.11592.3.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 17:10:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5JWO-0007uq-T7
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 17:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208Ab1CaPKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 11:10:44 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:41314 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757777Ab1CaPKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 11:10:43 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id E6BAB4611D;
	Thu, 31 Mar 2011 17:10:32 +0200 (CEST)
Received: (nullmailer pid 3232 invoked by uid 1000);
	Thu, 31 Mar 2011 15:10:42 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301583996.11592.3.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170498>

The variables dir and path are always allocated on the heap so it's
always safe to free them.

This memory would be freed by _exit, but it's good form to free memory
you've allocated.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

Hopefully this time there are no silly mistakes.

 builtin/clone.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2ee1fa9..fe0408c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -665,6 +665,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			err =3D run_command_v_opt(argv_submodule, RUN_GIT_CMD);
 	}
=20
+	free(dir);
+	free(path);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
--=20
1.7.4.1
