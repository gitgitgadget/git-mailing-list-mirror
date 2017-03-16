Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECB7202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 05:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdCPFU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 01:20:28 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33452 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdCPFUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 01:20:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id r45so4480069qte.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OTGbhkxYR4cAGqMtONy9Dssv+wziRAktAFIQrCoaBOE=;
        b=tgne8vtb3+4B/GND4OIN3IXHz6FUrb/2R8amBVnpox0i3/buaKLSCfIR8mUUhTeyL/
         78Qt1P2GYsCD7ZO8k+v7OKmv+lYEGpc5423EVxRviq2AVJaunk+jtGQQxO9vOgOQU7qj
         FVTUWrQGkjyeN+OF9T21kyfOxgLXG0hjo8to3H/NrPvhcw+xZkCN1byrM+sdfoFmjN/1
         9TnNi/Y5ZPzEAVdyaxqt1g9RBdQLYAPo5IGw5oCnsrCYj6LFCttdUbe01Vd99Mb/SL7J
         lhzXYvvXrfL7ya0h2PnbZDRVHFKfsS1QBg7Q5Jq4Zq2G9PcAHmpAg8sp//0Gc5ARf9i3
         Zntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OTGbhkxYR4cAGqMtONy9Dssv+wziRAktAFIQrCoaBOE=;
        b=ptPjrSEBPGWLYX580aCKVW1w1aEGOkvwM+nq2nlkSxLYMw0NQq0rIQs/dJBVlR7s3Z
         VtmPkVdCHcydKPkZkdP4vw0Omgqc8aeQyrMAYtog4T9tHQ2inxiAY20ciA09KKL3Rz+g
         JZDDGPdGmi3aoU8NrKIUwiQsWLLIi3FypF4Qtx9u8idTa4scvG+KpVp+tj0u2VJmfUE+
         2e8wzreBYutryKuQ1J05/bIfiie0O5KgBRocw/luFaiOigu6Q2nVzghm5UloCtD29ls7
         Xp5ixRZCO1ctQgoGHrEF6aeh1s1KwfgD0W18LiKKKyRukuNLA7CQiKh25mePzcdZm5Ca
         RkIQ==
X-Gm-Message-State: AFeK/H1f6nc3fB+Fj7M7ZSZYCgPZgNSRmeyMHMQ9TTPSjifXEKh6jJuLJUObN/DWFhNUHQ==
X-Received: by 10.200.49.232 with SMTP id i37mr6211875qte.241.1489641517667;
        Wed, 15 Mar 2017 22:18:37 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-52.cit.cornell.edu. [128.84.124.52])
        by smtp.googlemail.com with ESMTPSA id y52sm2913833qty.60.2017.03.15.22.18.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 22:18:37 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [GSoC][PATCH v4 3/4] credential-cache: use XDG_CACHE_HOME for socket
Date:   Thu, 16 Mar 2017 01:18:26 -0400
Message-Id: <20170316051827.97198-4-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170316051827.97198-1-lehmacdj@gmail.com>
References: <20170314003246.71586-4-lehmacdj@gmail.com>
 <20170316051827.97198-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make git-credential-cache follow the XDG base path specification by
default. This increases consistency with other applications and helps
keep clutter out of users' home directories.

Check the old socket location, ~/.git-credential-cache/, and use
~/.git-credential-cache/socket if that directory exists rather than
forcing users who have used `git credential-cache` before to migrate to
the new XDG compliant location.
Otherwise use the socket $XDG_CACHE_HOME/git/credential/socket following
XDG base path specification. Use the subdirectory credential/ in case
other files are cached under $XDG_CACHE_HOME/git/ in the future and to
make the socket's purpose clear.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 Documentation/git-credential-cache.txt | 11 +++++++----
 credential-cache.c                     | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 96208f822..2b8582639 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -33,10 +33,13 @@ OPTIONS
 --socket <path>::
 
 	Use `<path>` to contact a running cache daemon (or start a new
-	cache daemon if one is not started). Defaults to
-	`~/.git-credential-cache/socket`. If your home directory is on a
-	network-mounted filesystem, you may need to change this to a
-	local filesystem. You must specify an absolute path.
+	cache daemon if one is not started).
+	Defaults to `$XDG_CACHE_HOME/git/credential/socket` unless
+	`~/.git-credential-cache/` exists in which case
+	`~/.git-credential-cache/socket` is used instead.
+	If your home directory is on a network-mounted filesystem, you
+	may need to change this to a local filesystem. You must specify
+	an absolute path.
 
 CONTROLLING THE DAEMON
 ----------------------
diff --git a/credential-cache.c b/credential-cache.c
index cc8a6ee19..1fd800775 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "credential.h"
+#include "dir.h"
 #include "string-list.h"
 #include "parse-options.h"
 #include "unix-socket.h"
@@ -83,6 +84,18 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	strbuf_release(&buf);
 }
 
+static char *get_socket_path(void)
+{
+	char *old_credential_dir, *socket;
+	old_credential_dir = expand_user_path("~/.git-credential-cache");
+	if (old_credential_dir && directory_exists(old_credential_dir))
+		socket = expand_user_path("~/.git-credential-cache/socket");
+	else
+		socket = xdg_cache_home("credential/socket");
+	free(old_credential_dir);
+	return socket;
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	char *socket_path = NULL;
@@ -106,7 +119,7 @@ int cmd_main(int argc, const char **argv)
 	op = argv[0];
 
 	if (!socket_path)
-		socket_path = expand_user_path("~/.git-credential-cache/socket");
+		socket_path = get_socket_path();
 	if (!socket_path)
 		die("unable to find a suitable socket path; use --socket");
 
-- 
2.11.0

