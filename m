From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 13/16] index-helper: don't run if already running
Date: Wed,  6 Apr 2016 18:11:59 -0400
Message-ID: <1459980722-4836-14-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhB-0004rp-2E
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbcDFWMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 18:12:55 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36511 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbcDFWMu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:50 -0400
Received: by mail-qg0-f49.google.com with SMTP id f52so48328750qga.3
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I8ocPQkcH/JNUg3sYaVwFXzrQQE2iDdUrI+1G3lW/zU=;
        b=lQhCnAEWKoSpyCF2FN5/IhPWIwY6Z5MgfCu+PXVKpOuAnG8ldf0ckl/T+EA4Pl3ToG
         Ya7s7DapTiCcrZRm6iktv36XN9kLVWDudk5fZr+Nb0lp8t/2hloKMkgj6/5Zxpc1IHSL
         W4NH5IEm6Ed2x7HrCJ6uFaDq7mZCyXKlfry9I/1Oni5SyGum4qWr506YN90nFFeZEALi
         J2F9rcrAHhfvi6S21LxrgWmqAWb77f2FQcMdAxWUsAs1tUCvsHKIiw4TFBBItVU7wH1H
         6NZftI8s3l75W2okXxOAWhJTdTBEMtyjYabqMfjoMX9OJo0fgedoSRqp1qskT7PECwJQ
         9vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I8ocPQkcH/JNUg3sYaVwFXzrQQE2iDdUrI+1G3lW/zU=;
        b=jOGT3u/l9hfk+tTF8be5sFpWsdG15Y6gdrFyMgZEmMqycwgqP0IOyysjNONMx3z9im
         GTJSabhPE1QgpvuKPRiDgDoe7zOAn3GeelwL1KR0Z9uT684+ZLHYW8MQYcDp7gb/LLF4
         3cHd0BZ/DXl3ehys4NnW8ju+04qVdaAfl52MCgG1jqjadIJXOIol6p8HlpA63jQYQSTD
         OmAE5d3ewM13MGnAmN/6gezUjgas901/Dj5BeBY4tRS210oHQPVuFrcfbNoFK+7Md+5z
         Bv4iximG67lQLl5JKXlYdhs5wO7OXfZqnUjMl4sr4L4vxdX4vnjDVs6RDCftmFuQbJxn
         E/SA==
X-Gm-Message-State: AD7BkJIshl9U4dcgTrF0rM4rZ+lS+8Bljegesha1INkf0hFaPpci0+f3oWJB5uF4/qzVww==
X-Received: by 10.140.201.130 with SMTP id w124mr6033949qha.57.1459980769259;
        Wed, 06 Apr 2016 15:12:49 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290880>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index a3f6a74..b62d805 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -413,6 +413,13 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	/* check that no other copy is running */
+	fd = connect_to_index_helper();
+	if (fd > 0)
+		die(_("Already running"));
+	if (errno != ECONNREFUSED && errno != ENOENT)
+		die_errno(_("Unexpected error checking socket"));
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index b1fa96e..3f94d8a 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -33,4 +33,13 @@ test_expect_success 'index-helper creates usable path file and can be killed' '
 	test_path_is_missing .git/index-helper.path
 '
 
+test_expect_success 'index-helper will not start if already running' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --detach &&
+	test -L .git/index-helper.path &&
+	test_must_fail git index-helper 2>err &&
+	test -L .git/index-helper.path &&
+	grep "Already running" err
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
