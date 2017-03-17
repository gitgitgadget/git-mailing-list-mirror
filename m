Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981F620323
	for <e@80x24.org>; Fri, 17 Mar 2017 02:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdCQCyO (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 22:54:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33823 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdCQCyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 22:54:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id x35so8085835qtc.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 19:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MTuw6H7X+0/CIRw5XvZLNPDDZFkvS1yq2qNKv4UMHxo=;
        b=MEuTD+anBdp8WhWNSnVXJ7ZaQAiE6AT04BuZmHp5sbAAmMlYTTTDXK3k0YIQCUwxTu
         ojQHqipF8Y/x4K/ZrGGpqV1H8WwQ40dmiWGQXiIho82+a3E4C65K/XJfr3RuC/Aert+o
         7MuDcXaunwrWNO10pXsE+TZKMJfoT3qdUItBeKfKetFJoUnKVWLLVZHz8XQy9EDlXFlm
         KQ6JQfIqA3EH8njh1mv0cDxI+3x88Nevo6MfaRrXXYaaefeJ4X0FWT/lJRs8Yicyi6Fp
         PAfTwqgtP0fsh4QZgH13DU8eyT9FEM3hUJ1H5jV1ysLsemXOeFOIR4uPQMn+Yh143SNg
         B/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MTuw6H7X+0/CIRw5XvZLNPDDZFkvS1yq2qNKv4UMHxo=;
        b=o6WEZ8cARqGAvoI4DWeMkw/+3QX85ePKdTrjEF6KWMt/q5OZYmWbv2VZ/Nzqodrjxz
         W23I+vx95sQQqGNF7nL71ZMdSuxfR+8h0IBNyk+y0a6/k9lbI/8OhmOHSTyrXeDI1Gp+
         HReGzWJqDfQ31RlRyPQVwERq2P3D1Jd6ogEh72TXr6X8slLg2S4de4PmMTg8fTptMERN
         QrOQ4iAJAo5bn4DyDV6a64czTB7YfLfFtelENJVxzUkybn2pFwJin6rol242Ur3nsIlX
         QR3JB6uz4llfkBdRTr2cA8fVqjfgZo32rhuehSzS0g6SwBaGNZXlxFqCTi+zUsgHqUQZ
         QdnQ==
X-Gm-Message-State: AFeK/H0jxnPQvxt+x6xjhvHvI9Hh4Gbsl4tRECmTKE+10/WAvys/BHzM761TvrGC93FBXQ==
X-Received: by 10.237.34.59 with SMTP id n56mr11547307qtc.231.1489719197479;
        Thu, 16 Mar 2017 19:53:17 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.googlemail.com with ESMTPSA id r30sm5009007qtc.66.2017.03.16.19.53.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 19:53:17 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [GSoC][PATCH v5 2/3] credential-cache: use XDG_CACHE_HOME for socket
Date:   Thu, 16 Mar 2017 22:53:14 -0400
Message-Id: <20170317025315.84548-2-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170317025315.84548-1-lehmacdj@gmail.com>
References: <20170316051827.97198-5-lehmacdj@gmail.com>
 <20170317025315.84548-1-lehmacdj@gmail.com>
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
index cc8a6ee19..3cbd42001 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -83,6 +83,19 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	strbuf_release(&buf);
 }
 
+static char *get_socket_path(void)
+{
+	struct stat sb;
+	char *old_dir, *socket;
+	old_dir = expand_user_path("~/.git-credential-cache");
+	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
+		socket = xstrfmt("%s/socket", old_dir);
+	else
+		socket = xdg_cache_home("credential/socket");
+	free(old_dir);
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

