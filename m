From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 13/15] index-helper: don't run if already running
Date: Tue, 19 Apr 2016 19:28:07 -0400
Message-ID: <1461108489-29376-14-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:29:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4m-00005W-5V
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbcDSX2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:28:48 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36351 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbcDSX2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:31 -0400
Received: by mail-qg0-f44.google.com with SMTP id f52so19237005qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ni93mypGSg5MdMBihCSHAq8o8nyb8RU3mi6Y6ebaM0o=;
        b=qX4R5Bl8GuC9ke5OhEAnQNYskLOtPfrQ58Fe0r4t86Hg5cRpuBudCTJf/AENZNVdd3
         ++BLr/T/Kqrj5jDgyGsPLRcYSwhzcmiIqpHVgjTAYzTjWuSNGdicoKeGD7epR7OvAW31
         mdTI71UCQN13gDXERSWejhcBcZ8iv77w/UtZIm/dNOHOHMWxiZG3RRwovViM67q+ARwZ
         mNQ3t/6VQ1zweYWls418apR7I0dt/KTKMnNBHSAxGsW6GAMtmb05NmR8t92ew3UjwSEZ
         YIQkSr+4iLRHPKUx/A8sxlgkDJpmX9KAtvsd2sI4oznTSKjuz2F1BA1U/Jz74I69uh83
         WT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ni93mypGSg5MdMBihCSHAq8o8nyb8RU3mi6Y6ebaM0o=;
        b=Ac7mrZ/onHAsOTgl9p8r2m75HBKnrwKIT0PuN0NHpBcp/mrXrYcHzg9M7Moz78gkXj
         5VOT5B5waVi5+hAfe4u3ckjUhjxA3gEPeSCKAwZYf8iddvq+loW81+l9PpXggIP5nldr
         5+68A7fENDsPJOYtNXbY9Boiirf4iZ9wC5DHndXwAqmzkd9/t+uYp2Mrm7VtirHQqj6N
         Uh7H/pKeA0kkL2CX94t2bXRFC28OHfug2KoZFaZRf2MML9xFwjKv+ig/MnfPBXbZOK3I
         WUGn1a7S0ac1ZISeQr1ih782utxKHRyumb09Z7WQMujvOdH15C6wz4SdoufSythmEoBI
         EmLg==
X-Gm-Message-State: AOPr4FVJMc5dxM3h8Uj2UpZ/LDt8bJJBnCg1Z5U7HlA+O7eTVy2A+2zZrMKK5wIYaJBErw==
X-Received: by 10.140.19.6 with SMTP id 6mr7102579qgg.75.1461108510336;
        Tue, 19 Apr 2016 16:28:30 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291966>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index 6af01c9..8fcb76e 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -412,6 +412,13 @@ int main(int argc, char **argv)
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
