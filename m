From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 12/20] remote-hg: push to the appropriate branch
Date: Mon,  8 Apr 2013 12:13:26 -0500
Message-ID: <1365441214-21096-13-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFfq-0005gW-L9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934071Ab3DHRPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:25 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:56621 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3DHRPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:21 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so6488372oag.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wc+1ThW0rjEZZ7pMbRhNU97jFrc18Ww8WgLpSkvX32k=;
        b=OTy5SYJm32zNKEHWPu5rbYBLkZwjd6Jg4qdwl/7AXsRTH4cpVZcj2BrvCpoVZYeYTv
         QKRrUkT1ohHjASn789hl0CmOabmIoViq/FhUMXK/mfaO/xf+9cGBMPERbciapp3lxCNC
         GvtiQsMtVWk1mplLgIniw4nY8utKCXFzSTVxRNmjaeWKKJwKqvVfGjSH/V9Um3DWmFUB
         4Lqv0S3SmSzIqw/I6xyOdHx7Q65zlfnmjoLqe+Y1ukDVEmrNm4teZiwkocTIUZJuNZY5
         jLaBeK657ACk9LzBcv9jy+fkHAZuq1vhBm75PNizp3sJxtauIsZ/3pkXiflC7sWaEULU
         Yd1g==
X-Received: by 10.60.137.233 with SMTP id ql9mr15098124oeb.98.1365441321337;
        Mon, 08 Apr 2013 10:15:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t5sm4332488oex.1.2013.04.08.10.15.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220453>

From: Dusty Phillips <dusty@linux.ca>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index bccdf4e..8f6809a 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -625,6 +625,10 @@ def parse_commit(parser):
     if merge_mark:
         get_merge_files(repo, p1, p2, files)
 
+    # Check if the ref is supposed to be a named branch
+    if ref.startswith('refs/heads/branches/'):
+        extra['branch'] = ref.replace('refs/heads/branches/', '')
+
     if mode == 'hg':
         i = data.find('\n--HG--\n')
         if i >= 0:
-- 
1.8.2
