From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 12/21] remote-hg: push to the appropriate branch
Date: Thu, 11 Apr 2013 07:23:08 -0500
Message-ID: <1365682997-11329-13-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYv-0007iF-7A
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471Ab3DKMZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:04 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:59347 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161312Ab3DKMZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:04 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so233622qaj.6
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=h9A5OQEGAGdIDwI4eIPL59VPEKC7ftGG8IDkPk6YArg=;
        b=ifaCXU8Fc0PVGBd4ZtXwIqVzTSX7ZawOi4l8yiNDqSUlU3UjMc2ER7VMd9GaVbQsPX
         N0aIP/jE6m0UEUBCMtP4jzX2jH2IiLW+8FwYz7y++u63ZVB8fojWx9AXMIyA6gUr6kW6
         aYsYaiT/U4+qFDAtXDz9625+WBpTGky5tZPTuWBS61dOd/mh0/47SKLGv2XC6IU3gmbo
         mbWS1uuEZZnmRMVt1EiZ9u9P2cNGUfIkTsZ+KIPZaIXIX7wy22FcH4mj1f1N4a6MVxGg
         U8fPbNKkj02avVt9mNTUB0dVnyvcpa+pGNdDqIN2g0F8rJASAPS7z0nopQmWsXNKisKH
         Xo7Q==
X-Received: by 10.224.40.197 with SMTP id l5mr6817066qae.41.1365683102639;
        Thu, 11 Apr 2013 05:25:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 10sm6959471qax.13.2013.04.11.05.25.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220864>

From: Dusty Phillips <dusty@linux.ca>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index fc04f81..ec599c6 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -625,6 +625,10 @@ def parse_commit(parser):
     if merge_mark:
         get_merge_files(repo, p1, p2, files)
 
+    # Check if the ref is supposed to be a named branch
+    if ref.startswith('refs/heads/branches/'):
+        extra['branch'] = ref[len('refs/heads/branches/'):]
+
     if mode == 'hg':
         i = data.find('\n--HG--\n')
         if i >= 0:
-- 
1.8.2.1
