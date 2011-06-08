From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 09/19] git-remote-testgit: fix error handling
Date: Wed,  8 Jun 2011 20:48:40 +0200
Message-ID: <1307558930-16074-10-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpL-00087c-GZ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab1FHStq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:46 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46131 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab1FHStl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so282597ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=+hcm/l0IjHOSZp0huFJxx6alRRvDUrg/1ayZr2vFQ4U=;
        b=rwOtjEeM1YoPUaflHc4/L+Y8gror4NlcAzGoKmxKq5Iv/g44Qy9BvhWlK9NlcRcuge
         9JSN6ZAJGkGIRQ1AReB06oQAY/i2avwbJevvZFH6rgwwk+dPR/DTnNBEZdvssDNmAJQY
         Oo+PNh/7vQJMv59Lvbpzn+Bo9jfyRLMyYnN54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EZ4ioFvdNv3F3+en7Xba3ToNeBYKkIrB+lwLsHnVQ/SEECpG2woD40MZV8LP6YC2xd
         rWGFgL7/o7j+8Kqsy3OrPCN/IxnX76fnBZ1T4+o8eDUYRW/3//m1eJGfvdi8mIveozC1
         gCUKSvpkMsH48O+dRM/7BEHMTaFy36gXii4cQ=
Received: by 10.14.8.139 with SMTP id 11mr3138663eer.175.1307558980379;
        Wed, 08 Jun 2011 11:49:40 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175430>

If fast-export did not complete successfully the error handling code
itself would error out.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Moved to the front for bisectability.

 git_remote_helpers/git/importer.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index 70a7127..d938611 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -36,5 +36,6 @@ class GitImporter(object):
             args.append("--import-marks=" + path)
 
         child = subprocess.Popen(args)
-        if child.wait() != 0:
-            raise CalledProcessError
+        ret = child.wait()
+        if ret != 0:
+            raise subprocess.CalledProcessError(ret, args)
-- 
1.7.5.1.292.g728120
