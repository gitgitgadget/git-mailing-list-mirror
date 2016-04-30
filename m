From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 15/19] index-helper: don't run if already running
Date: Fri, 29 Apr 2016 21:02:09 -0400
Message-ID: <1461978133-13966-16-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:03:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJW-0008ET-IL
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbcD3BDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:03:03 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33621 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbcD3BCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:41 -0400
Received: by mail-qg0-f53.google.com with SMTP id f92so49709132qgf.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8adW7DXVD5xj3goVt+oa3GmEQswGc2RD+e83//sjQT0=;
        b=o1QiuYhUuByyNg8WNfw7Z0AvSK+UqIU63nLImQKEIF91VRTguTb2zn8NCyGIoXTBjr
         llqgFXj+NCESn7Ly1UjBK15qHTjO/pfNDXBjO1LkzvVJkXF4abJzOVmfloM/jSa8mo/g
         CcRpbFMuBJ9oYKzRVj8ZdU/R8JCtLO3lj8fc5ffOvSlc6GIsCcL5+eU68HethLrcpcUg
         ews7+FpxjWZXWwYm9abCakaqACzI376GRZ1TyT2B64NhAvw+sQFoF1yG/28x+uDhidQh
         +QlyvMvJuSdaOvkG0Hy/tInjhbRL/tW3uPRhmJLhkOPCf9z19Y3WtxtUqoJe0b/PgKi4
         UowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8adW7DXVD5xj3goVt+oa3GmEQswGc2RD+e83//sjQT0=;
        b=FlrVk32aQYAiqD0x9doXd1f8plsPi3NAdNtT07F9ItEe8ChOVKO6nBT9/vBwknOBVA
         Xk9SWZlHP4RGi9pbybXQwYAPCyf/Vqg0Vt/tlPsKFi/nm6kuq2fQtKEuKibYyqYlPjFX
         npasXtvXkLoNS+2rRYiZZCcp9qqIv/+5QCGJcwTS6zlI2yaibWD4ijEfsUj/McUapCom
         x7gOuUZXipPhknIwizmBzV7Sa9svoknpZeN2V75BAlumh/TZTNWGeb8F5unTfxdwVRct
         MQGLLQa2GntvHy8DBBE4lnsfvgm3FSpn3yIC67YRC9K7I/jHSiv5m40Zdx34iURLCda7
         p8cw==
X-Gm-Message-State: AOPr4FWpTIHo5FhhiyorBi91w7rOcm/ESUDIsqWBbQ7ZVWoNPKmcNr36VYZYnnhX8emASw==
X-Received: by 10.140.28.135 with SMTP id 7mr21860538qgz.72.1461978160763;
        Fri, 29 Apr 2016 18:02:40 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293115>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index 9ca2ca6..e8d1311 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -455,6 +455,13 @@ int main(int argc, char **argv)
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
