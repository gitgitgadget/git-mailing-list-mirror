From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] transport-helper: barf when user tries --dry-run
Date: Mon, 20 May 2013 20:09:14 -0500
Message-ID: <1369098554-11591-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 03:10:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueb6M-0006zT-1W
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 03:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096Ab3EUBKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 21:10:50 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54366 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903Ab3EUBKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 21:10:49 -0400
Received: by mail-ob0-f174.google.com with SMTP id fb19so78355obc.5
        for <git@vger.kernel.org>; Mon, 20 May 2013 18:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LHZ1s/WJmQbL5CI74KFpN3SmajP4u0iig79r1PGhAw0=;
        b=DlC4BJzd9x6lRvW2yC3GfbERXaYDSs36V/Qe1gqyyFZtVAfzS/8KXO/qeXsWMIfi8o
         wQvFlWhD6eKdYiTUp4nFxkR6eltnb0wzjgJaTPMkW/WQg3mhI3ubT4OJ2jPkYDCuO4XZ
         PPU9x+QgPKs7MqsPw3fNkB5RzL7AozfgO+YAvyA3YOHw78fVdUVGxZUgn0BZUM8U05rc
         GOLLO5u2C0IXY95MoN7j2dY3njSgBJz7YALMZCsx1t3zBA5QMCdXrEaWkSMHQNACEjdP
         doCFd64uHMEhTX09A9U6vRjqeH9LLHZ2z4NpFMKLNISCnovfAnskQONN+uKuWwZHccYf
         7kRA==
X-Received: by 10.182.224.162 with SMTP id rd2mr11285obc.95.1369098648934;
        Mon, 20 May 2013 18:10:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt1sm371870oeb.5.2013.05.20.18.10.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 18:10:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225009>

Certain remote-helpers (the ones with 'export') would try to push
regardless.

Obviously this is not what the user wants.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 522d791..daebdd9 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -789,6 +789,9 @@ static int push_refs_with_export(struct transport *transport,
 	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
 	struct strbuf buf = STRBUF_INIT;
 
+	if (flags & TRANSPORT_PUSH_DRY_RUN)
+		die("helper %s does not support dry-run", data->name);
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.3.rc3.dirty
