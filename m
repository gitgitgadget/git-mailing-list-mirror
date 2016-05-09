From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 15/19] index-helper: don't run if already running
Date: Mon,  9 May 2016 16:48:45 -0400
Message-ID: <1462826929-7567-16-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:51:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7i-0004LM-VM
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbcEIUt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:26 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34293 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcEIUtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:24 -0400
Received: by mail-qk0-f171.google.com with SMTP id r184so101995459qkc.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OmfxTEVfnNRuxzvLY9vhaUTSC55YWNXW+IdVfSnEtic=;
        b=ke+QwApxN4H0mMeAXBI6dlcURQshphR9KvFReDeSjIa/IDbuqB0MuVLoqx5/vw5Vur
         pLS+QQ/KUzHu0WsSNqhD1xUlZ4rQLSp8xYAMUsPQSfrAgdMQ6BZ6qS6GDRk/+gc1rfuO
         aueTKb5Vo+oh/gBvEKwmnaV07HNcSt6ccrPEZiAqWbIUsKx/+M9a5ttbGfzS345nZAFc
         7PQCcf3oOAYOBeZygPAZ4xL8Gfyt7R/ib9SjYrEz9T7mfAn9dGq9BQs3XZ0X97pxRpoS
         17xTUk7bj539xHjkUO+WCtbWi6V/MFt9345E3ZJsukvQsW81/8AITmjmH7OUEt/I2/De
         ArtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OmfxTEVfnNRuxzvLY9vhaUTSC55YWNXW+IdVfSnEtic=;
        b=LAPbjRs7M6ECSb4rUpN7NXBkV2Jx5b+oYHMsXQHSrq09XcReXjwqLYHljgcPrny2G+
         AG5Ygkbd3bh9TAifBHfukVENbGPLuaOphT+81kECmZDolSjzpPyjsGJrC905+T3icVJP
         sBbxoUfjHRRu2YsJZAGcZjNr4zMewzwDiYP9VRFPue7mDbh+eLGAIp4BNVd2EfEXuKqP
         TNJRC4mKign7JmkmGlciHGtg6oz381N7O2dfnMuiGX8apkvr/CzoHVCI1hUFU9CLcynl
         9h0CZZ1lS4RgVzXMLbDChnBkLQEX1oPN6+o9lc/cFBWbpxrCjlEyc9f0tELGaa8ba4wV
         JdyQ==
X-Gm-Message-State: AOPr4FVKrQxRlfEe9J8qu+nVuAjYYFfWqSO7bCOxCCwj6gwmERqzkXdLaM2uKyoYYlmlpA==
X-Received: by 10.55.100.76 with SMTP id y73mr16283257qkb.106.1462826963813;
        Mon, 09 May 2016 13:49:23 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294059>

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
