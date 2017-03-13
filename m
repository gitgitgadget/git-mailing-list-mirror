Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94EDE20373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbdCMUoB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:44:01 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35429 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbdCMUn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:43:58 -0400
Received: by mail-qk0-f181.google.com with SMTP id v125so228414939qkh.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Voy1BYbrwVnWRsnXzpd8DhYBd0effCZg3Coq3RhiLro=;
        b=FxEx6+IPmqUAW32uDEszINEWxqr3C3a5X9BAKebqI6kIcEGm0D3CX8CfSEK/58MVVL
         1Tedsu8bXttswlYNp5BM6Bf1Nyu9AJLTzFXJIwTtGWpzmUrcxdCZj+T4Iu5zaT37NxER
         pPWvfEHPoEsOYxPDBEOdr+knpIcZzckuR0v1leQU8zfditCA8H4xBTHmdu5z6r5w5wC2
         rxX+y1lt01jl9Nn5LanJBcaEaNu5AkX+20sG65MECksAPK96AHIbGF6zQUXYli+gezDW
         0wLN8nAS0UBxuKIDkyTvowU8Q+r/o2gxm+CrnVij/OuuU2Y/b5us5bIQhkYw+KbUgVIC
         ncYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Voy1BYbrwVnWRsnXzpd8DhYBd0effCZg3Coq3RhiLro=;
        b=BErkxJWZ7gWiCNEDs0bJ6RWOnw0jwez0DKpyujpmE5jkKWUx7wZk54ZYbbXZ9vo00c
         zo3mT61papXzo+qvpI2SerqazfhPYBwNibTAqVX9T7DxEJsREdb2bAlpS3FriKB3Bz3c
         3eXBKaPVSm5YMQflSHwPzdBWrybW4bUzAO3hqu2RbPEXW3zqVOoFUUp9hZ+Chd49U2/X
         1QrT8ZDhzVVX+7OMel3j2oplJkAg6vE5GrWcce9zyNMl0lZo1d9ymT4olzFUIkrjUZYM
         rkJFtn1Pe+ewiirEyHtCDP7VuiyGcgHhbr4udTJFEL2dnKjb4m5d9rd6SJsInCIveomM
         FK3g==
X-Gm-Message-State: AFeK/H3lGW9ZFMBBTDBb9UeuwiVx926Yu9veb4OXfUAfdm2ISPFXuv1W1xsFeN7iwSVd0Q==
X-Received: by 10.55.10.149 with SMTP id 143mr31548367qkk.212.1489437836962;
        Mon, 13 Mar 2017 13:43:56 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.googlemail.com with ESMTPSA id p19sm12952657qtp.36.2017.03.13.13.43.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 13:43:56 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     lehmacdj@gmail.com
Cc:     git@vger.kernel.org
Subject: [GSoC][PATCH v2 2/2] credential-cache: use XDG_CACHE_HOME for socket
Date:   Mon, 13 Mar 2017 16:43:55 -0400
Message-Id: <20170313204355.56559-2-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170313204355.56559-1-lehmacdj@gmail.com>
References: <20170313172232.96678-4-lehmacdj@gmail.com>
 <20170313204355.56559-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-credential-cache will now use a socket following the XDG base path
specification by default. This increases consistency with other
applications and helps keep clutter out of users' home directories.

We still check the old socket location, ~/.git-credential-cache/socket
first in case the user already has a socket at that location. This
ensures that a socket previously created will be used over forcibly
switching to the new socket location.

If there is not a socket at that location we create a new one at
$XDG_CACHE_HOME/git/credential/socket. This complies with the XDG
standard and good for the reasons previously mentioned. We use the
subdirectory credential/ in case we later want to store other files
under $XDG_CACHE_HOME/git/ and to make the purpose of the socket clear.

I also change to documentation to reflect the new default socket
location.
---
 Documentation/git-credential-cache.txt |  3 ++-
 credential-cache.c                     | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 96208f822..4b9db3856 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -34,7 +34,8 @@ OPTIONS
 
 	Use `<path>` to contact a running cache daemon (or start a new
 	cache daemon if one is not started). Defaults to
-	`~/.git-credential-cache/socket`. If your home directory is on a
+	`~/.git-credential-cache/socket` if it exists and otherwise
+    `$XDG_CACHE_HOME/git/credential/socket`. If your home directory is on a
 	network-mounted filesystem, you may need to change this to a
 	local filesystem. You must specify an absolute path.
 
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

