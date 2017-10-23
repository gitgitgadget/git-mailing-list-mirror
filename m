Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEBF0202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdJWXRH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:17:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44164 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJWXRG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:17:06 -0400
Received: by mail-io0-f194.google.com with SMTP id m16so21947201iod.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FkoSRNemPlrDyEhk9Igx7Ki0UMhbSREfBjO9y/BOcJc=;
        b=ZUefu3TDqpwkjS4ii2VBrS8WItkJ2qyk4jHWmj4I+HL2Uc+a1dcvY3T0xPViWoQsks
         cNhLaYKuHwb//MDw8wj4ne/Y2kZ5fN1Vk8zTbgATfUZYQonG1nmFeRssAJZVWiw79gmM
         bZcV0vVs+elOutcbCFqg4e7aqi8vsJ0wq6mIBpiRqUGw6DIeuW0Zfqmf6e017hWdoORx
         48fDp2i57od5w1NV0LVXGbbL5mDp+cR2LJUlFc88NkcnsESIOp1n/ORWqNtG5jtmUwpb
         bXk/Xd6gKtSE0CoHYHqBAew5Smjun6vV3yLvBu+DOMhgZ8o/6DnS3JLGuot2wamdVCfa
         7n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FkoSRNemPlrDyEhk9Igx7Ki0UMhbSREfBjO9y/BOcJc=;
        b=QKY/j4uaDyQ1ktaBghqGBM6zNQcm1VJTxktudeKO+tBnzRhwm/rGVFATKCnkuNkSWJ
         MFdOSyRb7pivN5gsowx9cO6UktW4b1vCgWxTQ8rpbWi2P/LkvsQc03aKS4+5TSUwXGYg
         Pv0ooi8KRBe0gSwfL9xohOkzIKQAG2jAvjcTPNNGiEQzN7e9m3MWkYQpVpiAqCK2uYoa
         nfmOr+8qoNJTghAHSwcY/VSDCmCk+7yD2Vch/KpswxPjIge00s1ECftafjZFMu/br0Sx
         FxZucDVGtY6i2AlgSkkhgyxmNpH8QU3Gm9HDZzPNRbbK6hRmna5jKbq95D7RrlOz9stU
         nm0A==
X-Gm-Message-State: AMCzsaUDYOBcNi+vqRavP7CNYbDlKAMe2kY48oTDwQqMNw0vSm+2sPz5
        IqcACbhWBpr9j+Jg7zOxZf0=
X-Google-Smtp-Source: ABhQp+QE+N4n8LZC6H23ostSV+wO+JCG1PPHqatxVnjAdCzrB+5IkxGd88CY8rGB8KzPoC4wPzJKhw==
X-Received: by 10.107.130.19 with SMTP id e19mr10949473iod.119.1508800625352;
        Mon, 23 Oct 2017 16:17:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y41sm46330ita.22.2017.10.23.16.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 16:17:04 -0700 (PDT)
Date:   Mon, 23 Oct 2017 16:17:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: [PATCH 1/5] connect: split git:// setup into a separate function
Message-ID: <20171023231703.f457jp43dh7fddpv@aiede.mtv.corp.google.com>
References: <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
 <20171023155713.5055125d7467d8daaee42e32@google.com>
 <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
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
As before, except with sbeller's Reviewed-by.

 connect.c | 103 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/connect.c b/connect.c
index 7fbd396b35..068e70caad 100644
--- a/connect.c
+++ b/connect.c
@@ -850,6 +850,64 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
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
+	struct child_process *conn = &no_fork;
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
+		git_tcp_connect(fd, hostandport, flags);
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
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -881,50 +939,7 @@ struct child_process *git_connect(int fd[2], const char *url,
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
-			git_tcp_connect(fd, hostandport, flags);
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
2.15.0.rc1.287.g2b38de12cc

