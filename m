Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E7220373
	for <e@80x24.org>; Tue, 14 Mar 2017 00:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbdCNAdN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 20:33:13 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36493 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdCNAdL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 20:33:11 -0400
Received: by mail-qt0-f195.google.com with SMTP id n37so8358318qtb.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 17:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mm+hzgz5TEchldEaJmInQPlARM3RUDWUFU5nwk8hkco=;
        b=B/SpmPbrL3qgc0fw4eSNx/FBm5JzCuQDFPFn3TqPSXXSKVwz9M12MmurDGHFLTelP3
         9SYlt6Q13cXkqzM5ttPAFQQRCHm8qgLZp6ofg6jGO1p8whZNSz24hp+QNk6ogyK/gh/d
         nb3jY6gY/zEEVvkp1sW/25vRxQBdwMFEYTH3YMA9YCedSrOCM3jqTqb9ExKhm1AwjZiw
         K0EXpY/VbiigYPxhRlTg+KKso1GXcOZRaAvbqkDJ7jcQ8l8B4j7ZjRYXRH0LOfRLVNMq
         Nup1KB9CS3AQwJJiOBUrSsy7yGM4zB02SjFAYgmIyyDBkjurA40+RmMt0JbypZb6QGYU
         4Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mm+hzgz5TEchldEaJmInQPlARM3RUDWUFU5nwk8hkco=;
        b=fCs3kbMzbuwlpgMiLwfhC4jz3ALl+hBYHDxN0ZdMAX1IK3N8/6XZx2YoNmRQpmf/Di
         eX+06E83yf5dHmQzLZ7Qof2XWjTv1HqcCEbzJvg1xqV5H487EGyUYyldr2FNfwcjADuB
         YwotLqHPxo8wtIa543LHSzrgBirI9S5S233OoBM9A/HEFpwLbYrAjik/dCq5NjTVhMjw
         F8H/4jj0IKmNoA3lfUahyOBWZQf6vNmKyBDA44c5gm5isyPdcZT2nFcDLOIFsPrzh45+
         uUF5nGJFjSiWPhHo1SGJItur0BbNIJ/T2NlqpnW+igb02E5np2imCLNSTe1kmZLne4TL
         JDlA==
X-Gm-Message-State: AMke39nHHNT1q5q2ClMPyR4GPTe1BZU7DgMjUU1ahOhTMKwi//QDLwGX71POjHXyDN5B8w==
X-Received: by 10.200.51.33 with SMTP id t30mr34925128qta.287.1489451590362;
        Mon, 13 Mar 2017 17:33:10 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.googlemail.com with ESMTPSA id z196sm13327954qkb.11.2017.03.13.17.33.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 17:33:09 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [GSoC][PATCH/RFC v3 2/3] credential-cache: use XDG_CACHE_HOME for socket
Date:   Mon, 13 Mar 2017 20:32:45 -0400
Message-Id: <20170314003246.71586-3-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170314003246.71586-1-lehmacdj@gmail.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make git-credential-cache follow the XDG base path specification by
default. This increases consistency with other applications and helps
keep clutter out of users' home directories.

Check the old socket location, ~/.git-credential-cache/socket and use it
instead if there is already a socket at that location rather than
forcibly creating a new socket at the new location.
If there is not a socket at that location create a new one at
$XDG_CACHE_HOME/git/credential/socket following XDG base path
specification. Use the subdirectory credential/ in case other files are
stored under $XDG_CACHE_HOME/git/ in the future and to make the socket's
purpose clear.

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
Reviewed-by: Junio C Hamano, Jeff King
---
 Documentation/git-credential-cache.txt | 10 ++++++----
 credential-cache.c                     | 16 +++++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 96208f822..fce6319e8 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -33,10 +33,12 @@ OPTIONS
 --socket <path>::
 
 	Use `<path>` to contact a running cache daemon (or start a new
-	cache daemon if one is not started). Defaults to
-	`~/.git-credential-cache/socket`. If your home directory is on a
-	network-mounted filesystem, you may need to change this to a
-	local filesystem. You must specify an absolute path.
+	cache daemon if one is not started).
+	Defaults to `~/.git-credential-cache/socket` if it exists and
+	`$XDG_CACHE_HOME/git/credential/socket` otherwise.
+	If your home directory is on a network-mounted filesystem, you
+	may need to change this to a local filesystem. You must specify
+	an absolute path.
 
 CONTROLLING THE DAEMON
 ----------------------
diff --git a/credential-cache.c b/credential-cache.c
index cc8a6ee19..db1343b46 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -83,6 +83,20 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	strbuf_release(&buf);
 }
 
+static char *get_socket_path(void) {
+	char *home_socket;
+
+	home_socket = expand_user_path("~/.git-credential-cache/socket");
+	if (home_socket) {
+		if (file_exists(home_socket))
+			return home_socket;
+		else
+			free(home_socket);
+	}
+
+	return xdg_cache_home("credential/socket");
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	char *socket_path = NULL;
@@ -106,7 +120,7 @@ int cmd_main(int argc, const char **argv)
 	op = argv[0];
 
 	if (!socket_path)
-		socket_path = expand_user_path("~/.git-credential-cache/socket");
+		socket_path = get_socket_path();
 	if (!socket_path)
 		die("unable to find a suitable socket path; use --socket");
 
-- 
2.11.0

