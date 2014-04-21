From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] merge: enable defaulttoupstream by default
Date: Sun, 20 Apr 2014 19:17:33 -0500
Message-ID: <1398039454-31193-2-git-send-email-felipe.contreras@gmail.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 02:28:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc26J-00029c-O4
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 02:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbaDUA2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 20:28:39 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:44242 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaDUA2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 20:28:00 -0400
Received: by mail-yk0-f180.google.com with SMTP id 19so2898690ykq.25
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QPi4k8bXbP6ojVjYLhgYFgaHAIgl0seifOqa8SOREuU=;
        b=Vc1Wq/FdAF1DKA8DnRvvILGKogzpV66pV2dhLYAeN8dd0SAGIJDQZfe0nPOqBa8Qmz
         nIvH2EOxfiseZkxZlltTJ47CdvEGEbSFGGr3oGY6zDNS3h95paINgUNtAexC2QvSB7Qw
         bDCL/f5F73hhzMHWGYruoID/7+AtN44ggnsLsAMaRFYC7adDKRAIH+UkbsVF673R6jsw
         yKarzHwjAy2mqs3Ti8cogsHQhCK7f/P2gCfZnhBxtLuCF7RfDhMvSQ+1fyyEoxPMyQwQ
         xMTepsH12H+5XX4Py03TICST/a5Q7KVyq3k/huQyXoQeWXTDvLDkrCLhnmDYK68shGOT
         QewQ==
X-Received: by 10.236.135.104 with SMTP id t68mr48400438yhi.35.1398040079581;
        Sun, 20 Apr 2014 17:27:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t63sm66601560yhm.32.2014.04.20.17.27.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 17:27:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246602>

There's no point in this:

% git merge
fatal: No commit specified and merge.defaultToUpstream not set.

We know the most likely scenario is that the user wants to merge the
upstream, and if not, he can set merge.defaultToUpstream to false.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-merge.txt | 5 ++---
 builtin/merge.c             | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index a3c1fa3..cf2c374 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -101,9 +101,8 @@ commit or stash your changes before running 'git merge'.
 	Specifying more than one commit will create a merge with
 	more than two parents (affectionately called an Octopus merge).
 +
-If no commit is given from the command line, and if `merge.defaultToUpstream`
-configuration variable is set, merge the remote-tracking branches
-that the current branch is configured to use as its upstream.
+If no commit is given from the command line, merge the remote-tracking
+branches that the current branch is configured to use as its upstream.
 See also the configuration section of this manual page.
 
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 66d8843..1fc9319 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -63,7 +63,7 @@ static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
 static int show_progress = -1;
-static int default_to_upstream;
+static int default_to_upstream = 1;
 static const char *sign_commit;
 
 static struct strategy all_strategy[] = {
-- 
1.9.2+fc1.1.g5c924db
