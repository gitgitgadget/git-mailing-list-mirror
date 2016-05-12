From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 16/20] index-helper: don't run if already running
Date: Thu, 12 May 2016 16:20:11 -0400
Message-ID: <1463084415-19826-17-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6X-0005AB-L0
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbcELUUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:20:53 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36345 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbcELUUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:51 -0400
Received: by mail-io0-f178.google.com with SMTP id i75so103992573ioa.3
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N0BOywmee+RFHdr1ALgEGeLyC+qk6uOqrzdZD6YAwU4=;
        b=L3hdBlr7StW85FfBB5eyMyNhwobtMweWcOVvKnjPq3E67OL/NRyJFEj4NprqsfrL4o
         aMyL5bZDYp1X7CQScSoIbuKSt0kstK6GgM54BbPQO//he4Kj/XM2S1mQfGYOUFxISNe7
         618mQCKV6x+Xd0MUxQ2b6+wm+JMOR2QE/Kli2Q6SayGk+VNR2sqrnY3Rtg1PaRaQQD2x
         ImL1qW7Kiup5PL1PrwmzaoEmQ5YvH4pMqT0NQThR6HbgW3gcYcn8V5w3TEVlej0T5mBp
         eVaAvjqy1qbuiJw8AzwLrA49Iqe8mZmlKzYxt9rApQswDxqkQ/ma7b8vPfsF9Qhww3pc
         XK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N0BOywmee+RFHdr1ALgEGeLyC+qk6uOqrzdZD6YAwU4=;
        b=RP39yyw5d6s+lzcnt7bwlO0ApUhSfm/Gb6Vnf4158qHOrJvEAYL6LqpckEka1mjG6x
         I1qkZJd7XatKHDjU4382nxSSMJ4TO6O3snXkXrS5qc7Nm+ywfUC89RMRG5vhSrU83HyN
         RpqelJR4zGrf90Nq7nOpBPNz2CbfFNFEU9rk3XWXuZy/BrccOgDU7T7RfZpo341afmYh
         +WoLTh8BL9Mb2iHfekTahzUSfGSOlCRnvW+YWaMdlojIKDAG5LN6tOu2ToXWQ0NoPDSa
         0ov/UnocDBAsGsgnqrZmSQBq6bff0AjIR4ilNWkZg8FzJU27HJWbNTaMQFXA3ZKU2pj+
         aAmw==
X-Gm-Message-State: AOPr4FWxfYoZKZGKOc19HJMVz0zpejkIHqV39bf6eFtuGF61QkUeMxsja08f2VMgCX0p6Q==
X-Received: by 10.107.140.13 with SMTP id o13mr9421154iod.161.1463084449320;
        Thu, 12 May 2016 13:20:49 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294461>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index a1b33e4..7b893a0 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -435,6 +435,13 @@ int main(int argc, char **argv)
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
