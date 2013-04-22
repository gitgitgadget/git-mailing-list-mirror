From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/16] remote-hg: properly mark branches up-to-date
Date: Mon, 22 Apr 2013 16:55:12 -0500
Message-ID: <1366667724-567-5-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOkb-0002E7-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab3DVV54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:57:56 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:53182 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab3DVV5z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:57:55 -0400
Received: by mail-oa0-f51.google.com with SMTP id k14so6441160oag.24
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Za4ZFOToKiENqOKzNsIBKK7r5H+OIANxglF6B4FHjh0=;
        b=0a/ptSuBaYQGRIPdj3ydTA73aMwaOeHu40KPr7Cvok93LDQ9g2JNWk8B9BsOxD8tl3
         EtHV2HMBrSXr5V3j/PyR9aTw/pSOcDaP+OdR7O6Zco8seH095OTV/T4EiJyQ8+1rZWCd
         FFxmJiFyu690Ol8q9IlKfYUcO8DYCICwH0JcnYJKbnVgHnGHvBXZF1kW+X8zEUB2MSR+
         1Oy3og753WDRChwwvUBkqrqDbDBMW6id6hXq8rsIvxmt9kEdgp7vQpf5roGE9kB/ehZ/
         epx1gBWRXRdtvwWNOsfXViLHzY8zBJJmo923I5fMI8NGT94ZK02IsveTEln4r9H/kdBw
         Kgcg==
X-Received: by 10.60.15.98 with SMTP id w2mr11493817oec.128.1366667874689;
        Mon, 22 Apr 2013 14:57:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id w7sm20056276obx.9.2013.04.22.14.57.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:57:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222102>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b6589a3..a4db5b0 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -742,6 +742,10 @@ def do_export(parser):
 
     for ref, node in parsed_refs.iteritems():
         if ref.startswith('refs/heads/branches'):
+            branch = ref[len('refs/heads/branches/'):]
+            if branch in branches and node in branches[branch]:
+                # up to date
+                continue
             print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
-- 
1.8.2.1.790.g4588561
