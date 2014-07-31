From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/5] receive-pack.c: add receive.atomicpush configuration option
Date: Thu, 31 Jul 2014 14:39:10 -0700
Message-ID: <1406842751-6657-5-git-send-email-sahlberg@google.com>
References: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCy4V-0005Ge-G5
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaGaVjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:39:24 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:45961 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbaGaVjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:39:15 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so612521pde.5
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=evIqcTj+6gjZBXKpNC5Jtg41gwJkGmLZcwIdgxE/BQ8=;
        b=Ao6k/+v5Zxtjh2DO2oakeRaw1nz9M9rfHdrJXXiUFRGMjlFEGD1F5jEK5YIeWIPrpF
         uT2Lig8I/QN6dttsBQOmJsKBrMngMXpolzxQYug6lzoa7zJm0CjJ04ZX9164IaLRL2jL
         KwZPYkD/anXU3XaHux7hYs02vqhTgaHKLJmMv17RG7X6Z0yZv55ncHjLyt0dEQ8HqL8W
         +VRySa6ZDhWR7E6f4T49gqklxp6QGTkmDA3i80O88/slpIYhFt+ldZ8U3OIEVm81SyBH
         m5ruhKiruqrr7hx2sOj4jTlpgqQSRVZA+AA+mBqV79ujqx63XHrDu9wkTSOvUV8We8OC
         LeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=evIqcTj+6gjZBXKpNC5Jtg41gwJkGmLZcwIdgxE/BQ8=;
        b=WViSL4YOZv3FwGEt7VL0iBSeBDzgfJGulGJOFZwwysjODU2hkmdLCLcCaCTqsqYcXJ
         +Jk26Vu8VmXCpcmTnQQ4UWBD88OoLK3RfMbKph0an6awRncKlJfQT7eizSzRXo826p+i
         OAMZ5GUoE4OHV76Xds7Yoi3Qf9IG5i0UbhKX/PXFP3a+xG3cD+CSu24o+ok87H3d/X7J
         wuHrExHAOp/L1mHf3nQsFznhesnWCdTcnJP2oPQ+0B7NpuZ1KA7SBgFAm0FZ1v2X+CYl
         EGdtXmtx7+fA62Se0w6lnOCJzhl6oRtEhzzuFCYTREF3aAR4biNxMPybPcfay7xXrqDZ
         0oaA==
X-Gm-Message-State: ALoCoQkLHgSyFWGnB0SlPPNFuzrydod96V4bWV0tG+6HeFD42JlIuj23YAyjRBFL3dC44iUUiCtj
X-Received: by 10.66.246.229 with SMTP id xz5mr441585pac.34.1406842754608;
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si422521yhk.4.2014.07.31.14.39.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6E11B31C60D;
	Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F169DE055F; Thu, 31 Jul 2014 14:39:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.528.gd0e7a84
In-Reply-To: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254612>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Documentation/config.txt | 5 +++++
 builtin/receive-pack.c   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d718bd..75ce157 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2038,6 +2038,11 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
 
+receive.atomicpush::
+	By default, git-receive-pack will only use atomic ref transactions
+	if the client negotiates it. When set to true, git-receive-pack
+	will force atomic ref updates for all client pushes.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 47f778d..9fa637a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -132,6 +132,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.atomicpush") == 0) {
+		use_atomic_push = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
-- 
2.0.1.528.gd0e7a84
