From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 15/19] index-helper: don't run if already running
Date: Wed, 27 Apr 2016 16:04:37 -0400
Message-ID: <1461787481-877-16-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVjB-0003bG-N2
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbcD0UGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:06:20 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:32977 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbcD0UF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:27 -0400
Received: by mail-qg0-f47.google.com with SMTP id f92so21853691qgf.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WmGn1DMxPUzWQomGn2vvbjZVK5kO+4vMZMrAigWLY/w=;
        b=dffA8Tz/WX6/Ku68Matt7bad3eKsoL3tmji7GREj50oi+kLumJovaAPJMdl0/6wtUy
         Xwg3c5q6d9Os8YJtFEr8I+DWovgQjduRnIU9t2+0Zq7oSPOCSRZ2MNAJMhLCrUqxj167
         aMflCIeo6h4lH7VHFUqkj//4OanaSDhw7Wj170iNiSePyXSnIDYDWQzIsg1TB8apofGa
         GByejM/rfXEmP4XR9887SDvg5vZf78LmMKmICjdo59d0ZjmPslvxQybs5Vh/+iA1keup
         7HikvBy3tNRWP0vct1hWgYObCmE8z1jX4ZOvPZfZOAIpxF8T449zv38/QUaxqZ4Zbzgo
         kOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WmGn1DMxPUzWQomGn2vvbjZVK5kO+4vMZMrAigWLY/w=;
        b=L6vg1rGfApC2p1jl+yxxNXutjvXWGL8uH3b8BnyFMt2N+5W++FHlW/oZUyAGhJl/9g
         LJYWo72RmTpYXo5Frn7jNh/oL2R9PHGnxbIaZtrPqjdszfPAcpoRaP+85/lbmwwTGpY1
         IKq73NBVPHwayZ7v5AOKYWhvokRoPzkBgCF8gMg3skhYtIVYfLDIa53XBaWlsbhhqbwy
         uKc2NPpNlP7fCjBP1V2DzcHtT9Syi0KKFnQE7sshNdStGvaSMuTcVutTdvwcUSpNm581
         U/DaHgbZ6WbzIxp8UU5jMSdipuP8deiumSQZCI4NTlqaUZf4vR5IMkoExpcghgDu695F
         i+1g==
X-Gm-Message-State: AOPr4FVzSNWySrt4WStC6BjPsYPgi9OMW+jidhz25SGtJBQd0oPqyzTQeU2q/7kxTyhjug==
X-Received: by 10.140.42.78 with SMTP id b72mr10123641qga.48.1461787527032;
        Wed, 27 Apr 2016 13:05:27 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292799>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index 60a71f2..092c814 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -463,6 +463,13 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	/* check that no other copy is running */
+	fd = unix_stream_connect(git_path("index-helper.sock"));
+	if (fd > 0)
+		die(_("Already running"));
+	if (errno != ECONNREFUSED && errno != ENOENT)
+		die_errno(_("Unexpected error checking socket"));
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index e71b5af..7159971 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -29,4 +29,13 @@ test_expect_success 'index-helper creates usable path file and can be killed' '
 	test_path_is_missing .git/index-helper.sock
 '
 
+test_expect_success 'index-helper will not start if already running' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --detach &&
+	test -S .git/index-helper.sock &&
+	test_must_fail git index-helper 2>err &&
+	test -S .git/index-helper.sock &&
+	grep "Already running" err
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
