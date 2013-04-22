From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/16] remote-hg: don't update bookmarks unnecessarily
Date: Mon, 22 Apr 2013 16:55:20 -0500
Message-ID: <1366667724-567-13-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 00:00:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOmK-0005FR-ML
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab3DVV76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:59:58 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:59052 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab3DVV76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:59:58 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so5942405obc.30
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=cq8hX78bFAGUI2PvkDrq2AVFS7jJagVWhRqJwfD2a8w=;
        b=yyRAd4QsjmUpjSkdGN0AA3+ieGUrF2SMTgpofeWvH5CXufBGXEOhh+YUm+2dqVEpz1
         nVP0GGHE8iCdXhcZNx+FNV1gHmVqRNKZ7yGwcxYkovav75gVRD4+EAx9nOgZHHBh8AVX
         43fhInKrMaxdXDlBMydKvYW5V2vcaD/+RO0SmQcZbIof29M/DsLqdRJi1g9fbbJf5GuU
         y6/HIY1+Xeduow5Ewa/aIn5WOeu8IoebhRaFVpgZA72FfED/FxVpN2NpCFEhmGr6ipz5
         c4P/oiQlq/DzLynb8zIM4buq7hz6N8E69oUGwYKfyf9GUSkVUqtUeXF+iNrKjPEI2EkX
         jUMw==
X-Received: by 10.60.30.131 with SMTP id s3mr11503631oeh.106.1366667997561;
        Mon, 22 Apr 2013 14:59:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id wl10sm20074517obc.1.2013.04.22.14.59.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:59:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222110>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 4f6c7b7..dbb4091 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -830,6 +830,9 @@ def do_export(parser):
         else:
             old = ''
 
+        if old == new:
+            continue
+
         if bmark == 'master' and 'master' not in parser.repo._bookmarks:
             # fake bookmark
             pass
-- 
1.8.2.1.790.g4588561
