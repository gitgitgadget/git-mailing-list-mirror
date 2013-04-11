From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 11/21] remote-hg: update tags globally
Date: Thu, 11 Apr 2013 07:23:07 -0500
Message-ID: <1365682997-11329-12-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYu-0007iF-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161464Ab3DKMZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:00 -0400
Received: from mail-qe0-f48.google.com ([209.85.128.48]:50081 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:59 -0400
Received: by mail-qe0-f48.google.com with SMTP id 2so831940qea.21
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=a8Jlr4eMh9nxt5LyielvuvB5CvXHIQMxM6vmAxjPgEA=;
        b=NfCANQx01taQyOXdL4pgBJJJ7Y4vXkKKLbtXv/qD7FORouyABCCRckAJp/tbW5Sdl5
         96gQfhsN+37Pj1HfMZ+tbB8WIcUccl7Y6UNP/mEMX9vtilUCgzmbhdI8AMWVy1gnk4fc
         9PcTiwp1Z5l9X5pxCcaugIL57p4yPH9toVd/fFxjvyu+57P4gbLsERCg0kNkOaqQILdC
         sCOcCfRQN/6VoKp7/jjbfxYPFmdDZJ3uOnzovE+evr5QFbp7eKVg1lwaHEOSCjaCIVKu
         YNSWGDHN2YGWweu+c5HXMh4vb4VF9EEVSyw00MK+uodpdvtp8ekXajnMfJPqwQ3Vf0+Q
         AtZw==
X-Received: by 10.229.128.224 with SMTP id l32mr1317021qcs.87.1365683099276;
        Thu, 11 Apr 2013 05:24:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t3sm6286821qen.5.2013.04.11.05.24.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220863>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 46cddc9..fc04f81 100755
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
1.8.2.1
