From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 15/19] index-helper: don't run if already running
Date: Thu,  5 May 2016 17:47:07 -0400
Message-ID: <1462484831-13643-16-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:48:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR82-0008DU-7G
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757844AbcEEVr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:47:56 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33959 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757917AbcEEVru (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:50 -0400
Received: by mail-qk0-f181.google.com with SMTP id r184so50943763qkc.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OmfxTEVfnNRuxzvLY9vhaUTSC55YWNXW+IdVfSnEtic=;
        b=JaDL0BTONzq4BSbY3RjKHOTXntfjQmVg8262qEl4azHxLSpxkDHnpBJIl7heMeAJm2
         9RQd1/cRL5ZXD9t1xl5Ld6X63vdfwed6q282jHTW59nQ8xex8RbWCtzfmrA1tT2oq7ox
         D+OpkXS5qFYgSg63fLwVnHWNXTJvcQilO5d/t1XCq7FJ/3vxrZNPIbVJINZ27bdAYO1I
         D133yJDoXjZugR6T6cF1hvzc9ukKhes+EpAlvIP80meo8QWgT9X0Y+8dGP0pn91VUdfa
         /2PSTau/wD43/QkAc3F9O8AtF1MN7DyYuQ/ar+kA1IpRz0M/uaJrS0d2zpfPxSQ+WW25
         Py2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OmfxTEVfnNRuxzvLY9vhaUTSC55YWNXW+IdVfSnEtic=;
        b=IYr8hpFozkjLFD3iJCyjGXLdPJ5HA4zM7WDt7YI++F22M+qobM/FM47offaVnLjnMe
         XcF77FZN7vmNnA7jefB0z8rJolZiusQCODFkkW3ONlJVAKCY6z4BQXQJSWMcnIr87HTI
         YK1/LwqfgjukpGm+zyuO2aO0qxSAE2sZltgXBlNyyTW/RK+wZKSbNQdGtSiBKxOY1i+H
         CJ0oZIv1UOZCnhxbqV4bkYQuioLB6C12IlkEt3yald6/DJUdw87LDetEPbuC377MmSQ5
         SshmH8zQs39pJYypeXmeb5Vxq2Ky5Ks1BtRqsdp45TMybf18wkDFtyV7ms+XKctnMsC0
         RIKg==
X-Gm-Message-State: AOPr4FWW3iWUPEJ8KW0x64G3axIOyYzNxU1OBK2SSGndRgEJEQtMxLevTkuHnuYiLA9XhA==
X-Received: by 10.55.31.71 with SMTP id f68mr17139785qkf.86.1462484864568;
        Thu, 05 May 2016 14:47:44 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293699>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index 4ed1610..b275f6e 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -458,6 +458,13 @@ int main(int argc, char **argv)
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
