From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 17/20] remote-hg: add 'insecure' option
Date: Mon,  8 Apr 2013 12:13:31 -0500
Message-ID: <1365441214-21096-18-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFfs-0005gW-7g
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934827Ab3DHRPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59069 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760775Ab3DHRPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:36 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so6422439oag.19
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nLBFVaeE7VFUsLrBYjQM6p/8EAqXDpSDN23K88izfqg=;
        b=wiKwU6153pltFK+a2qUZmbiwK0j+nbjdQUeN5InccXVSqeMlxlwCqjEFV0f/QKBAac
         VBzRBuuFt/d8sZQW1y1oZBaClw4LIBEA7WnB9qqZ/7pyvUJG2J+ff5tSImh2qCKIEGjd
         hiTu+eNTuz/cfbj4PZGZW/jmJ78UAL2Bs5MrihxgPU8NsOXM0VyA2QezniFUL1smAzn9
         ZPNxub94udkYiQ8stUqXDhtYX2LioCAQg5KenljfmEdjYDn31cMJ71OqVTuAhotfJ1MQ
         TYSwU/t2dnMsiNJeQBDt1DSxuV71tzHZ1UHek0XyXKy+oNt1D/KbDSyr8WBRbpias+JU
         yBZQ==
X-Received: by 10.60.32.198 with SMTP id l6mr16414539oei.27.1365441336188;
        Mon, 08 Apr 2013 10:15:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s8sm4897967obf.2.2013.04.08.10.15.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220457>

From: Simon Ruderich <simon@ruderich.org>

If set to true acts as hg's clone/pull --insecure option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 078d3e8..2f642a6 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -30,6 +30,9 @@ import urllib
 # If you don't want to force pushes (and thus risk creating new remote heads):
 # git config --global remote-hg.force-push false
 #
+# If you want the equivalent of hg's clone/pull--insecure option:
+# git config remote-hg.insecure true
+#
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
@@ -279,6 +282,12 @@ def get_repo(url, alias):
     myui.setconfig('ui', 'interactive', 'off')
     myui.fout = sys.stderr
 
+    try:
+        if get_config('remote-hg.insecure') == 'true\n':
+            myui.setconfig('web', 'cacerts', '')
+    except subprocess.CalledProcessError:
+        pass
+
     if hg.islocal(url):
         repo = hg.repository(myui, url)
     else:
-- 
1.8.2
