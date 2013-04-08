From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 11/20] remote-hg: update tags globally
Date: Mon,  8 Apr 2013 12:13:25 -0500
Message-ID: <1365441214-21096-12-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFfq-0005gW-4E
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934393Ab3DHRPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:23 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:41395 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760355Ab3DHRPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:19 -0400
Received: by mail-oa0-f53.google.com with SMTP id m17so6485884oag.12
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KkfkH//AqJ/5xuv0yNVuNJLRc0FmcHGxM+toQMspP2Y=;
        b=uRZLXKikdLDL2wS/J/HsTKH4nRi4HqpJQEmfL/KkmZHAUZvwP0onEAhZRH8mVtn2z6
         zd46zCABtP9zoJzytUPwQsDhFZlnlCS9uPjO1amZ5Zo9FUq569zpZLbsVUT51yS8LndR
         3yradEj4Z4uTOiOG+HvLGMmPMkALG77363gv1SqXApf4FyH5EtQXP2+zPD//nrnfgifU
         EHTbFbkqTkVz6toEETXpg7E42rsD5Zo8Kclyz97Balf5Z2HJncrANlW7sANZHf8o2Kw+
         T0HsbcVcNGruidWGoZLH17bd/8M+UE/+C4ZSSddyBrjDE0EnXUkQkCd8Elm61inCOuQC
         eOUA==
X-Received: by 10.182.60.136 with SMTP id h8mr12884593obr.47.1365441318532;
        Mon, 08 Apr 2013 10:15:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id qk4sm24999160obc.5.2013.04.08.10.15.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220452>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b54de1e..bccdf4e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -715,7 +715,11 @@ def do_export(parser):
             continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
-            parser.repo.tag([tag], node, None, True, None, {})
+            if mode == 'git':
+                msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
+                parser.repo.tag([tag], node, msg, False, None, {})
+            else:
+                parser.repo.tag([tag], node, None, True, None, {})
             print "ok %s" % ref
         else:
             # transport-helper/fast-export bugs
-- 
1.8.2
