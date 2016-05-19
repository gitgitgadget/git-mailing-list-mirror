From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 16/20] index-helper: don't run if already running
Date: Thu, 19 May 2016 17:45:53 -0400
Message-ID: <1463694357-6503-17-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Vmo-0006rX-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbcESVrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:47:08 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35457 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbcESVq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:57 -0400
Received: by mail-qk0-f173.google.com with SMTP id n62so50136349qkc.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LaM7qCnleboHzQUuT8+fBmYLemhY7aAxl3DGyMQO/F8=;
        b=D7u4N64dwVPXGaoUWHgIKLlUWPCQpLMswY1gVqgz8kOSV36nTcLNF/08thVUetL3IR
         wBafAq8lUJRzOc9eLTuLwfT8H+gnZ5Fa3nrZjxjcmg0QbeTXAsCypwDZvyy4f00UEEfc
         Iz/NcfMXZOs5JebtKfed9YcE5z6rEbdZIl0cQ8xrWBM+ea15118Yxu6Z4SLW61PUnplr
         TM2WQQryWxCcuk65m9lNFYau6qFI/sQ/J+xgZkTzELWRuHCa07imqPIBrRgMfMkwZJk/
         4jvYmDygjVJbYW1NjCTODQHpH3ushKCdK/m8U+PruBna2hcDltUj3PGqeUoB5/hrTA+v
         dt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LaM7qCnleboHzQUuT8+fBmYLemhY7aAxl3DGyMQO/F8=;
        b=U+k2lsf87CqcNTuHPILNy7Ndx/Zln0uw5gc6ToOFZ4cgBr3ulay1LlpSO50+Ndpl9G
         /7oN2b6P3+iRwsdqEgCdX7wtiKZLBOE1+1yD1GNkTGV8LoaVMo6Mwa0PxyRmyi/DMKPz
         oJAEgjBBu8Ps99QpfyuoF5j7SYCDhcBuTkBkxlYIZFJkOwO1cZIX7SMhKTVQeodXk0by
         HhGOkK/7/lw1P3PNtAh/DQbFjUj4E6uCYrBtV+uG8HLT7KAsAM4eETk4SkwPUxgiM8yq
         n8ee1i7RechUWoZjx+v1W91HAaPecqwsPNRHOxQtv0coSZ+fJDCtDFu2nibRKHHHBbXp
         yz8w==
X-Gm-Message-State: AOPr4FXDQGosyvXb/FkkvD/JQcyp66LWQTb1GyVtXCf/HTSChfw0c92MrSBxDJl27jRI4w==
X-Received: by 10.55.195.20 with SMTP id a20mr16970759qkj.159.1463694416101;
        Thu, 19 May 2016 14:46:56 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295118>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index 4a171e6..ddc641a 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -438,6 +438,13 @@ int main(int argc, char **argv)
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
