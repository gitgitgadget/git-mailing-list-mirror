From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 08/20] index-helper: log warnings
Date: Thu, 12 May 2016 16:20:03 -0400
Message-ID: <1463084415-19826-9-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6C-0004k4-6F
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbcELUUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:20:37 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38068 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcELUUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:36 -0400
Received: by mail-ig0-f178.google.com with SMTP id m9so59973909ige.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2+bs7JIOoQ3++7JZExPU7jyWZ56WZiE3q9+DV+dPZU=;
        b=jV0S7Eoo97uZDWvMZF+CVccjQYISKmEoJbRkaDMwKezNB3fj42pfv+qkn/hYoS4p7D
         /XOHP0Fa64kFglrmXjR/B7MXCUI9W/SoOtN2Y5ZvOqWF0lidTVD4cHfdh+o8ZCchj6Fq
         WkvsQs8wt/JbqpBy87GalM8Vry7KDFqd1g9ECn/9OMIwfWSbk6q4eSZbgqwgJcQHsetz
         7SpnZ5v8TCXETSfg3A7WtkVRimC06hRU0UWgCo9UxzEED8rcSC4kjfsqef41+gKPZbS6
         6yD2CTOfAA+i450ljvKgKIjwK8e5yLnnQUpgo8EAokiHo1SArsVRg5XYntYIAdancBgV
         s6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2+bs7JIOoQ3++7JZExPU7jyWZ56WZiE3q9+DV+dPZU=;
        b=akF389fEmpeivvLBkKHE50gFpAxd7S/jjXaXcbB5gJiENaiI3sTICgzHifrx6PQjSU
         3XbglUeAGBjF7oQ0PEAEIzjhdta97YAOpvhpcQnzJ8FzxwVorgRezYmxahXR3YuzCwhb
         l3m/gAGgnR0h5TMfkKoacbhuayvpsnmc/j9Q3GGGO81n0f3Hl0t3i3yGkEwbZzvr9FEp
         9NjQ4qrscmQePQCtJkAyebEkYm6aljqtq5muh6WfmiPKb8bHnGXthQ5Q/hjCWgj5/AtA
         +lc6LJ0yxDE28bfBKZ0NG/DglhWQvShf6EzMoU2oFN4cJ26ap0RMyuiBAGbrQjlsNYks
         /5lQ==
X-Gm-Message-State: AOPr4FWL7Xy4yGwQYBWijP34JsheBSlbc1NHFjq7RSxA4Quod7DyiWVRWKsq2KYAZFxI6A==
X-Received: by 10.50.150.68 with SMTP id ug4mr29164705igb.14.1463084435039;
        Thu, 12 May 2016 13:20:35 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294451>

Instead of writing warnings to stderr, write them to a log.  Later, we'll
probably be daemonized, so writing to stderr will be pointless.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index f853960..e144752 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -57,6 +57,9 @@ command. The following commands are used to control the daemon:
 
 All commands and replies are terminated by a NUL byte.
 
+In the event of an error, messages may be written to
+$GIT_DIR/index-helper.log.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/index-helper.c b/index-helper.c
index 65abfd0..a3a9b00 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -95,7 +95,8 @@ static void share_index(struct index_state *istate, struct shm *is)
 	if (shared_mmap_create(istate->mmap_size, &new_mmap,
 			       git_path("shm-index-%s",
 					sha1_to_hex(istate->sha1))) < 0) {
-		die("Failed to create shm-index file");
+		warning("Failed to create shm-index file");
+		exit(1);
 	}
 
 
@@ -321,8 +322,17 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		die_errno(_("could not set up index-helper socket"));
 
+	if (detach) {
+		FILE *fp = fopen(git_path("index-helper.log"), "a");
+		if (!fp)
+			die("failed to open %s for writing",
+			    git_path("index-helper.log"));
+		set_error_handle(fp);
+	}
+
 	if (detach && daemonize(&daemonized))
 		die_errno(_("unable to detach"));
+
 	loop(fd, idle_in_seconds);
 
 	close(fd);
-- 
2.4.2.767.g62658d5-twtrsrc
