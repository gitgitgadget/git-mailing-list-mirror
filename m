From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 13/16] index-helper: don't run if already running
Date: Tue, 12 Apr 2016 20:33:06 -0400
Message-ID: <1460507589-25525-14-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:34:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kr-0002sP-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758948AbcDMAdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:33:44 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34247 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907AbcDMAdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:36 -0400
Received: by mail-qg0-f51.google.com with SMTP id c6so31058859qga.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ho7miPx6xhmTQNHMWjtpU6sE0uMe9G4QXJ46fmToYdA=;
        b=KohBRpisi9in5tmG5y+9BUFIwKS/sjMO3phgx5DhtCZZ2ebM7yP5uAzgBmKeyrZ3Xb
         BCKZiF3WrLOHJ8l8EGkKSV6yHEjccDWuWW9DlFfbqaM9Ed4hXemnhApifsKdacjKvHpH
         q8Wr/VwmAEAxP/2FEktQFPV3LBi9vbxO5OIkzdIRY8EhCFvkTq1oxQADt8FIfuSE+Yf2
         H1w5eij76QKgAeqZKjpV2aqqWqHbxoLy40darF+B1OYb8RBKGXbQO1bwKfMzuT9w92Wn
         EoGW+nJbDoGUHRrz3SNbtcVh1yoZv1tY6U9bl4nb8rfXM+mUlPqyEZtrG5dgWjNzrSjE
         QfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ho7miPx6xhmTQNHMWjtpU6sE0uMe9G4QXJ46fmToYdA=;
        b=IzBh/xs0nEUf4rY8TebZ3hVbAWlpD5TeEISb2gIKnCTXdEVy67MwV8wiIWcj5fqx3n
         XTGz457uwn33drGn/M7ZSsgKvLa3vyEQBr/H1oIkm0wslyFQynFDoDdpJYf5Fs2NQTjJ
         +pGZENl7FI/MR8JkyYPsuCwJNp06VYwbWdPchPRlacFre0ZUcaRudLNVnZIC5sNG6gD9
         zZu13qhM638zeCw/ZgJV4YwDC+w0WdK8V31edu7JhntAnHMG84K5uUbJVJPaDNdBI9Qs
         Zw5UvyUwWAPGuw9WBpas22ObLWHTCTOEpzebV6XSlB8CR+tZ+NBKRbAIhpiFnOK8zTdy
         /Jtg==
X-Gm-Message-State: AOPr4FW8ohwo2zPVgMP6myr3yKIk74VVmS+2dOi4xXrSFVBtn+K31XboBzS0eKIVs8zXZA==
X-Received: by 10.140.242.77 with SMTP id n74mr8157010qhc.2.1460507615569;
        Tue, 12 Apr 2016 17:33:35 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291351>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index 3e0990e..dcb2041 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -480,6 +480,13 @@ int main(int argc, char **argv)
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
index fdb0d7b..32ef6f7 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -32,4 +32,13 @@ test_expect_success 'index-helper creates usable path file and can be killed' '
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
