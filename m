From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 08/20] index-helper: log warnings
Date: Thu, 19 May 2016 17:45:45 -0400
Message-ID: <1463694357-6503-9-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:46:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmO-0006Zn-DH
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbcESVqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:46:50 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33957 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbcESVqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:48 -0400
Received: by mail-qk0-f173.google.com with SMTP id y126so21161602qke.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GERHy4AQNAzh+Y4svLtp5YWexhIIYpOVLs6Q79tZozE=;
        b=EiPWhOYMHvLOdi3YW0yVjKE1w7/xZ6+kIH9l+13/PHs1HONN1TZRlgSOByE8DUXMhA
         WfsJNBnhqqpZ6aKac3nMLpdhX2z2kHSQN/EYOeOg8q6+Bve/peKYUNHeQ95v3yUpQ5dM
         4+gGQRtNgbVi3tGrod+6KZ6a1g0fqUm1uv6ZqyQ8OCDQYeg9aozg1MAGoRMVTAVaCphj
         SnS3U8KJ/0zs/hkljD4YFKihc+ac9qZ/M16T5x00mex2QsEWRyyS7bjPMC2jwh05C5vF
         VS6/Glnm0LLGiAWI2jlTjBctHWKViQtZbouYGfP4ZI4bV5MqhiumGhTHbSOYkvt7l4xp
         dO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GERHy4AQNAzh+Y4svLtp5YWexhIIYpOVLs6Q79tZozE=;
        b=kIywE0C1P8rNtnJWN99PhDmo3rQ9Y6VWDEgU7Mq2x0ROFHU+hSnYYt33rDH0xw/o0Y
         3PGS6SGO+siWYyKTIA2O2GjBM0eAKw7X/uPqVVvyzpQi3OAdam9IFKebD6ZssA90hW5P
         lkojI1PNP/SG4lQL51ywlEu05BlHZApF5G+LGfXwMth/76oPeeCOKZJ1IDx0CHAvdM7r
         YT87gCR4NERMJd/sT1g7oJWAoEFLR0WVszIcEmUawKNYbqi94yX1pXirYXpxVCeb8TYm
         3AgzEp2XXTIZUM96LeGIPxHRyxIMuL2e+BTEKuj4U8tYoZZdM1B1uLJfE9u3+KsrEYmX
         7tBA==
X-Gm-Message-State: AOPr4FWhJOWcm54aZGzyqs3DXOrATagvPOz0lA8Pb+iCqgSBSbROAhS6vZoEEjIK3Kskiw==
X-Received: by 10.55.214.151 with SMTP id p23mr17025198qkl.104.1463694406678;
        Thu, 19 May 2016 14:46:46 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:45 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295109>

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
index 6c8108f..e99109a 100644
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
 
 
@@ -324,8 +325,17 @@ int main(int argc, char **argv)
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
