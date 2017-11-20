Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D28202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbdKTVXc (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:23:32 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:40520 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbdKTVXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:23:30 -0500
Received: by mail-io0-f193.google.com with SMTP id d123so1155821iog.7
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9gMeChb5vW2GGXNQdwmBhehhyhnOyuC2sntfUgRkNQ=;
        b=WnfrfURdsneX2nG0O8oMkqTAiD7L3qbrZE3hJPp1NF1cTCJhxs6ETXc+XN4v4pRM2g
         18K1XgtviBBBdteq9YhCwee2ycv005DVhmQzV4jREsDp+aP/Z2dyp7hWL6m6Kzg3dZZ6
         qio2a7gyHT33zDpKDtsQMPEcA1jzxtxMHntCQWIShYtXj9knXWsAd3CbhtWcGzB3nEvo
         VII9Dmi7Lr/wBYYqQsfuSGcaJE/+n/KmGQ6gEJW6XEMsBfdM3m5OQ0E4scfnonshfbyo
         XayhQ7BuloFZrusK9x2rxi9UqwlHA8YaBy47/LX2PzQuDRk+eESsI9qi1nBesuEy4Tzs
         8MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9gMeChb5vW2GGXNQdwmBhehhyhnOyuC2sntfUgRkNQ=;
        b=SBs+qzx9X9GAcDM2nFHBw1xWdi1gLcKMpYQQ07SaShoEYiLJVhaz/KiXRcEQDe1D5e
         Pe953o2E6THVj3/pxP3bpd4Pr2xiJ8lMHSCX+hcx4NhfV5lUVy8OigU1Q/6mRQEv6Sps
         sKbldSx+F/1rDcttfso5P5g+xtP78LI5fQvpGL/l6qsUqkCahv4f9Xt5xSEnu2ev8vZH
         8MMNT4wuXP3pGjjv3PLeB1W4Aae9aJkdX1y8P8/x9ZJmE1V3Z6o9ZVYoDcK8YWbGfA4v
         CO2qTCYR2u9c6vPa+EJVMssdtLQQYQ3pKPeibSMwKObKkwgQVm7YlhI5+OyufGL4iC66
         yFtQ==
X-Gm-Message-State: AJaThX4nGwIqC20/1exr49ABe3R7ARWU2Gd4ybWk25Ivn7cArZnkmC+u
        OlbuNH8egnqkQMWzaE78SEF650BK
X-Google-Smtp-Source: AGs4zMZUFSRO7UwJgWFaC7B6wm3i2AmEFZV4Qe/jIBARmgxSJcY6o56jfDcApy1cvxbWe/sXO2jKpg==
X-Received: by 10.107.34.206 with SMTP id i197mr13963920ioi.134.1511213009782;
        Mon, 20 Nov 2017 13:23:29 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x7sm4845106iod.86.2017.11.20.13.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:23:29 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:23:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH 3/8] connect: split git:// setup into a separate function
Message-ID: <20171120212327.ssk6vmw2hd5jwbi5@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git_connect function is growing long.  Split the
PROTO_GIT-specific portion to a separate function to make it easier to
read.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
As before.

 connect.c | 103 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/connect.c b/connect.c
index aa994d1518..9425229206 100644
--- a/connect.c
+++ b/connect.c
@@ -861,6 +861,64 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
 	return ssh_variant;
 }
 
+/*
+ * Open a connection using Git's native protocol.
+ *
+ * The caller is responsible for freeing hostandport, but this function may
+ * modify it (for example, to truncate it to remove the port part).
+ */
+static struct child_process *git_connect_git(int fd[2], char *hostandport,
+					     const char *path, const char *prog,
+					     int flags)
+{
+	struct child_process *conn;
+	struct strbuf request = STRBUF_INIT;
+	/*
+	 * Set up virtual host information based on where we will
+	 * connect, unless the user has overridden us in
+	 * the environment.
+	 */
+	char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
+	if (target_host)
+		target_host = xstrdup(target_host);
+	else
+		target_host = xstrdup(hostandport);
+
+	transport_check_allowed("git");
+
+	/* These underlying connection commands die() if they
+	 * cannot connect.
+	 */
+	if (git_use_proxy(hostandport))
+		conn = git_proxy_connect(fd, hostandport);
+	else
+		conn = git_tcp_connect(fd, hostandport, flags);
+	/*
+	 * Separate original protocol components prog and path
+	 * from extended host header with a NUL byte.
+	 *
+	 * Note: Do not add any other headers here!  Doing so
+	 * will cause older git-daemon servers to crash.
+	 */
+	strbuf_addf(&request,
+		    "%s %s%chost=%s%c",
+		    prog, path, 0,
+		    target_host, 0);
+
+	/* If using a new version put that stuff here after a second null byte */
+	if (get_protocol_version_config() > 0) {
+		strbuf_addch(&request, '\0');
+		strbuf_addf(&request, "version=%d%c",
+			    get_protocol_version_config(), '\0');
+	}
+
+	packet_write(fd[1], request.buf, request.len);
+
+	free(target_host);
+	strbuf_release(&request);
+	return conn;
+}
+
 /*
  * This returns the dummy child_process `no_fork` if the transport protocol
  * does not need fork(2), or a struct child_process object if it does.  Once
@@ -892,50 +950,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
-		struct strbuf request = STRBUF_INIT;
-		/*
-		 * Set up virtual host information based on where we will
-		 * connect, unless the user has overridden us in
-		 * the environment.
-		 */
-		char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
-		if (target_host)
-			target_host = xstrdup(target_host);
-		else
-			target_host = xstrdup(hostandport);
-
-		transport_check_allowed("git");
-
-		/* These underlying connection commands die() if they
-		 * cannot connect.
-		 */
-		if (git_use_proxy(hostandport))
-			conn = git_proxy_connect(fd, hostandport);
-		else
-			conn = git_tcp_connect(fd, hostandport, flags);
-		/*
-		 * Separate original protocol components prog and path
-		 * from extended host header with a NUL byte.
-		 *
-		 * Note: Do not add any other headers here!  Doing so
-		 * will cause older git-daemon servers to crash.
-		 */
-		strbuf_addf(&request,
-			    "%s %s%chost=%s%c",
-			    prog, path, 0,
-			    target_host, 0);
-
-		/* If using a new version put that stuff here after a second null byte */
-		if (get_protocol_version_config() > 0) {
-			strbuf_addch(&request, '\0');
-			strbuf_addf(&request, "version=%d%c",
-				    get_protocol_version_config(), '\0');
-		}
-
-		packet_write(fd[1], request.buf, request.len);
-
-		free(target_host);
-		strbuf_release(&request);
+		conn = git_connect_git(fd, hostandport, path, prog, flags);
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
-- 
2.15.0.448.gf294e3d99a

